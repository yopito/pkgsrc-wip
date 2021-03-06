$NetBSD$

Allow setting VERSION and prevent overwriting it.

--- common.mk.orig	2016-09-06 02:03:21.000000000 +0000
+++ common.mk
@@ -24,7 +24,7 @@ ifeq ($(wildcard .git),)
   VERSION := $(shell [ -f $(TOPDIR)/I3_VERSION ] && cat $(TOPDIR)/I3_VERSION | cut -d '-' -f 1)
   I3_VERSION := '$(shell [ -f $(TOPDIR)/I3_VERSION ] && cat $(TOPDIR)/I3_VERSION)'
 else
-  VERSION := $(shell git describe --tags --abbrev=0)
+  VERSION ?= $(shell git describe --tags --abbrev=0)
   I3_VERSION := '$(shell git describe --tags --always) ($(shell git log --pretty=format:%cd --date=short -n1), branch \"$(shell git describe --tags --always --all | sed s:heads/::)\")'
 endif
 
