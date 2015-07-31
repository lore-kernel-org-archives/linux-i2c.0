From: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: [PATCH 3/6] i2c: Xilinx IIC: make all ioread/write calls 32-bit
Date: Fri, 31 Jul 2015 14:00:31 +0200
Message-ID: <1438344034-20211-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-1-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

According to DS756, XIIC ignores WSTRB and assumes all byte lanes are active.
Thus, 8-bit and 16-bit writes might trash reserved bits. Only read/write aligned 32-bit
words for consistency.

Signed-off-by: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c | 80 ++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index e566ccb..c6448f2 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -168,30 +168,8 @@ struct xiic_i2c {
 static void xiic_start_xfer(struct xiic_i2c *i2c);
 static void __xiic_start_xfer(struct xiic_i2c *i2c);
 
-static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
-{
-	iowrite8(value, i2c->base + reg);
-}
-
-static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
-{
-	return ioread8(i2c->base + reg);
-}
-
-static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
-{
-	iowrite16(value, i2c->base + reg);
-}
-
-static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
-{
-	iowrite32(value, i2c->base + reg);
-}
-
-static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
-{
-	return ioread32(i2c->base + reg);
-}
+#define xiic_getreg32(i2c, reg)        ioread32(i2c->base + reg)
+#define xiic_setreg32(i2c, reg, value) iowrite32(value, i2c->base + reg)
 
 static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
 {
@@ -219,11 +197,11 @@ static inline void xiic_irq_clr_en(struct xiic_i2c *i2c, u32 mask)
 
 static void xiic_clear_rx_fifo(struct xiic_i2c *i2c)
 {
-	u8 sr;
-	for (sr = xiic_getreg8(i2c, XIIC_SR_REG);
+	u32 sr;
+	for (sr = xiic_getreg32(i2c, XIIC_SR_REG);
 		!(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
-		sr = xiic_getreg8(i2c, XIIC_SR_REG))
-		xiic_getreg8(i2c, XIIC_DRR_REG);
+		sr = xiic_getreg32(i2c, XIIC_SR_REG))
+		xiic_getreg32(i2c, XIIC_DRR_REG);
 }
 
 static void xiic_reinit(struct xiic_i2c *i2c)
@@ -231,13 +209,13 @@ static void xiic_reinit(struct xiic_i2c *i2c)
 	xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK);
 
 	/* Set receive Fifo depth to maximum (zero based). */
-	xiic_setreg8(i2c, XIIC_RFD_REG, IIC_RX_FIFO_DEPTH - 1);
+	xiic_setreg32(i2c, XIIC_RFD_REG, IIC_RX_FIFO_DEPTH - 1);
 
 	/* Reset Tx Fifo. */
-	xiic_setreg8(i2c, XIIC_CR_REG, XIIC_CR_TX_FIFO_RESET_MASK);
+	xiic_setreg32(i2c, XIIC_CR_REG, XIIC_CR_TX_FIFO_RESET_MASK);
 
 	/* Enable IIC Device, remove Tx Fifo reset & disable general call. */
-	xiic_setreg8(i2c, XIIC_CR_REG, XIIC_CR_ENABLE_DEVICE_MASK);
+	xiic_setreg32(i2c, XIIC_CR_REG, XIIC_CR_ENABLE_DEVICE_MASK);
 
 	/* make sure RX fifo is empty */
 	xiic_clear_rx_fifo(i2c);
@@ -250,36 +228,36 @@ static void xiic_reinit(struct xiic_i2c *i2c)
 
 static void xiic_deinit(struct xiic_i2c *i2c)
 {
-	u8 cr;
+	u32 cr;
 
 	xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK);
 
 	/* Disable IIC Device. */
-	cr = xiic_getreg8(i2c, XIIC_CR_REG);
-	xiic_setreg8(i2c, XIIC_CR_REG, cr & ~XIIC_CR_ENABLE_DEVICE_MASK);
+	cr = xiic_getreg32(i2c, XIIC_CR_REG);
+	xiic_setreg32(i2c, XIIC_CR_REG, cr & ~XIIC_CR_ENABLE_DEVICE_MASK);
 }
 
 static void xiic_read_rx(struct xiic_i2c *i2c)
 {
-	u8 bytes_in_fifo;
+	u32 bytes_in_fifo;
 	int i;
 
-	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG) + 1;
+	bytes_in_fifo = xiic_getreg32(i2c, XIIC_RFO_REG) + 1;
 
 	dev_dbg(i2c->adap.dev.parent,
 		"%s entry, bytes in fifo: %d, msg: %d, SR: 0x%x, CR: 0x%x\n",
 		__func__, bytes_in_fifo, xiic_rx_space(i2c),
-		xiic_getreg8(i2c, XIIC_SR_REG),
-		xiic_getreg8(i2c, XIIC_CR_REG));
+		xiic_getreg32(i2c, XIIC_SR_REG),
+		xiic_getreg32(i2c, XIIC_CR_REG));
 
 	if (bytes_in_fifo > xiic_rx_space(i2c))
 		bytes_in_fifo = xiic_rx_space(i2c);
 
 	for (i = 0; i < bytes_in_fifo; i++)
 		i2c->rx_msg->buf[i2c->rx_pos++] =
