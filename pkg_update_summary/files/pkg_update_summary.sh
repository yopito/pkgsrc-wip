#!/bin/sh -e

# Copyright (c) 2007-2008 Aleksey Cheusov <vle@gmx.net>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if test -z "$PKG_INFO_CMD"; then
    PKG_INFO_CMD=pkg_info
fi

if test -z "$TEST_CMD"; then
    TEST_CMD=test
fi

if $TEST_CMD $# -eq 2; then
    summary_file="$1"
    bin_pkg_dir="$2"
    uncompress='cat'
    compress='cat'
elif $TEST_CMD $# -eq 4; then
    summary_file="$1"
    bin_pkg_dir="$2"
    uncompress="$3"
    compress="$4"
else
    echo 'usage: pkg_update_summary <summary_file> <bin_pkg_dir> [uncompress compress]' 1>&2
    exit 1
fi

cd "$bin_pkg_dir"

pkgs2summary (){
    xargs $PKG_INFO_CMD -X
}

get_all_pkgs (){
    ls -1t "$bin_pkg_dir" | grep '[.]t[gb]z$'
}

get_updated_pkgs (){
    get_all_pkgs |
    while read f; do
	if $TEST_CMD "$f" -nt "$summary_file"; then
	    echo "$f"
	else
	    break
	fi
    done
}

subtract (){
    cat "$@" |
    LC_ALL=C sort |
    LC_ALL=C uniq -c |
    awk '$1 == 1 {print $2}'
}

get_unchanged_pkgs (){
#    echo "updated=$updated"
#    echo "all=$all"
    { echo "$all"; echo "$updated"; } | subtract
}

tmp1="`dirname $summary_file`/`basename $summary_file`.tmp1"
tmp2="`dirname $summary_file`/`basename $summary_file`.tmp2"

trap "rm -f $tmp1 $tmp2" 0 1 2 15

filter_unchanged (){
    pkgs_fn=$1
    shift

    awk -v pkgs_fn="$pkgs_fn" '
    BEGIN {
	while (0 < (ret = getline < pkgs_fn)){
	    sub(/[.]t[bg]z$/, "")
	    keep_array [$1] = ""
	}
	if (ret < 0){
	    printf "reading from %s failed\n", pkgs_fn > "/dev/stderr"
	    exit 2
	}

	FS = "="
    }
    $1 == "PKGNAME", NF == 0 {
	if ($1 == "PKGNAME"){
	    keep = ($2 in keep_array)
	}

	if (keep){
	    print $0
	}
    }
    ' "$@"
}

show_debugging_info (){
    if $TEST_CMD "$TRACE"; then
	printf "\n\nall binary packages : \n\n$all"

	printf "\n\nupdated packages : \n\n$updated"

	printf "\n\nkept packages : \n\n"; cat "$tmp2"

	printf "\n\nremoved packages : \n\n"
	{ echo "$all" | sed 's/[.]t[gb]z$//'
	    sed -n 's/^PKGNAME=//p' "$summary_file"
	} | subtract
    fi
}

if $TEST_CMD -f "$summary_file"; then
    updated="`get_updated_pkgs`"
    all="`get_all_pkgs`"
    get_unchanged_pkgs > "$tmp2"

    {
	$uncompress "$summary_file" | filter_unchanged "$tmp2"
	echo "$updated" | pkgs2summary 
    } | $compress > "$tmp1"

    show_debugging_info
else
    get_all_pkgs |
    pkgs2summary | $compress > "$tmp1"
fi

if $TEST_CMD -z "$TRACE"; then
    mv "$tmp1" "$summary_file"
fi
