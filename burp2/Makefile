# $NetBSD$

# XXX paths are hardcoded with LOCALBASE in config files. normal ?
# XXX libexec/burp/summary_script : /usr/sbin/burp
# XXX burp 1.x: missing share/examples/burp/autoupgrade/
# XXX burp_ca is a *bash* shell script
# XXX burp 1.x libexec scripts: all with /bin/sh (not bash)
# XXX burp_ca: etc=/etc/burp
# XXX impact of PKG_SYSCONFSUBDIR ?
# XXX startup script ?
# XXX burp 1.x has INSTALL/DEINSTALL script.
# XXX compare config files content with burp 1.x (esp. paths)
# XXX work/.destdir/tmp/pkg/var/spool/burp
# XXX gettext ?
# XXX popt usefull ? burp 1.x using it
# XXX DEPENDS ? perl, openssl, librsync, ...
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
	${MKDIR} ${DESTDIR}${PREFIX}/share/examples/burp
	${MV} ${DESTDIR}${PKG_SYSCONFDIR:Q}/* ${DESTDIR}${PREFIX}/share/examples/burp/.

.include "../../devel/popt/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../net/librsync/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../devel/uthash/buildlink3.mk"
.include "../../devel/yajl/buildlink3.mk"
.include "../../devel/ncurses/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
