# $NetBSD$

# XXX reuse patches from burp1 ? like etc=@PKG_SYSCONFIGDIR@/burp ?
# XXX - when PKG_SYSCONFIGDIR is in use ? build ? pkg install ?
# XXX startup script for burp-server: check bacula sample
# XXX split into subpackages: -doc, -client, -server (example: bacula ?)
# XXX missing acl support ?
#       """
#       checking sys/xattr.h usability... yes
#       checking sys/xattr.h presence... yes
#       checking for sys/xattr.h... yes
#       configure:                    acl: no
#       """
# XXX libexec/burp/summary_script : /usr/sbin/burp is hardcoded
# XXX missing folder share/examples/burp/autoupgrade/ (compared to burp1)
# XXX add cron examples
# XXX work/.destdir/tmp/pkg/var/spool/burp
# XXX gettext ?
# XXX popt usefull ? burp1 using it
#
# Note: burp1 packaging in pkgsrc/sysutils/burp/

VERSION=	2.0.48
DISTNAME=	burp-${VERSION}
PKGNAME=	burp2-${VERSION}
#PKGREVISION=	1
CATEGORIES=	sysutils archivers
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=burp/}
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://burp.grke.net/
COMMENT=	Networked backup and restore program
LICENSE=	gnu-agpl-v3

CONFLICTS=	burp-[0-9]*

WRKSRC=		${WRKDIR}/${DISTNAME}
USE_LANGUAGES=	c c++
GNU_CONFIGURE=	yes

PKG_SYSCONFSUBDIR=	burp

EXAMPLESDIR=		${PREFIX}/share/examples/burp
INSTALLATION_DIRS+=	${EXAMPLESDIR}

SUBST_CLASSES+=		bashtosh
SUBST_STAGE.bashtosh=	pre-configure
SUBST_FILES.bashtosh=	configs/certs/CA/burp_ca.in
SUBST_SED.bashtosh=	-e 's,^function ,,g'

REPLACE_SH+=		configs/certs/CA/burp_ca.in
REPLASE_SH+=		configs/server/notify_script
REPLASE_SH+=		configs/server/timer_script

CONF_FILES+=		${EXAMPLESDIR}/CA.cnf           ${PKG_SYSCONFDIR}/CA.cnf
CONF_FILES+=		${EXAMPLESDIR}/burp.conf        ${PKG_SYSCONFDIR}/burp.conf
CONF_FILES+=		${EXAMPLESDIR}/burp-server.conf ${PKG_SYSCONFDIR}/burp-server.conf

MAKE_DIRS+=		${PKG_SYSCONFDIR}/CA-client

CONFIGURE_ARGS+=	--sysconfdir=${PKG_SYSCONFDIR}
CONFIGURE_ARGS+=	--sbindir=${PREFIX}/sbin
CONFIGURE_ARGS+=	--bindir=${PREFIX}/bin
CONFIGURE_ARGS+=	--localstatedir=${VARBASE}
# without '--': '--scriptdir' is NOT a known configure arg
CONFIGURE_ARGS+=	scriptdir=${PREFIX}/libexec/burp

# XXX examples
#RCD_SCRIPTS=	bacula bacula-dir bacula-sd bacula-fd

# 'install-all': install + config files and scripts generation and installation
INSTALL_TARGET=	install-all

post-install:
	# config/scripts are generated on install phase (not just copied)
	${MV} ${DESTDIR}${PKG_SYSCONFDIR}/* ${DESTDIR}${EXAMPLESDIR}/.

.include "../../devel/popt/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../net/librsync/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../devel/uthash/buildlink3.mk"
.include "../../devel/yajl/buildlink3.mk"
.include "../../devel/ncurses/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
