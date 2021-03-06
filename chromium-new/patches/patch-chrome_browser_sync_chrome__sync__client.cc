$NetBSD$

--- chrome/browser/sync/chrome_sync_client.cc.orig	2016-06-24 01:02:13.000000000 +0000
+++ chrome/browser/sync/chrome_sync_client.cc
@@ -577,7 +577,7 @@ void ChromeSyncClient::RegisterDesktopDa
   }
 #endif
 
-#if defined(OS_LINUX) || defined(OS_WIN) || defined(OS_CHROMEOS)
+#if defined(OS_LINUX) || defined(OS_WIN) || defined(OS_CHROMEOS) || defined(OS_BSD)
   // Dictionary sync is enabled by default.
   if (!disabled_types.Has(syncer::DICTIONARY)) {
     sync_service->RegisterDataTypeController(new UIDataTypeController(
