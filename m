From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 20/22] i2c-designware: Skip RX_FULL and TX_EMPTY bits on
 tx abort errors
Date: Fri, 06 Nov 2009 21:51:36 +0900
Message-ID: <4AF41BD8.8090404@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Suppose TX_ABRT occurs in the middle of processing i2c_msg msgs[], and
a STOP condition has already been generated on the bus.  In this case,
subsequent i2c_dw_xfer_msg() might initiate a new and unnecessary I2C
transaction, which we'd have to avoid.

Furthermore, anytime TX_ABRT is set, the contents of tx/rx buffers are
flushed, so we don't have to process RX_FULL and TX_EMPTY.

Disable interrupts, and skip them.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index cb83671..e6b1e6e 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -621,6 +621,13 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
+
+		/*
+		 * Anytime TX_ABRT is set, the contents of the tx/rx
+		 * buffers are flushed.  Make sure to skip them.
+		 */
+		writel(0, dev->base + DW_IC_INTR_MASK);
+		goto tx_aborted;
 	}
 
 	if (stat & DW_IC_INTR_RX_FULL)
@@ -635,6 +642,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	 * the current transmit status.
 	 */
 
+tx_aborted:
 	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
 
-- 
1.6.5.2
