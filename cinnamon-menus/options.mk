# $NetBSD: options.mk,v 1.1 2015/02/19 21:21:12 jihbed Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.cinnamon-menus
PKG_SUPPORTED_OPTIONS=	introspection
PKG_SUGGESTED_OPTIONS=

.include "../../mk/bsd.options.mk"

PLIST_VARS+=	introspection

.if !empty(PKG_OPTIONS:Mintrospection)
BUILDLINK_DEPMETHOD.gobject-introspection+=	build
.include "../../devel/gobject-introspection/buildlink3.mk"
CONFIGURE_ARGS+=	--enable-introspection
PLIST.introspection=	yes
.else
CONFIGURE_ARGS+=	--disable-introspection
.endif
