From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Refactor for_each callbacks
Date: Sat, 7 Nov 2009 10:32:01 +0100
Message-ID: <20091107103201.0ccd1414@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Functions i2c_do_add_adapter() and __attach_adapter() do essentially
the same thing, differing only in how the parameters are passed. Same
for i2c_do_add_adapter() and __detach_adapter(). Introduce wrappers to
normalize the parameters, so that we do not have to duplicate the
code.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   70 +++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

--- linux-2.6.32-rc6.orig/drivers/i2c/i2c-core.c	2009-11-06 17:09:41.000000000 +0100
+++ linux-2.6.32-rc6/drivers/i2c/i2c-core.c	2009-11-07 10:28:40.000000000 +0100
@@ -558,11 +558,9 @@ static void i2c_scan_static_board_info(s
 	up_read(&__i2c_board_lock);
 }
 
-static int i2c_do_add_adapter(struct device_driver *d, void *data)
+static int i2c_do_add_adapter(struct i2c_driver *driver,
+			      struct i2c_adapter *adap)
 {
-	struct i2c_driver *driver = to_i2c_driver(d);
-	struct i2c_adapter *adap = data;
-
 	/* Detect supported devices on that bus, and instantiate them */
 	i2c_detect(adap, driver);
 
@@ -574,6 +572,11 @@ static int i2c_do_add_adapter(struct dev
 	return 0;
 }
 
+static int __process_new_adapter(struct device_driver *d, void *data)
+{
+	return i2c_do_add_adapter(to_i2c_driver(d), data);
+}
+
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = 0, dummy;
@@ -614,7 +617,7 @@ static int i2c_register_adapter(struct i
 	/* Notify drivers */
 	mutex_lock(&core_lock);
 	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
-				 i2c_do_add_adapter);
+				 __process_new_adapter);
 	mutex_unlock(&core_lock);
 
 	return 0;
@@ -715,10 +718,9 @@ retry:
 }
 EXPORT_SYMBOL_GPL(i2c_add_numbered_adapter);
 
-static int i2c_do_del_adapter(struct device_driver *d, void *data)
+static int i2c_do_del_adapter(struct i2c_driver *driver,
+			      struct i2c_adapter *adapter)
 {
-	struct i2c_driver *driver = to_i2c_driver(d);
-	struct i2c_adapter *adapter = data;
 	struct i2c_client *client, *_n;
 	int res;
 
@@ -750,6 +752,11 @@ static int __unregister_client(struct de
 	return 0;
 }
 
+static int __process_removed_adapter(struct device_driver *d, void *data)
+{
+	return i2c_do_del_adapter(to_i2c_driver(d), data);
+}
+
 /**
  * i2c_del_adapter - unregister I2C adapter
  * @adap: the adapter being unregistered
@@ -776,7 +783,7 @@ int i2c_del_adapter(struct i2c_adapter *
 	/* Tell drivers about this removal */
 	mutex_lock(&core_lock);
 	res = bus_for_each_drv(&i2c_bus_type, NULL, adap,
-			       i2c_do_del_adapter);
+			       __process_removed_adapter);
 	mutex_unlock(&core_lock);
 	if (res)
 		return res;
@@ -815,22 +822,11 @@ EXPORT_SYMBOL(i2c_del_adapter);
 
 /* ------------------------------------------------------------------------- */
 
-static int __attach_adapter(struct device *dev, void *data)
+static int __process_new_driver(struct device *dev, void *data)
 {
-	struct i2c_adapter *adapter;
-	struct i2c_driver *driver = data;
-
 	if (dev->type != &i2c_adapter_type)
 		return 0;
-	adapter = to_i2c_adapter(dev);
-
-	i2c_detect(adapter, driver);
-
-	/* Legacy drivers scan i2c busses directly */
-	if (driver->attach_adapter)
-		driver->attach_adapter(adapter);
-
-	return 0;
+	return i2c_do_add_adapter(data, to_i2c_adapter(dev));
 }
 
 /*
@@ -862,40 +858,18 @@ int i2c_register_driver(struct module *o
 	INIT_LIST_HEAD(&driver->clients);
 	/* Walk the adapters that are already present */
 	mutex_lock(&core_lock);
-	bus_for_each_dev(&i2c_bus_type, NULL, driver, __attach_adapter);
+	bus_for_each_dev(&i2c_bus_type, NULL, driver, __process_new_driver);
 	mutex_unlock(&core_lock);
 
 	return 0;
 }
 EXPORT_SYMBOL(i2c_register_driver);
 
-static int __detach_adapter(struct device *dev, void *data)
+static int __process_removed_driver(struct device *dev, void *data)
 {
-	struct i2c_adapter *adapter;
-	struct i2c_driver *driver = data;
-	struct i2c_client *client, *_n;
-
 	if (dev->type != &i2c_adapter_type)
 		return 0;
-	adapter = to_i2c_adapter(dev);
-
-	/* Remove the devices we created ourselves as the result of hardware
-	 * probing (using a driver's detect method) */
-	list_for_each_entry_safe(client, _n, &driver->clients, detected) {
-		dev_dbg(&adapter->dev, "Removing %s at 0x%x\n",
-			client->name, client->addr);
-		list_del(&client->detected);
-		i2c_unregister_device(client);
-	}
-
-	if (driver->detach_adapter) {
-		if (driver->detach_adapter(adapter))
-			dev_err(&adapter->dev,
-				"detach_adapter failed for driver [%s]\n",
-				driver->driver.name);
-	}
-
-	return 0;
+	return i2c_do_del_adapter(data, to_i2c_adapter(dev));
 }
 
 /**
@@ -906,7 +880,7 @@ static int __detach_adapter(struct devic
 void i2c_del_driver(struct i2c_driver *driver)
 {
 	mutex_lock(&core_lock);
-	bus_for_each_dev(&i2c_bus_type, NULL, driver, __detach_adapter);
+	bus_for_each_dev(&i2c_bus_type, NULL, driver, __process_removed_driver);
 	mutex_unlock(&core_lock);
 
 	driver_unregister(&driver->driver);


-- 
Jean Delvare
