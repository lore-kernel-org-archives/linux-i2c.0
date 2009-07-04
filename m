From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Sat, 4 Jul 2009 19:14:31 +0200
Message-ID: <20090704191431.3d352d0b@hyperion.delvare>
References: <20090426103025.4525edd3@hyperion.delvare>
 <20090504124341.42405e79@hyperion.delvare>
 <ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kay,

Sorry for the late reply...

On Mon, 4 May 2009 14:40:36 +0200, Kay Sievers wrote:
> On Mon, May 4, 2009 at 12:43, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > We don't need to give adapters a parent if they don't have one. The
> > driver core will put them in the virtual device directory and all will
> > be fine.
> >
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> > Much better than my first attempt. Not sure what will happen if we ever
> > turn i2c-adapters into bus devices. I see that the driver core puts
> > class devices without a parent in virtual, but what about _bus_ devices
> 
> I'm sure, that "virtual" logic could be done for bus devices too, if
> it's needed. I don't see any reason why that wouldn't be fine.
> 
> (The less difference between classes and buses the better. It is wrong
> to have two types of subsystems, doing almost the same thing. One
> could argue that it could be useful inside the kernel, which it isn't,
> I think, but exporting them to userspace was definitely the wrong
> thing.)

I finally took a stab at this. The resulting patch is below. I have
used device_type to differentiate between I2C clients and I2C adapters.
Is this what you had in mind?

It seems to work reasonably well, with the following issues remaining:

* The change breaks at least sensors-detect and libsensors. I can
  easily modify them so that they work again, but we still have a
  compatibility issue. Is it possible to have a compatibility option
  that would add symbolic links from class/i2c-adapter/i2c-* to
  bus/i2c/devices/i2c-* for a couple years?

* Now that i2c-core makes use of device_type, I tried to move the power
  management handling callbacks there from bus_type, to save a test in
  each function, however I found that the callback set is different
  between bus_type and device_type.pm. Why is it so? Is there a document
  explaining the difference? Is the whole world (including bus_type)
  eventually moving to dev_pm_ops?

* When i2c-adapters were class devices, virtual ones (for example
  i2c-stub) appeared in sysfs as devices/virtual/i2c-adapter/i2c-*,
  which made sense and seemed safe. Now that I have turned them into
  bus devices, virtual ones appear in sysfs as devices/i2c-* directly,
  which looks dirty and could result in collisions someday. What should
  be done about this? I wanted to use virtual_device_parent() but it is
  internal to the driver core at the moment, and doesn't even exist if
  CONFIG_SYSFS_DEPRECATED=y.

I would be grateful if you can advise on any of the above points.
Thanks.

* * * * *

* Introduce two device types for i2c: i2c_client_type and i2c_adapter_type.
* Remove i2c-adapter class and use i2c_adapter_type instead.
* Many callbacks had to be modified to check whether the device that
  is passed has the correct type, now that clients and adapters live in
  the same namespace.

---
 drivers/i2c/i2c-core.c |  140 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 54 deletions(-)

--- linux-2.6.31-rc1.orig/drivers/i2c/i2c-core.c	2009-07-04 18:33:04.000000000 +0200
+++ linux-2.6.31-rc1/drivers/i2c/i2c-core.c	2009-07-04 19:06:04.000000000 +0200
@@ -46,6 +46,7 @@ static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 static LIST_HEAD(userspace_devices);
 
+static struct device_type i2c_client_type;
 static int i2c_check_addr(struct i2c_adapter *adapter, int addr);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
@@ -64,9 +65,13 @@ static const struct i2c_device_id *i2c_m
 
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
-	struct i2c_client	*client = to_i2c_client(dev);
-	struct i2c_driver	*driver = to_i2c_driver(drv);
+	struct i2c_client	*client = i2c_verify_client(dev);
+	struct i2c_driver	*driver;
+
+	if (!client)
+		return 0;
 
+	driver = to_i2c_driver(drv);
 	/* match on an id table if there is one */
 	if (driver->id_table)
 		return i2c_match_id(driver->id_table, client) != NULL;
