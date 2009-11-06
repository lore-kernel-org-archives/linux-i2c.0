From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 19/22] i2c-designware: i2c_dw_xfer_msg: Fix error handling
 procedures
Date: Fri, 06 Nov 2009 21:51:18 +0900
Message-ID: <4AF41BC6.6090809@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Current error handling procedures are not good in two respects:

* Forgot to mark dev->cmd_complete as "completed" on errors

  Once an I2C transaction is initiated, wait_for_completion_
  interruptible_timeout() waits for dev->cmd_complete to be completed.
  We have to take care of it whenever an error is detected, otherwise
  we will have a needless HZ timeout.

* Forgot to disable interrupts

  In the previous patch, interrupt mask operations have been changed.
  We don't disable interrupts at the end of the interrupt handler any
  more, and try to keep RX_FULL (and TX_EMPTY if required) enabled
  during the transaction so that we can send longer data than the size
  of Tx/Rx FIFO.

  If an error is detected, we need to disable interrupts before
  quitting current transaction.

We can work around above points using dev->msg_err effectively.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 6acbe84..cb83671 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -380,14 +380,18 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		 * reprogram the target address in the i2c
 		 * adapter when we are done with this transfer
 		 */
-		if (msgs[dev->msg_write_idx].addr != addr)
-			return;
+		if (msgs[dev->msg_write_idx].addr != addr) {
+			dev_err(dev->dev,
+				"%s: invalid target address\n", __func__);
+			dev->msg_err = -EINVAL;
+			break;
+		}
 
 		if (msgs[dev->msg_write_idx].len == 0) {
 			dev_err(dev->dev,
 				"%s: invalid message length\n", __func__);
 			dev->msg_err = -EINVAL;
-			return;
+			break;
 		}
 
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
@@ -426,6 +430,9 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	if (dev->msg_write_idx == dev->msgs_num)
 		intr_mask &= ~DW_IC_INTR_TX_EMPTY;
 
+	if (dev->msg_err)
+		intr_mask = 0;
+
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
 }
 
@@ -628,7 +635,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	 * the current transmit status.
 	 */
 
-	if (stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
+	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
 
 	return IRQ_HANDLED;
-- 
1.6.5.2
