From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/8] i2c: img-scb: use DIV_ROUND_UP to round divisor values
Date: Mon, 27 Jul 2015 12:47:16 +0100
Message-ID: <1437997641-32575-4-git-send-email-sifan.naeem@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437997641-32575-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "Stable kernel (v3.19+)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Using % can be slow depending on the architecture.

Using DIV_ROUND_UP is nicer and more efficient way to do it.

Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Stable kernel (v3.19+) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 0368d91..b4f59e1 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1179,9 +1179,7 @@ static int img_i2c_init(struct img_i2c *i2c)
 		int_bitrate++;
 
 	/* Setup TCKH value */
-	tckh = timing.tckh / clk_period;
-	if (timing.tckh % clk_period)
-		tckh++;
+	tckh = DIV_ROUND_UP(timing.tckh, clk_period);
 
 	if (tckh > 0)
 		data = tckh - 1;
@@ -1201,9 +1199,7 @@ static int img_i2c_init(struct img_i2c *i2c)
 	img_i2c_writel(i2c, SCB_TIME_TCKL_REG, data);
 
 	/* Setup TSDH value */
-	tsdh = timing.tsdh / clk_period;
-	if (timing.tsdh % clk_period)
-		tsdh++;
+	tsdh = DIV_ROUND_UP(timing.tsdh, clk_period);
 
 	if (tsdh > 1)
 		data = tsdh - 1;
-- 
1.7.9.5
