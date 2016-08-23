From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v4 4/4] i2c: designware: do not disable adapter after transfer
Date: Tue, 23 Aug 2016 19:18:56 -0300
Message-ID: <1471990736-30190-5-git-send-email-lucas.demarchi@intel.com>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Lucas De Marchi <lucas.demarchi@intel.com>, =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
List-Id: linux-i2c@vger.kernel.org

Disabling the adapter after each transfer adds additional delays
for each I2C transfer. Even if we don't wait for it to be disabled
anymore, on next transfer we will need to if we have several transfers
in a row.

Now during the transfer init we check if IC_TAR can be changed
dynamically, the status register for no activity and TX buffer being
empty. In this case we don't need to disable it

When a transfer fails the adapter will still be disabled - this is a
conservative approach. When transfers succeed, the adapter is left
enabled and it's configured so to disable interrupts.

Alternating register reads on 2 slaves:
perf stat -r4 chrt -f 10 ./i2c-test /dev/i2c-1 25000 0x40 0x6 0x1e 0x00

Before:
	8.638705161 seconds time elapsed                  ( +-  5.90% )
After:
	7.516821591 seconds time elapsed                  ( +-  0.11% )

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 55 +++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index b855beb..e7f0285 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -89,7 +89,9 @@
 					 DW_IC_INTR_TX_ABRT | \
 					 DW_IC_INTR_STOP_DET)
 
-#define DW_IC_STATUS_ACTIVITY	0x1
+#define DW_IC_STATUS_ACTIVITY		0x1
+#define DW_IC_STATUS_TFE		BIT(2)
+#define DW_IC_STATUS_MST_ACTIVITY	BIT(5)
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
@@ -434,9 +436,25 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 ic_tar = 0;
+	bool enabled;
 
-	/* Disable the adapter */
-	__i2c_dw_enable_and_wait(dev, false);
+	enabled = dw_readl(dev, DW_IC_ENABLE_STATUS) & 1;
+
+	if (enabled) {
+		u32 ic_status;
+
+		/*
+		 * Only disable adapter if ic_tar and ic_con can't be
+		 * dynamically updated
+		 */
+		ic_status = dw_readl(dev, DW_IC_STATUS);
+		if (!dev->dynamic_tar_update_enabled ||
+		    (ic_status & DW_IC_STATUS_MST_ACTIVITY) ||
+		    !(ic_status & DW_IC_STATUS_TFE)) {
+			__i2c_dw_enable_and_wait(dev, false);
+			enabled = false;
+		}
+	}
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
 	if (dev->dynamic_tar_update_enabled) {
@@ -465,8 +483,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	/* enforce disabled interrupts (due to HW issues) */
 	i2c_dw_disable_int(dev);
 
-	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	if (!enabled)
+		__i2c_dw_enable(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
@@ -647,7 +665,8 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 }
 
 /*
- * Prepare controller for a transaction and call i2c_dw_xfer_msg
+ * Prepare controller for a transaction and start transfer by calling
+ * i2c_dw_xfer_init()
  */
 static int
 i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
@@ -690,16 +709,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
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
@@ -836,9 +845,19 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	 */
 
 tx_aborted:
-	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
+	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
+			|| dev->msg_err) {
+		/*
+		 * We must disable interruts before returning and signaling
+		 * the end of the current transfer. Otherwise the hardware
+		 * might continue generating interrupts for non-existent
+		 * transfers.
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
2.7.4
