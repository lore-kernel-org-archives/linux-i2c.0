From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 4/9] i2c: xiic: Remove the disabling of interrupts
Date: Wed, 17 Jun 2015 20:48:14 +0530
Message-ID: <1434554299-23443-5-git-send-email-shubhraj@xilinx.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434554299-23443-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently before every transfer the interrupts are disabled.
So incase the slave nacks in the middle of the transfer the
current transfer is not aborted. Upon enabling the interrupts
conditions like NACK , arbitration lost will not be masked.
Remove the disabling of the interrupts.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 92ea52a..d9501ab 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -664,15 +664,8 @@ static void __xiic_start_xfer(struct xiic_i2c *i2c)
 
 static void xiic_start_xfer(struct xiic_i2c *i2c)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&i2c->lock, flags);
-	/* disable interrupts globally */
-	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, 0);
-	spin_unlock_irqrestore(&i2c->lock, flags);
 
 	__xiic_start_xfer(i2c);
-	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
 }
 
 static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
-- 
1.7.1
