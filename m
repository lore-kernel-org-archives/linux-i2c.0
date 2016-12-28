From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v5 1/7] i2c: designware: Cleaning and comment style fixes.
Date: Wed, 28 Dec 2016 14:43:20 +0000
Message-ID: <1e838e350479fe3e0d0e5f4a7fcd15c03fe53e1c.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:42747 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbcL1Org (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Dec 2016 09:47:36 -0500
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

The purpose of this commit is to fix some comments and styling issues 
in the existing code due to the need of reuse this code. What is being 
made here is:

- Sorted the headers files
- Corrected some comments style
- Reverse tree in the variables declaration
- Add/remove empty lines and tabs where needed
- Fix of a misspelled word

The value of this, besides the rules of coding style, is because I
will use this code after and it will make my future patch a lot bigger 
and complicated to review. The work here won't bring any additional work
to backported fixes because is just style and reordering.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V5 (Jarkko): 
- This patch was submitted by it self and it god ACK. I need it in the 
  patchset because the next patch relly on this one.
- Also fixed the commit length.

 drivers/i2c/busses/i2c-designware-core.c    | 36 ++++++++++++++---------------
 drivers/i2c/busses/i2c-designware-platdrv.c | 27 +++++++++++-----------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6d81c56184d3..9d724a6a7ec8 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -21,17 +21,17 @@
  * ----------------------------------------------------------------------------
  *
  */
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/pm_runtime.h>
-#include <linux/delay.h>
 #include <linux/module.h>
-#include "i2c-designware-core.h"
+#include <linux/pm_runtime.h>
 
+#include "i2c-designware-core.h"
 /*
  * Registers offset
  */
@@ -98,7 +98,7 @@
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
-#define DW_IC_TAR_10BITADDR_MASTER BIT(12)
+#define DW_IC_TAR_10BITADDR_MASTER		BIT(12)
 
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH	(BIT(2) | BIT(3))
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_MASK	GENMASK(3, 2)
@@ -113,10 +113,10 @@
 #define TIMEOUT			20 /* ms */
 
 /*
- * hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
+ * Hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
  *
- * only expected abort codes are listed here
- * refer to the datasheet for the full list
+ * Only expected abort codes are listed here,
+ * refer to the datasheet for the full list.
  */
 #define ABRT_7B_ADDR_NOACK	0
 #define ABRT_10ADDR1_NOACK	1
@@ -338,14 +338,14 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
-		/* Configure register endianess access */
+		/* Configure register endianness access */
 		dev->accessor_flags |= ACCESS_SWAP;
 	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
 		/* Configure register access mode 16bit */
 		dev->accessor_flags |= ACCESS_16BIT;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
-		dev_err(dev->dev, "Unknown Synopsys component type: "
-			"0x%08x\n", reg);
+		dev_err(dev->dev,
+			"Unknown Synopsys component type: 0x%08x\n", reg);
 		i2c_dw_release_lock(dev);
 		return -ENODEV;
 	}
@@ -355,7 +355,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	/* Disable the adapter */
 	__i2c_dw_enable_and_wait(dev, false);
 
-	/* set standard and fast speed deviders for high/low periods */
+	/* Set standard and fast speed deviders for high/low periods */
 
 	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
 	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
@@ -444,7 +444,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
 	dw_writel(dev, 0, DW_IC_RX_TL);
 
-	/* configure the i2c master */
+	/* Configure the I2C master */
 	dw_writel(dev, dev->master_cfg , DW_IC_CON);
 
 	i2c_dw_release_lock(dev);
@@ -480,7 +480,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	/* Disable the adapter */
 	__i2c_dw_enable_and_wait(dev, false);
 
-	/* if the slave address is ten bit address, enable 10BITADDR */
+	/* If the slave address is ten bit address, enable 10BITADDR */
 	if (dev->dynamic_tar_update_enabled) {
 		/*
 		 * If I2C_DYNAMIC_TAR_UPDATE is set, the 10-bit addressing
@@ -505,7 +505,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	 */
 	dw_writel(dev, msgs[dev->msg_write_idx].addr | ic_tar, DW_IC_TAR);
 
-	/* enforce disabled interrupts (due to HW issues) */
+	/* Enforce disabled interrupts (due to HW issues) */
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
@@ -539,7 +539,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		u32 flags = msgs[dev->msg_write_idx].flags;
 
 		/*
-		 * if target address has changed, we need to
+		 * If target address has changed, we need to
 		 * reprogram the target address in the i2c
 		 * adapter when we are done with this transfer
 		 */
@@ -601,7 +601,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
 
-				/* avoid rx buffer overrun */
+				/* Avoid rx buffer overrun */
 				if (dev->rx_outstanding >= dev->rx_fifo_depth)
 					break;
 
@@ -905,7 +905,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 		/*
 		 * Anytime TX_ABRT is set, the contents of the tx/rx
-		 * buffers are flushed.  Make sure to skip them.
+		 * buffers are flushed. Make sure to skip them.
 		 */
 		dw_writel(dev, 0, DW_IC_INTR_MASK);
 		goto tx_aborted;
@@ -927,7 +927,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
 	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
-		/* workaround to trigger pending interrupt */
+		/* Workaround to trigger pending interrupt */
 		stat = dw_readl(dev, DW_IC_INTR_MASK);
 		i2c_dw_disable_int(dev);
 		dw_writel(dev, stat, DW_IC_INTR_MASK);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6ce431323125..4070baea4fb9 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -21,26 +21,27 @@
  * ----------------------------------------------------------------------------
  *
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
-#include <linux/i2c.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_data/i2c-designware.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
-#include <linux/io.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
-#include <linux/platform_data/i2c-designware.h>
+
 #include "i2c-designware-core.h"
 
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
@@ -176,11 +177,11 @@ static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
+	struct dw_i2c_dev *dev;
+	u32 acpi_speed, ht = 0;
 	struct resource *mem;
 	int irq, r;
-	u32 acpi_speed, ht = 0;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -371,7 +372,7 @@ static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 #define DW_I2C_DEV_PMOPS NULL
 #endif
 
-/* work with hotplug and coldplug */
+/* Work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
-- 
2.11.0
