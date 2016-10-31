From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] i2c: make busses/i2c-pxa-pci.c explicitly non-modular
Date: Mon, 31 Oct 2016 13:59:47 -0400
Message-ID: <20161031175947.10531-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:32934 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945310AbcJaSBK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 31 Oct 2016 14:01:10 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-i2c@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/i2c/busses/Kconfig:config I2C_PXA_PCI
drivers/i2c/busses/Kconfig:     def_bool I2C_PXA && X86_32 && PCI && OF

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_pci_driver() uses the same init level priority as
builtin_pci_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 417464e9ea2a..004deb96afe3 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -1,9 +1,13 @@
 /*
+ * CE4100 PCI-I2C glue code for PXA's driver
+ * Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ * License: GPL v2
+ *
  * The CE4100's I2C device is more or less the same one as found on PXA.
  * It does not support slave mode, the register slightly moved. This PCI
  * device provides three bars, every contains a single I2C controller.
  */
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -134,35 +138,17 @@ err_mem:
 	return ret;
 }
 
-static void ce4100_i2c_remove(struct pci_dev *dev)
-{
-	struct ce4100_devices *sds;
-	unsigned int i;
-
-	sds = pci_get_drvdata(dev);
-
-	for (i = 0; i < ARRAY_SIZE(sds->pdev); i++)
-		platform_device_unregister(sds->pdev[i]);
-
-	pci_disable_device(dev);
-	kfree(sds);
-}
-
 static const struct pci_device_id ce4100_i2c_devices[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e68)},
 	{ },
 };
-MODULE_DEVICE_TABLE(pci, ce4100_i2c_devices);
 
 static struct pci_driver ce4100_i2c_driver = {
+	.driver = {
+		.suppress_bind_attrs = true,
+	},
 	.name           = "ce4100_i2c",
 	.id_table       = ce4100_i2c_devices,
 	.probe          = ce4100_i2c_probe,
-	.remove         = ce4100_i2c_remove,
 };
-
-module_pci_driver(ce4100_i2c_driver);
-
-MODULE_DESCRIPTION("CE4100 PCI-I2C glue code for PXA's driver");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");
+builtin_pci_driver(ce4100_i2c_driver);
-- 
2.6.1
