$NetBSD$

--- chrome/chrome_browser.gypi.orig	2016-06-24 01:02:14.000000000 +0000
+++ chrome/chrome_browser.gypi
@@ -3590,7 +3590,7 @@
             '../device/media_transfer_protocol/media_transfer_protocol.gyp:device_media_transfer_protocol',
           ],
         }],
-        ['OS=="linux" and chromeos==0', {
+        ['(OS=="linux" and chromeos==0) or os_bsd==1', {
           'dependencies': [
             '../build/linux/system.gyp:libspeechd',
           ],
@@ -3654,7 +3654,7 @@
         ['use_x11==1', {
           'sources': [ '<@(chrome_browser_x11_sources)' ],
         }],
-        ['os_posix == 1 and OS != "mac" and OS != "ios"', {
+        ['os_posix == 1 and OS != "mac" and OS != "ios" and os_bsd != 1', {
           'sources': [
             'app/chrome_crash_reporter_client.cc',
             'app/chrome_crash_reporter_client.h',
@@ -3786,6 +3786,12 @@
             }],
           ],
         }],
+        ['os_bsd==1', {
+          'sources/': [
+            ['exclude', '^browser/media_galleries/linux/'],
+            ['exclude', '^browser/memory/system_memory_stats_recorder_linux.cc'],
+          ],
+        }],
         ['OS=="mac"', {
           'dependencies': [
             '../third_party/google_toolbox_for_mac/google_toolbox_for_mac.gyp:google_toolbox_for_mac',
@@ -3902,7 +3908,7 @@
             }],
           ],
         }],
-        ['OS=="linux"', {
+        ['OS=="linux" or os_bsd==1', {
           'conditions': [
             ['use_aura==1', {
               'dependencies': [
@@ -3921,7 +3927,7 @@
             }],
           ],
         }],
-        ['OS=="linux" or OS=="win"', {
+        ['OS=="linux" or OS=="win" or os_bsd==1', {
             'sources': [ '<@(chrome_browser_non_mac_desktop_sources)' ],
         }],
         ['desktop_linux==1', {
