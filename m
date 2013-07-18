From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 2/3] i2c: mxs: Rework the PIO mode operation
Date: Thu, 18 Jul 2013 02:46:40 +0200
Message-ID: <1374108401-7439-2-git-send-email-marex@denx.de>
References: <1374108401-7439-1-git-send-email-marex@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374108401-7439-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <sb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Analyze and rework the PIO mode operation. The PIO mode operation
was unreliable on MX28, by analyzing the bus with LA, the checks
for when data were available or were to be sent were wrong.

The PIO WRITE has to be completely reworked as it multiple problems.
The MX23 datasheet helped here, see comments in the code for details.
The problems boil down to:
- RUN bit in CTRL0 must be set after DATA register was written
- The PIO transfer must be 4 bytes long tops, otherwise use
  clock stretching.
Both of these fixes are implemented.

The PIO READ operation can only be done for up to four bytes as
we are unable to read out the data from the DATA register fast
enough.

This patch also tries to document the investigation within the
code.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Christoph Baumann <sb-/RsSufbtIHM@public.gmane.org>
Cc: Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |  243 +++++++++++++++++++++++++-----------------
 1 file changed, 145 insertions(+), 98 deletions(-)

NOTE: This evolved from RFC, so I won't call it a V2 per-se. Here is a
      changelog though:
      - Make READ more performant by waiting for the RUN bit to be cleared
        before reading the DATA register instead of waiting 5ms.
      - Cleanup useless functions

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index ca54ac4..86913d9 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -7,6 +7,8 @@
  *
  * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  *
+ * WARNING: This driver does NOT support PIO mode on i.MX23.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -295,48 +297,11 @@ write_init_pio_fail:
 	return -EINVAL;
 }
 
-static int mxs_i2c_pio_wait_dmareq(struct mxs_i2c_dev *i2c)
+static int mxs_i2c_pio_wait_xfer_end(struct mxs_i2c_dev *i2c)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
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
+	while (readl(i2c->regs + MXS_I2C_CTRL0) & MXS_I2C_CTRL0_RUN) {
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
 		cond_resched();
@@ -374,106 +339,179 @@ static void mxs_i2c_pio_trigger_cmd(struct mxs_i2c_dev *i2c, u32 cmd)
 	writel(reg, i2c->regs + MXS_I2C_CTRL0);
 }
 
+/*
+ * Start WRITE transaction on the I2C bus. By studying i.MX23 datasheet,
+ * CTRL0::PIO_MODE bit description clarifies the order in which the registers
+ * must be written during PIO mode operation. First, the CTRL0 register has
+ * to be programmed with all the necessary bits but the RUN bit. Then the
+ * payload has to be written into the DATA register. Finally, the transmission
+ * is executed by setting the RUN bit in CTRL0.
+ */
+static void mxs_i2c_pio_trigger_write_cmd(struct mxs_i2c_dev *i2c, u32 cmd,
+					  u32 data)
+{
+	writel(cmd, i2c->regs + MXS_I2C_CTRL0);
+	writel(data, i2c->regs + MXS_I2C_DATA);
+	writel(MXS_I2C_CTRL0_RUN, i2c->regs + MXS_I2C_CTRL0_SET);
+}
+
 static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msg, uint32_t flags)
 {
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 	uint32_t addr_data = msg->addr << 1;
 	uint32_t data = 0;
-	int i, shifts_left, ret;
+	int i, ret, xlen = 0;
+	uint32_t start;
 
 	/* Mute IRQs coming from this block. */
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_CLR);
 
