$NetBSD$

fix build for pkgsrc, by allowing qmake to link binaries in situ
and create an install target

--- src/3rdparty/stemmer/stemmer.pro.orig	2016-07-01 07:13:14.000000000 +0000
+++ src/3rdparty/stemmer/stemmer.pro
@@ -44,5 +44,5 @@ HEADERS += \

 TARGET = stemmer
 TEMPLATE = lib
-CONFIG += staticlib
-#CONFIG += plugin
+CONFIG += plugin
+INSTALLS += target
