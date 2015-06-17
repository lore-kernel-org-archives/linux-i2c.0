From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 2/9] i2c: xiic: move the xiic_process to thread context
Date: Wed, 17 Jun 2015 20:48:12 +0530
Message-ID: <1434554299-23443-3-git-send-email-shubhraj@xilinx.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434554299-23443-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The xiic_process is a 154 line code that runs in isr context currently
move it to thread context. Also the name xiic_process suggests that the
intension was to run in process context.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 912780a..1a6e637 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -358,8 +358,9 @@ static void xiic_wakeup(struct xiic_i2c *i2c, int code)
 	wake_up(&i2c->wait);
 }
 
-static void xiic_process(struct xiic_i2c *i2c)
+static irqreturn_t xiic_process(int irq, void *dev_id)
 {
+	struct xiic_i2c *i2c = dev_id;
 	u32 pend, isr, ier;
 	u32 clr = 0;
 
@@ -368,6 +369,7 @@ static void xiic_process(struct xiic_i2c *i2c)
 	 * To find which interrupts are pending; AND interrupts pending with
 	 * interrupts masked.
 	 */
+	spin_lock(&i2c->lock);
 	isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
 	ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
 	pend = isr & ier;
@@ -378,11 +380,6 @@ static void xiic_process(struct xiic_i2c *i2c)
 		__func__, xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
 		i2c->tx_msg, i2c->nmsgs);
 
-	/* Do not processes a devices interrupts if the device has no
-	 * interrupts pending
-	 */
-	if (!pend)
-		return;
 
 	/* Service requesting interrupt */
 	if ((pend & XIIC_INTR_ARB_LOST_MASK) ||
@@ -502,6 +499,8 @@ out:
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
 
 	xiic_setreg32(i2c, XIIC_IISR_OFFSET, clr);
+	spin_unlock(&i2c->lock);
+	return IRQ_HANDLED;
 }
 
 static int xiic_bus_busy(struct xiic_i2c *i2c)
@@ -602,16 +601,21 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 static irqreturn_t xiic_isr(int irq, void *dev_id)
 {
 	struct xiic_i2c *i2c = dev_id;
-
-	spin_lock(&i2c->lock);
+	u32 pend, isr, ier;
+	irqreturn_t ret = IRQ_HANDLED;
+	/* Do not processes a devices interrupts if the device has no
+	 * interrupts pending
+	 */
 
 	dev_dbg(i2c->adap.dev.parent, "%s entry\n", __func__);
 
-	xiic_process(i2c);
-
-	spin_unlock(&i2c->lock);
+	isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
+	ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
+	pend = isr & ier;
+	if (pend)
+		ret = IRQ_WAKE_THREAD;
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static void __xiic_start_xfer(struct xiic_i2c *i2c)
@@ -752,7 +756,10 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
-	ret = devm_request_irq(&pdev->dev, irq, xiic_isr, 0, pdev->name, i2c);
+	ret = devm_request_threaded_irq(&pdev->dev, irq, xiic_isr,
+					xiic_process, IRQF_ONESHOT,
+					pdev->name, i2c);
+
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
 		return ret;
-- 
1.7.1
