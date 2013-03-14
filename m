From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/3] i2c: mxs: always end a transfer with a proper STOP
Date: Thu, 14 Mar 2013 12:49:08 +0100
Message-ID: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Our transfers always start with the device address, so there is never a
situation where we just do a restart transfer. Full blown transfers should
always end with a STOP as per i2c spec.

Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 120f246..f9704b2 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -87,10 +87,12 @@
 				 MXS_I2C_CTRL0_XFER_COUNT(1))
 
 #define MXS_CMD_I2C_WRITE	(MXS_I2C_CTRL0_PRE_SEND_START |	\
+				 MXS_I2C_CTRL0_POST_SEND_STOP | \
 				 MXS_I2C_CTRL0_MASTER_MODE |	\
 				 MXS_I2C_CTRL0_DIRECTION)
 
 #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
+				 MXS_I2C_CTRL0_POST_SEND_STOP | \
 				 MXS_I2C_CTRL0_MASTER_MODE)
 
 /**
@@ -158,8 +160,7 @@ static void mxs_i2c_dma_irq_callback(void *param)
 	mxs_i2c_dma_finish(i2c);
 }
 
-static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
-			struct i2c_msg *msg, uint32_t flags)
+static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
 {
 	struct dma_async_tx_descriptor *desc;
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
@@ -200,7 +201,7 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 		 */
 
 		/* Queue the PIO register write transfer. */
-		i2c->pio_data[1] = flags | MXS_CMD_I2C_READ |
+		i2c->pio_data[1] = MXS_CMD_I2C_READ |
 				MXS_I2C_CTRL0_XFER_COUNT(msg->len);
 		desc = dmaengine_prep_slave_sg(i2c->dmach,
 					(struct scatterlist *)&i2c->pio_data[1],
@@ -231,7 +232,7 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 		 */
 
 		/* Queue the PIO register write transfer. */
-		i2c->pio_data[0] = flags | MXS_CMD_I2C_WRITE |
+		i2c->pio_data[0] = MXS_CMD_I2C_WRITE |
 				MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1);
 		desc = dmaengine_prep_slave_sg(i2c->dmach,
 					(struct scatterlist *)&i2c->pio_data[0],
@@ -326,8 +327,7 @@ static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c)
 	return 0;
 }
 
-static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
-			struct i2c_msg *msg, uint32_t flags)
+static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
 {
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 	uint32_t addr_data = msg->addr << 1;
@@ -355,7 +355,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			return ret;
 
 		/* READ command. */
-		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_READ | flags |
+		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_READ |
 			MXS_I2C_CTRL0_XFER_COUNT(msg->len),
 			i2c->regs + MXS_I2C_CTRL0);
 
@@ -373,7 +373,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		addr_data |= I2C_SMBUS_WRITE;
 
 		/* WRITE command. */
-		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_WRITE | flags |
+		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_WRITE |
 			MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1),
 			i2c->regs + MXS_I2C_CTRL0);
 
@@ -418,17 +418,13 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 /*
  * Low level master read/write transaction.
  */
-static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
-				int stop)
+static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg)
 {
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 	int ret;
-	int flags;
 
-	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
-
-	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
-		msg->addr, msg->len, msg->flags, stop);
+	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x\n",
+		msg->addr, msg->len, msg->flags);
 
 	if (msg->len == 0)
 		return -EINVAL;
@@ -440,13 +436,13 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	 * based on this empirical measurement and a lot of previous frobbing.
 	 */
 	if (msg->len < 8) {
-		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
+		ret = mxs_i2c_pio_setup_xfer(adap, msg);
 		if (ret)
 			mxs_i2c_reset(i2c);
 	} else {
 		i2c->cmd_err = 0;
 		INIT_COMPLETION(i2c->cmd_complete);
-		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
+		ret = mxs_i2c_dma_setup_xfer(adap, msg);
 		if (ret)
 			return ret;
 
@@ -479,7 +475,7 @@ static int mxs_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int err;
 
 	for (i = 0; i < num; i++) {
-		err = mxs_i2c_xfer_msg(adap, &msgs[i], i == (num - 1));
+		err = mxs_i2c_xfer_msg(adap, &msgs[i]);
 		if (err)
 			return err;
 	}
-- 
1.7.10.4
