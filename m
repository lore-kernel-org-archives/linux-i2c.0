From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] i2c: nforce2: Use IS_ENABLED() instead of checking for built-in or module
Date: Tue, 26 Apr 2016 13:22:33 -0400
Message-ID: <1461691353-22095-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34657 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbcDZRWr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 13:22:47 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/i2c/busses/i2c-nforce2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 70b3c9158509..42fcc9458432 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -127,7 +127,7 @@ static struct pci_driver nforce2_driver;
 
 /* For multiplexing support, we need a global reference to the 1st
    SMBus channel */
-#if defined CONFIG_I2C_NFORCE2_S4985 || defined CONFIG_I2C_NFORCE2_S4985_MODULE
+#if IS_ENABLED(CONFIG_I2C_NFORCE2_S4985)
 struct i2c_adapter *nforce2_smbus;
 EXPORT_SYMBOL_GPL(nforce2_smbus);
 
-- 
2.5.5