-			xiic_getreg8(i2c, XIIC_DRR_REG);
+			xiic_getreg32(i2c, XIIC_DRR_REG);
 
-	xiic_setreg8(i2c, XIIC_RFD_REG,
+	xiic_setreg32(i2c, XIIC_RFD_REG,
 		(xiic_rx_space(i2c) > IIC_RX_FIFO_DEPTH) ?
 		IIC_RX_FIFO_DEPTH - 1 :  xiic_rx_space(i2c) - 1);
 }
@@ -287,12 +265,12 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
 static int xiic_tx_fifo_space(struct xiic_i2c *i2c)
 {
 	/* return the actual space left in the FIFO */
-	return IIC_TX_FIFO_DEPTH - xiic_getreg8(i2c, XIIC_TFO_REG) - 1;
+	return IIC_TX_FIFO_DEPTH - xiic_getreg32(i2c, XIIC_TFO_REG) - 1;
 }
 
 static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
 {
-	u8 fifo_space = xiic_tx_fifo_space(i2c);
+	u32 fifo_space = xiic_tx_fifo_space(i2c);
 	int len = xiic_tx_space(i2c);
 
 	len = (len > fifo_space) ? fifo_space : len;
@@ -307,7 +285,7 @@ static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
 			data |= XIIC_TX_DYN_STOP_MASK;
 			dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
 		}
-		xiic_setreg16(i2c, XIIC_DTR_REG, data);
+		xiic_setreg32(i2c, XIIC_DTR_REG, data);
 	}
 }
 
@@ -340,7 +318,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	dev_dbg(i2c->adap.dev.parent, "%s: IER: 0x%x, ISR: 0x%x, pend: 0x%x\n",
 		__func__, ier, isr, pend);
 	dev_dbg(i2c->adap.dev.parent, "%s: SR: 0x%x, msg: %p, nmsgs: %d\n",
-		__func__, xiic_getreg8(i2c, XIIC_SR_REG),
+		__func__, xiic_getreg32(i2c, XIIC_SR_REG),
 		i2c->tx_msg, i2c->nmsgs);
 
 
@@ -468,7 +446,7 @@ out:
 
 static int xiic_bus_busy(struct xiic_i2c *i2c)
 {
-	u8 sr = xiic_getreg8(i2c, XIIC_SR_REG);
+	u32 sr = xiic_getreg32(i2c, XIIC_SR_REG);
 
 	return (sr & XIIC_SR_BUS_BUSY_MASK) ? -EBUSY : 0;
 }
@@ -511,17 +489,17 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 	rx_watermark = msg->len;
 	if (rx_watermark > IIC_RX_FIFO_DEPTH)
 		rx_watermark = IIC_RX_FIFO_DEPTH;
-	xiic_setreg8(i2c, XIIC_RFD_REG, rx_watermark - 1);
+	xiic_setreg32(i2c, XIIC_RFD_REG, rx_watermark - 1);
 
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
-		xiic_setreg16(i2c, XIIC_DTR_REG,
+		xiic_setreg32(i2c, XIIC_DTR_REG,
 			(msg->addr << 1) | XIIC_READ_OPERATION |
 			XIIC_TX_DYN_START_MASK);
 
 	xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
 
-	xiic_setreg16(i2c, XIIC_DTR_REG,
+	xiic_setreg32(i2c, XIIC_DTR_REG,
 		msg->len | ((i2c->nmsgs == 1) ? XIIC_TX_DYN_STOP_MASK : 0));
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
@@ -541,7 +519,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 		__func__, msg, msg->len);
 	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
 		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
-		xiic_getreg8(i2c, XIIC_CR_REG));
+		xiic_getreg32(i2c, XIIC_CR_REG));
 
 	if (!(msg->flags & I2C_M_NOSTART)) {
 		/* write the address */
@@ -551,7 +529,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 			/* no data and last message -> add STOP */
 			data |= XIIC_TX_DYN_STOP_MASK;
 
-		xiic_setreg16(i2c, XIIC_DTR_REG, data);
+		xiic_setreg32(i2c, XIIC_DTR_REG, data);
 	}
 
 	xiic_fill_tx_fifo(i2c);
@@ -639,7 +617,7 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	int err;
 
 	dev_dbg(adap->dev.parent, "%s entry SR: 0x%x\n", __func__,
-		xiic_getreg8(i2c, XIIC_SR_REG));
+		xiic_getreg32(i2c, XIIC_SR_REG));
 
 	err = xiic_busy(i2c);
 	if (err)
-- 
2.5.0
