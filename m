From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: convert drivers/i2c/* to use module_i2c_driver()
Date: Mon, 13 Feb 2012 17:05:03 +0800
Message-ID: <1329123903.13995.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch converts the drivers in drivers/i2c/* to use the
module_i2c_driver() macro which makes the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/i2c-smbus.c     |   13 +------------
 drivers/i2c/muxes/pca9541.c |   13 +------------
 drivers/i2c/muxes/pca954x.c |   13 +------------
 3 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index f61ccc1..9316705 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -244,18 +244,7 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
 }
 EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
 
-static int __init i2c_smbus_init(void)
-{
-	return i2c_add_driver(&smbalert_driver);
-}
-
-static void __exit i2c_smbus_exit(void)
-{
-	i2c_del_driver(&smbalert_driver);
-}
-
-module_init(i2c_smbus_init);
-module_exit(i2c_smbus_exit);
+module_i2c_driver(smbalert_driver);
 
 MODULE_AUTHOR("Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>");
 MODULE_DESCRIPTION("SMBus protocol extensions support");
diff --git a/drivers/i2c/muxes/pca9541.c b/drivers/i2c/muxes/pca9541.c
index ed699c5..e0df9b6 100644
--- a/drivers/i2c/muxes/pca9541.c
+++ b/drivers/i2c/muxes/pca9541.c
@@ -393,18 +393,7 @@ static struct i2c_driver pca9541_driver = {
 	.id_table = pca9541_id,
 };
 
-static int __init pca9541_init(void)
-{
-	return i2c_add_driver(&pca9541_driver);
-}
-
-static void __exit pca9541_exit(void)
-{
-	i2c_del_driver(&pca9541_driver);
-}
-
-module_init(pca9541_init);
-module_exit(pca9541_exit);
+module_i2c_driver(pca9541_driver);
 
 MODULE_AUTHOR("Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>");
 MODULE_DESCRIPTION("PCA9541 I2C master selector driver");
diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
index 6f89536..0e37ef2 100644
--- a/drivers/i2c/muxes/pca954x.c
+++ b/drivers/i2c/muxes/pca954x.c
@@ -284,18 +284,7 @@ static struct i2c_driver pca954x_driver = {
 	.id_table	= pca954x_id,
 };
 
-static int __init pca954x_init(void)
-{
-	return i2c_add_driver(&pca954x_driver);
-}
-
-static void __exit pca954x_exit(void)
-{
-	i2c_del_driver(&pca954x_driver);
-}
-
-module_init(pca954x_init);
-module_exit(pca954x_exit);
+module_i2c_driver(pca954x_driver);
 
 MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>");
 MODULE_DESCRIPTION("PCA954x I2C mux/switch driver");
-- 
1.7.5.4
