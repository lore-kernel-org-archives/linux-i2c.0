From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] Revert "i2c: dev: switch from register_chrdev to cdev API"
Date: Sat, 28 May 2016 11:07:47 +0200
Message-ID: <1464426467-1824-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52246 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbcE1JHw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 28 May 2016 05:07:52 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Erico Nunes <erico.nunes@datacom.ind.br>, Dan Carpenter <dan.carpenter@oracle.com>, kernel-janitors@vger.kernel.org, LKP <lkp@01.org>, Wolfram Sang <wsa@the-dreams.de>

This reverts commit d6760b14d4a1243f918d983bba1e35c5a5cd5a6d. When
hitting Linus' tree, buildbots ran additional checks and found boot
problems. Although Dan Carpenter provided an obvious fix already, I
still could not reproduce one problem manually (at least not on a
Saturday morning). So we'll try again later after some more
investigation.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-dev.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 89593dcb79f032..bc3cc7faf5af46 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -22,7 +22,6 @@
 
 /* The I2C_RDWR ioctl code is written by Kolja Waschk <waschk@telos.de> */
 
-#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/i2c-dev.h>
@@ -48,10 +47,9 @@ struct i2c_dev {
 	struct list_head list;
 	struct i2c_adapter *adap;
 	struct device *dev;
-	struct cdev cdev;
 };
 
-#define I2C_MINORS	MINORMASK
+#define I2C_MINORS	256
 static LIST_HEAD(i2c_dev_list);
 static DEFINE_SPINLOCK(i2c_dev_list_lock);
 
@@ -554,12 +552,6 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 
-	cdev_init(&i2c_dev->cdev, &i2cdev_fops);
-	i2c_dev->cdev.owner = THIS_MODULE;
-	res = cdev_add(&i2c_dev->cdev, MKDEV(I2C_MAJOR, adap->nr), 1);
-	if (res)
-		goto error_cdev;
-
 	/* register this i2c device with the driver core */
 	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
 				     MKDEV(I2C_MAJOR, adap->nr), NULL,
@@ -573,8 +565,6 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 		 adap->name, adap->nr);
 	return 0;
 error:
-	cdev_del(&i2c_dev->cdev);
-error_cdev:
 	put_i2c_dev(i2c_dev);
 	return res;
 }
@@ -594,7 +584,6 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 
 	put_i2c_dev(i2c_dev);
 	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
-	cdev_del(&i2c_dev->cdev);
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
 	return 0;
@@ -631,7 +620,7 @@ static int __init i2c_dev_init(void)
 
 	printk(KERN_INFO "i2c /dev entries driver\n");
 
-	res = register_chrdev_region(MKDEV(I2C_MAJOR, 0), I2C_MINORS, "i2c");
+	res = register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops);
 	if (res)
 		goto out;
 
@@ -655,7 +644,7 @@ static int __init i2c_dev_init(void)
 out_unreg_class:
 	class_destroy(i2c_dev_class);
 out_unreg_chrdev:
-	unregister_chrdev_region(MKDEV(I2C_MAJOR, 0), I2C_MINORS);
+	unregister_chrdev(I2C_MAJOR, "i2c");
 out:
 	printk(KERN_ERR "%s: Driver Initialisation failed\n", __FILE__);
 	return res;
@@ -666,7 +655,7 @@ static void __exit i2c_dev_exit(void)
 	bus_unregister_notifier(&i2c_bus_type, &i2cdev_notifier);
 	i2c_for_each_dev(NULL, i2cdev_detach_adapter);
 	class_destroy(i2c_dev_class);
-	unregister_chrdev_region(MKDEV(I2C_MAJOR, 0), I2C_MINORS);
+	unregister_chrdev(I2C_MAJOR, "i2c");
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
-- 
2.8.1
