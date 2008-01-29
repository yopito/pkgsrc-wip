#!/bin/sh

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

set -e

############################################################
# user settable variables
if test -z "$PKGSRCDIR"; then
    PKGSRCDIR=/usr/pkgsrc
fi

if test -z "$MAKE"; then
    MAKE=make
fi

############################################################
cd $PKGSRCDIR

tmpfn=/tmp/pkgdirs2info.$$
trap 'rm -f $tmpfn' 0 1 2 15

############################################################
summary_data2summary (){
    awk '
    function normalize (w){
	return toupper(w)
    }

    BEGIN {
	descr_msg = normalize("description:")
    }

    $1 == "prefix" {
	next
    }

    $1 == "index" {
	next
    }

    $1 == "descr" {
	fn = $3
	while (0 < ret = (getline < fn)){
	    print descr_msg "=" $0
	}
	if (ret < 0){
	    printf "reading from `" fn "` failed\n" > "/dev/stderr"
	    exit 1
	}
	next
    }

    NF > 0 {
	hdr = (normalize($1) "=")
	$1 = $2 = ""

	print hdr substr($0, 3)
    }'
}

cd_and_print_summary_data (){
    # $1 - pkgpath
    ( cd $1 && ${MAKE} print-summary-data; ) > "$tmpfn";
}

generate_summary (){
    # general information
    if cd_and_print_summary_data $1 > "$tmpfn"; then
	pkgname=`awk '$1 == "index" {print $3}' "$tmpfn"`
	pkgpath=`awk '$1 == "index" {print $2}' "$tmpfn"`
	echo "PKGNAME=$pkgname"
	echo "PKGPATH=$pkgpath"
	cat "$tmpfn" | summary_data2summary

	# not expanding PLIST yet
	plist_fn=$1/PLIST
	if test -f $plist_fn; then
	    awk '/^[^@]/ {print "PLIST=" $0}' $plist_fn
	fi

	echo '' # empty line - separator 
    else
	printf "Bad package $1, skipped\n" 1>&2
    fi
}

############################################################
if test $# -eq 0; then
    # processing stdin
    while read pkgpath; do
	generate_summary "$pkgpath"
    done
else
    # processing arguments
    for pkgpath in "$@"; do
	generate_summary "$pkgpath"
    done
fi
