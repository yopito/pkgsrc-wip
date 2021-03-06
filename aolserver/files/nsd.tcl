# nsd.tcl --  The AOLserver Startup Script
#
#      This is a Tcl script that is sourced when AOLserver starts up.
#      A detailed reference is in "doc/config.txt".
#

ns_log notice "config.tcl: starting to read config file..."


#
# Set some Tcl variables that are commonly used throughout this file.
#

set httpport               80
set httpsport              443

# The hostname and address should be set to actual values.

set hostname               [ns_info hostname]
set address                [ns_info address]

set servername             "server1"
set serverdesc             "Test Server"

set homedir                [file dirname [ns_info nsd]]/..
set bindir                 ${homedir}/bin

set pageroot               ${homedir}/share/nsd/servers/${servername}/pages
set directoryfile          index.adp,index.html,index.htm

set ext [info sharedlibextension]

#
# Global server parameters
#

ns_section "ns/parameters"
ns_param  home             $homedir
ns_param  verbose	   true

#
# Server logging
#

ns_param   dev             true      ;# Display logging with "Dev" severity
ns_param   debug           false     ;# Display logging with "Debug" severity
ns_param   logexpanded     false     ;# true = double-spaced server.log
ns_param   logroll         true     ;# Roll server.log every 24 hours.
ns_param   maxbackup       10        ;# Max number of old server.log files
ns_param   pidfile         "nspid"   ;# PID of server (named "nspid.PORT")
ns_param   serverlog       "/var/log/nsd/${servername}.log" ;# Filename of server.log


#
# Thread library (nsthread) parameters
#

ns_section "ns/threads"
ns_param   mutexmeter      true      ;# measure lock contention
ns_param   stacksize [expr 128*1024] ;# Per-thread stack size.

#
# MIME types.
#
#  Note: AOLserver already has an exhaustive list of MIME types, but in
#  case something is missing you can add it here.
#

ns_section "ns/mimetypes"
ns_param   default         "*/*"     ;# MIME type for unknown extension.
ns_param   noextension     "*/*"     ;# MIME type for missing extension.
#ns_param   ".xls"          "application/vnd.ms-excel"

############################################################
#
# Server-level configuration
#
#  There is only one server in AOLserver, but this is helpful when multiple
#  servers share the same configuration file.  This file assumes that only
#  one server is in use so it is set at the top in the "server" Tcl variable.
#  Other host-specific values are set up above as Tcl variables, too.
#

ns_section "ns/servers"
ns_param   $servername     $serverdesc


#
# Server parameters
#

ns_section "ns/server/${servername}"
ns_param   directoryfile   $directoryfile
ns_param   pageroot        $pageroot
ns_param   globalstats     true      ;# Enable built-in statistics.
ns_param   urlstats        true      ;# Enable URL statistics.
ns_param   maxurlstats     1000      ;# Max number of URL's to do stats on.
ns_param   enabletclpages  false     ;# Parse *.tcl files in pageroot.

# Database Driver Configuration
# 
# Sample config for postgres.

#ns_section "ns/db/drivers"
#ns_param        postgres        nspostgres.so

#ns_section "ns/db/pools"
#ns_param        pgpool          PGPool

#ns_section "ns/db/pool/pgpool"
#ns_param driver postgres
#ns_param connections 5
#ns_param datasource localhost:5432:webdatabase
#ns_param logsqlerrors on
#ns_param verbose on
#ns_param user "webuser"

#ns_section "ns/server/${servername}/db"
#ns_param Pools *
#ns_param DefaultPool pgpool


#
# Scaling and Tuning Options
#
#  Note: These values aren't necessarily the defaults.
#

ns_param   connsperthread  5          ;# Normally there's one conn per thread

#ns_param   flushcontent    false     ;# Flush all data before returning
#ns_param   maxconnections  100       ;# Max connections to put on queue
#ns_param   maxdropped      0         ;# Shut down if dropping too many conns
#ns_param   maxthreads      20        ;# Tune this to scale your server
#ns_param   minthreads      0         ;# Tune this to scale your server
#ns_param   threadtimeout   120       ;# Idle threads die at this rate


# Directory listings -- use an ADP or a Tcl proc to generate them.
#ns_param   directoryadp    $pageroot/dirlist.adp ;# Choose one or the other.
#ns_param   directoryproc   _ns_dirlist           ;#  ...but not both!
#ns_param   directorylisting simple               ;# Can be simple or fancy.


#
# ADP (AOLserver Dynamic Page) configuration
#
ns_section "ns/server/${servername}/adp"
ns_param   map             "/*.adp"  ;# Extensions to parse as ADP's.
#ns_param   map             "/*.html" ;# Any extension can be mapped.
ns_param   enableexpire    false     ;# Set "Expires: now" on all ADP's.
ns_param   enabledebug     false     ;# Allow Tclpro debugging with "?debug".

# ADP special pages
ns_param   errorpage      ${pageroot}/test.adp ;# ADP error page.


#
# ADP custom parsers -- see adp.c
#
ns_section "ns/server/${servername}/adp/parsers"
ns_param   adp             ".adp"    ;# adp is the default parser.

#
# TCL library location -- This is critical for NetBSD since we moved stuff
#

ns_section "ns/server/${servername}/tcl"
ns_param        library         ${homedir}/share/nsd/modules/tcl


#
# Socket driver module (HTTP)  -- nssock
#
ns_section "ns/server/${servername}/module/nssock"
ns_param   port            $httpport
ns_param   hostname        $hostname
ns_param   address         $address


#
# Control port -- nscp
#
#  nscp does not load unless nscp_user is a valid user.
#
#ns_section "ns/server/${servername}/module/nscp"
#ns_param   port            $nscp_port
#ns_param   address         $nscp_addr

#ns_section "ns/server/${servername}/module/nscp/users"
#ns_param   user            $nscp_user


#
# Access log -- nslog
#
ns_section "ns/server/${servername}/module/nslog"
ns_param   rolllog         false      ;# Should we roll log?
ns_param   rollonsignal    true      ;# Roll log on SIGHUP.
ns_param   rollhour        0         ;# Time to roll log.
ns_param   maxbackup       5         ;# Max number to keep around when rolling.
ns_param   file            "/var/log/nsd/${servername}access.log"


#
# CGI interface -- nscgi
#
#  WARNING: These directories must not live under pageroot.
#
ns_section "ns/server/${servername}/module/nscgi"
#ns_param   map "GET  /cgi /usr/local/cgi"     ;# CGI script file dir (GET).
#ns_param   map "POST /cgi /usr/local/cgi"     ;# CGI script file dir (POST).


#
# Modules to load
#
ns_section "ns/server/${servername}/modules"
ns_param   nssock          ${bindir}/nssock${ext}
ns_param   nslog           ${bindir}/nslog${ext}
#ns_param   nscgi           ${bindir}/nscgi${ext}  ;# Map the paths before using.
#ns_param   nsperm          ${bindir}/nsperm${ext} ;# Edit passwd before using.

#
# nscp: Only loads if nscp_user is set (see above).
#
#if { $nscp_user != "" } {

#    if ![string match "127.0.0.1" $nscp_addr] {
#	# Anything but 127.0.0.1 is not recommended.
#	ns_log warning "config.tcl: nscp listening on ${nscp_addr}:${nscp_port}"
#    }
#    ns_param nscp ${bindir}/nscp${ext}

#} else {
#    ns_log warning "config.tcl: nscp not loaded -- user/password is not set."
#}

ns_log notice "config.tcl: finished reading config file."
