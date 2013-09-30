From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] i2c: mv64xxx: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 17:32:06 +0530
Message-ID: <1380542526-2943-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 7f3a474..f42d88a 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -909,7 +909,7 @@ static struct platform_driver mv64xxx_i2c_driver = {
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= MV64XXX_I2C_CTLR_NAME,
-		.of_match_table = of_match_ptr(mv64xxx_i2c_of_match_table),
+		.of_match_table = mv64xxx_i2c_of_match_table,
 	},
 };
 
-- 
1.7.9.5
