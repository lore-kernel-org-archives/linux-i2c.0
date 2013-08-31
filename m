From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] i2c: i2c-dev: Create 'name' attribute automatically
Date: Sat, 31 Aug 2013 09:30:19 -0700
Message-ID: <1377966619-20197-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The 'name' attribute is needed for all i2c-dev class devices, meaning
it can be created automatically by pointing to it in the class data
structure. This simplifies the code and reduces the probability for race
conditions.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/i2c/i2c-dev.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index c3ccdea..46eea02 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -111,7 +111,11 @@ static ssize_t show_adapter_name(struct device *dev,
 		return -ENODEV;
 	return sprintf(buf, "%s\n", i2c_dev->adap->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
+
+static struct device_attribute i2c_dev_attributes[] = {
+	__ATTR(name, S_IRUGO, show_adapter_name, NULL),
+	{ }
+};
 
 /* ------------------------------------------------------------------------- */
 
@@ -538,7 +542,11 @@ static const struct file_operations i2cdev_fops = {
 
 /* ------------------------------------------------------------------------- */
 
-static struct class *i2c_dev_class;
+static struct class i2c_dev_class = {
+	.owner = THIS_MODULE,
+	.name = "i2c-dev",
+	.dev_attrs = i2c_dev_attributes,
+};
 
 static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 {
@@ -555,22 +563,17 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 		return PTR_ERR(i2c_dev);
 
 	/* register this i2c device with the driver core */
-	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
+	i2c_dev->dev = device_create(&i2c_dev_class, &adap->dev,
 				     MKDEV(I2C_MAJOR, adap->nr), NULL,
 				     "i2c-%d", adap->nr);
 	if (IS_ERR(i2c_dev->dev)) {
 		res = PTR_ERR(i2c_dev->dev);
 		goto error;
 	}
-	res = device_create_file(i2c_dev->dev, &dev_attr_name);
-	if (res)
-		goto error_destroy;
 
 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
 		 adap->name, adap->nr);
 	return 0;
-error_destroy:
-	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 error:
 	return_i2c_dev(i2c_dev);
 	return res;
@@ -589,9 +592,8 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
-	device_remove_file(i2c_dev->dev, &dev_attr_name);
 	return_i2c_dev(i2c_dev);
-	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
+	device_destroy(&i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
 	return 0;
@@ -632,11 +634,9 @@ static int __init i2c_dev_init(void)
 	if (res)
 		goto out;
 
-	i2c_dev_class = class_create(THIS_MODULE, "i2c-dev");
-	if (IS_ERR(i2c_dev_class)) {
-		res = PTR_ERR(i2c_dev_class);
+	res = class_register(&i2c_dev_class);
+	if (res)
 		goto out_unreg_chrdev;
-	}
 
 	/* Keep track of adapters which will be added or removed later */
 	res = bus_register_notifier(&i2c_bus_type, &i2cdev_notifier);
@@ -649,7 +649,7 @@ static int __init i2c_dev_init(void)
 	return 0;
 
 out_unreg_class:
-	class_destroy(i2c_dev_class);
+	class_unregister(&i2c_dev_class);
 out_unreg_chrdev:
 	unregister_chrdev(I2C_MAJOR, "i2c");
 out:
@@ -661,7 +661,7 @@ static void __exit i2c_dev_exit(void)
 {
 	bus_unregister_notifier(&i2c_bus_type, &i2cdev_notifier);
 	i2c_for_each_dev(NULL, i2cdev_detach_adapter);
-	class_destroy(i2c_dev_class);
+	class_unregister(&i2c_dev_class);
 	unregister_chrdev(I2C_MAJOR, "i2c");
 }
 
-- 
1.7.9.7
