# $NetBSD: Makefile,v 1.3 2013/06/04 07:45:22 thomasklausner Exp $

DISTNAME=	chaos
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}-${VERSION}
CATEGORIES=	math
MASTER_SITES=	http://www.math.uic.edu/~culler/chaos/
EXTRACT_SUFX=	.tgz

MAINTAINER=	jihbed.research@gmail.com
HOMEPAGE=	http://www.math.uic.edu/~culler/chaos/
COMMENT=	UIC REU on Chaos, Fractals and Complex Dynamics
#LICENSE=	# TODO: (see mk/license.mk)

DEPENDS+=	${PYPKGPREFIX}-Tk-[0-9]*:../../x11/py-Tk

VERSION=	1.0
PYDISTUTILSPKG=	yes

.include "../../lang/python/extension.mk"
.include "../../mk/bsd.pkg.mk"
