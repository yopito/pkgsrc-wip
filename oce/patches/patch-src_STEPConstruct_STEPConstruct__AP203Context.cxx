$NetBSD$

On fbsd + clang we get:
error: cast from 'char* (*)(int, int)' to 'Standard_Integer' loses precision

Fix taken from
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=131600

--- src/STEPConstruct/STEPConstruct_AP203Context.cxx.orig	2016-06-02 12:18:16.000000000 +0000
+++ src/STEPConstruct/STEPConstruct_AP203Context.cxx
@@ -105,6 +105,15 @@ Handle(StepBasic_DateAndTime) STEPConstr
 
     Handle(StepBasic_CoordinatedUniversalTimeOffset) zone = 
       new StepBasic_CoordinatedUniversalTimeOffset;
+
+#if defined(__FreeBSD__)
+    struct tm newtime;
+    time_t ltime;
+    ltime = time(&ltime);
+    localtime_r(&ltime, &newtime);
+    int timezone = newtime.tm_gmtoff;
+#endif
+    
     Standard_Integer shift = Standard_Integer(timezone);
     Standard_Integer shifth = abs ( shift ) / 3600;
     Standard_Integer shiftm = ( abs ( shift ) - shifth * 3600 ) / 60;
