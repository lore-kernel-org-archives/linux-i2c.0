From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH 1/3] i2c_intel_mid: Improve error reporting
Date: Tue, 25 Jan 2011 14:20:48 +0000
Message-ID: <20110125142040.9472.88734.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Catalin Popescu <catalinx.popescu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

The error messages printed from mrst_i2c_abort() didn't give slave address info.

But I2C device driver developers always need this to check which slave device
has the problem.

This patch enhances the error message format by adding slave address info to
each error message.

Signed-off-by: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[Ported to upstream driver branch and tidied a spot]
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-intel-mid.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)


diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index c714927..cfb0bb3 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -78,7 +78,7 @@ struct intel_mid_i2c_private {
 	void __iomem *base;
 	int speed;
 	struct completion complete;
-	int abort;
+	u32 abort;
 	u8 *rx_buf;
 	int rx_buf_len;
 	enum mid_i2c_status status;
@@ -464,9 +464,15 @@ static inline bool intel_mid_i2c_address_neq(const struct i2c_msg *p1,
 static void intel_mid_i2c_abort(struct intel_mid_i2c_private *i2c)
 {
 	/* Read about source register */
-	int abort = i2c->abort;
+	u32 abort = i2c->abort;
 	struct i2c_adapter *adap = &i2c->adap;
 
+	if (abort & (ABRT_MASTER_DIS | ABRT_10B_RD_NORSTRT |
+	    ABRT_SBYTE_NORSTRT | ABRT_SBYTE_ACKDET | ABRT_TXDATA_NOACK |
+	    ABRT_10ADDR2_NOACK | ABRT_10ADDR1_NOACK | ABRT_7B_ADDR_NOACK))
+		dev_err(&adap->dev, "i2c abort on address 0x%x\n",
+							i2c->msg->addr);
+
 	/* Single transfer error check:
 	 * According to databook, TX/RX FIFOs would be flushed when
 	 * the abort interrupt occured.
@@ -550,7 +556,8 @@ static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
 	i2c->status = STATUS_READ_START;
 	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
 	if (!err) {
-		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
+		dev_err(&adap->dev, "Timeout for ACK from I2C slave 0x%x\n",
+						i2c->msg->addr);
 		intel_mid_i2c_hwinit(i2c);
 		return -ETIMEDOUT;
 	}
@@ -602,7 +609,8 @@ static int xfer_write(struct i2c_adapter *adap,
 	i2c->status = STATUS_WRITE_START;
 	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
 	if (!err) {
-		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
+		dev_err(&adap->dev, "Timeout for ACK from I2C slave 0x%x\n",
+							i2c->msg->addr);
 		intel_mid_i2c_hwinit(i2c);
 		return -ETIMEDOUT;
 	} else {
