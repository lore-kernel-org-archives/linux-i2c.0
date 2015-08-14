From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 4/7] i2c: img-scb: fix LOW and HIGH period values for the SCL clock
Date: Fri, 14 Aug 2015 16:50:21 +0100
Message-ID: <1439567424-8094-5-git-send-email-sifan.naeem@imgtec.com>
References: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567424-8094-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently, after determining the minimum value for the High period
(TCKH) the remainder of the internal clock pulses is set as the Low
period (TCKL). This causes the i2c clock duty cycle to be much less
than 50%.

Modify the starting position to TCKH and TCKL at 50% of the internal
clock, and adjusts the TCKH and TCKL values from there should the
minimum value for TCKL not be met. This results in duty cycles closer
to 50%.

Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index b4f59e1a5cac..e4daebcdf824 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1178,25 +1178,29 @@ static int img_i2c_init(struct img_i2c *i2c)
 	    ((bitrate_khz * clk_period) / 2))
 		int_bitrate++;
 
-	/* Setup TCKH value */
-	tckh = DIV_ROUND_UP(timing.tckh, clk_period);
+	/*
+	 * Setup clock duty cycle, start with 50% and adjust TCKH and TCKL
+	 * values from there if they don't meet minimum timing requirements
+	 */
+	tckh = int_bitrate / 2;
+	tckl = int_bitrate - tckh;
 
-	if (tckh > 0)
-		data = tckh - 1;
-	else
-		data = 0;
+	/* Adjust TCKH and TCKL values */
+	data = DIV_ROUND_UP(timing.tckl, clk_period);
 
-	img_i2c_writel(i2c, SCB_TIME_TCKH_REG, data);
+	if (tckl < data) {
+		tckl = data;
+		tckh = int_bitrate - tckl;
+	}
 
-	/* Setup TCKL value */
-	tckl = int_bitrate - tckh;
+	if (tckh > 0)
+		--tckh;
 
 	if (tckl > 0)
-		data = tckl - 1;
-	else
-		data = 0;
+		--tckl;
 
-	img_i2c_writel(i2c, SCB_TIME_TCKL_REG, data);
+	img_i2c_writel(i2c, SCB_TIME_TCKH_REG, tckh);
+	img_i2c_writel(i2c, SCB_TIME_TCKL_REG, tckl);
 
 	/* Setup TSDH value */
 	tsdh = DIV_ROUND_UP(timing.tsdh, clk_period);
-- 
1.7.9.5
