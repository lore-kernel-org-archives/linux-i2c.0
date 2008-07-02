From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 1/1] i2c_gpio: keep probe resident for hotplugged
	devices.
Date: Wed, 02 Jul 2008 11:16:12 +0100
Message-ID: <20080702101611.858837181@fluff.org>
References: <20080702101611.757880819@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-i2c-gpio-fixprobe.patch
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Change the i2c_gpio driver to use platform_driver_register()
instead of platform_driver_probe() to ensure that is can
attach to any devices that may be loaded after it has initialised.

Cc: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc8-quilt3/drivers/i2c/busses/i2c-gpio.c
===================================================================
--- linux-2.6.26-rc8-quilt3.orig/drivers/i2c/busses/i2c-gpio.c	2008-06-25 09:46:48.000000000 +0100
+++ linux-2.6.26-rc8-quilt3/drivers/i2c/busses/i2c-gpio.c	2008-07-02 11:12:05.000000000 +0100
@@ -77,7 +77,7 @@ static int i2c_gpio_getscl(void *data)
 	return gpio_get_value(pdata->scl_pin);
 }
 
-static int __init i2c_gpio_probe(struct platform_device *pdev)
+static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
@@ -174,7 +174,7 @@ err_alloc_adap:
 	return ret;
 }
 
-static int __exit i2c_gpio_remove(struct platform_device *pdev)
+static int __devexit i2c_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_adapter *adap;
@@ -196,14 +196,15 @@ static struct platform_driver i2c_gpio_d
 		.name	= "i2c-gpio",
 		.owner	= THIS_MODULE,
 	},
-	.remove		= __exit_p(i2c_gpio_remove),
+	.probe		= i2c_gpio_probe,
+	.remove		= __devexit_p(i2c_gpio_remove),
 };
 
 static int __init i2c_gpio_init(void)
 {
 	int ret;
 
-	ret = platform_driver_probe(&i2c_gpio_driver, i2c_gpio_probe);
+	ret = platform_driver_register(&i2c_gpio_driver);
 	if (ret)
 		printk(KERN_ERR "i2c-gpio: probe failed: %d\n", ret);
 

-- 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
