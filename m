From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/6] i2c: Get rid of the legacy binding model
Date: Sat, 2 May 2009 11:40:20 +0200
Message-ID: <20090502114020.41c38247@hyperion.delvare>
References: <20090502113856.39940f1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090502113856.39940f1e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We converted all the legacy i2c drivers so we can finally get rid of
the legacy binding model. Hooray!

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 Documentation/feature-removal-schedule.txt |    9 ---
 Documentation/i2c/writing-clients          |   16 +----
 drivers/i2c/i2c-core.c                     |   81 +---------------------------
 include/linux/i2c.h                        |   39 +++----------
 4 files changed, 18 insertions(+), 127 deletions(-)

--- linux-2.6.30-rc4.orig/Documentation/feature-removal-schedule.txt	2009-04-30 09:52:11.000000000 +0200
+++ linux-2.6.30-rc4/Documentation/feature-removal-schedule.txt	2009-04-30 09:52:14.000000000 +0200
@@ -354,15 +354,6 @@ Who:  Krzysztof Piotr Oledzki <ole@ans.p
 
 ---------------------------
 
-What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client()
-When:	2.6.30
-Check:	i2c_attach_client i2c_detach_client
-Why:	Deprecated by the new (standard) device driver binding model. Use
-	i2c_driver->probe() and ->remove() instead.
-Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-
----------------------------
-
 What:	fscher and fscpos drivers
 When:	June 2009
 Why:	Deprecated by the new fschmd driver.
--- linux-2.6.30-rc4.orig/drivers/i2c/i2c-core.c	2009-04-30 09:52:11.000000000 +0200
+++ linux-2.6.30-rc4/drivers/i2c/i2c-core.c	2009-04-30 18:05:25.000000000 +0200
@@ -44,6 +44,7 @@ static DEFINE_IDR(i2c_adapter_idr);
 
 #define is_newstyle_driver(d) ((d)->probe || (d)->remove || (d)->detect)
 
