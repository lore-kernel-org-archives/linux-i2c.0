From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 1/9] i2c: xiic: Remove the disabling of interrupts
Date: Wed, 17 Jun 2015 20:48:11 +0530
Message-ID: <1434554299-23443-2-git-send-email-shubhraj@xilinx.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434554299-23443-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently the interrupts are disabled at the start of the
isr and enabled at the end of the isr. Remove the same.

In case the slave device NACKs the transaction while in the isr
the transfer will continue and the NACK interrupt will arrive
only after the isr is serviced.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 4dda23f..912780a 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -604,14 +604,11 @@ static irqreturn_t xiic_isr(int irq, void *dev_id)
 	struct xiic_i2c *i2c = dev_id;
 
 	spin_lock(&i2c->lock);
-	/* disable interrupts globally */
-	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, 0);
 
 	dev_dbg(i2c->adap.dev.parent, "%s entry\n", __func__);
 
 	xiic_process(i2c);
 
-	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
 	spin_unlock(&i2c->lock);
 
 	return IRQ_HANDLED;
-- 
1.7.1
