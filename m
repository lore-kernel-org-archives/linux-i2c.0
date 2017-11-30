From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: [PATCH 1/2] Makefile: add flag to disable dynamic libraries
Date: Thu, 30 Nov 2017 09:12:26 +0100
Message-ID: <1512029547-8639-1-git-send-email-angelo@amarulasolutions.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42662 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdK3IMd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 03:12:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id l141so11247880wmg.1
        for <linux-i2c@vger.kernel.org>; Thu, 30 Nov 2017 00:12:32 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de, Angelo Compagnucci <angelo@amarulasolutions.com>

In such cases where you need to disable entirely the dynamic
library compilation, now you can use the BUILD_DYNAMIC_LIB=0
flag.

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 Makefile      | 8 ++++++++
 lib/Module.mk | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c85317c..a9ab4a2 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,14 @@ ifeq ($(USE_STATIC_LIB),1)
 BUILD_STATIC_LIB := 1
 endif
 
+BUILD_DYNAMIC_LIB ?= 1
+
+ifeq ($(BUILD_DYNAMIC_LIB),0)
+ifeq ($(BUILD_STATIC_LIB),0)
+$(error BUILD_DYNAMIC_LIB and BUILD_STATIC_LIB cannot be disabled at the same time)
+endif
+endif
+
 KERNELVERSION	:= $(shell uname -r)
 
 .PHONY: all strip clean install uninstall
diff --git a/lib/Module.mk b/lib/Module.mk
index 432a051..9dc2642 100644
--- a/lib/Module.mk
+++ b/lib/Module.mk
@@ -27,9 +27,13 @@ LIB_SHSONAME	:= $(LIB_SHBASENAME).$(LIB_MAINVER)
 LIB_SHLIBNAME	:= $(LIB_SHBASENAME).$(LIB_VER)
 LIB_STLIBNAME	:= libi2c.a
 
-LIB_TARGETS	:= $(LIB_SHLIBNAME)
 LIB_LINKS	:= $(LIB_SHSONAME) $(LIB_SHBASENAME)
 LIB_OBJECTS	:= smbus.o
+
+LIB_TARGETS :=
+ifeq ($(BUILD_DYNAMIC_LIB),1)
+LIB_TARGETS	+= $(LIB_SHLIBNAME)
+endif
 ifeq ($(BUILD_STATIC_LIB),1)
 LIB_TARGETS	+= $(LIB_STLIBNAME)
 LIB_OBJECTS	+= smbus.ao
-- 
2.7.4
