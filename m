From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 3/3] i2c: iproc: Support larger TX transfer
Date: Fri, 12 Feb 2016 13:10:43 -0800
Message-ID: <1455311443-30590-4-git-send-email-ray.jui@broadcom.com>
References: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Ray Jui <rjui@broadcom.com>

The current iProc I2C driver only allows each TX transfer up to 63
bytes (the TX FIFO has a size of 64 bytes, and one byte is reserved
for slave address). This patch enhances the driver to support TX
transfer in each I2C message for up to 65535 bytes (a practical
maximum, since member 'max_write_len' of 'struct i2c_adapter_quirks is
of type 'u16')

This works by loading up the I2C TX FIFO and enabling the TX underrun
interrupt for each burst. After each burst of TX data is finished,
i.e., when the TX FIFO becomes empty, the TX underrun interrupt will be
triggered and another burst of TX data can be loaded into the TX FIFO.
This repeats until all TX data are finished

Signed-off-by: Ray Jui <rjui@broadcom.com>
Tested-by: Icarus Chau <ichau@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 84 ++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index c368159..c115676 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -58,11 +58,13 @@
 #define IE_M_RX_FIFO_FULL_SHIFT      31
 #define IE_M_RX_THLD_SHIFT           30
 #define IE_M_START_BUSY_SHIFT        28
+#define IE_M_TX_UNDERRUN_SHIFT       27
 
 #define IS_OFFSET                    0x3c
 #define IS_M_RX_FIFO_FULL_SHIFT      31
 #define IS_M_RX_THLD_SHIFT           30
 #define IS_M_START_BUSY_SHIFT        28
+#define IS_M_TX_UNDERRUN_SHIFT       27
 
 #define M_TX_OFFSET                  0x40
 #define M_TX_WR_STATUS_SHIFT         31
@@ -76,7 +78,7 @@
 #define M_RX_DATA_SHIFT              0
 #define M_RX_DATA_MASK               0xff
 
-#define I2C_TIMEOUT_MSEC             100
+#define I2C_TIMEOUT_MSEC             50000
 #define M_TX_RX_FIFO_SIZE            64
 
 enum bus_speed_index {
@@ -95,12 +97,17 @@ struct bcm_iproc_i2c_dev {
 
 	struct completion done;
 	int xfer_is_done;
+
+	struct i2c_msg *msg;
+
+	/* bytes that have been transferred */
+	unsigned int tx_bytes;
 };
 
 /*
  * Can be expanded in the future if more interrupt status bits are utilized
  */
-#define ISR_MASK (1 << IS_M_START_BUSY_SHIFT)
+#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT))
 
 static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 {
@@ -112,9 +119,49 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 	if (!status)
 		return IRQ_NONE;
 
+	/* TX FIFO is empty and we have more data to send */
+	if (status & BIT(IS_M_TX_UNDERRUN_SHIFT)) {
+		struct i2c_msg *msg = iproc_i2c->msg;
+		unsigned int tx_bytes = msg->len - iproc_i2c->tx_bytes;
+		unsigned int i;
+		u32 val;
+
+		/* can only fill up to the FIFO size */
+		tx_bytes = min_t(unsigned int, tx_bytes, M_TX_RX_FIFO_SIZE);
+		for (i = 0; i < tx_bytes; i++) {
+			/* start from where we left over */
+			unsigned int idx = iproc_i2c->tx_bytes + i;
+
+			val = msg->buf[idx];
+
+			/* mark the last byte */
+			if (idx == msg->len - 1) {
+				u32 tmp;
+
+				val |= BIT(M_TX_WR_STATUS_SHIFT);
+
+				/*
+				 * Since this is the last byte, we should
+				 * now disable TX FIFO underrun interrupt
+				 */
+				tmp = readl(iproc_i2c->base + IE_OFFSET);
+				tmp &= ~BIT(IE_M_TX_UNDERRUN_SHIFT);
+				writel(tmp, iproc_i2c->base + IE_OFFSET);
+			}
+
+			/* load data into TX FIFO */
+			writel(val, iproc_i2c->base + M_TX_OFFSET);
+		}
+		/* update number of transferred bytes */
+		iproc_i2c->tx_bytes += tx_bytes;
+	}
+
+	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
+		iproc_i2c->xfer_is_done = 1;
+		complete_all(&iproc_i2c->done);
+	}
+
 	writel(status, iproc_i2c->base + IS_OFFSET);
-	iproc_i2c->xfer_is_done = 1;
-	complete_all(&iproc_i2c->done);
 
 	return IRQ_HANDLED;
 }
@@ -207,6 +254,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	int ret, i;
 	u8 addr;
 	u32 val;
+	unsigned int tx_bytes;
 	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
 
 	/* check if bus is busy */
@@ -216,13 +264,20 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 		return -EBUSY;
 	}
 
+	iproc_i2c->msg = msg;
+
 	/* format and load slave address into the TX FIFO */
 	addr = msg->addr << 1 | (msg->flags & I2C_M_RD ? 1 : 0);
 	writel(addr, iproc_i2c->base + M_TX_OFFSET);
 
-	/* for a write transaction, load data into the TX FIFO */
+	/*
+	 * For a write transaction, load data into the TX FIFO. Only allow
+	 * loading up to TX FIFO size - 1 bytes of data since the first byte
+	 * has been used up by the slave address
+	 */
+	tx_bytes = min_t(unsigned int, msg->len, M_TX_RX_FIFO_SIZE - 1);
 	if (!(msg->flags & I2C_M_RD)) {
-		for (i = 0; i < msg->len; i++) {
+		for (i = 0; i < tx_bytes; i++) {
 			val = msg->buf[i];
 
 			/* mark the last byte */
@@ -231,6 +286,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 			writel(val, iproc_i2c->base + M_TX_OFFSET);
 		}
+		iproc_i2c->tx_bytes = tx_bytes;
 	}
 
 	/* mark as incomplete before starting the transaction */
@@ -242,13 +298,24 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	 * transaction is done, i.e., the internal start_busy bit, transitions
 	 * from 1 to 0.
 	 */
-	writel(1 << IE_M_START_BUSY_SHIFT, iproc_i2c->base + IE_OFFSET);
+	val = BIT(IE_M_START_BUSY_SHIFT);
+
+	/*
+	 * If TX data size is larger than the TX FIFO, need to enable TX
+	 * underrun interrupt, which will be triggerred when the TX FIFO is
+	 * empty. When that happens we can then pump more data into the FIFO
+	 */
+	if (!(msg->flags & I2C_M_RD) &&
+	    msg->len > iproc_i2c->tx_bytes)
+		val |= BIT(IE_M_TX_UNDERRUN_SHIFT);
+
+	writel(val, iproc_i2c->base + IE_OFFSET);
 
 	/*
 	 * Now we can activate the transfer. For a read operation, specify the
 	 * number of bytes to read
 	 */
-	val = 1 << M_CMD_START_BUSY_SHIFT;
+	val = BIT(M_CMD_START_BUSY_SHIFT);
 	if (msg->flags & I2C_M_RD) {
 		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
 		       (msg->len << M_CMD_RD_CNT_SHIFT);
@@ -331,7 +398,6 @@ static const struct i2c_algorithm bcm_iproc_algo = {
 static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
 	/* need to reserve one byte in the FIFO for the slave address */
 	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
-	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
 };
 
 static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
-- 
1.9.1
