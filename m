From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] lib/Module.mk: don't install dynamic library when disabled
Date: Tue,  2 Jan 2018 07:00:30 +0200
Message-ID: <ae2e0c9708aeb4a8fb301a1a4016cec7b05fc142.1514869230.git.baruch@tkos.co.il>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:59263 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeABFAz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 2 Jan 2018 00:00:55 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Baruch Siach <baruch@tkos.co.il>, Angelo Compagnucci <angelo@amarulasolutions.com>

Do not attempt to install the dynamic library when build of that library
is disabled. Fixes the following installation error:

install -m 755 lib/libi2c.so.0.1.0 .../target/usr/lib
install: cannot stat 'lib/libi2c.so.0.1.0': No such file or directory
lib/Module.mk:90: recipe for target 'install-lib' failed

Cc: Angelo Compagnucci <angelo@amarulasolutions.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 lib/Module.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Module.mk b/lib/Module.mk
index 2ebc70d76ed9..c492961e0a4a 100644
--- a/lib/Module.mk
+++ b/lib/Module.mk
@@ -88,9 +88,11 @@ clean-lib:
 
 install-lib: $(addprefix $(LIB_DIR)/,$(LIB_TARGETS))
 	$(INSTALL_DIR) $(DESTDIR)$(libdir)
+ifeq ($(BUILD_DYNAMIC_LIB),1)
 	$(INSTALL_PROGRAM) $(LIB_DIR)/$(LIB_SHLIBNAME) $(DESTDIR)$(libdir)
 	$(LN) $(LIB_SHLIBNAME) $(DESTDIR)$(libdir)/$(LIB_SHSONAME)
 	$(LN) $(LIB_SHSONAME) $(DESTDIR)$(libdir)/$(LIB_SHBASENAME)
+endif
 ifeq ($(BUILD_STATIC_LIB),1)
 	$(INSTALL_DATA) $(LIB_DIR)/$(LIB_STLIBNAME) $(DESTDIR)$(libdir)
 endif
-- 
2.15.1
