$NetBSD$

--- components/webcrypto/algorithms/test_helpers.cc.orig	2016-06-24 01:02:20.000000000 +0000
+++ components/webcrypto/algorithms/test_helpers.cc
@@ -26,7 +26,11 @@
 #include "components/webcrypto/status.h"
 #include "third_party/WebKit/public/platform/WebCryptoAlgorithmParams.h"
 #include "third_party/WebKit/public/platform/WebCryptoKeyAlgorithm.h"
+#if defined(OS_BSD)
+#include <re2/re2.h>
+#else
 #include "third_party/re2/src/re2/re2.h"
+#endif
 
 namespace webcrypto {
 
