From: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] hwmon: lm92: Add devicetree support
Date: Thu, 23 Jul 2015 11:29:08 +0200
Message-ID: <1437643748-11677-1-git-send-email-denis@eukrea.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
---
 drivers/hwmon/lm92.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index cfaf70b..a1e10cd 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -44,6 +44,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/jiffies.h>
 
 /*
@@ -386,6 +387,13 @@ static int lm92_probe(struct i2c_client *new_client,
  * Module and driver stuff
  */
 
+#ifdef CONFIG_OF
+static const struct of_device_id lm92_of_match[] = {
+	{ .compatible = "national,lm92", },
+};
+MODULE_DEVICE_TABLE(of, lm92_of_match);
+#endif
+
 static const struct i2c_device_id lm92_id[] = {
 	{ "lm92", 0 },
 	/* max6635 could be added here */
@@ -397,6 +405,7 @@ static struct i2c_driver lm92_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "lm92",
+		.of_match_table = of_match_ptr(lm92_of_match),
 	},
 	.probe		= lm92_probe,
 	.id_table	= lm92_id,
-- 
2.4.5
