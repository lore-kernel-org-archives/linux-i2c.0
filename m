From: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: [PATCH 0/6] i2c: Xilinx IIC: rename register defines
Date: Fri, 31 Jul 2015 14:00:28 +0200
Message-ID: <1438344034-20211-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-1-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

*_REG_OFFSET => *_REG

Signed-off-by: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c | 73 +++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 8b95f75..59b035c 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -79,23 +79,22 @@ struct xiic_i2c {
 };
 
 
-#define XIIC_MSB_OFFSET 0
-#define XIIC_REG_OFFSET (0x100+XIIC_MSB_OFFSET)
+#define XIIC_REG_OFFSET 0x100
 
 /*
  * Register offsets in bytes from RegisterBase. Three is added to the
  * base offset to access LSB (IBM style) of the word
  */
-#define XIIC_CR_REG_OFFSET   (0x00+XIIC_REG_OFFSET)	/* Control Register   */
-#define XIIC_SR_REG_OFFSET   (0x04+XIIC_REG_OFFSET)	/* Status Register    */
-#define XIIC_DTR_REG_OFFSET  (0x08+XIIC_REG_OFFSET)	/* Data Tx Register   */
-#define XIIC_DRR_REG_OFFSET  (0x0C+XIIC_REG_OFFSET)	/* Data Rx Register   */
-#define XIIC_ADR_REG_OFFSET  (0x10+XIIC_REG_OFFSET)	/* Address Register   */
-#define XIIC_TFO_REG_OFFSET  (0x14+XIIC_REG_OFFSET)	/* Tx FIFO Occupancy  */
-#define XIIC_RFO_REG_OFFSET  (0x18+XIIC_REG_OFFSET)	/* Rx FIFO Occupancy  */
-#define XIIC_TBA_REG_OFFSET  (0x1C+XIIC_REG_OFFSET)	/* 10 Bit Address reg */
-#define XIIC_RFD_REG_OFFSET  (0x20+XIIC_REG_OFFSET)	/* Rx FIFO Depth reg  */
-#define XIIC_GPO_REG_OFFSET  (0x24+XIIC_REG_OFFSET)	/* Output Register    */
+#define XIIC_CR_REG   (0x00+XIIC_REG_OFFSET)	/* Control Register   */
+#define XIIC_SR_REG   (0x04+XIIC_REG_OFFSET)	/* Status Register    */
+#define XIIC_DTR_REG  (0x08+XIIC_REG_OFFSET)	/* Data Tx Register   */
+#define XIIC_DRR_REG  (0x0C+XIIC_REG_OFFSET)	/* Data Rx Register   */
+#define XIIC_ADR_REG  (0x10+XIIC_REG_OFFSET)	/* Address Register   */
+#define XIIC_TFO_REG  (0x14+XIIC_REG_OFFSET)	/* Tx FIFO Occupancy  */
+#define XIIC_RFO_REG  (0x18+XIIC_REG_OFFSET)	/* Rx FIFO Occupancy  */
+#define XIIC_TBA_REG  (0x1C+XIIC_REG_OFFSET)	/* 10 Bit Address reg */
+#define XIIC_RFD_REG  (0x20+XIIC_REG_OFFSET)	/* Rx FIFO Depth reg  */
+#define XIIC_GPO_REG  (0x24+XIIC_REG_OFFSET)	/* Output Register    */
 
 /* Control Register masks */
 #define XIIC_CR_ENABLE_DEVICE_MASK        0x01	/* Device enable = 1      */
@@ -257,10 +256,10 @@ static inline void xiic_irq_clr_en(struct xiic_i2c *i2c, u32 mask)
 static void xiic_clear_rx_fifo(struct xiic_i2c *i2c)
 {
 	u8 sr;
-	for (sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
+	for (sr = xiic_getreg8(i2c, XIIC_SR_REG);
 		!(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
-		sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET))
-		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
+		sr = xiic_getreg8(i2c, XIIC_SR_REG))
+		xiic_getreg8(i2c, XIIC_DRR_REG);
 }
 
 static void xiic_reinit(struct xiic_i2c *i2c)
@@ -268,13 +267,13 @@ static void xiic_reinit(struct xiic_i2c *i2c)
 	xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK);
 
 	/* Set receive Fifo depth to maximum (zero based). */
-	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, IIC_RX_FIFO_DEPTH - 1);
+	xiic_setreg8(i2c, XIIC_RFD_REG, IIC_RX_FIFO_DEPTH - 1);
 
 	/* Reset Tx Fifo. */
-	xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_TX_FIFO_RESET_MASK);
+	xiic_setreg8(i2c, XIIC_CR_REG, XIIC_CR_TX_FIFO_RESET_MASK);
 
 	/* Enable IIC Device, remove Tx Fifo reset & disable general call. */
-	xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_DEVICE_MASK);
+	xiic_setreg8(i2c, XIIC_CR_REG, XIIC_CR_ENABLE_DEVICE_MASK);
 
 	/* make sure RX fifo is empty */
 	xiic_clear_rx_fifo(i2c);
@@ -292,8 +291,8 @@ static void xiic_deinit(struct xiic_i2c *i2c)
 	xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK);
 
 	/* Disable IIC Device. */
