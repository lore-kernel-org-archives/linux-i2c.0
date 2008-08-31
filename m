From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-parport-light: Don't register a platform device
 resource
Date: Sun, 31 Aug 2008 12:07:37 +0200
Message-ID: <20080831120737.0ee934ea@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-parport-light driver isn't a real platform driver, so it
should not instantiate platform devices with resources. The resource
management system can't cope with colliding resources, and we are
likely to create such a colliding resource.

So, better just try to grab the I/O ports we need right at module
initialization time, and bail out if we can't. It has the added
benefit that the module will no longer load if it isn't going to work,
which is definitely more user-friendly.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport-light.c |   39 ++++++--------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

--- linux-2.6.27-rc5.orig/drivers/i2c/busses/i2c-parport-light.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.27-rc5/drivers/i2c/busses/i2c-parport-light.c	2008-08-30 17:05:45.000000000 +0200
@@ -123,11 +123,6 @@ static struct i2c_adapter parport_adapte
 static int __devinit i2c_parport_probe(struct platform_device *pdev)
 {
 	int err;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, res->end - res->start + 1, DRVNAME))
-		return -EBUSY;
 
 	/* Reset hardware to a sane state (SCL and SDA high) */
 	parport_setsda(NULL, 1);
@@ -138,29 +133,19 @@ static int __devinit i2c_parport_probe(s
 
 	parport_adapter.dev.parent = &pdev->dev;
 	err = i2c_bit_add_bus(&parport_adapter);
-	if (err) {
+	if (err)
 		dev_err(&pdev->dev, "Unable to register with I2C\n");
-		goto exit_region;
-	}
-	return 0;
-
-exit_region:
-	release_region(res->start, res->end - res->start + 1);
 	return err;
 }
 
 static int __devexit i2c_parport_remove(struct platform_device *pdev)
 {
-	struct resource *res;
-
 	i2c_del_adapter(&parport_adapter);
 
 	/* Un-init if needed (power off...) */
 	if (adapter_parm[type].init.val)
 		line_set(0, &adapter_parm[type].init);
 
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start, res->end - res->start + 1);
 	return 0;
 }
 
@@ -175,12 +160,6 @@ static struct platform_driver i2c_parpor
 
 static int __init i2c_parport_device_add(u16 address)
 {
-	struct resource res = {
-		.start	= address,
-		.end	= address + 2,
-		.name	= DRVNAME,
-		.flags	= IORESOURCE_IO,
-	};
 	int err;
 
 	pdev = platform_device_alloc(DRVNAME, -1);
@@ -190,13 +169,6 @@ static int __init i2c_parport_device_add
 		goto exit;
 	}
 
-	err = platform_device_add_resources(pdev, &res, 1);
-	if (err) {
-		printk(KERN_ERR DRVNAME ": Device resource addition failed "
-		       "(%d)\n", err);
-		goto exit_device_put;
-	}
-
 	err = platform_device_add(pdev);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
@@ -231,13 +203,16 @@ static int __init i2c_parport_init(void)
 		base = DEFAULT_BASE;
 	}
 
+	if (!request_region(base, 3, DRVNAME))
+		return -EBUSY;
+
         if (!adapter_parm[type].getscl.val)
 		parport_algo_data.getscl = NULL;
 
 	/* Sets global pdev as a side effect */
 	err = i2c_parport_device_add(base);
 	if (err)
-		goto exit;
+		goto exit_release;
 
 	err = platform_driver_register(&i2c_parport_driver);
 	if (err)
@@ -247,7 +222,8 @@ static int __init i2c_parport_init(void)
 
 exit_device:
 	platform_device_unregister(pdev);
-exit:
+exit_release:
+	release_region(base, 3);
 	return err;
 }
 
@@ -255,6 +231,7 @@ static void __exit i2c_parport_exit(void
 {
 	platform_driver_unregister(&i2c_parport_driver);
 	platform_device_unregister(pdev);
+	release_region(base, 3);
 }
 
 MODULE_AUTHOR("Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>");


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
