From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] i2c: meson: implement the master_xfer_atomic callback
Date: Wed,  8 Jan 2020 00:29:01 +0100
Message-ID: <20200107232901.891177-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, wsa@the-dreams.de
Cc: khilman@baylibre.com, narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.galvani@gmail.com, jian.hu@amlogic.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-i2c@vger.kernel.org

Boards with some of the 32-bit SoCs (mostly Meson8 and Meson8m2) use a
Ricoh RN5T618 PMU which acts as system power controller. The driver for
the system power controller may need to the I2C bus just before shutting
down or rebooting the system. At this stage the interrupts may be
disabled already.

Implement the master_xfer_atomic callback so the driver for the RN5T618
PMU can communicate properly with the PMU when shutting down or
rebooting the board. The CTRL register has a status bit which can be
polled to determine when processing has completed. According to the
public S805 datasheet the value 0 means "idle" and 1 means "running".

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/i2c/busses/i2c-meson.c | 97 +++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 1e2647f9a2a7..7486b46e475f 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -213,6 +214,30 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 	writel(i2c->tokens[1], i2c->regs + REG_TOK_LIST1);
 }
 
+static void meson_i2c_transfer_complete(struct meson_i2c *i2c, u32 ctrl)
+{
+	if (ctrl & REG_CTRL_ERROR) {
+		/*
+		 * The bit is set when the IGNORE_NAK bit is cleared
+		 * and the device didn't respond. In this case, the
+		 * I2C controller automatically generates a STOP
+		 * condition.
+		 */
+		dev_dbg(i2c->dev, "error bit set\n");
+		i2c->error = -ENXIO;
+		i2c->state = STATE_IDLE;
+	} else {
+		if (i2c->state == STATE_READ && i2c->count)
+			meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos,
+					   i2c->count);
+
+		i2c->pos += i2c->count;
+
+		if (i2c->pos >= i2c->msg->len)
+			i2c->state = STATE_IDLE;
+	}
+}
+
 static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 {
 	struct meson_i2c *i2c = dev_id;
@@ -232,27 +257,9 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (ctrl & REG_CTRL_ERROR) {
-		/*
-		 * The bit is set when the IGNORE_NAK bit is cleared
-		 * and the device didn't respond. In this case, the
-		 * I2C controller automatically generates a STOP
-		 * condition.
-		 */
-		dev_dbg(i2c->dev, "error bit set\n");
-		i2c->error = -ENXIO;
-		i2c->state = STATE_IDLE;
-		complete(&i2c->done);
-		goto out;
-	}
-
-	if (i2c->state == STATE_READ && i2c->count)
-		meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
+	meson_i2c_transfer_complete(i2c, ctrl);
 
-	i2c->pos += i2c->count;
-
-	if (i2c->pos >= i2c->msg->len) {
-		i2c->state = STATE_IDLE;
+	if (i2c->state == STATE_IDLE) {
 		complete(&i2c->done);
 		goto out;
 	}
@@ -279,10 +286,11 @@ static void meson_i2c_do_start(struct meson_i2c *i2c, struct i2c_msg *msg)
 }
 
 static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
-			      int last)
+			      int last, bool atomic)
 {
 	unsigned long time_left, flags;
 	int ret = 0;
+	u32 ctrl;
 
 	i2c->msg = msg;
 	i2c->last = last;
@@ -300,13 +308,24 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
 
 	i2c->state = (msg->flags & I2C_M_RD) ? STATE_READ : STATE_WRITE;
 	meson_i2c_prepare_xfer(i2c);
-	reinit_completion(&i2c->done);
+
+	if (!atomic)
+		reinit_completion(&i2c->done);
 
 	/* Start the transfer */
 	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, REG_CTRL_START);
 
-	time_left = msecs_to_jiffies(I2C_TIMEOUT_MS);
-	time_left = wait_for_completion_timeout(&i2c->done, time_left);
+	if (atomic) {
+		ret = readl_poll_timeout_atomic(i2c->regs + REG_CTRL, ctrl,
+						!(ctrl & REG_CTRL_STATUS),
+						10, I2C_TIMEOUT_MS * 1000);
+	} else {
+		time_left = msecs_to_jiffies(I2C_TIMEOUT_MS);
+		time_left = wait_for_completion_timeout(&i2c->done, time_left);
+
+		if (!time_left)
+			ret = -ETIMEDOUT;
+	}
 
 	/*
 	 * Protect access to i2c struct and registers from interrupt
@@ -315,13 +334,14 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
 	 */
 	spin_lock_irqsave(&i2c->lock, flags);
 
+	if (atomic && !ret)
+		meson_i2c_transfer_complete(i2c, ctrl);
+
 	/* Abort any active operation */
 	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
 
-	if (!time_left) {
+	if (ret)
 		i2c->state = STATE_IDLE;
-		ret = -ETIMEDOUT;
-	}
 
 	if (i2c->error)
 		ret = i2c->error;
@@ -331,8 +351,8 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
 	return ret;
 }
 
-static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			  int num)
+static int meson_i2c_xfer_messages(struct i2c_adapter *adap,
+				   struct i2c_msg *msgs, int num, bool atomic)
 {
 	struct meson_i2c *i2c = adap->algo_data;
 	int i, ret = 0;
@@ -340,7 +360,7 @@ static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	clk_enable(i2c->clk);
 
 	for (i = 0; i < num; i++) {
-		ret = meson_i2c_xfer_msg(i2c, msgs + i, i == num - 1);
+		ret = meson_i2c_xfer_msg(i2c, msgs + i, i == num - 1, atomic);
 		if (ret)
 			break;
 	}
@@ -350,14 +370,27 @@ static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	return ret ?: i;
 }
 
+static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			  int num)
+{
+	return meson_i2c_xfer_messages(adap, msgs, num, false);
+}
+
+static int meson_i2c_xfer_atomic(struct i2c_adapter *adap,
+				 struct i2c_msg *msgs, int num)
+{
+	return meson_i2c_xfer_messages(adap, msgs, num, true);
+}
+
 static u32 meson_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static const struct i2c_algorithm meson_i2c_algorithm = {
-	.master_xfer	= meson_i2c_xfer,
-	.functionality	= meson_i2c_func,
+	.master_xfer		= meson_i2c_xfer,
+	.master_xfer_atomic	= meson_i2c_xfer_atomic,
+	.functionality		= meson_i2c_func,
 };
 
 static int meson_i2c_probe(struct platform_device *pdev)
-- 
2.24.1
