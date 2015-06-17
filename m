From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 3/9] i2c: xiic: Do not reset controller before every transfer
Date: Wed, 17 Jun 2015 20:48:13 +0530
Message-ID: <1434554299-23443-4-git-send-email-shubhraj@xilinx.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434554299-23443-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently before every transfer the controller is reinitialised.
We are already resetting the controller upon errors so upon every
transfer is a performance kill.
Remove the same.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 1a6e637..92ea52a 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -667,7 +667,6 @@ static void xiic_start_xfer(struct xiic_i2c *i2c)
 	unsigned long flags;
 
 	spin_lock_irqsave(&i2c->lock, flags);
-	xiic_reinit(i2c);
 	/* disable interrupts globally */
 	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, 0);
 	spin_unlock_irqrestore(&i2c->lock, flags);
-- 
1.7.1
