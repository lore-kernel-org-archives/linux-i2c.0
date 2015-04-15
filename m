From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c: core: Export bus recovery functions
Date: Wed, 15 Apr 2015 19:18:39 +0100
Message-ID: <1429121919-1448-1-git-send-email-broonie@kernel.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Current -next fails to link an ARM allmodconfig because drivers that use
the core recovery functions can be built as modules but those functions
are not exported:

ERROR: "i2c_generic_gpio_recovery" [drivers/i2c/busses/i2c-davinci.ko] undefined!
ERROR: "i2c_generic_scl_recovery" [drivers/i2c/busses/i2c-davinci.ko] undefined!
ERROR: "i2c_recover_bus" [drivers/i2c/busses/i2c-davinci.ko] undefined!

Add exports to fix this.

Fixes: 5f9296ba21b3c (i2c: Add bus recovery infrastructure)
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 1672e6b12774..098f698fe8f4 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -596,6 +596,7 @@ int i2c_generic_scl_recovery(struct i2c_adapter *adap)
 	adap->bus_recovery_info->set_scl(adap, 1);
 	return i2c_generic_recovery(adap);
 }
+EXPORT_SYMBOL_GPL(i2c_generic_scl_recovery);
 
 int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
 {
@@ -610,6 +611,7 @@ int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(i2c_generic_gpio_recovery);
 
 int i2c_recover_bus(struct i2c_adapter *adap)
 {
@@ -619,6 +621,7 @@ int i2c_recover_bus(struct i2c_adapter *adap)
 	dev_dbg(&adap->dev, "Trying i2c bus recovery\n");
 	return adap->bus_recovery_info->recover_bus(adap);
 }
+EXPORT_SYMBOL_GPL(i2c_recover_bus);
 
 static int i2c_device_probe(struct device *dev)
 {
-- 
2.1.4
