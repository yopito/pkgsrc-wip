# $NetBSD: Makefile,v 1.10 2015/06/29 12:28:55 nils Exp $

DISTNAME=		${GHCOMMIT}
PKGNAME=		logrotate-3.10.0.20160812
CATEGORIES=		sysutils
MASTER_SITES=		${MASTER_SITE_GITHUB:=logrotate/logrotate/archive/}

MAINTAINER=		nils@NetBSD.org
HOMEPAGE=		https://github.com/logrotate/logrotate/
COMMENT=		Daemon to rotate, compress, remove and mail system log files
LICENSE=		gnu-gpl-v2

GHCOMMIT=		6c0dfc4a3d3b0535a4848d4ccb92631016a20a2d
USE_TOOLS+=		gmake gzip:run gunzip:run mail:run automake autoconf
USE_LIBTOOL=		yes
GNU_CONFIGURE=		yes
HAS_CONFIGURE=		yes
NO_EXPORT_CPP=		yes

WRKSRC=			${WRKDIR}/logrotate-${GHCOMMIT}
CONFIGURE_ENV+=		STATEFILE=\"${VARBASE}/db/logrotate.status\"
CONFIGURE_ENV+=		DEFAULT_MAIL_COMMAND=\"${MAIL_CMD:Q}\"
CONFIGURE_ENV+=		COMPRESS_COMMAND=\"${GZIP_CMD:[1]:Q}\"
CONFIGURE_ENV+=		UNCOMPRESS_COMMAND=\"${GUNZIP_CMD:[1]:Q}\"

BUILD_DEFS+=		VARBASE
EGDIR=			${PREFIX}/share/examples/logrotate
CONF_FILES=		${EGDIR}/logrotate.conf ${PKG_SYSCONFDIR}/logrotate.conf
OWN_DIRS=		${PKG_SYSCONFDIR}/logrotate.d
MESSAGE_SUBST+=		EGDIR=${EGDIR}
INSTALLATION_DIRS+=	${EGDIR} ${PKG_SYSCONFDIR} ${OWN_DIRS}
AUTO_MKDIRS=		yes

SUBST_CLASSES+=		paths
SUBST_STAGE.paths=	pre-build
SUBST_MESSAGE.paths=	Substituting paths variables.
SUBST_FILES.paths=	examples/logrotate-default
SUBST_FILES.paths+=	examples/logrotate.cron
SUBST_FILES.paths+=	logrotate.8
SUBST_VARS.paths=	PREFIX
SUBST_VARS.paths+=	VARBASE
SUBST_VARS.paths+=	PKG_SYSCONFDIR

DOCDIR=			share/doc/logrotate

pre-configure:
	cd ${WRKSRC} && \
		${SETENV} ${CONFIGURE_ENV} ./autogen.sh

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/logrotate ${DESTDIR}${PREFIX}/sbin
	${INSTALL_DATA} ${WRKSRC}/examples/logrotate-default ${DESTDIR}${EGDIR}/logrotate.conf
	${INSTALL_DATA} ${WRKSRC}/examples/logrotate.cron ${DESTDIR}/${EGDIR}
	${INSTALL_DATA} ${WRKSRC}/README.* ${DESTDIR}${PREFIX}/${DOCDIR}
	${INSTALL_DATA} ${WRKSRC}/CHANGES ${DESTDIR}${PREFIX}/${DOCDIR}
	${INSTALL_DATA} ${WRKSRC}/COPYING ${DESTDIR}${PREFIX}/${DOCDIR}
	${INSTALL_MAN} ${WRKSRC}/logrotate.conf.5 ${DESTDIR}${PREFIX}/${PKGMANDIR}/man5
	${INSTALL_MAN} ${WRKSRC}/logrotate.8 ${DESTDIR}${PREFIX}/${PKGMANDIR}/man8

.include "../../devel/popt/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
