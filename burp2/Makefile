# $NetBSD$

# XXX missing folder etc/CA-client/ (compared to XBPS burp)
# XXX libexec/burp/summary_script : /usr/sbin/burp is hardcoded
# XXX burp_ca: hardcoded "etc=/etc/burp"
# XXX burp 1.x burp_ca notify_script and timer_script: all with /bin/sh (not bash)
# XXX missing folder share/examples/burp/autoupgrade/ (compared to burp 1.x)
# XXX burp_ca is a *bash* shell script ... depends on bash
# XXX impact of PKG_SYSCONFSUBDIR ? see nothing with burp 1.x, bacula ?
# XXX add cron examples 
# XXX startup script ? check bacula ?
# XXX burp 1.x has INSTALL/DEINSTALL script.
# XXX work/.destdir/tmp/pkg/var/spool/burp
# XXX gettext ?
# XXX popt usefull ? burp 1.x using it
# XXX (runtime) DEPENDS ? perl, openssl, librsync, bash, ...
# XXX patches from burp 1.x ?
# XXX split into subpackages: -doc, -client, -server
# XXX warns about incompat between 1.x and 2.x

GITHUB_PROJECT=	burp
#PKGREVISION=	1
DISTNAME=	2.0.36
PKGNAME=	burp2-${DISTNAME}
CATEGORIES=	sysutils archivers
MASTER_SITES=	${MASTER_SITE_GITHUB:=grke/}
DIST_SUBDIR=	${GITHUB_PROJECT}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://burp.grke.net/
COMMENT=	Networked backup and restore program
LICENSE=	gnu-agpl-v3

CONFLICTS=	burp-[0-9]*

WRKSRC=		${WRKDIR}/${GITHUB_PROJECT}-${DISTNAME}
USE_LANGUAGES=	c c++
GNU_CONFIGURE=	yes
USE_TOOLS+=	autoreconf automake m4

PKG_SYSCONFSUBDIR=	burp

EXAMPLESDIR=		${PREFIX}/share/examples/burp
INSTALLATION_DIRS+=	${EXAMPLESDIR}

CONF_FILES+=		${EXAMPLESDIR}/CA.cnf           ${PKG_SYSCONFDIR}/CA.cnf
CONF_FILES+=		${EXAMPLESDIR}/burp.conf        ${PKG_SYSCONFDIR}/burp.conf
CONF_FILES+=		${EXAMPLESDIR}/burp-server.conf ${PKG_SYSCONFDIR}/burp-server.conf

pre-configure:
	cd ${WRKSRC} && autoreconf -fvi

CONFIGURE_ARGS+=	--sysconfdir=${PKG_SYSCONFDIR:Q} \
			--mandir=${PREFIX}/${PKGMANDIR} \
			--sbindir=${PREFIX}/sbin \
			--bindir=${PREFIX}/sbin \
			scriptdir=${PREFIX}/libexec/burp

# 'install-all': generate and install config files and scripts
INSTALL_TARGET=	install-all

post-install:
	# config/scripts are generated on install phase (not just copied)
	${MV} ${DESTDIR}${PKG_SYSCONFDIR:Q}/* ${EXAMPLESDIR}/.

.include "../../devel/popt/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../net/librsync/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../devel/uthash/buildlink3.mk"
.include "../../devel/yajl/buildlink3.mk"
.include "../../devel/ncurses/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
