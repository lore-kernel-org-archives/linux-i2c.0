From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] Revert "i2c: designware: do not disable adapter after transfer"
Date: Fri, 25 Nov 2016 17:22:27 +0200
Message-ID: <20161125152227.24396-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:5872 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755305AbcKYPWm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 25 Nov 2016 10:22:42 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>

This reverts commit 0317e6c0f1dc1ba86b8d9dccc010c5e77b8355fa.

Srinivas reported recently touchscreen and touchpad stopped working in
Haswell based machine in Linux 4.9-rc series with timeout errors from
i2c_designware:

[   16.508013] i2c_designware INT33C3:00: controller timed out
[   16.508302] i2c_hid i2c-MSFT0001:02: failed to change power setting.
[   17.532016] i2c_designware INT33C3:00: controller timed out
[   18.556022] i2c_designware INT33C3:00: controller timed out
[   18.556315] i2c_hid i2c-ATML1000:00: failed to retrieve report from device.

I managed to reproduce similar errors on another Haswell based machine
where touchscreen initialization fails maybe in every 1/5 - 1/2 boots.
Since root cause for these errors is not clear yet and debugging is
ongoing it's better to revert this commit as we are near to release.

Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Also https://bugzilla.kernel.org/show_bug.cgi?id=188501 may relate to
that but that's not confirmed yet with the reporter does revert help.
---
 drivers/i2c/busses/i2c-designware-core.c | 55 +++++++++++---------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c53058d6139c..b403fa5ecf49 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -91,9 +91,7 @@
 					 DW_IC_INTR_TX_ABRT | \
 					 DW_IC_INTR_STOP_DET)
 
-#define DW_IC_STATUS_ACTIVITY		0x1
-#define DW_IC_STATUS_TFE		BIT(2)
-#define DW_IC_STATUS_MST_ACTIVITY	BIT(5)
+#define DW_IC_STATUS_ACTIVITY	0x1
 
 #define DW_IC_SDA_HOLD_RX_SHIFT		16
 #define DW_IC_SDA_HOLD_RX_MASK		GENMASK(23, DW_IC_SDA_HOLD_RX_SHIFT)
@@ -478,25 +476,9 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 ic_tar = 0;
-	bool enabled;
 
-	enabled = dw_readl(dev, DW_IC_ENABLE_STATUS) & 1;
-
-	if (enabled) {
-		u32 ic_status;
-
-		/*
-		 * Only disable adapter if ic_tar and ic_con can't be
-		 * dynamically updated
-		 */
-		ic_status = dw_readl(dev, DW_IC_STATUS);
-		if (!dev->dynamic_tar_update_enabled ||
-		    (ic_status & DW_IC_STATUS_MST_ACTIVITY) ||
-		    !(ic_status & DW_IC_STATUS_TFE)) {
-			__i2c_dw_enable_and_wait(dev, false);
-			enabled = false;
-		}
-	}
+	/* Disable the adapter */
+	__i2c_dw_enable_and_wait(dev, false);
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
 	if (dev->dynamic_tar_update_enabled) {
@@ -526,8 +508,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	/* enforce disabled interrupts (due to HW issues) */
 	i2c_dw_disable_int(dev);
 
-	if (!enabled)
-		__i2c_dw_enable(dev, true);
+	/* Enable the adapter */
+	__i2c_dw_enable(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
@@ -708,8 +690,7 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 }
 
 /*
- * Prepare controller for a transaction and start transfer by calling
- * i2c_dw_xfer_init()
+ * Prepare controller for a transaction and call i2c_dw_xfer_msg
  */
 static int
 i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
@@ -752,6 +733,16 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		goto done;
 	}
 
+	/*
+	 * We must disable the adapter before returning and signaling the end
+	 * of the current transfer. Otherwise the hardware might continue
+	 * generating interrupts which in turn causes a race condition with
+	 * the following transfer.  Needs some more investigation if the
+	 * additional interrupts are a hardware bug or this driver doesn't
+	 * handle them correctly yet.
+	 */
+	__i2c_dw_enable(dev, false);
+
 	if (dev->msg_err) {
 		ret = dev->msg_err;
 		goto done;
@@ -893,19 +884,9 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	 */
 
 tx_aborted:
-	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
-			|| dev->msg_err) {
-		/*
-		 * We must disable interruts before returning and signaling
-		 * the end of the current transfer. Otherwise the hardware
-		 * might continue generating interrupts for non-existent
-		 * transfers.
-		 */
-		i2c_dw_disable_int(dev);
-		dw_readl(dev, DW_IC_CLR_INTR);
-
+	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
-	} else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
+	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
 		/* workaround to trigger pending interrupt */
 		stat = dw_readl(dev, DW_IC_INTR_MASK);
 		i2c_dw_disable_int(dev);
-- 
2.10.2
