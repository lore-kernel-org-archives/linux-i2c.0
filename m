From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: [PATCH] i2c-tools: lib/Module.mk: fixing LIB_LINKS dependency
Date: Mon, 11 Dec 2017 18:00:24 +0100
Message-ID: <1513011624-1555-1-git-send-email-angelo@amarulasolutions.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35452 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdLKRCE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Dec 2017 12:02:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id f9so15538292wmh.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 Dec 2017 09:02:03 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Angelo Compagnucci <angelo@amarulasolutions.com>

LIB_LINKS should be added as a dependency only when
BUILD_DYNAMIC_LIB is enabled

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 lib/Module.mk | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Module.mk b/lib/Module.mk
index 8a58f5b..de189a2 100644
--- a/lib/Module.mk
+++ b/lib/Module.mk
@@ -27,10 +27,9 @@ LIB_SHSONAME	:= $(LIB_SHBASENAME).$(LIB_MAINVER)
 LIB_SHLIBNAME	:= $(LIB_SHBASENAME).$(LIB_VER)
 LIB_STLIBNAME	:= libi2c.a
 
-LIB_LINKS	:= $(LIB_SHSONAME) $(LIB_SHBASENAME)
-
 LIB_TARGETS	:=
 ifeq ($(BUILD_DYNAMIC_LIB),1)
+LIB_LINKS	:= $(LIB_SHSONAME) $(LIB_SHBASENAME)
 LIB_TARGETS	+= $(LIB_SHLIBNAME)
 endif
 ifeq ($(BUILD_STATIC_LIB),1)
-- 
2.7.4
