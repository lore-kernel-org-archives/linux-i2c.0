From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] i2c: designware: Fix spelling typos in the comments
Date: Thu, 19 Mar 2020 17:30:12 +0200
Message-ID: <20200319153012.36136-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12687 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCSPab (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 19 Mar 2020 11:30:31 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fix spelling typos in the comments with help of `codespell`.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 2 +-
 drivers/i2c/busses/i2c-designware-common.c   | 8 ++++----
 drivers/i2c/busses/i2c-designware-master.c   | 2 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c   | 2 +-
 drivers/i2c/busses/i2c-designware-slave.c    | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 33da07d64494..c6a7a00e1d52 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Intel BayTrail PMIC I2C bus semaphore implementaion
+ * Intel BayTrail PMIC I2C bus semaphore implementation
  * Copyright (c) 2014, Intel Corporation.
  */
 #include <linux/device.h>
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 2de7452fcd6d..a6265ffab556 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -102,7 +102,7 @@ int i2c_dw_set_reg_access(struct dw_i2c_dev *dev)
 	i2c_dw_release_lock(dev);
 
 	if (reg == swab32(DW_IC_COMP_TYPE_VALUE)) {
-		/* Configure register endianess access */
+		/* Configure register endianness access */
 		dev->flags |= ACCESS_SWAP;
 	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
 		/* Configure register access mode 16bit */
@@ -190,10 +190,10 @@ int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
 
 		/*
 		 * Workaround for avoiding TX arbitration lost in case I2C
-		 * slave pulls SDA down "too quickly" after falling egde of
+		 * slave pulls SDA down "too quickly" after falling edge of
 		 * SCL by enabling non-zero SDA RX hold. Specification says it
 		 * extends incoming SDA low to high transition while SCL is
-		 * high but it apprears to help also above issue.
+		 * high but it appears to help also above issue.
 		 */
 		if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
 			dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
@@ -356,7 +356,7 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
 	/* Disable controller */
 	__i2c_dw_disable(dev);
 
-	/* Disable all interupts */
+	/* Disable all interrupts */
 	dw_writel(dev, 0, DW_IC_INTR_MASK);
 	dw_readl(dev, DW_IC_CLR_INTR);
 }
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index e8b328242256..529f54249609 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -521,7 +521,7 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 
 	/*
 	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
-	 * Ths unmasked raw version of interrupt status bits are available
+	 * The unmasked raw version of interrupt status bits is available
 	 * in the IC_RAW_INTR_STAT register.
 	 *
 	 * That is,
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 60d9ed7543a6..6a66e7e5abff 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -110,7 +110,7 @@ static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 static int mrfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 {
 	/*
-	 * On Intel Merrifield the user visible i2c busses are enumerated
+	 * On Intel Merrifield the user visible i2c buses are enumerated
 	 * [1..7]. So, we add 1 to shift the default range. Besides that the
 	 * first PCI slot provides 4 functions, that's why we have to add 0 to
 	 * the first slot and 4 to the next one.
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index f5f001738df5..f00079e4569d 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -107,7 +107,7 @@ static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 
 	/*
 	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
-	 * Ths unmasked raw version of interrupt status bits are available
+	 * The unmasked raw version of interrupt status bits is available
 	 * in the IC_RAW_INTR_STAT register.
 	 *
 	 * That is,
-- 
2.25.1
