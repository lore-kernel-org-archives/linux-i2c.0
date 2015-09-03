From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c: Remove setting for 1 second timeout from adapter drivers
Date: Thu,  3 Sep 2015 14:19:46 +0300
Message-ID: <1441279186-12861-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I2C adapter drivers that are using 1 second timeout can leave the timeout
unset and let the i2c-core.c: i2c_register_adapter() to set it instead.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c      | 1 -
 drivers/i2c/busses/i2c-iop3xx.c       | 1 -
 drivers/i2c/busses/i2c-mpc.c          | 1 -
 drivers/i2c/busses/i2c-mv64xxx.c      | 5 -----
 drivers/i2c/busses/i2c-pca-platform.c | 1 -
 5 files changed, 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 722f839cfa3c..13fda39acffe 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -748,7 +748,6 @@ static int iic_probe(struct platform_device *ofdev)
 	i2c_set_adapdata(adap, dev);
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo = &iic_algo;
-	adap->timeout = HZ;
 
 	ret = i2c_add_adapter(adap);
 	if (ret  < 0) {
diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 72d6161cf77c..c4ed8281bec2 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -479,7 +479,6 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 	/*
 	 * Default values...should these come in from board code?
 	 */
-	new_adapter->timeout = HZ;
 	new_adapter->algo = &iop3xx_i2c_algo;
 
 	init_waitqueue_head(&adapter_data->waitq);
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 48ecffecc0ed..b4bb64ffe3cd 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -640,7 +640,6 @@ static const struct i2c_algorithm mpc_algo = {
 static struct i2c_adapter mpc_ops = {
 	.owner = THIS_MODULE,
 	.algo = &mpc_algo,
-	.timeout = HZ,
 };
 
 static const struct of_device_id mpc_i2c_of_match[];
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 30059c1df2a3..2640390be5dd 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -832,11 +832,6 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		reset_control_deassert(drv_data->rstc);
 	}
 
-	/* Its not yet defined how timeouts will be specified in device tree.
-	 * So hard code the value to 1 second.
-	 */
-	drv_data->adapter.timeout = HZ;
-
 	device = of_match_device(mv64xxx_i2c_of_match_table, dev);
 	if (!device)
 		return -ENODEV;
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 3bd2e7d06e4b..2b930df0e6b5 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -183,7 +183,6 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
 		i2c->gpio = platform_data->gpio;
 	} else {
-		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
 		i2c->gpio = -1;
 	}
-- 
2.5.1