+static int i2c_attach_client(struct i2c_client *client);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 /* ------------------------------------------------------------------------- */
@@ -467,7 +468,7 @@ static int i2c_register_adapter(struct i
 
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
-	/* create pre-declared device nodes for new-style drivers */
+	/* create pre-declared device nodes */
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
 
@@ -610,7 +611,6 @@ static int i2c_do_del_adapter(struct dev
  */
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct i2c_client *client, *_n;
 	int res = 0;
 
 	mutex_lock(&core_lock);
@@ -629,28 +629,6 @@ int i2c_del_adapter(struct i2c_adapter *
 	if (res)
 		goto out_unlock;
 
-	/* detach any active clients. This must be done first, because
-	 * it can fail; in which case we give up. */
-	list_for_each_entry_safe_reverse(client, _n, &adap->clients, list) {
-		struct i2c_driver	*driver;
-
-		driver = client->driver;
-
-		/* new style, follow standard driver model */
-		if (!driver || is_newstyle_driver(driver)) {
-			i2c_unregister_device(client);
-			continue;
-		}
-
-		/* legacy drivers create and remove clients themselves */
-		if ((res = driver->detach_client(client))) {
-			dev_err(&adap->dev, "detach_client failed for client "
-				"[%s] at address 0x%02x\n", client->name,
-				client->addr);
-			goto out_unlock;
-		}
-	}
-
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
@@ -692,11 +670,7 @@ static int __attach_adapter(struct devic
 
 /*
  * An i2c_driver is used with one or more i2c_client (device) nodes to access
- * i2c slave chips, on a bus instance associated with some i2c_adapter.  There
- * are two models for binding the driver to its device:  "new style" drivers
- * follow the standard Linux driver model and just respond to probe() calls
- * issued if the driver core sees they match(); "legacy" drivers create device
- * nodes themselves.
+ * i2c slave chips, on a bus instance associated with some i2c_adapter.
  */
 
 int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
@@ -707,21 +681,11 @@ int i2c_register_driver(struct module *o
 	if (unlikely(WARN_ON(!i2c_bus_type.p)))
 		return -EAGAIN;
 
-	/* new style driver methods can't mix with legacy ones */
-	if (is_newstyle_driver(driver)) {
-		if (driver->detach_adapter || driver->detach_client) {
-			printk(KERN_WARNING
-					"i2c-core: driver [%s] is confused\n",
-					driver->driver.name);
-			return -EINVAL;
-		}
-	}
-
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.owner = owner;
 	driver->driver.bus = &i2c_bus_type;
 
-	/* for new style drivers, when registration returns the driver core
+	/* When registration returns, the driver core
 	 * will have called probe() for all matching-but-unbound devices.
 	 */
 	res = driver_register(&driver->driver);
@@ -760,29 +724,11 @@ static int __detach_adapter(struct devic
 	if (is_newstyle_driver(driver))
 		return 0;
 
-	/* Have a look at each adapter, if clients of this driver are still
-	 * attached. If so, detach them to be able to kill the driver
-	 * afterwards.
-	 */
 	if (driver->detach_adapter) {
 		if (driver->detach_adapter(adapter))
 			dev_err(&adapter->dev,
 				"detach_adapter failed for driver [%s]\n",
 				driver->driver.name);
-	} else {
-		struct i2c_client *client, *_n;
-
-		list_for_each_entry_safe(client, _n, &adapter->clients, list) {
-			if (client->driver != driver)
-				continue;
-			dev_dbg(&adapter->dev,
-				"detaching client [%s] at 0x%02x\n",
-				client->name, client->addr);
-			if (driver->detach_client(client))
-				dev_err(&adapter->dev, "detach_client "
-					"failed for client [%s] at 0x%02x\n",
-					client->name, client->addr);
-		}
 	}
 
 	return 0;
@@ -824,7 +770,7 @@ static int i2c_check_addr(struct i2c_ada
 	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
 }
 
-int i2c_attach_client(struct i2c_client *client)
+static int i2c_attach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int res;
@@ -866,23 +812,6 @@ out_err:
 		"(%d)\n", client->name, client->addr, res);
 	return res;
 }
-EXPORT_SYMBOL(i2c_attach_client);
-
-int i2c_detach_client(struct i2c_client *client)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	mutex_lock(&adapter->clist_lock);
-	list_del(&client->list);
-	mutex_unlock(&adapter->clist_lock);
-
-	init_completion(&client->released);
-	device_unregister(&client->dev);
-	wait_for_completion(&client->released);
-
-	return 0;
-}
-EXPORT_SYMBOL(i2c_detach_client);
 
 /**
  * i2c_use_client - increments the reference count of the i2c client structure
--- linux-2.6.30-rc4.orig/include/linux/i2c.h	2009-04-30 09:52:11.000000000 +0200
+++ linux-2.6.30-rc4/include/linux/i2c.h	2009-04-30 18:04:20.000000000 +0200
@@ -100,9 +100,8 @@ extern s32 i2c_smbus_write_i2c_block_dat
  * @class: What kind of i2c device we instantiate (for detect)
  * @attach_adapter: Callback for bus addition (for legacy drivers)
  * @detach_adapter: Callback for bus removal (for legacy drivers)
- * @detach_client: Callback for device removal (for legacy drivers)
- * @probe: Callback for device binding (new-style drivers)
- * @remove: Callback for device unbinding (new-style drivers)
+ * @probe: Callback for device binding
+ * @remove: Callback for device unbinding
  * @shutdown: Callback for device shutdown
  * @suspend: Callback for device suspend
  * @resume: Callback for device resume
@@ -137,26 +136,14 @@ struct i2c_driver {
 	int id;
 	unsigned int class;
 
-	/* Notifies the driver that a new bus has appeared. This routine
-	 * can be used by the driver to test if the bus meets its conditions
-	 * & seek for the presence of the chip(s) it supports. If found, it
-	 * registers the client(s) that are on the bus to the i2c admin. via
-	 * i2c_attach_client.  (LEGACY I2C DRIVERS ONLY)
+	/* Notifies the driver that a new bus has appeared or is about to be
+	 * removed. You should avoid using this if you can, it will probably
+	 * be removed in a near future.
 	 */
 	int (*attach_adapter)(struct i2c_adapter *);
 	int (*detach_adapter)(struct i2c_adapter *);
 
-	/* tells the driver that a client is about to be deleted & gives it
-	 * the chance to remove its private data. Also, if the client struct
-	 * has been dynamically allocated by the driver in the function above,
-	 * it must be freed here.  (LEGACY I2C DRIVERS ONLY)
-	 */
-	int (*detach_client)(struct i2c_client *) __deprecated;
-
-	/* Standard driver model interfaces, for "new style" i2c drivers.
-	 * With the driver model, device enumeration is NEVER done by drivers;
-	 * it's done by infrastructure.  (NEW STYLE DRIVERS ONLY)
-	 */
+	/* Standard driver model interfaces */
 	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
 	int (*remove)(struct i2c_client *);
 
@@ -248,11 +235,10 @@ static inline void i2c_set_clientdata(st
  * that, such as chip type, configuration, associated IRQ, and so on.
  *
  * i2c_board_info is used to build tables of information listing I2C devices
- * that are present.  This information is used to grow the driver model tree
- * for "new style" I2C drivers.  For mainboards this is done statically using
- * i2c_register_board_info(); bus numbers identify adapters that aren't
- * yet available.  For add-on boards, i2c_new_device() does this dynamically
- * with the adapter already known.
+ * that are present.  This information is used to grow the driver model tree.
+ * For mainboards this is done statically using i2c_register_board_info();
+ * bus numbers identify adapters that aren't yet available.  For add-on boards,
+ * i2c_new_device() does this dynamically with the adapter already known.
  */
 struct i2c_board_info {
 	char		type[I2C_NAME_SIZE];
@@ -425,11 +411,6 @@ static inline int i2c_add_driver(struct
 	return i2c_register_driver(THIS_MODULE, driver);
 }
 
-/* These are deprecated, your driver should use the standard .probe()
- * and .remove() methods instead. */
-extern int __deprecated i2c_attach_client(struct i2c_client *);
-extern int __deprecated i2c_detach_client(struct i2c_client *);
-
 extern struct i2c_client *i2c_use_client(struct i2c_client *client);
 extern void i2c_release_client(struct i2c_client *client);
 
--- linux-2.6.30-rc4.orig/Documentation/i2c/writing-clients	2009-04-30 08:37:40.000000000 +0200
+++ linux-2.6.30-rc4/Documentation/i2c/writing-clients	2009-04-30 09:52:14.000000000 +0200
@@ -126,19 +126,9 @@ different) configuration information, as
 that can't be distinguished by protocol probing, or which need some board
 specific information to operate correctly.
 
-Accordingly, the I2C stack now has two models for associating I2C devices
-with their drivers:  the original "legacy" model, and a newer one that's
-fully compatible with the Linux 2.6 driver model.  These models do not mix,
-since the "legacy" model requires drivers to create "i2c_client" device
-objects after SMBus style probing, while the Linux driver model expects
-drivers to be given such device objects in their probe() routines.
 
-The legacy model is deprecated now and will soon be removed, so we no
-longer document it here.
-
-
-Standard Driver Model Binding ("New Style")
--------------------------------------------
+Device/Driver Binding
+---------------------
 
 System infrastructure, typically board-specific initialization code or
 boot firmware, reports what I2C devices exist.  For example, there may be
@@ -201,7 +191,7 @@ a given I2C bus.  This is for example th
 devices on a PC's SMBus.  In that case, you may want to let your driver
 detect supported devices automatically.  This is how the legacy model
 was working, and is now available as an extension to the standard
-driver model (so that we can finally get rid of the legacy model.)
+driver model.
 
 You simply have to define a detect callback which will attempt to
 identify supported devices (returning 0 for supported ones and -ENODEV

-- 
Jean Delvare