+	/*
+	 * MX23 idea:
+	 * - Enable CTRL0::PIO_MODE (1 << 24)
+	 * - Enable CTRL1::ACK_MODE (1 << 27)
+	 *
+	 * WARNING! The MX23 is broken in some way, even if it claims
+	 * to support PIO, when we try to transfer any amount of data
+	 * that is not aligned to 4 bytes, the DMA engine will have
+	 * bits in DEBUG1::DMA_BYTES_ENABLES still set even after the
+	 * transfer. This in turn will mess up the next transfer as
+	 * the block it emit one byte write onto the bus terminated
+	 * with a NAK+STOP. A possible workaround is to reset the IP
+	 * block after every PIO transmission, which might just work.
+	 *
+	 * NOTE: The CTRL0::PIO_MODE description is important, since
+	 * it outlines how the PIO mode is really supposed to work.
+	 */
+
 	if (msg->flags & I2C_M_RD) {
+		/*
+		 * PIO READ transfer:
+		 *
+		 * This transfer MUST be limited to 4 bytes maximum. It is not
+		 * possible to transfer more than four bytes via PIO, since we
+		 * can not in any way make sure we can read the data from the
+		 * DATA register fast enough. Besides, the RX FIFO is only four
+		 * bytes deep, thus we can only really read up to four bytes at
+		 * time. Finally, there is no bit indicating us that new data
+		 * arrived at the FIFO and can thus be fetched from the DATA
+		 * register.
+		 */
+		BUG_ON(msg->len > 4);
+
 		addr_data |= I2C_SMBUS_READ;
 
 		/* SELECT command. */
-		mxs_i2c_pio_trigger_cmd(i2c, MXS_CMD_I2C_SELECT);
+		mxs_i2c_pio_trigger_write_cmd(i2c, MXS_CMD_I2C_SELECT, addr_data);
 
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
+		ret = mxs_i2c_pio_wait_xfer_end(i2c);
+		if (ret) {
+			dev_err(i2c->dev,
+				"PIO: Failed to send SELECT command!\n");
 			goto cleanup;
+		}
 
 		/* READ command. */
 		mxs_i2c_pio_trigger_cmd(i2c,
 					MXS_CMD_I2C_READ | flags |
 					MXS_I2C_CTRL0_XFER_COUNT(msg->len));
 
+		ret = mxs_i2c_pio_wait_xfer_end(i2c);
+		if (ret) {
+			dev_err(i2c->dev,
+				"PIO: Failed to send SELECT command!\n");
+			goto cleanup;
+		}
+
+		data = readl(i2c->regs + MXS_I2C_DATA);
 		for (i = 0; i < msg->len; i++) {
-			if ((i & 3) == 0) {
-				ret = mxs_i2c_pio_wait_dmareq(i2c);
-				if (ret)
-					return ret;
-				data = readl(i2c->regs + MXS_I2C_DATA);
-				writel(MXS_I2C_DEBUG0_DMAREQ,
-				       i2c->regs + MXS_I2C_DEBUG0_CLR);
-			}
 			msg->buf[i] = data & 0xff;
 			data >>= 8;
 		}
 	} else {
+		/*
+		 * PIO WRITE transfer:
+		 *
+		 * The code below implements clock stretching to circumvent
+		 * the possibility of kernel not being able to supply data
+		 * fast enough. It is possible to transfer arbitrary amount
+		 * of data using PIO write.
+		 */
 		addr_data |= I2C_SMBUS_WRITE;
 
-		/* WRITE command. */
-		mxs_i2c_pio_trigger_cmd(i2c,
-					MXS_CMD_I2C_WRITE | flags |
-					MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1));
-
 		/*
 		 * The LSB of data buffer is the first byte blasted across
 		 * the bus. Higher order bytes follow. Thus the following
 		 * filling schematic.
 		 */
+
 		data = addr_data << 24;
