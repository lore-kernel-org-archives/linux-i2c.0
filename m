From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] i2c: mux: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 09:04:25 +0530
Message-ID: <1380512066-23681-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 74b41ae..cb9af93 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -238,7 +238,7 @@ static struct platform_driver i2c_arbitrator_driver = {
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-arb-gpio-challenge",
-		.of_match_table = of_match_ptr(i2c_arbitrator_of_match),
+		.of_match_table = i2c_arbitrator_of_match,
 	},
 };
 
-- 
1.7.9.5
