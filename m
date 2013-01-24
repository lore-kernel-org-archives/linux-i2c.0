From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH V2] i2c: mxs: Add PIO and mixed-DMA support
Date: Thu, 24 Jan 2013 13:56:21 +0100
Message-ID: <1359032181-10601-1-git-send-email-marex@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add support for the PIO mode and mixed PIO/DMA mode support. The mixed
PIO/DMA is the default mode of operation. This shall leverage overhead
that the driver creates due to setting up DMA descriptors even for very
short transfers.

The current boundary between PIO/DMA 8 bytes, transfers shorter than 8
bytes are transfered by PIO, longer transfers use DMA. The performance
of write transfers remains unchanged, while there is a minor improvement
of read performance. Reading 16KB EEPROM with DMA-only operations gives
a read speed of 39.5KB/s, while with then new mixed-mode the speed is
blazing 40.6KB/s.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |  180 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 167 insertions(+), 13 deletions(-)

V2: Add comment about the 8-byte boundary between PIO and DMA mode. Follow the
    same pattern as in the SPI driver (where the boundary is 32 bytes). I didnt
    add a tunable here as requested, since this seems to be the best value.

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 977c4d5..6bbc14d 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -39,6 +39,7 @@
 #define MXS_I2C_CTRL0_SET	(0x04)
 
 #define MXS_I2C_CTRL0_SFTRST			0x80000000
+#define MXS_I2C_CTRL0_RUN			0x20000000
 #define MXS_I2C_CTRL0_SEND_NAK_ON_LAST		0x02000000
 #define MXS_I2C_CTRL0_RETAIN_CLOCK		0x00200000
 #define MXS_I2C_CTRL0_POST_SEND_STOP		0x00100000
@@ -64,6 +65,13 @@
 #define MXS_I2C_CTRL1_SLAVE_STOP_IRQ		0x02
 #define MXS_I2C_CTRL1_SLAVE_IRQ			0x01
 
+#define MXS_I2C_DATA		(0xa0)
+
+#define MXS_I2C_DEBUG0		(0xb0)
+#define MXS_I2C_DEBUG0_CLR	(0xb8)
+
+#define MXS_I2C_DEBUG0_DMAREQ	0x80000000
+
 #define MXS_I2C_IRQ_MASK	(MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ | \
 				 MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ | \
 				 MXS_I2C_CTRL1_EARLY_TERM_IRQ | \
@@ -298,6 +306,135 @@ write_init_pio_fail:
 	return -EINVAL;
 }
 
