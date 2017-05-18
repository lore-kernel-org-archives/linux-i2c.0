From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/2] i2c: sh_mobile: remove platform_data
Date: Thu, 18 May 2017 23:11:39 +0200
Message-ID: <20170518211140.12023-2-wsa+renesas@sang-engineering.com>
References: <20170518211140.12023-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170518211140.12023-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

No platform currently upstream makes use of this platform_data anymore.
The ones that did are converted to DT meanwhile. So, remove it. The old
platforms likely don't have the 'clks_per_cnt' feature, otherwise it
would have been implemented by now. And in the unlikely case they need
to setup a different bus speed, we should rather go for a generic i2c
platform data just for that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c |  8 --------
 include/linux/i2c/i2c-sh_mobile.h  | 11 -----------
 2 files changed, 19 deletions(-)
 delete mode 100644 include/linux/i2c/i2c-sh_mobile.h

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 3d75593487454c..d5e39eccae9b97 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -24,7 +24,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/i2c/i2c-sh_mobile.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -879,7 +878,6 @@ static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, struct sh_mobile
 
 static int sh_mobile_i2c_probe(struct platform_device *dev)
 {
-	struct i2c_sh_mobile_platform_data *pdata = dev_get_platdata(&dev->dev);
 	struct sh_mobile_i2c_data *pd;
 	struct i2c_adapter *adap;
 	struct resource *res;
@@ -910,7 +908,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	if (IS_ERR(pd->reg))
 		return PTR_ERR(pd->reg);
 
-	/* Use platform data bus speed or STANDARD_MODE */
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
 	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
 
@@ -929,11 +926,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 			if (config->setup)
 				config->setup(pd);
 		}
-	} else {
-		if (pdata && pdata->bus_speed)
-			pd->bus_speed = pdata->bus_speed;
-		if (pdata && pdata->clks_per_count)
-			pd->clks_per_count = pdata->clks_per_count;
 	}
 
 	/* The IIC blocks on SH-Mobile ARM processors
diff --git a/include/linux/i2c/i2c-sh_mobile.h b/include/linux/i2c/i2c-sh_mobile.h
deleted file mode 100644
index 06e3089795fbee..00000000000000
--- a/include/linux/i2c/i2c-sh_mobile.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __I2C_SH_MOBILE_H__
-#define __I2C_SH_MOBILE_H__
-
-#include <linux/platform_device.h>
-
-struct i2c_sh_mobile_platform_data {
-	unsigned long bus_speed;
-	unsigned int clks_per_count;
-};
-
-#endif /* __I2C_SH_MOBILE_H__ */
-- 
2.11.0
