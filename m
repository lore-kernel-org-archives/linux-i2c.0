From: <shubhrajyoti.datta@gmail.com>
Subject: [PATCH] i2c: xiic: Make the start and the byte count write atomic
Date: Mon, 3 Sep 2018 15:11:11 +0530
Message-ID: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: shubhrajyoti.datta@gmail.com, wsa@the-dreams.de, michal.simek@xilinx.com, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Disable interrupts while configuring the transfer and enable them back.

We have below as the programming sequence
1. start and slave address
2. byte count and stop

In some customer platform there was a lot of interrupts between 1 and 2
and after slave address (around 7 clock cyles) if 2 is not executed
then the transaction is nacked.

To fix this case make the 2 writes atomic.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/i2c/busses/i2c-xiic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 9a71e50..4e3b2a4 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -532,6 +532,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 {
 	u8 rx_watermark;
 	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
+	unsigned long flags;
 
 	/* Clear and enable Rx full interrupt. */
 	xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK | XIIC_INTR_TX_ERROR_MASK);
@@ -547,6 +548,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 		rx_watermark = IIC_RX_FIFO_DEPTH;
 	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rx_watermark - 1);
 
+	local_irq_save(flags);
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
@@ -556,6 +558,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 	xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
 		msg->len | ((i2c->nmsgs == 1) ? XIIC_TX_DYN_STOP_MASK : 0));
+	local_irq_restore(flags);
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
 		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
-- 
2.1.1
