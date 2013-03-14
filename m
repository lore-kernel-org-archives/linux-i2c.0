From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] i2c: at91: Use of_match_ptr() macro
Date: Thu, 14 Mar 2013 15:43:03 +0530
Message-ID: <1363255983-25407-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This eliminates having an #ifdef returning NULL for the case
when OF is disabled.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 75195e3..23a1c44 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -603,8 +603,6 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
 	}
 };
 MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
-#else
-#define atmel_twi_dt_ids NULL
 #endif
 
 static bool filter(struct dma_chan *chan, void *slave)
@@ -828,7 +826,7 @@ static struct platform_driver at91_twi_driver = {
 	.driver		= {
 		.name	= "at91_i2c",
 		.owner	= THIS_MODULE,
-		.of_match_table = atmel_twi_dt_ids,
+		.of_match_table = of_match_ptr(atmel_twi_dt_ids),
 		.pm	= at91_twi_pm_ops,
 	},
 };
-- 
1.7.4.1