+static int mxs_i2c_pio_wait_dmareq(struct mxs_i2c_dev *i2c)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+
+	while (!(readl(i2c->regs + MXS_I2C_DEBUG0) &
+		MXS_I2C_DEBUG0_DMAREQ)) {
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+		cond_resched();
+	}
+
+	writel(MXS_I2C_DEBUG0_DMAREQ, i2c->regs + MXS_I2C_DEBUG0_CLR);
+
+	return 0;
+}
+
+static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+
+	/*
+	 * We do not use interrupts in the PIO mode. Due to the
+	 * maximum transfer length being 8 bytes in PIO mode, the
+	 * overhead of interrupt would be too large and this would
+	 * neglect the gain from using the PIO mode.
+	 */
+
+	while (!(readl(i2c->regs + MXS_I2C_CTRL1) &
+		MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ)) {
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+		cond_resched();
+	}
+
+	writel(MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ,
+		i2c->regs + MXS_I2C_CTRL1_CLR);
+
+	return 0;
+}
+
+static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
+			struct i2c_msg *msg, uint32_t flags)
+{
+	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
+	uint32_t addr_data = msg->addr << 1;
+	uint32_t data = 0;
+	int i, shifts_left, ret;
+
+	/* Mute IRQs coming from this block. */
+	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_CLR);
+
+	if (msg->flags & I2C_M_RD) {
+		addr_data |= I2C_SMBUS_READ;
+
+		/* SELECT command. */
+		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_SELECT,
+			i2c->regs + MXS_I2C_CTRL0);
+
+		ret = mxs_i2c_pio_wait_dmareq(i2c);
+		if (ret)
+			return ret;
+
+		writel(addr_data, i2c->regs + MXS_I2C_DATA);
+
+		ret = mxs_i2c_pio_wait_cplt(i2c);
+		if (ret)
+			return ret;
+
+		/* READ command. */
+		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_READ | flags |
+			MXS_I2C_CTRL0_XFER_COUNT(msg->len),
+			i2c->regs + MXS_I2C_CTRL0);
+
+		for (i = 0; i < msg->len; i++) {
+			if ((i & 3) == 0) {
+				ret = mxs_i2c_pio_wait_dmareq(i2c);
+				if (ret)
+					return ret;
+				data = readl(i2c->regs + MXS_I2C_DATA);
+			}
+			msg->buf[i] = data & 0xff;
+			data >>= 8;
+		}
+	} else {
+		addr_data |= I2C_SMBUS_WRITE;
+
+		/* WRITE command. */
+		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_WRITE | flags |
+			MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1),
+			i2c->regs + MXS_I2C_CTRL0);
+
+		/*
+		 * The LSB of data buffer is the first byte blasted across
+		 * the bus. Higher order bytes follow. Thus the following
+		 * filling schematic.
+		 */
+		data = addr_data << 24;
+		for (i = 0; i < msg->len; i++) {
+			data >>= 8;
+			data |= (msg->buf[i] << 24);
+			if ((i & 3) == 2) {
+				ret = mxs_i2c_pio_wait_dmareq(i2c);
+				if (ret)
+					return ret;
+				writel(data, i2c->regs + MXS_I2C_DATA);
+			}
+		}
+
+		shifts_left = 24 - (i & 3) * 8;
+		if (shifts_left) {
+			data >>= shifts_left;
+			ret = mxs_i2c_pio_wait_dmareq(i2c);
+			if (ret)
+				return ret;
+			writel(data, i2c->regs + MXS_I2C_DATA);
+		}
+	}
+
+	ret = mxs_i2c_pio_wait_cplt(i2c);
+	if (ret)
+		return ret;
+
+	/* Clear any dangling IRQs and re-enable interrupts. */
+	writel(MXS_I2C_IRQ_MASK, i2c->regs + MXS_I2C_CTRL1_CLR);
+	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
+
+	return 0;
+}
+
 /*
  * Low level master read/write transaction.
  */
@@ -316,24 +453,41 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	if (msg->len == 0)
 		return -EINVAL;
 
-	INIT_COMPLETION(i2c->cmd_complete);
-	i2c->cmd_err = 0;
-
-	ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
-	if (ret)
-		return ret;
+	/*
+	 * The current boundary to select between PIO/DMA transfer method
+	 * is set to 8 bytes, transfers shorter than 8 bytes are transfered
+	 * using PIO mode while longer transfers use DMA. The performance
+	 * of write transfers remains unchanged, but there is a minor
+	 * improvement of read performance. Reading 16KB EEPROM with DMA-only
+	 * operation gives a read speed of 39.5KB/s, while with the combined
+	 * PIO/DMA mode, the speed is blazing 40.6KB/s. The 8 byte border is
+	 * based on this empirical measurement and a lot of previous frobbing.
+	 */
+	if (msg->len < 8) {
+		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
+		if (ret)
+			mxs_i2c_reset(i2c);
+	} else {
+		i2c->cmd_err = 0;
+		INIT_COMPLETION(i2c->cmd_complete);
+		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
+		if (ret)
+			return ret;
 
-	ret = wait_for_completion_timeout(&i2c->cmd_complete,
+		ret = wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
-	if (ret == 0)
-		goto timeout;
+		if (ret == 0)
+			goto timeout;
+
+		if (i2c->cmd_err == -ENXIO)
+			mxs_i2c_reset(i2c);
 
-	if (i2c->cmd_err == -ENXIO)
-		mxs_i2c_reset(i2c);
+		ret = i2c->cmd_err;
+	}
 
-	dev_dbg(i2c->dev, "Done with err=%d\n", i2c->cmd_err);
+	dev_dbg(i2c->dev, "Done with err=%d\n", ret);
 
-	return i2c->cmd_err;
+	return ret;
 
 timeout:
 	dev_dbg(i2c->dev, "Timeout!\n");
-- 
1.7.10.4
