# $NetBSD: Makefile,v 1.9 2016/08/18 14:53:24 richard Exp $

DISTNAME=	meson-0.33.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_PYPI:=m/meson/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://mesonbuild.com/
COMMENT=	Open source build system meant to be fast and user friendly
LICENSE=	apache-2.0

DEPENDS+=	ninja-build-[0-9]*:../../devel/ninja-build

# c++ for tests
USE_LANGUAGES=	c c++

SUBST_CLASSES+=		man
SUBST_SED.man+=		-e "s,share/man,${PKGMANDIR},"
SUBST_FILES.man+=	setup.py
SUBST_STAGE.man=	pre-configure
SUBST_MESSAGE.man=	Fixing man page installation path.

post-extract:
	# see https://github.com/mesonbuild/meson/issues/695
	# patching does not work, perhaps due to spaces in path?
	${CP} ${FILESDIR}/meson.build ${WRKSRC}/test\ cases/frameworks/6\ gettext/src/meson.build

do-test:
	${LN} -s ${PYTHONBIN} ${BUILDLINK_DIR}/bin/python3
	cd ${WRKSRC} && ${PYTHONBIN} run_tests.py

.include "../../lang/python/egg.mk"
.include "../../mk/bsd.pkg.mk"
