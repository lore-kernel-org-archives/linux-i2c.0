From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Mon,  1 Jul 2013 17:41:43 -0300
Message-ID: <1372711303-17705-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Recently we have been seing some reports about PIO mode not working properly.

- http://www.spinics.net/lists/linux-i2c/msg11985.html
- http://marc.info/?l=linux-i2c&m=137235593101385&w=2
- https://lkml.org/lkml/2013/6/24/430

Let's use DMA mode even for small transfers.

Without this patch, i2c reads the incorrect sgtl5000 version on a mx28evk when
touchscreen is enabled:
                                           
[    5.856270] sgtl5000 0-000a: Device with ID register 0 is not a sgtl5000     
[    9.877307] sgtl5000 0-000a: ASoC: failed to probe CODEC -19                 
[    9.883528] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -19      
[    9.892955] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-19)  

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Applies against 3.10

 drivers/i2c/busses/i2c-mxs.c | 211 ++-----------------------------------------
 1 file changed, 9 insertions(+), 202 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 2039f23..8f87b98 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -288,187 +288,6 @@ write_init_pio_fail:
 	return -EINVAL;
 }
 
-static int mxs_i2c_pio_wait_dmareq(struct mxs_i2c_dev *i2c)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
-
-	while (!(readl(i2c->regs + MXS_I2C_DEBUG0) &
-		MXS_I2C_DEBUG0_DMAREQ)) {
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-		cond_resched();
-	}
-
-	return 0;
-}
-
-static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c, int last)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
-
-	/*
-	 * We do not use interrupts in the PIO mode. Due to the
-	 * maximum transfer length being 8 bytes in PIO mode, the
-	 * overhead of interrupt would be too large and this would
-	 * neglect the gain from using the PIO mode.
-	 */
-
-	while (!(readl(i2c->regs + MXS_I2C_CTRL1) &
-		MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ)) {
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-		cond_resched();
-	}
-
-	writel(MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ,
-		i2c->regs + MXS_I2C_CTRL1_CLR);
-
-	/*
-	 * When ending a transfer with a stop, we have to wait for the bus to
-	 * go idle before we report the transfer as completed. Otherwise the
-	 * start of the next transfer may race with the end of the current one.
-	 */
-	while (last && (readl(i2c->regs + MXS_I2C_STAT) &
-			(MXS_I2C_STAT_BUS_BUSY | MXS_I2C_STAT_CLK_GEN_BUSY))) {
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-		cond_resched();
-	}
-
-	return 0;
-}
-
-static int mxs_i2c_pio_check_error_state(struct mxs_i2c_dev *i2c)
-{
-	u32 state;
-
-	state = readl(i2c->regs + MXS_I2C_CTRL1_CLR) & MXS_I2C_IRQ_MASK;
-
-	if (state & MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ)
-		i2c->cmd_err = -ENXIO;
-	else if (state & (MXS_I2C_CTRL1_EARLY_TERM_IRQ |
-			  MXS_I2C_CTRL1_MASTER_LOSS_IRQ |
-			  MXS_I2C_CTRL1_SLAVE_STOP_IRQ |
-			  MXS_I2C_CTRL1_SLAVE_IRQ))
-		i2c->cmd_err = -EIO;
-
-	return i2c->cmd_err;
-}
-
-static void mxs_i2c_pio_trigger_cmd(struct mxs_i2c_dev *i2c, u32 cmd)
-{
-	u32 reg;
-
-	writel(cmd, i2c->regs + MXS_I2C_CTRL0);
-
-	/* readback makes sure the write is latched into hardware */
-	reg = readl(i2c->regs + MXS_I2C_CTRL0);
-	reg |= MXS_I2C_CTRL0_RUN;
-	writel(reg, i2c->regs + MXS_I2C_CTRL0);
-}
-
-static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
-			struct i2c_msg *msg, uint32_t flags)
-{
-	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
-	uint32_t addr_data = msg->addr << 1;
-	uint32_t data = 0;
-	int i, shifts_left, ret;
-
-	/* Mute IRQs coming from this block. */
-	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_CLR);
-
-	if (msg->flags & I2C_M_RD) {
-		addr_data |= I2C_SMBUS_READ;
-
-		/* SELECT command. */
-		mxs_i2c_pio_trigger_cmd(i2c, MXS_CMD_I2C_SELECT);
-
-		ret = mxs_i2c_pio_wait_dmareq(i2c);
-		if (ret)
-			return ret;
-
-		writel(addr_data, i2c->regs + MXS_I2C_DATA);
-		writel(MXS_I2C_DEBUG0_DMAREQ, i2c->regs + MXS_I2C_DEBUG0_CLR);
-
-		ret = mxs_i2c_pio_wait_cplt(i2c, 0);
-		if (ret)
-			return ret;
-
-		if (mxs_i2c_pio_check_error_state(i2c))
-			goto cleanup;
-
-		/* READ command. */
-		mxs_i2c_pio_trigger_cmd(i2c,
-					MXS_CMD_I2C_READ | flags |
-					MXS_I2C_CTRL0_XFER_COUNT(msg->len));
-
-		for (i = 0; i < msg->len; i++) {
-			if ((i & 3) == 0) {
-				ret = mxs_i2c_pio_wait_dmareq(i2c);
-				if (ret)
-					return ret;
-				data = readl(i2c->regs + MXS_I2C_DATA);
-				writel(MXS_I2C_DEBUG0_DMAREQ,
-				       i2c->regs + MXS_I2C_DEBUG0_CLR);
-			}
-			msg->buf[i] = data & 0xff;
-			data >>= 8;
-		}
-	} else {
-		addr_data |= I2C_SMBUS_WRITE;
-
-		/* WRITE command. */
-		mxs_i2c_pio_trigger_cmd(i2c,
-					MXS_CMD_I2C_WRITE | flags |
-					MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1));
-
-		/*
-		 * The LSB of data buffer is the first byte blasted across
-		 * the bus. Higher order bytes follow. Thus the following
-		 * filling schematic.
-		 */
-		data = addr_data << 24;
-		for (i = 0; i < msg->len; i++) {
-			data >>= 8;
-			data |= (msg->buf[i] << 24);
-			if ((i & 3) == 2) {
-				ret = mxs_i2c_pio_wait_dmareq(i2c);
-				if (ret)
-					return ret;
-				writel(data, i2c->regs + MXS_I2C_DATA);
-				writel(MXS_I2C_DEBUG0_DMAREQ,
-				       i2c->regs + MXS_I2C_DEBUG0_CLR);
-			}
-		}
-
-		shifts_left = 24 - (i & 3) * 8;
-		if (shifts_left) {
-			data >>= shifts_left;
-			ret = mxs_i2c_pio_wait_dmareq(i2c);
-			if (ret)
-				return ret;
-			writel(data, i2c->regs + MXS_I2C_DATA);
-			writel(MXS_I2C_DEBUG0_DMAREQ,
-			       i2c->regs + MXS_I2C_DEBUG0_CLR);
-		}
-	}
-
-	ret = mxs_i2c_pio_wait_cplt(i2c, flags & MXS_I2C_CTRL0_POST_SEND_STOP);
-	if (ret)
-		return ret;
-
-	/* make sure we capture any occurred error into cmd_err */
-	mxs_i2c_pio_check_error_state(i2c);
-
-cleanup:
-	/* Clear any dangling IRQs and re-enable interrupts. */
-	writel(MXS_I2C_IRQ_MASK, i2c->regs + MXS_I2C_CTRL1_CLR);
-	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
-
-	return 0;
-}
-
 /*
  * Low level master read/write transaction.
  */
@@ -487,28 +306,16 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	if (msg->len == 0)
 		return -EINVAL;
 
-	/*
-	 * The current boundary to select between PIO/DMA transfer method
-	 * is set to 8 bytes, transfers shorter than 8 bytes are transfered
-	 * using PIO mode while longer transfers use DMA. The 8 byte border is
-	 * based on this empirical measurement and a lot of previous frobbing.
-	 */
 	i2c->cmd_err = 0;
-	if (msg->len < 8) {
-		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
-		if (ret)
-			mxs_i2c_reset(i2c);
-	} else {
-		INIT_COMPLETION(i2c->cmd_complete);
-		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
-		if (ret)
-			return ret;
-
-		ret = wait_for_completion_timeout(&i2c->cmd_complete,
-						msecs_to_jiffies(1000));
-		if (ret == 0)
-			goto timeout;
-	}
+	INIT_COMPLETION(i2c->cmd_complete);
+	ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&i2c->cmd_complete,
+					  msecs_to_jiffies(1000));
+	if (ret == 0)
+		goto timeout;
 
 	if (i2c->cmd_err == -ENXIO) {
 		/*
-- 
1.8.1.2
