From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3] i2c-dev: Use standard bus notification mechanism
Date: Sun, 20 Feb 2011 15:09:25 +0100
Message-ID: <20110220150925.6e58cb37@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use the standard driver core mechanism to keep track of i2c adapters
present on the system: i2c_for_each_dev and a notifier. This will let
us deprecate and ultimately remove the legacy attach_adapter and
detach_adapter callbacks in i2c_driver.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-dev.c |   60 +++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 21 deletions(-)

--- linux-2.6.38-rc5.orig/drivers/i2c/i2c-dev.c	2011-02-19 18:54:23.000000000 +0100
+++ linux-2.6.38-rc5/drivers/i2c/i2c-dev.c	2011-02-19 21:30:17.000000000 +0100
@@ -28,6 +28,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -37,16 +39,13 @@
 #include <linux/jiffies.h>
 #include <linux/uaccess.h>
 
-static struct i2c_driver i2cdev_driver;
-
 /*
  * An i2c_dev represents an i2c_adapter ... an I2C or SMBus master, not a
  * slave (i2c_client) with which messages will be exchanged.  It's coupled
  * with a character special file which is accessed by user mode drivers.
  *
  * The list of i2c_dev structures is parallel to the i2c_adapter lists
- * maintained by the driver model, and is updated using notifications
- * delivered to the i2cdev_driver.
+ * maintained by the driver model, and is updated using bus notifications.
  */
 struct i2c_dev {
 	struct list_head list;
@@ -491,7 +490,6 @@ static int i2cdev_open(struct inode *ino
 		return -ENOMEM;
 	}
 	snprintf(client->name, I2C_NAME_SIZE, "i2c-dev %d", adap->nr);
-	client->driver = &i2cdev_driver;
 
 	client->adapter = adap;
 	file->private_data = client;
@@ -522,19 +520,18 @@ static const struct file_operations i2cd
 
 /* ------------------------------------------------------------------------- */
 
-/*
- * The legacy "i2cdev_driver" is used primarily to get notifications when
- * I2C adapters are added or removed, so that each one gets an i2c_dev
- * and is thus made available to userspace driver code.
- */
-
 static struct class *i2c_dev_class;
 
-static int i2cdev_attach_adapter(struct i2c_adapter *adap)
+static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 {
+	struct i2c_adapter *adap;
 	struct i2c_dev *i2c_dev;
 	int res;
 
+	if (dev->type != &i2c_adapter_type)
+		return 0;
+	adap = to_i2c_adapter(dev);
+
 	i2c_dev = get_free_i2c_dev(adap);
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
@@ -561,10 +558,15 @@ error:
 	return res;
 }
 
-static int i2cdev_detach_adapter(struct i2c_adapter *adap)
+static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 {
+	struct i2c_adapter *adap;
 	struct i2c_dev *i2c_dev;
 
+	if (dev->type != &i2c_adapter_type)
+		return 0;
+	adap = to_i2c_adapter(dev);
+
 	i2c_dev = i2c_dev_get_by_minor(adap->nr);
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
@@ -577,12 +579,23 @@ static int i2cdev_detach_adapter(struct
 	return 0;
 }
 
-static struct i2c_driver i2cdev_driver = {
-	.driver = {
-		.name	= "dev_driver",
-	},
-	.attach_adapter	= i2cdev_attach_adapter,
-	.detach_adapter	= i2cdev_detach_adapter,
+int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
+			 void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		return i2cdev_attach_adapter(dev, NULL);
+	case BUS_NOTIFY_DEL_DEVICE:
+		return i2cdev_detach_adapter(dev, NULL);
+	}
+
+	return 0;
+}
+
+static struct notifier_block i2cdev_notifier = {
+	.notifier_call = i2cdev_notifier_call,
 };
 
 /* ------------------------------------------------------------------------- */
@@ -607,10 +620,14 @@ static int __init i2c_dev_init(void)
 		goto out_unreg_chrdev;
 	}
 
-	res = i2c_add_driver(&i2cdev_driver);
+	/* Keep track of adapters which will be added or removed later */
+	res = bus_register_notifier(&i2c_bus_type, &i2cdev_notifier);
 	if (res)
 		goto out_unreg_class;
 
+	/* Bind to already existing adapters right away */
+	i2c_for_each_dev(NULL, i2cdev_attach_adapter);
+
 	return 0;
 
 out_unreg_class:
@@ -624,7 +641,8 @@ out:
 
 static void __exit i2c_dev_exit(void)
 {
-	i2c_del_driver(&i2cdev_driver);
+	i2c_for_each_dev(NULL, i2cdev_detach_adapter);
+	bus_unregister_notifier(&i2c_bus_type, &i2cdev_notifier);
 	class_destroy(i2c_dev_class);
 	unregister_chrdev(I2C_MAJOR, "i2c");
 }


-- 
Jean Delvare
