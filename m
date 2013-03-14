From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/3] i2c: mxs: do error checking and handling in PIO mode
Date: Thu, 14 Mar 2013 12:49:10 +0100
Message-ID: <1363261750-26645-3-git-send-email-l.stach@pengutronix.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363261750-26645-1-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In PIO mode we can end up with the same errors as in DMA mode, but as IRQs
are disabled there we have to check for them manually after each command.

Also don't use the big controller reset hammer when receiving a NAK from a
slave. It's sufficient to tell the controller to continue at a clean state.

Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index e8f07dc..c982670 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -56,6 +56,7 @@
 #define MXS_I2C_CTRL1_SET	(0x44)
 #define MXS_I2C_CTRL1_CLR	(0x48)
 
+#define MXS_I2C_CTRL1_CLR_GOT_A_NAK		0x10000000
 #define MXS_I2C_CTRL1_BUS_FREE_IRQ		0x80
 #define MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ	0x40
 #define MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ		0x20
@@ -341,6 +342,23 @@ static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c, int last)
 	return 0;
 }
 
+static int mxs_i2c_pio_check_error_state(struct mxs_i2c_dev *i2c)
+{
+	u32 state;
+
+	state = readl(i2c->regs + MXS_I2C_CTRL1_CLR) & MXS_I2C_IRQ_MASK;
+
+	if (state & MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ)
+		i2c->cmd_err = -ENXIO;
+	else if (state & (MXS_I2C_CTRL1_EARLY_TERM_IRQ |
+			  MXS_I2C_CTRL1_MASTER_LOSS_IRQ |
+			  MXS_I2C_CTRL1_SLAVE_STOP_IRQ |
+			  MXS_I2C_CTRL1_SLAVE_IRQ))
+		i2c->cmd_err = -EIO;
+
+	return i2c->cmd_err;
+}
+
 static void mxs_i2c_pio_trigger_cmd(struct mxs_i2c_dev *i2c, u32 cmd)
 {
 	u32 reg;
@@ -380,6 +398,9 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
 		if (ret)
 			return ret;
 
+		if (mxs_i2c_pio_check_error_state(i2c))
+			goto cleanup;
+
 		/* READ command. */
 		mxs_i2c_pio_trigger_cmd(i2c, MXS_CMD_I2C_READ |
 					MXS_I2C_CTRL0_XFER_COUNT(msg->len));
@@ -438,6 +459,10 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
 	if (ret)
 		return ret;
 
+	/* make sure we capture any occurred error into cmd_err */
+	mxs_i2c_pio_check_error_state(i2c);
+
+cleanup:
 	/* Clear any dangling IRQs and re-enable interrupts. */
 	writel(MXS_I2C_IRQ_MASK, i2c->regs + MXS_I2C_CTRL1_CLR);
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
@@ -465,12 +490,12 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg)
 	 * using PIO mode while longer transfers use DMA. The 8 byte border is
 	 * based on this empirical measurement and a lot of previous frobbing.
 	 */
+	i2c->cmd_err = 0;
 	if (msg->len < 8) {
 		ret = mxs_i2c_pio_setup_xfer(adap, msg);
 		if (ret)
 			mxs_i2c_reset(i2c);
 	} else {
-		i2c->cmd_err = 0;
 		INIT_COMPLETION(i2c->cmd_complete);
 		ret = mxs_i2c_dma_setup_xfer(adap, msg);
 		if (ret)
@@ -480,13 +505,19 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg)
 						msecs_to_jiffies(1000));
 		if (ret == 0)
 			goto timeout;
+	}
 
-		if (i2c->cmd_err == -ENXIO)
-			mxs_i2c_reset(i2c);
-
-		ret = i2c->cmd_err;
+	if (i2c->cmd_err == -ENXIO) {
+		/*
+		 * If the transfer fails with a NAK from the slave the
+		 * controller halts until it gets told to return to idle state.
+		 */
+		writel(MXS_I2C_CTRL1_CLR_GOT_A_NAK,
+		       i2c->regs + MXS_I2C_CTRL1_SET);
 	}
 
+	ret = i2c->cmd_err;
+
 	dev_dbg(i2c->dev, "Done with err=%d\n", ret);
 
 	return ret;
-- 
1.7.10.4
