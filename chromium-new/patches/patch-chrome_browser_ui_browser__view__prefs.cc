$NetBSD$

--- chrome/browser/ui/browser_view_prefs.cc.orig	2016-06-24 01:02:14.000000000 +0000
+++ chrome/browser/ui/browser_view_prefs.cc
@@ -10,7 +10,7 @@
 #include "components/prefs/pref_registry_simple.h"
 #include "components/prefs/pref_service.h"
 
-#if defined(OS_LINUX) && !defined(OS_CHROMEOS)
+#if defined(OS_LINUX) && !defined(OS_CHROMEOS)  || defined(OS_BSD)
 #include "ui/base/x/x11_util.h"
 #endif
 
@@ -33,7 +33,7 @@ void RegisterBrowserViewLocalPrefs(PrefR
 void RegisterBrowserViewProfilePrefs(
     user_prefs::PrefRegistrySyncable* registry) {
   bool custom_frame_default = false;
-#if defined(OS_LINUX) && !defined(OS_CHROMEOS)
+#if defined(OS_LINUX) && !defined(OS_CHROMEOS)  || defined(OS_BSD)
   custom_frame_default = ui::GetCustomFramePrefDefault();
 #endif
 
