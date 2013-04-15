From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 1/2] i2c: mxs: remove races in PIO code
Date: Mon, 15 Apr 2013 12:16:54 +0200
Message-ID: <1366021015-5936-1-git-send-email-l.stach@pengutronix.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363261750-26645-1-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This commit fixes the three following races in PIO code:

- The CTRL0 register is racy in itself, when programming transfer state and
  run bit in the same cycle the hardware sometimes ends up using the state
  from the last transfer. Fix this by programming state in one cycle, make
  sure the write is flushed down APBX bus by reading back the reg and only
  then trigger the run bit.

- Only clear the DMAREQ bit in DEBUG0 after the read/write to the data reg
  happened. Otherwise we are racing with the hardware about who touches
  the data reg first.

- When checking for completion of a transfer it's not sufficient to check
  if the data engine finished, but also a check for i2c bus idle is needed.
  In PIO mode we are really fast to program the next transfer after a finished
  one, so the controller possibly tries to start a new transfer while the
  clkgen engine is still busy writing the NAK/STOP from the last transfer to
  the bus.

Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c | 58 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 120f246..f8558550 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -65,6 +65,10 @@
 #define MXS_I2C_CTRL1_SLAVE_STOP_IRQ		0x02
 #define MXS_I2C_CTRL1_SLAVE_IRQ			0x01
 
+#define MXS_I2C_STAT		(0x50)
+#define MXS_I2C_STAT_BUS_BUSY			0x00000800
+#define MXS_I2C_STAT_CLK_GEN_BUSY		0x00000400
+
 #define MXS_I2C_DATA		(0xa0)
 
 #define MXS_I2C_DEBUG0		(0xb0)
@@ -297,12 +301,10 @@ static int mxs_i2c_pio_wait_dmareq(struct mxs_i2c_dev *i2c)
 		cond_resched();
 	}
 
-	writel(MXS_I2C_DEBUG0_DMAREQ, i2c->regs + MXS_I2C_DEBUG0_CLR);
-
 	return 0;
 }
 
-static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c)
+static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c, int last)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
@@ -323,9 +325,33 @@ static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c)
 	writel(MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ,
 		i2c->regs + MXS_I2C_CTRL1_CLR);
 
+	/*
+	 * When ending a transfer with a stop, we have to wait for the bus to
+	 * go idle before we report the transfer as completed. Otherwise the
+	 * start of the next transfer may race with the end of the current one.
+	 */
+	while (last && (readl(i2c->regs + MXS_I2C_STAT) &
+			(MXS_I2C_STAT_BUS_BUSY | MXS_I2C_STAT_CLK_GEN_BUSY))) {
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+		cond_resched();
+	}
+
 	return 0;
 }
 
+static void mxs_i2c_pio_trigger_cmd(struct mxs_i2c_dev *i2c, u32 cmd)
+{
+	u32 reg;
+
+	writel(cmd, i2c->regs + MXS_I2C_CTRL0);
+
+	/* readback makes sure the write is latched into hardware */
+	reg = readl(i2c->regs + MXS_I2C_CTRL0);
+	reg |= MXS_I2C_CTRL0_RUN;
+	writel(reg, i2c->regs + MXS_I2C_CTRL0);
+}
+
 static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msg, uint32_t flags)
 {
@@ -341,23 +367,23 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		addr_data |= I2C_SMBUS_READ;
 
 		/* SELECT command. */
-		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_SELECT,
-			i2c->regs + MXS_I2C_CTRL0);
+		mxs_i2c_pio_trigger_cmd(i2c, MXS_CMD_I2C_SELECT);
 
 		ret = mxs_i2c_pio_wait_dmareq(i2c);
 		if (ret)
 			return ret;
 
 		writel(addr_data, i2c->regs + MXS_I2C_DATA);
+		writel(MXS_I2C_DEBUG0_DMAREQ, i2c->regs + MXS_I2C_DEBUG0_CLR);
 
-		ret = mxs_i2c_pio_wait_cplt(i2c);
+		ret = mxs_i2c_pio_wait_cplt(i2c, 0);
 		if (ret)
 			return ret;
 
 		/* READ command. */
-		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_READ | flags |
-			MXS_I2C_CTRL0_XFER_COUNT(msg->len),
-			i2c->regs + MXS_I2C_CTRL0);
+		mxs_i2c_pio_trigger_cmd(i2c,
+					MXS_CMD_I2C_READ | flags |
+					MXS_I2C_CTRL0_XFER_COUNT(msg->len));
 
 		for (i = 0; i < msg->len; i++) {
 			if ((i & 3) == 0) {
@@ -365,6 +391,8 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 				if (ret)
 					return ret;
 				data = readl(i2c->regs + MXS_I2C_DATA);
+				writel(MXS_I2C_DEBUG0_DMAREQ,
+				       i2c->regs + MXS_I2C_DEBUG0_CLR);
 			}
 			msg->buf[i] = data & 0xff;
 			data >>= 8;
@@ -373,9 +401,9 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		addr_data |= I2C_SMBUS_WRITE;
 
 		/* WRITE command. */
-		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_WRITE | flags |
-			MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1),
-			i2c->regs + MXS_I2C_CTRL0);
+		mxs_i2c_pio_trigger_cmd(i2c,
+					MXS_CMD_I2C_WRITE | flags |
+					MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1));
 
 		/*
 		 * The LSB of data buffer is the first byte blasted across
@@ -391,6 +419,8 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 				if (ret)
 					return ret;
 				writel(data, i2c->regs + MXS_I2C_DATA);
+				writel(MXS_I2C_DEBUG0_DMAREQ,
+				       i2c->regs + MXS_I2C_DEBUG0_CLR);
 			}
 		}
 
@@ -401,10 +431,12 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			if (ret)
 				return ret;
 			writel(data, i2c->regs + MXS_I2C_DATA);
+			writel(MXS_I2C_DEBUG0_DMAREQ,
+			       i2c->regs + MXS_I2C_DEBUG0_CLR);
 		}
 	}
 
-	ret = mxs_i2c_pio_wait_cplt(i2c);
+	ret = mxs_i2c_pio_wait_cplt(i2c, flags & MXS_I2C_CTRL0_POST_SEND_STOP);
 	if (ret)
 		return ret;
 
-- 
1.8.2.rc2
