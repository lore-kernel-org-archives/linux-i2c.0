From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] i2c: xiic: Replace spinlock with mutex
Date: Mon, 16 Nov 2015 14:42:05 +0100
Message-ID: <1447681325-30914-3-git-send-email-lars@metafoo.de>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0071.outbound.protection.outlook.com ([65.55.169.71]:37216
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752724AbbKPNmO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 Nov 2015 08:42:14 -0500
In-Reply-To: <1447681325-30914-1-git-send-email-lars@metafoo.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

All protected sections are only called from sleep-able context, so there is
no need to use a spinlock.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/i2c/busses/i2c-xiic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 0b20449..6efd200 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -70,7 +70,7 @@ struct xiic_i2c {
 	wait_queue_head_t	wait;
 	struct i2c_adapter	adap;
 	struct i2c_msg		*tx_msg;
-	spinlock_t		lock;
+	struct mutex		lock;
 	unsigned int		tx_pos;
 	unsigned int		nmsgs;
 	enum xilinx_i2c_state	state;
@@ -369,7 +369,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	 * To find which interrupts are pending; AND interrupts pending with
 	 * interrupts masked.
 	 */
-	spin_lock(&i2c->lock);
+	mutex_lock(&i2c->lock);
 	isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
 	ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
 	pend = isr & ier;
@@ -497,7 +497,7 @@ out:
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
 
 	xiic_setreg32(i2c, XIIC_IISR_OFFSET, clr);
-	spin_unlock(&i2c->lock);
+	mutex_unlock(&i2c->lock);
 	return IRQ_HANDLED;
 }
 
@@ -662,10 +662,10 @@ static void __xiic_start_xfer(struct xiic_i2c *i2c)
 
 static void xiic_start_xfer(struct xiic_i2c *i2c)
 {
-	spin_lock(&i2c->lock);
+	mutex_lock(&i2c->lock);
 	xiic_reinit(i2c);
 	__xiic_start_xfer(i2c);
-	spin_unlock(&i2c->lock);
+	mutex_unlock(&i2c->lock);
 }
 
 static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
@@ -745,7 +745,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
 
-	spin_lock_init(&i2c->lock);
+	mutex_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, xiic_isr,
-- 
2.1.4
