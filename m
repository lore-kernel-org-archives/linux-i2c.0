From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Thu, 31 Mar 2016 23:47:46 -0300
Message-ID: <1459478866-3896-1-git-send-email-lucas.de.marchi@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35541 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757866AbcDACsM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 31 Mar 2016 22:48:12 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, christian.ruppert@alitech.com

From: Lucas De Marchi <lucas.demarchi@intel.com>

Disabling the adapter after each transfer is pretty bad for sensors and
other devices doing small transfers at a high rate. It slows down the
transfer rate a lot since each of them have to wait the adapter to be
enabled again.

It was done in order to avoid the adapter to generate interrupts when
it's not being used. Instead of doing that here we just disable the
interrupt generation in the controller. With a small program test to
read/write registers in a sensor the speed doubled. Example below with
write sequences of 16 bytes:

Before:
	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
	num_transfers=20000
	transfer_time_avg=1032.728500us

After:
	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
	num_transfers=20000
	transfer_time_avg=470.256050us

During the init we check the status register for no activity and TX
buffer being empty since otherwise we can't change IC_TAR dynamically.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

Mika / Christian,

This is a second approach to a patch sent last year:
https://patchwork.ozlabs.org/patch/481952/

I hope that now it's in a better form. This has been tested on a Baytrail soc
(MinnowBoard Turbot) and is working. Would be nice to know if it also works on
Christian's machine since it was the one giving problems.  Christian, could you
give this a try?  It has been tested on top of 4.4.6 (+ some backports) and
4.6.0-rc1.

thanks!
Lucas De Marchi

 drivers/i2c/busses/i2c-designware-core.c | 50 ++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 99b54be..f8e6f2b 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -90,6 +90,7 @@
 					 DW_IC_INTR_STOP_DET)
 
 #define DW_IC_STATUS_ACTIVITY	0x1
+#define DW_IC_STATUS_TX_EMPTY	0x2
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
@@ -383,6 +384,8 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	/* configure the i2c master */
 	dw_writel(dev, dev->master_cfg , DW_IC_CON);
 
+	__i2c_dw_enable(dev, true);
+
 	if (dev->release_lock)
 		dev->release_lock(dev);
 	return 0;
@@ -412,9 +415,16 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 ic_con, ic_tar = 0;
-
-	/* Disable the adapter */
-	__i2c_dw_enable(dev, false);
+	bool need_reenable = false;
+	u32 ic_status;
+
+	/* check ic_tar and ic_con can be dynamically updated */
+	ic_status = dw_readl(dev, DW_IC_STATUS);
+	if (ic_status & DW_IC_STATUS_ACTIVITY
+		|| !(ic_status & DW_IC_STATUS_TX_EMPTY)) {
+		need_reenable = true;
+		__i2c_dw_enable(dev, false);
+	}
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
 	ic_con = dw_readl(dev, DW_IC_CON);
@@ -442,8 +452,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	/* enforce disabled interrupts (due to HW issues) */
 	i2c_dw_disable_int(dev);
 
-	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	if (need_reenable)
+		__i2c_dw_enable(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
@@ -624,7 +634,8 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 }
 
 /*
- * Prepare controller for a transaction and call i2c_dw_xfer_msg
+ * Prepare controller for a transaction and start transfer by calling
+ * i2c_dw_xfer_init()
  */
 static int
 i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
@@ -665,22 +676,11 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	/* wait for tx to complete */
 	if (!wait_for_completion_timeout(&dev->cmd_complete, HZ)) {
 		dev_err(dev->dev, "controller timed out\n");
-		/* i2c_dw_init implicitly disables the adapter */
 		i2c_dw_init(dev);
 		ret = -ETIMEDOUT;
 		goto done;
 	}
 
-	/*
-	 * We must disable the adapter before returning and signaling the end
-	 * of the current transfer. Otherwise the hardware might continue
-	 * generating interrupts which in turn causes a race condition with
-	 * the following transfer.  Needs some more investigation if the
-	 * additional interrupts are a hardware bug or this driver doesn't
-	 * handle them correctly yet.
-	 */
-	__i2c_dw_enable(dev, false);
-
 	if (dev->msg_err) {
 		ret = dev->msg_err;
 		goto done;
@@ -818,9 +818,21 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	 */
 
 tx_aborted:
-	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
+	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
+			|| dev->msg_err) {
+		/*
+		 * We must disable interruts before returning and signaling
+		 * the end of the current transfer. Otherwise the hardware
+		 * might continue generating interrupts which in turn causes a
+		 * race condition with next transfer.  Needs some more
+		 * investigation if the additional interrupts are a hardware
+		 * bug or this driver doesn't handle them correctly yet.
+		 */
+		i2c_dw_disable_int(dev);
+		dw_readl(dev, DW_IC_CLR_INTR);
+
 		complete(&dev->cmd_complete);
-	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
+	} else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
 		/* workaround to trigger pending interrupt */
 		stat = dw_readl(dev, DW_IC_INTR_MASK);
 		i2c_dw_disable_int(dev);
-- 
2.5.5
