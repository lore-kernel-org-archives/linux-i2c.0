From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/4] i2c: Convert i2c adapters to bus devices
Date: Wed, 5 Aug 2009 11:13:04 +0200
Message-ID: <20090805111304.03e231cc@hyperion.delvare>
References: <20090805110537.73735169@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090805110537.73735169-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Kay says i2c adapters shouldn't be class devices but bus devices.
Convert them that way, using a device type.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   75 +++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

--- linux-2.6.31-rc1.orig/drivers/i2c/i2c-core.c	2009-07-04 14:19:47.000000000 +0200
+++ linux-2.6.31-rc1/drivers/i2c/i2c-core.c	2009-07-04 15:31:30.000000000 +0200
@@ -46,6 +46,7 @@ static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 static LIST_HEAD(userspace_devices);
 
+static struct device_type i2c_client_type;
 static int i2c_check_addr(struct i2c_adapter *adapter, int addr);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
@@ -186,10 +187,10 @@ static void i2c_client_dev_release(struc
 }
 
 static ssize_t
-show_client_name(struct device *dev, struct device_attribute *attr, char *buf)
+show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	return sprintf(buf, "%s\n", client->name);
+	return sprintf(buf, "%s\n", dev->type == &i2c_client_type ?
+		       to_i2c_client(dev)->name : to_i2c_adapter(dev)->name);
 }
 
 static ssize_t
@@ -199,7 +200,7 @@ show_modalias(struct device *dev, struct
 	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, show_client_name, NULL);
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
 
 static struct attribute *i2c_dev_attrs[] = {
@@ -395,13 +396,6 @@ static void i2c_adapter_dev_release(stru
 	complete(&adap->dev_released);
 }
 
-static ssize_t
-show_adapter_name(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct i2c_adapter *adap = to_i2c_adapter(dev);
-	return sprintf(buf, "%s\n", adap->name);
-}
-
 /*
  * Let users instantiate I2C devices through sysfs. This can be used when
  * platform initialization code doesn't contain the proper data for
@@ -520,17 +514,28 @@ i2c_sysfs_delete_device(struct device *d
 	return res;
 }
 
-static struct device_attribute i2c_adapter_attrs[] = {
-	__ATTR(name, S_IRUGO, show_adapter_name, NULL),
-	__ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device),
-	__ATTR(delete_device, S_IWUSR, NULL, i2c_sysfs_delete_device),
-	{ },
+static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
+static DEVICE_ATTR(delete_device, S_IWUSR, NULL, i2c_sysfs_delete_device);
+
+static struct attribute *i2c_adapter_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL
+};
+
+static struct attribute_group i2c_adapter_attr_group = {
+	.attrs		= i2c_adapter_attrs,
+};
+
+static struct attribute_group *i2c_adapter_attr_groups[] = {
+	&i2c_adapter_attr_group,
+	NULL
 };
 
-static struct class i2c_adapter_class = {
-	.owner			= THIS_MODULE,
-	.name			= "i2c-adapter",
-	.dev_attrs		= i2c_adapter_attrs,
+static struct device_type i2c_adapter_type = {
+	.groups		= i2c_adapter_attr_groups,
+	.release	= i2c_adapter_dev_release,
 };
 
 static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
@@ -582,8 +587,8 @@ static int i2c_register_adapter(struct i
 		adap->timeout = HZ;
 
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
-	adap->dev.release = &i2c_adapter_dev_release;
-	adap->dev.class = &i2c_adapter_class;
+	adap->dev.bus = &i2c_bus_type;
+	adap->dev.type = &i2c_adapter_type;
 	res = device_register(&adap->dev);
 	if (res)
 		goto out_list;
@@ -795,9 +800,13 @@ EXPORT_SYMBOL(i2c_del_adapter);
 
 static int __attach_adapter(struct device *dev, void *data)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(dev);
+	struct i2c_adapter *adapter;
 	struct i2c_driver *driver = data;
 
+	if (dev->type != &i2c_adapter_type)
+		return 0;
+	adapter = to_i2c_adapter(dev);
+
 	i2c_detect(adapter, driver);
 
 	/* Legacy drivers scan i2c busses directly */
@@ -836,8 +845,7 @@ int i2c_register_driver(struct module *o
 	INIT_LIST_HEAD(&driver->clients);
 	/* Walk the adapters that are already present */
 	mutex_lock(&core_lock);
-	class_for_each_device(&i2c_adapter_class, NULL, driver,
-			      __attach_adapter);
+	bus_for_each_dev(&i2c_bus_type, NULL, driver, __attach_adapter);
 	mutex_unlock(&core_lock);
 
 	return 0;
@@ -846,10 +854,14 @@ EXPORT_SYMBOL(i2c_register_driver);
 
 static int __detach_adapter(struct device *dev, void *data)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(dev);
+	struct i2c_adapter *adapter;
 	struct i2c_driver *driver = data;
 	struct i2c_client *client, *_n;
 
+	if (dev->type != &i2c_adapter_type)
+		return 0;
+	adapter = to_i2c_adapter(dev);
+
 	/* Remove the devices we created ourselves as the result of hardware
 	 * probing (using a driver's detect method) */
 	list_for_each_entry_safe(client, _n, &driver->clients, detected) {
@@ -877,8 +889,7 @@ static int __detach_adapter(struct devic
 void i2c_del_driver(struct i2c_driver *driver)
 {
 	mutex_lock(&core_lock);
-	class_for_each_device(&i2c_adapter_class, NULL, driver,
-			      __detach_adapter);
+	bus_for_each_dev(&i2c_bus_type, NULL, driver, __detach_adapter);
 	mutex_unlock(&core_lock);
 
 	driver_unregister(&driver->driver);
@@ -967,16 +978,11 @@ static int __init i2c_init(void)
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
-	retval = class_register(&i2c_adapter_class);
-	if (retval)
-		goto bus_err;
 	retval = i2c_add_driver(&dummy_driver);
 	if (retval)
-		goto class_err;
+		goto bus_err;
 	return 0;
 
-class_err:
-	class_unregister(&i2c_adapter_class);
 bus_err:
 	bus_unregister(&i2c_bus_type);
 	return retval;
@@ -985,7 +991,6 @@ bus_err:
 static void __exit i2c_exit(void)
 {
 	i2c_del_driver(&dummy_driver);
-	class_unregister(&i2c_adapter_class);
 	bus_unregister(&i2c_bus_type);
 }
 

-- 
Jean Delvare
