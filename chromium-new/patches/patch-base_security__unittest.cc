$NetBSD$

--- base/security_unittest.cc.orig	2016-06-24 01:02:08.000000000 +0000
+++ base/security_unittest.cc
@@ -74,7 +74,7 @@ bool IsTcMallocBypassed() {
 // FAILS_ is too clunky.
 void OverflowTestsSoftExpectTrue(bool overflow_detected) {
   if (!overflow_detected) {
-#if defined(OS_LINUX) || defined(OS_ANDROID) || defined(OS_MACOSX)
+#if defined(OS_POSIX) && !defined(OS_NACL)
     // Sadly, on Linux, Android, and OSX we don't have a good story yet. Don't
     // fail the test, but report.
     printf("Platform has overflow: %s\n",
