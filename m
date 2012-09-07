From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed via Device Tree
Date: Fri,  7 Sep 2012 12:14:52 +0100
Message-ID: <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Each I2C device can be correctly probed already using Device Tree,
but the sub-devices still have to be registered by calls to
i2c_register_board_info(). After this patch, each sub-device can
be registered directly from Device Tree instead, removing the
requirement for the aforementioned calls from platform code.

CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5d1a970..01231c2 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/i2c-nomadik.h>
 #include <linux/of.h>
+#include <linux/of_i2c.h>
 
 #define DRIVER_NAME "nmk-i2c"
 
@@ -998,6 +999,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	adap = &dev->adap;
+	adap->dev.of_node = np;
 	adap->dev.parent = &adev->dev;
 	adap->owner	= THIS_MODULE;
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
@@ -1027,6 +1029,8 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_add_adap;
 	}
 
+	of_i2c_register_devices(adap);
+
 	pm_runtime_put(&adev->dev);
 
 	return 0;
-- 
1.7.9.5
