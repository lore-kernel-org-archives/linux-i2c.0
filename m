From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] misc: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:23:17 +0900
Message-ID: <1436509397-27721-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/misc/ad525x_dpot-i2c.c         | 1 -
 drivers/misc/apds990x.c                | 1 -
 drivers/misc/bh1770glc.c               | 1 -
 drivers/misc/bmp085-i2c.c              | 1 -
 drivers/misc/eeprom/at24.c             | 1 -
 drivers/misc/isl29003.c                | 1 -
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 1 -
 drivers/misc/ti-st/st_kim.c            | 1 -
 drivers/misc/tsl2550.c                 | 1 -
 9 files changed, 9 deletions(-)

diff --git a/drivers/misc/ad525x_dpot-i2c.c b/drivers/misc/ad525x_dpot-i2c.c
index 705b881e186d..d11187d36ddd 100644
--- a/drivers/misc/ad525x_dpot-i2c.c
+++ b/drivers/misc/ad525x_dpot-i2c.c
@@ -106,7 +106,6 @@ MODULE_DEVICE_TABLE(i2c, ad_dpot_id);
 static struct i2c_driver ad_dpot_i2c_driver = {
 	.driver = {
 		.name	= "ad_dpot",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad_dpot_i2c_probe,
 	.remove		= ad_dpot_i2c_remove,
diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 3739ffa9cdf1..a3e789b85cc8 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1275,7 +1275,6 @@ static const struct dev_pm_ops apds990x_pm_ops = {
 static struct i2c_driver apds990x_driver = {
 	.driver	 = {
 		.name	= "apds990x",
-		.owner	= THIS_MODULE,
 		.pm	= &apds990x_pm_ops,
 	},
 	.probe	  = apds990x_probe,
diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index b756381b8250..753d7ecdadaa 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -1396,7 +1396,6 @@ static const struct dev_pm_ops bh1770_pm_ops = {
 static struct i2c_driver bh1770_driver = {
 	.driver	 = {
 		.name	= "bh1770glc",
-		.owner	= THIS_MODULE,
 		.pm	= &bh1770_pm_ops,
 	},
 	.probe	  = bh1770_probe,
diff --git a/drivers/misc/bmp085-i2c.c b/drivers/misc/bmp085-i2c.c
index a7c16295b816..f35c218aaa1a 100644
--- a/drivers/misc/bmp085-i2c.c
+++ b/drivers/misc/bmp085-i2c.c
@@ -66,7 +66,6 @@ MODULE_DEVICE_TABLE(i2c, bmp085_id);
 
 static struct i2c_driver bmp085_i2c_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= BMP085_NAME,
 	},
 	.id_table	= bmp085_id,
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2d3db81be099..8c157229ac82 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -689,7 +689,6 @@ static int at24_remove(struct i2c_client *client)
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
-		.owner = THIS_MODULE,
 	},
 	.probe = at24_probe,
 	.remove = at24_remove,
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index 12c30b486b27..976df0013633 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -465,7 +465,6 @@ MODULE_DEVICE_TABLE(i2c, isl29003_id);
 static struct i2c_driver isl29003_driver = {
 	.driver = {
 		.name	= ISL29003_DRV_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= ISL29003_PM_OPS,
 	},
 	.probe	= isl29003_probe,
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index e3e7f1dc27ba..0c3bb7e3ee80 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -274,7 +274,6 @@ static const struct dev_pm_ops lis3_pm_ops = {
 static struct i2c_driver lis3lv02d_i2c_driver = {
 	.driver	 = {
 		.name   = DRV_NAME,
-		.owner  = THIS_MODULE,
 		.pm     = &lis3_pm_ops,
 		.of_match_table = of_match_ptr(lis3lv02d_i2c_dt_ids),
 	},
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 5027b8ffae43..c84093e639e0 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -939,7 +939,6 @@ static struct platform_driver kim_platform_driver = {
 	.resume = kim_resume,
 	.driver = {
 		.name = "kim",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(kim_of_match),
 	},
 };
diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index b00335652e52..87a13374fdc0 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -446,7 +446,6 @@ MODULE_DEVICE_TABLE(i2c, tsl2550_id);
 static struct i2c_driver tsl2550_driver = {
 	.driver = {
 		.name	= TSL2550_DRV_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= TSL2550_PM_OPS,
 	},
 	.probe	= tsl2550_probe,
-- 
1.9.1