@@ -94,10 +99,14 @@ static int i2c_device_uevent(struct devi
 
 static int i2c_device_probe(struct device *dev)
 {
-	struct i2c_client	*client = to_i2c_client(dev);
-	struct i2c_driver	*driver = to_i2c_driver(dev->driver);
+	struct i2c_client	*client = i2c_verify_client(dev);
+	struct i2c_driver	*driver;
 	int status;
 
+	if (!client)
+		return 0;
+
+	driver = to_i2c_driver(dev->driver);
 	if (!driver->probe || !driver->id_table)
 		return -ENODEV;
 	client->driver = driver;
@@ -114,11 +123,11 @@ static int i2c_device_probe(struct devic
 
 static int i2c_device_remove(struct device *dev)
 {
-	struct i2c_client	*client = to_i2c_client(dev);
+	struct i2c_client	*client = i2c_verify_client(dev);
 	struct i2c_driver	*driver;
 	int			status;
 
-	if (!dev->driver)
+	if (!client || !dev->driver)
 		return 0;
 
 	driver = to_i2c_driver(dev->driver);
@@ -136,37 +145,40 @@ static int i2c_device_remove(struct devi
 
 static void i2c_device_shutdown(struct device *dev)
 {
+	struct i2c_client *client = i2c_verify_client(dev);
 	struct i2c_driver *driver;
 
-	if (!dev->driver)
+	if (!client || !dev->driver)
 		return;
 	driver = to_i2c_driver(dev->driver);
 	if (driver->shutdown)
-		driver->shutdown(to_i2c_client(dev));
+		driver->shutdown(client);
 }
 
 static int i2c_device_suspend(struct device *dev, pm_message_t mesg)
 {
+	struct i2c_client *client = i2c_verify_client(dev);
 	struct i2c_driver *driver;
 
-	if (!dev->driver)
+	if (!client || !dev->driver)
 		return 0;
 	driver = to_i2c_driver(dev->driver);
 	if (!driver->suspend)
 		return 0;
-	return driver->suspend(to_i2c_client(dev), mesg);
+	return driver->suspend(client, mesg);
 }
 
 static int i2c_device_resume(struct device *dev)
 {
+	struct i2c_client *client = i2c_verify_client(dev);
 	struct i2c_driver *driver;
 
-	if (!dev->driver)
+	if (!client || !dev->driver)
 		return 0;
 	driver = to_i2c_driver(dev->driver);
 	if (!driver->resume)
 		return 0;
-	return driver->resume(to_i2c_client(dev));
+	return driver->resume(client);
 }
 
 static void i2c_client_dev_release(struct device *dev)
@@ -175,10 +187,10 @@ static void i2c_client_dev_release(struc
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
@@ -188,18 +200,28 @@ show_modalias(struct device *dev, struct
 	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
 
-static struct device_attribute i2c_dev_attrs[] = {
-	__ATTR(name, S_IRUGO, show_client_name, NULL),
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
+
+static struct attribute *i2c_dev_attrs[] = {
+	&dev_attr_name.attr,
 	/* modalias helps coldplug:  modprobe $(cat .../modalias) */
-	__ATTR(modalias, S_IRUGO, show_modalias, NULL),
-	{ },
+	&dev_attr_modalias.attr,
+	NULL
+};
+
+static struct attribute_group i2c_dev_attr_group = {
+	.attrs		= i2c_dev_attrs,
+};
+
+static struct attribute_group *i2c_dev_attr_groups[] = {
+	&i2c_dev_attr_group,
+	NULL
 };
 
 struct bus_type i2c_bus_type = {
 	.name		= "i2c",
-	.dev_attrs	= i2c_dev_attrs,
 	.match		= i2c_device_match,
-	.uevent		= i2c_device_uevent,
 	.probe		= i2c_device_probe,
 	.remove		= i2c_device_remove,
 	.shutdown	= i2c_device_shutdown,
@@ -208,6 +230,12 @@ struct bus_type i2c_bus_type = {
 };
 EXPORT_SYMBOL_GPL(i2c_bus_type);
 
+static struct device_type i2c_client_type = {
+	.groups		= i2c_dev_attr_groups,
+	.uevent		= i2c_device_uevent,
+	.release	= i2c_client_dev_release,
+};
+
 
 /**
  * i2c_verify_client - return parameter as i2c_client, or NULL
@@ -220,7 +248,7 @@ EXPORT_SYMBOL_GPL(i2c_bus_type);
  */
 struct i2c_client *i2c_verify_client(struct device *dev)
 {
-	return (dev->bus == &i2c_bus_type)
+	return (dev->type == &i2c_client_type)
 			? to_i2c_client(dev)
 			: NULL;
 }
@@ -273,7 +301,7 @@ i2c_new_device(struct i2c_adapter *adap,
 
 	client->dev.parent = &client->adapter->dev;
 	client->dev.bus = &i2c_bus_type;
-	client->dev.release = i2c_client_dev_release;
+	client->dev.type = &i2c_client_type;
 
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
 		     client->addr);
@@ -368,13 +396,6 @@ static void i2c_adapter_dev_release(stru
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
@@ -493,17 +514,28 @@ i2c_sysfs_delete_device(struct device *d
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
 };
 
-static struct class i2c_adapter_class = {
-	.owner			= THIS_MODULE,
-	.name			= "i2c-adapter",
-	.dev_attrs		= i2c_adapter_attrs,
+static struct attribute_group i2c_adapter_attr_group = {
+	.attrs		= i2c_adapter_attrs,
+};
+
+static struct attribute_group *i2c_adapter_attr_groups[] = {
+	&i2c_adapter_attr_group,
+	NULL
+};
+
+static struct device_type i2c_adapter_type = {
+	.groups		= i2c_adapter_attr_groups,
+	.release	= i2c_adapter_dev_release,
 };
 
 static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
@@ -555,8 +587,8 @@ static int i2c_register_adapter(struct i
 		adap->timeout = HZ;
 
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
-	adap->dev.release = &i2c_adapter_dev_release;
-	adap->dev.class = &i2c_adapter_class;
+	adap->dev.bus = &i2c_bus_type;
+	adap->dev.type = &i2c_adapter_type;
 	res = device_register(&adap->dev);
 	if (res)
 		goto out_list;
@@ -768,9 +800,13 @@ EXPORT_SYMBOL(i2c_del_adapter);
 
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
@@ -809,8 +845,7 @@ int i2c_register_driver(struct module *o
 	INIT_LIST_HEAD(&driver->clients);
 	/* Walk the adapters that are already present */
 	mutex_lock(&core_lock);
-	class_for_each_device(&i2c_adapter_class, NULL, driver,
-			      __attach_adapter);
+	bus_for_each_dev(&i2c_bus_type, NULL, driver, __attach_adapter);
 	mutex_unlock(&core_lock);
 
 	return 0;
@@ -819,10 +854,14 @@ EXPORT_SYMBOL(i2c_register_driver);
 
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
@@ -850,8 +889,7 @@ static int __detach_adapter(struct devic
 void i2c_del_driver(struct i2c_driver *driver)
 {
 	mutex_lock(&core_lock);
-	class_for_each_device(&i2c_adapter_class, NULL, driver,
-			      __detach_adapter);
+	bus_for_each_dev(&i2c_bus_type, NULL, driver, __detach_adapter);
 	mutex_unlock(&core_lock);
 
 	driver_unregister(&driver->driver);
@@ -940,16 +978,11 @@ static int __init i2c_init(void)
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
@@ -958,7 +991,6 @@ bus_err:
 static void __exit i2c_exit(void)
 {
 	i2c_del_driver(&dummy_driver);
-	class_unregister(&i2c_adapter_class);
 	bus_unregister(&i2c_bus_type);
 }
 


-- 
Jean Delvare
