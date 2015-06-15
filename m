From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 8/9] i2c: xiic: Remove the Addressed as slave interrupt
Date: Mon, 15 Jun 2015 20:47:59 +0530
Message-ID: <1434381480-3042-8-git-send-email-shubhraj@xilinx.com>
References: <1434381480-3042-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434381480-3042-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently there is no slave mode. Do not enable the AAS interrupt.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 62f7138..69d937e 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -283,7 +283,7 @@ static void xiic_reinit(struct xiic_i2c *i2c)
 	/* Enable interrupts */
 	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
 
-	xiic_irq_clr_en(i2c, XIIC_INTR_AAS_MASK | XIIC_INTR_ARB_LOST_MASK);
+	xiic_irq_clr_en(i2c, XIIC_INTR_ARB_LOST_MASK);
 }
 
 static void xiic_deinit(struct xiic_i2c *i2c)
-- 
1.7.1