-	cr = xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
-	xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr & ~XIIC_CR_ENABLE_DEVICE_MASK);
+	cr = xiic_getreg8(i2c, XIIC_CR_REG);
+	xiic_setreg8(i2c, XIIC_CR_REG, cr & ~XIIC_CR_ENABLE_DEVICE_MASK);
 }
 
 static void xiic_read_rx(struct xiic_i2c *i2c)
@@ -301,22 +300,22 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
 	u8 bytes_in_fifo;
 	int i;
 
-	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
+	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG) + 1;
 
 	dev_dbg(i2c->adap.dev.parent,
 		"%s entry, bytes in fifo: %d, msg: %d, SR: 0x%x, CR: 0x%x\n",
 		__func__, bytes_in_fifo, xiic_rx_space(i2c),
-		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
-		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
+		xiic_getreg8(i2c, XIIC_SR_REG),
+		xiic_getreg8(i2c, XIIC_CR_REG));
 
 	if (bytes_in_fifo > xiic_rx_space(i2c))
 		bytes_in_fifo = xiic_rx_space(i2c);
 
 	for (i = 0; i < bytes_in_fifo; i++)
 		i2c->rx_msg->buf[i2c->rx_pos++] =
-			xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
+			xiic_getreg8(i2c, XIIC_DRR_REG);
 
-	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET,
+	xiic_setreg8(i2c, XIIC_RFD_REG,
 		(xiic_rx_space(i2c) > IIC_RX_FIFO_DEPTH) ?
 		IIC_RX_FIFO_DEPTH - 1 :  xiic_rx_space(i2c) - 1);
 }
@@ -324,7 +323,7 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
 static int xiic_tx_fifo_space(struct xiic_i2c *i2c)
 {
 	/* return the actual space left in the FIFO */
-	return IIC_TX_FIFO_DEPTH - xiic_getreg8(i2c, XIIC_TFO_REG_OFFSET) - 1;
+	return IIC_TX_FIFO_DEPTH - xiic_getreg8(i2c, XIIC_TFO_REG) - 1;
 }
 
 static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
@@ -344,7 +343,7 @@ static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
 			data |= XIIC_TX_DYN_STOP_MASK;
 			dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
 		}
-		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
+		xiic_setreg16(i2c, XIIC_DTR_REG, data);
 	}
 }
 
@@ -377,7 +376,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	dev_dbg(i2c->adap.dev.parent, "%s: IER: 0x%x, ISR: 0x%x, pend: 0x%x\n",
 		__func__, ier, isr, pend);
 	dev_dbg(i2c->adap.dev.parent, "%s: SR: 0x%x, msg: %p, nmsgs: %d\n",
-		__func__, xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
+		__func__, xiic_getreg8(i2c, XIIC_SR_REG),
 		i2c->tx_msg, i2c->nmsgs);
 
 
@@ -505,7 +504,7 @@ out:
 
 static int xiic_bus_busy(struct xiic_i2c *i2c)
 {
-	u8 sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
+	u8 sr = xiic_getreg8(i2c, XIIC_SR_REG);
 
 	return (sr & XIIC_SR_BUS_BUSY_MASK) ? -EBUSY : 0;
 }
@@ -548,17 +547,17 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 	rx_watermark = msg->len;
 	if (rx_watermark > IIC_RX_FIFO_DEPTH)
 		rx_watermark = IIC_RX_FIFO_DEPTH;
-	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rx_watermark - 1);
+	xiic_setreg8(i2c, XIIC_RFD_REG, rx_watermark - 1);
 
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
-		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
+		xiic_setreg16(i2c, XIIC_DTR_REG,
 			(msg->addr << 1) | XIIC_READ_OPERATION |
 			XIIC_TX_DYN_START_MASK);
 
 	xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
 
-	xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
+	xiic_setreg16(i2c, XIIC_DTR_REG,
 		msg->len | ((i2c->nmsgs == 1) ? XIIC_TX_DYN_STOP_MASK : 0));
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
@@ -578,7 +577,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 		__func__, msg, msg->len);
 	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
 		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
-		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
+		xiic_getreg8(i2c, XIIC_CR_REG));
 
 	if (!(msg->flags & I2C_M_NOSTART)) {
 		/* write the address */
@@ -588,7 +587,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 			/* no data and last message -> add STOP */
 			data |= XIIC_TX_DYN_STOP_MASK;
 
-		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
+		xiic_setreg16(i2c, XIIC_DTR_REG, data);
 	}
 
 	xiic_fill_tx_fifo(i2c);
@@ -676,7 +675,7 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	int err;
 
 	dev_dbg(adap->dev.parent, "%s entry SR: 0x%x\n", __func__,
-		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET));
+		xiic_getreg8(i2c, XIIC_SR_REG));
 
 	err = xiic_busy(i2c);
 	if (err)
@@ -766,9 +765,9 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	 * set, assume that the endianness was wrong and swap.
 	 */
 	i2c->endianness = LITTLE;
-	xiic_setreg32(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_TX_FIFO_RESET_MASK);
+	xiic_setreg32(i2c, XIIC_CR_REG, XIIC_CR_TX_FIFO_RESET_MASK);
 	/* Reset is cleared in xiic_reinit */
-	sr = xiic_getreg32(i2c, XIIC_SR_REG_OFFSET);
+	sr = xiic_getreg32(i2c, XIIC_SR_REG);
 	if (!(sr & XIIC_SR_TX_FIFO_EMPTY_MASK))
 		i2c->endianness = BIG;
 
-- 
2.5.0