+
+		/* Start the transfer with START condition. */
+		start = MXS_I2C_CTRL0_PRE_SEND_START;
+
+		/* If the transfer is long, use clock stretching. */
+		if (msg->len > 3)
+			start |= MXS_I2C_CTRL0_RETAIN_CLOCK;
+
 		for (i = 0; i < msg->len; i++) {
 			data >>= 8;
 			data |= (msg->buf[i] << 24);
-			if ((i & 3) == 2) {
-				ret = mxs_i2c_pio_wait_dmareq(i2c);
-				if (ret)
-					return ret;
-				writel(data, i2c->regs + MXS_I2C_DATA);
-				writel(MXS_I2C_DEBUG0_DMAREQ,
-				       i2c->regs + MXS_I2C_DEBUG0_CLR);
+
+			if (i + 1 == msg->len) {
+				/* This is the last transfer. */
+				start |= flags;
+				start &= ~MXS_I2C_CTRL0_RETAIN_CLOCK;
+				xlen = (i + 2) % 4;
+				data >>= (4 - xlen) * 8;
+			} else if ((i & 3) == 2) {
+				/* Regular transfer. */
+				xlen = 4;
+			} else {
+				/* Just stuff data. */
+				continue;
 			}
-		}
 
-		shifts_left = 24 - (i & 3) * 8;
-		if (shifts_left) {
-			data >>= shifts_left;
-			ret = mxs_i2c_pio_wait_dmareq(i2c);
-			if (ret)
-				return ret;
-			writel(data, i2c->regs + MXS_I2C_DATA);
+			dev_dbg(i2c->dev,
+				"PIO: len=%i pos=%i total=%i [W%s%s%s]\n",
+				xlen, i, msg->len,
+				start & MXS_I2C_CTRL0_PRE_SEND_START ? "S": "",
+				start & MXS_I2C_CTRL0_POST_SEND_STOP ? "E": "",
+				start & MXS_I2C_CTRL0_RETAIN_CLOCK ? "C": "");
+
 			writel(MXS_I2C_DEBUG0_DMAREQ,
 			       i2c->regs + MXS_I2C_DEBUG0_CLR);
+
+			mxs_i2c_pio_trigger_write_cmd(i2c,
+				start | MXS_I2C_CTRL0_MASTER_MODE |
+				MXS_I2C_CTRL0_DIRECTION |
+				MXS_I2C_CTRL0_XFER_COUNT(xlen), data);
+
+			/* The START condition is sent only once. */
+			start &= ~MXS_I2C_CTRL0_PRE_SEND_START;
+
+			/* Wait for the end of the transfer. */
+			ret = mxs_i2c_pio_wait_xfer_end(i2c);
+			if (ret) {
+				dev_err(i2c->dev,
+					"PIO: Failed to finish WRITE cmd!\n");
+				break;
+			}
+
+			/* Check NAK here ? */
 		}
 	}
 
-	ret = mxs_i2c_pio_wait_cplt(i2c, flags & MXS_I2C_CTRL0_POST_SEND_STOP);
-	if (ret)
-		return ret;
-
 	/* make sure we capture any occurred error into cmd_err */
-	mxs_i2c_pio_check_error_state(i2c);
+	ret = mxs_i2c_pio_check_error_state(i2c);
 
 cleanup:
 	/* Clear any dangling IRQs and re-enable interrupts. */
 	writel(MXS_I2C_IRQ_MASK, i2c->regs + MXS_I2C_CTRL1_CLR);
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -485,6 +523,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 	int ret;
 	int flags;
+	int use_pio = 0;
 
 	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
 
@@ -495,16 +534,24 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		return -EINVAL;
 
 	/*
-	 * The current boundary to select between PIO/DMA transfer method
-	 * is set to 8 bytes, transfers shorter than 8 bytes are transfered
-	 * using PIO mode while longer transfers use DMA. The 8 byte border is
-	 * based on this empirical measurement and a lot of previous frobbing.
-	 * Note: this special feature only works on i.MX28 SoC
+	 * The MX28 I2C IP block can only do PIO READ for transfer of to up
+	 * 4 bytes of length. The write transfer is not limited as it can use
+	 * clock stretching to avoid FIFO underruns.
 	 */
+	if ((msg->flags & I2C_M_RD) && (msg->len <= 4))
+		use_pio = 1;
+	if (!(msg->flags & I2C_M_RD) && (msg->len < 7))
+		use_pio = 1;
+
+	/* Disable PIO on MX23. */
+	if (i2c->dev_type == MXS_I2C_V1)
+		use_pio = 0;
+
 	i2c->cmd_err = 0;
-	if (i2c->dev_type == MXS_I2C_V2 && msg->len < 8) {
+	if (use_pio) {
 		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
-		if (ret)
+		/* No need to reset the block if NAK was received. */
+		if (ret && (ret != -ENXIO))
 			mxs_i2c_reset(i2c);
 	} else {
 		INIT_COMPLETION(i2c->cmd_complete);
@@ -516,9 +563,11 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 						msecs_to_jiffies(1000));
 		if (ret == 0)
 			goto timeout;
+
+		ret = i2c->cmd_err;
 	}
 
-	if (i2c->cmd_err == -ENXIO) {
+	if (ret == -ENXIO) {
 		/*
 		 * If the transfer fails with a NAK from the slave the
 		 * controller halts until it gets told to return to idle state.
@@ -527,8 +576,6 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		       i2c->regs + MXS_I2C_CTRL1_SET);
 	}
 
-	ret = i2c->cmd_err;
-
 	dev_dbg(i2c->dev, "Done with err=%d\n", ret);
 
 	return ret;
-- 
1.7.10.4
