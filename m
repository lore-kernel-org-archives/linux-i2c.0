From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH 2/2] i2c-intel-mid: improve timeout handling
Date: Wed, 24 Nov 2010 14:49:21 +0000
Message-ID: <20101124144920.10210.36601.stgit@bob.linux.org.uk>
References: <20101124144904.10210.90314.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101124144904.10210.90314.stgit-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

The old solution for i2c xfer timeout was to set timeout value to one second
for all i2c xfers.  That's not reasonable for all of the various speed modes
and data lengths.

This patch sets the xfer_read timeout value based on both bus speed and data
length.

Signed-off-by: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[Ported to the upstream branch and extracted as a helper function]
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-intel-mid.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)


diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index bdf17da..b39abd8 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -303,6 +303,29 @@ static int ctl_num = 6;
 module_param_array(speed_mode, int, &ctl_num, S_IRUGO);
 MODULE_PARM_DESC(speed_mode, "Set the speed of the i2c interface (0-2)");
 
+/* Timeout and delay bases for the speed modes */
+static const u16 xfer_timeout[NUM_SPEEDS] = {100, 25, 3};
+
+/**
+ * xfer_wait	-	wait for a transfer to complete
+ * @adapt: i2c interface
+ * @len: length of message
+ *
+ * Wait for completion or timeout of a message. The timeout depends upon
+ * the speed of the interface and the message length
+ *
+ * Returns the result of the wait for completion
+ */
+
+static int xfer_wait(struct intel_mid_i2c_private *i2c, int len)
+{
+	unsigned long timeout;
+
+	timeout = msecs_to_jiffies(len * xfer_timeout[i2c->speed]);
+	return wait_for_completion_interruptible_timeout(&i2c->complete,
+								timeout);
+}
+
 /**
  * intel_mid_i2c_disable - Disable I2C controller
  * @adap: struct pointer to i2c_adapter
@@ -322,7 +345,6 @@ static int intel_mid_i2c_disable(struct i2c_adapter *adap)
 	int err = 0;
 	int count = 0;
 	int ret1, ret2;
-	static const u16 delay[NUM_SPEEDS] = {100, 25, 3};
 
 	/* Set IC_ENABLE to 0 */
 	writel(0, i2c->base + IC_ENABLE);
@@ -331,7 +353,7 @@ static int intel_mid_i2c_disable(struct i2c_adapter *adap)
 	dev_dbg(&adap->dev, "mrst i2c disable\n");
 	while ((ret1 = readl(i2c->base + IC_ENABLE_STATUS) & 0x1)
 		|| (ret2 = readl(i2c->base + IC_STATUS) & 0x1)) {
-		udelay(delay[i2c->speed]);
+		udelay(xfer_timeout[i2c->speed]);
 		writel(0, i2c->base + IC_ENABLE);
 		dev_dbg(&adap->dev, "i2c is busy, count is %d speed %d\n",
 			count, i2c->speed);
@@ -513,6 +535,7 @@ static void intel_mid_i2c_abort(struct intel_mid_i2c_private *i2c)
 	i2c->status = STATUS_XFER_ABORT;
 }
 
+
 /**
  * xfer_read - Internal function to implement master read transfer.
  * @adap: i2c_adapter struct pointer
@@ -554,7 +577,7 @@ static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
 		writel(IC_RD, i2c->base + IC_DATA_CMD);
 
 	i2c->status = STATUS_READ_START;
-	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
+	err = xfer_wait(i2c, length);
 	if (!err) {
 		dev_err(&adap->dev, "Timeout for ACK from I2C slave 0x%x\n",
 						i2c->msg->addr);
@@ -607,7 +630,7 @@ static int xfer_write(struct i2c_adapter *adap,
 		writel((u16)(*(buf + i)), i2c->base + IC_DATA_CMD);
 
 	i2c->status = STATUS_WRITE_START;
-	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
+	err = xfer_wait(i2c, length);
 	if (!err) {
 		dev_err(&adap->dev, "Timeout for ACK from I2C slave 0x%x\n",
 							i2c->msg->addr);
