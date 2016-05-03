From: Erico Nunes <erico.nunes@datacom.ind.br>
Subject: [PATCH 1/1] i2c-dev: switch from register_chrdev to cdev API
Date: Tue,  3 May 2016 15:45:43 -0300
Message-ID: <1462301143-6084-1-git-send-email-erico.nunes@datacom.ind.br>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx.datacom.ind.br ([177.66.5.10]:50305 "EHLO
	mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932362AbcECSvi (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 3 May 2016 14:51:38 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

i2c-dev had never moved away from the older register_chrdev interface to
implement its char device registration. The register_chrdev API has the
limitation of enabling only up to 256 i2c-dev busses to exist.

Large platforms with lots of i2c devices (i.e. pluggable transceivers)
with dedicated busses may have to exceed that limit.
In particular, there are also platforms making use of the i2c bus
multiplexing API, which instantiates a virtual bus for each possible
multiplexed selection.

This patch removes the register_chrdev usage and replaces it with the
less old cdev API, which takes away the 256 i2c-dev bus limitation.
It should not have any other impact for i2c bus drivers or user space.

This patch has been tested on qemu x86 and qemu powerpc platforms with
the aid of a module which adds and removes 5000 virtual i2c busses, as
well as validated on an existing powerpc hardware platform which makes
use of the i2c bus multiplexing API.
i2c-dev busses with device minor numbers larger than 256 have also been
validated to work with the existing i2c-tools.

Signed-off-by: Erico Nunes <erico.nunes@datacom.ind.br>
---
 drivers/i2c/i2c-dev.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 0b1108d..bacb472 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/cdev.h>
 
 /*
  * An i2c_dev represents an i2c_adapter ... an I2C or SMBus master, not a
@@ -47,9 +48,10 @@ struct i2c_dev {
 	struct list_head list;
 	struct i2c_adapter *adap;
 	struct device *dev;
+	struct cdev cdev;
 };
 
-#define I2C_MINORS	256
+#define I2C_MINORS	MINORMASK
 static LIST_HEAD(i2c_dev_list);
 static DEFINE_SPINLOCK(i2c_dev_list_lock);
 
@@ -552,6 +554,12 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 
+	cdev_init(&i2c_dev->cdev, &i2cdev_fops);
+	i2c_dev->cdev.owner = THIS_MODULE;
+	res = cdev_add(&i2c_dev->cdev, MKDEV(I2C_MAJOR, adap->nr), 1);
+	if (res)
+		goto error_cdev;
+
 	/* register this i2c device with the driver core */
 	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
 				     MKDEV(I2C_MAJOR, adap->nr), NULL,
@@ -565,6 +573,8 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 		 adap->name, adap->nr);
 	return 0;
 error:
+	cdev_del(&i2c_dev->cdev);
+error_cdev:
 	return_i2c_dev(i2c_dev);
 	return res;
 }
@@ -584,6 +594,7 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 
 	return_i2c_dev(i2c_dev);
 	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
+	cdev_del(&i2c_dev->cdev);
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
 	return 0;
@@ -620,7 +631,7 @@ static int __init i2c_dev_init(void)
 
 	printk(KERN_INFO "i2c /dev entries driver\n");
 
-	res = register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops);
+	res = register_chrdev_region(MKDEV(I2C_MAJOR, 0), I2C_MINORS, "i2c");
 	if (res)
 		goto out;
 
@@ -644,7 +655,7 @@ static int __init i2c_dev_init(void)
 out_unreg_class:
 	class_destroy(i2c_dev_class);
 out_unreg_chrdev:
-	unregister_chrdev(I2C_MAJOR, "i2c");
+	unregister_chrdev_region(MKDEV(I2C_MAJOR, 0), I2C_MINORS);
 out:
 	printk(KERN_ERR "%s: Driver Initialisation failed\n", __FILE__);
 	return res;
@@ -655,7 +666,7 @@ static void __exit i2c_dev_exit(void)
 	bus_unregister_notifier(&i2c_bus_type, &i2cdev_notifier);
 	i2c_for_each_dev(NULL, i2cdev_detach_adapter);
 	class_destroy(i2c_dev_class);
-	unregister_chrdev(I2C_MAJOR, "i2c");
+	unregister_chrdev_region(MKDEV(I2C_MAJOR, 0), I2C_MINORS);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
-- 
1.9.1
