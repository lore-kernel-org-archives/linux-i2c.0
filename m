From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: [PATCH] lib: Fix compilation when USE_STATIC_LIB
Date: Tue, 28 Nov 2017 23:58:17 +0100
Message-ID: <1511909897-18600-1-git-send-email-angelo@amarulasolutions.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40959 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdK1W6Z (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Nov 2017 17:58:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id v19so2498247wmh.5
        for <linux-i2c@vger.kernel.org>; Tue, 28 Nov 2017 14:58:25 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de, Angelo Compagnucci <angelo@amarulasolutions.com>

This patch removes the mandatory compiling of the shared library
when USE_STATIC_LIB is used.

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 lib/Module.mk | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/Module.mk b/lib/Module.mk
index 432a051..bdcb19d 100644
--- a/lib/Module.mk
+++ b/lib/Module.mk
@@ -27,12 +27,13 @@ LIB_SHSONAME	:= $(LIB_SHBASENAME).$(LIB_MAINVER)
 LIB_SHLIBNAME	:= $(LIB_SHBASENAME).$(LIB_VER)
 LIB_STLIBNAME	:= libi2c.a
 
-LIB_TARGETS	:= $(LIB_SHLIBNAME)
 LIB_LINKS	:= $(LIB_SHSONAME) $(LIB_SHBASENAME)
 LIB_OBJECTS	:= smbus.o
 ifeq ($(BUILD_STATIC_LIB),1)
-LIB_TARGETS	+= $(LIB_STLIBNAME)
+LIB_TARGETS	:= $(LIB_STLIBNAME)
 LIB_OBJECTS	+= smbus.ao
+else
+LIB_TARGETS	:= $(LIB_SHLIBNAME)
 endif
 
 #
-- 
2.7.4
