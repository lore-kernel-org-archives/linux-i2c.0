From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] i2c-i801: make it depend on CONFIG_X86
Date: Wed, 15 Jun 2016 16:22:03 +0300
Message-ID: <1465996923-76230-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34745 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbcFONWg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 09:22:36 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The IP seems not used outside of x86 world, so, make it depend on CONFIG_X86.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/Kconfig    | 4 ++--
 drivers/i2c/busses/i2c-i801.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f167021..78609ad 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -89,8 +89,8 @@ config I2C_HIX5HD2
 
 config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
-	depends on PCI
-	select CHECK_SIGNATURE if X86 && DMI
+	depends on X86 && PCI
+	select CHECK_SIGNATURE if DMI
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b436963..9dcc417 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -902,7 +902,7 @@ static const struct pci_device_id i801_ids[] = {
 
 MODULE_DEVICE_TABLE(pci, i801_ids);
 
-#if defined CONFIG_X86 && defined CONFIG_DMI
+#ifdef CONFIG_DMI
 static unsigned char apanel_addr;
 
 /* Scan the system ROM for the signature "FJKEYINF" */
@@ -1020,7 +1020,7 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
 #else
 static void __init input_apanel_init(void) {}
 static void i801_probe_optional_slaves(struct i801_priv *priv) {}
-#endif	/* CONFIG_X86 && CONFIG_DMI */
+#endif	/* CONFIG_DMI */
 
 #if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
 		defined CONFIG_DMI
-- 
2.8.1
