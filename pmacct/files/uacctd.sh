#!/bin/sh
#
# $NetBSD: uacctd.sh,v 1.2 2015/02/10 00:21:42 mbowie Exp $
#

# PROVIDE: uacctd
# REQUIRE: NETWORK

$_rc_subr_loaded . /etc/rc.subr

name="uacctd"
rcvar=${name}
command=@PREFIX@/sbin/${name}
required_files="@PKG_SYSCONFDIR@/${name}.conf"
pidfile="/var/run/${name}.pid"
command_args="-F ${pidfile} -f ${required_files}"

load_rc_config $name

run_rc_command "$1"

