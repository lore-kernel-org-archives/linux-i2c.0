From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] i2c: mux-gpio: Remove redundant of_match_ptr
Date: Wed,  2 Oct 2013 22:21:19 +0530
Message-ID: <1380732680-2408-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 5d4a99b..927a7de 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -279,7 +279,7 @@ static struct platform_driver i2c_mux_gpio_driver = {
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-mux-gpio",
-		.of_match_table = of_match_ptr(i2c_mux_gpio_of_match),
+		.of_match_table = i2c_mux_gpio_of_match,
 	},
 };
 
-- 
1.7.4.1
