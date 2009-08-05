From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/4] i2c: Convert i2c clients to a device type
Date: Wed, 5 Aug 2009 11:12:25 +0200
Message-ID: <20090805111225.0030b14e@hyperion.delvare>
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

This is required for upcoming changes.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   67 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 20 deletions(-)

--- linux-2.6.31-rc1.orig/drivers/i2c/i2c-core.c	2009-06-30 08:48:46.000000000 +0200
+++ linux-2.6.31-rc1/drivers/i2c/i2c-core.c	2009-06-30 15:31:33.000000000 +0200
@@ -64,9 +64,13 @@ static const struct i2c_device_id *i2c_m
 
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
@@ -94,10 +98,14 @@ static int i2c_device_uevent(struct devi
 
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
@@ -114,11 +122,11 @@ static int i2c_device_probe(struct devic
 
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
@@ -136,37 +144,40 @@ static int i2c_device_remove(struct devi
 
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
@@ -188,18 +199,28 @@ show_modalias(struct device *dev, struct
 	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
 
-static struct device_attribute i2c_dev_attrs[] = {
-	__ATTR(name, S_IRUGO, show_client_name, NULL),
+static DEVICE_ATTR(name, S_IRUGO, show_client_name, NULL);
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
@@ -208,6 +229,12 @@ struct bus_type i2c_bus_type = {
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
@@ -220,7 +247,7 @@ EXPORT_SYMBOL_GPL(i2c_bus_type);
  */
 struct i2c_client *i2c_verify_client(struct device *dev)
 {
-	return (dev->bus == &i2c_bus_type)
+	return (dev->type == &i2c_client_type)
 			? to_i2c_client(dev)
 			: NULL;
 }
@@ -273,7 +300,7 @@ i2c_new_device(struct i2c_adapter *adap,
 
 	client->dev.parent = &client->adapter->dev;
 	client->dev.bus = &i2c_bus_type;
-	client->dev.release = i2c_client_dev_release;
+	client->dev.type = &i2c_client_type;
 
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
 		     client->addr);

-- 
Jean Delvare
