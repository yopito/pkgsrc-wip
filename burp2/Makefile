# XXX what about popt ? burp 1.x using it
# XXX PLIST content
# XXX patches from burp 1.x ?
# XXX split into subpackages: -doc, -client, -server
# XXX warns about incompat between 1.x and 2.x
# XXX conflict with burp 1.x package

# $NetBSD$

GITHUB_PROJECT=	burp
#PKGREVISION=	1
DISTNAME=	2.0.36
PKGNAME=	burp2-${DISTNAME}
CATEGORIES=	sysutils archivers
MASTER_SITES=	${MASTER_SITE_GITHUB:=grke/}
DIST_SUBDIR=	${GITHUB_PROJECT}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://burp.grke.net
COMMENT=	Networked backup and restore program
LICENSE=	gnu-agpl-v3

WRKSRC=		${WRKDIR}/${GITHUB_PROJECT}-${DISTNAME}
USE_LANGUAGES=	c c++
GNU_CONFIGURE=	yes
USE_TOOLS+=	autoreconf automake m4

pre-configure:
	cd ${WRKSRC} && autoreconf -fvi


#XXX#.include "../../devel/popt/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../net/librsync/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../devel/uthash/buildlink3.mk"
.include "../../devel/yajl/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
