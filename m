From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/5] i2c: Add detection capability to new-style drivers
Date: Mon, 16 Jun 2008 22:16:09 +0200
Message-ID: <20080616221609.1ca46ed9@hyperion.delvare>
References: <20080616221257.446a2145@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080616221257.446a2145-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add a mechanism to let new-style i2c drivers optionally autodetect
devices they would support on selected buses and ask i2c-core to
instantiate them. This is a replacement for legacy i2c drivers, much
cleaner.

Where drivers had to implement both a legacy i2c_driver and a
new-style i2c_driver so far, this mechanism makes it possible to get
rid of the legacy i2c_driver and implement both enumerated and
detected device support with just one (new-style) i2c_driver.

Here is a quick conversion guide for these drivers, step by step:

* Delete the legacy driver definition, registration and removal.
  Delete the attach_adapter and detach_client methods of the legacy
  driver.

* Change the prototype of the legacy detect function from
    static int foo_detect(struct i2c_adapter *adapter, int address, int kind);
  to
    static int foo_detect(struct i2c_client *client, int kind,
    			  struct i2c_board_info *info);

* Set the new-style driver detect callback to this new function, and
  set its address_data to &addr_data (addr_data is generally provided
  by I2C_CLIENT_INSMOD.)

* Add the appropriate class to the new-style driver. This is
  typically the class the legacy attach_adapter method was checking
  for. Class checking is now mandatory (done by i2c-core.) See
  <linux/i2c.h> for the list of available classes.

* Remove the i2c_client allocation and freeing from the detect
  function. A pre-allocated client is now handed to you by i2c-core,
  and is freed automatically.

* Make the detect function fill the type field of the i2c_board_info
  structure it was passed as a parameter, and return 0, on success. If
  the detection fails, return -ENODEV.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
This patch depends on:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-use-class_for_each_device.patch
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-simplify-i2c_del_driver.patch

Implementation note: i2c_detect and i2c_detect_address are basically
clones of i2c_probe and i2c_probe_address but operating on a callback
with a slightly different prototype. This duplicated code accounts
for a large part of the patch, but once legacy drivers are gone,
i2c_probe and i2c_probe_address will be removed, so this is no
long-term duplication.

 Documentation/i2c/writing-clients |   29 ++++
 drivers/i2c/i2c-core.c            |  222 +++++++++++++++++++++++++++++++++++--
 include/linux/i2c.h               |   36 +++++-
 3 files changed, 271 insertions(+), 16 deletions(-)

--- linux-2.6.26-rc6.orig/Documentation/i2c/writing-clients	2008-06-16 13:26:01.000000000 +0200
+++ linux-2.6.26-rc6/Documentation/i2c/writing-clients	2008-06-16 18:36:54.000000000 +0200
@@ -44,6 +44,10 @@ static struct i2c_driver foo_driver = {
 	.id_table	= foo_ids,
 	.probe		= foo_probe,
 	.remove		= foo_remove,
+	/* if device autodetection is needed: */
+	.class		= I2C_CLASS_SOMETHING,
+	.detect		= foo_detect,
+	.address_data	= &addr_data,
 
 	/* else, driver uses "legacy" binding model: */
 	.attach_adapter	= foo_attach_adapter,
@@ -217,6 +221,31 @@ in the I2C bus driver. You may want to s
 reference for later use.
 
 
+Device Detection (Standard driver model)
+----------------------------------------
+
+Sometimes you do not know in advance which I2C devices are connected to
+a given I2C bus.  This is for example the case of hardware monitoring
+devices on a PC's SMBus.  In that case, you may want to let your driver
+detect supported devices automatically.  This is how the legacy model
+was working, and is now available as an extension to the standard
+driver model (so that we can finally get rid of the legacy model.)
+
+You simply have to define a detect callback which will attempt to
+identify supported devices (returning 0 for supported ones and -ENODEV
+for unsupported ones), a list of addresses to probe, and a device type
+(or class) so that only I2C buses which may have that type of device
+connected (and not otherwise enumerated) will be probed.  The i2c
+core will then call you back as needed and will instantiate a device
+for you for every successful detection.
+
+Note that this mechanism is purely optional and not suitable for all
+devices.  You need some reliable way to identify the supported devices
+(typically using device-specific, dedicated identification registers),
+otherwise misdetections are likely to occur and things can get wrong
+quickly.
+
+
 Device Deletion (Standard driver model)
 ---------------------------------------
 
--- linux-2.6.26-rc6.orig/drivers/i2c/i2c-core.c	2008-06-16 13:26:02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/i2c-core.c	2008-06-16 18:30:43.000000000 +0200
@@ -42,7 +42,9 @@
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 
-#define is_newstyle_driver(d) ((d)->probe || (d)->remove)
+#define is_newstyle_driver(d) ((d)->probe || (d)->remove || (d)->detect)
+
+static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 /* ------------------------------------------------------------------------- */
 
@@ -409,6 +411,10 @@ static int i2c_do_add_adapter(struct dev
 	struct i2c_driver *driver = to_i2c_driver(d);
 	struct i2c_adapter *adap = data;
 
+	/* Detect supported devices on that bus, and instantiate them */
+	i2c_detect(adap, driver);
+
+	/* Let legacy drivers scan this bus for matching devices */
 	if (driver->attach_adapter) {
 		/* We ignore the return code; if it fails, too bad */
 		driver->attach_adapter(adap);
@@ -448,7 +454,7 @@ static int i2c_register_adapter(struct i
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
 
-	/* let legacy drivers scan this bus for matching devices */
+	/* Notify drivers */
 	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 				 i2c_do_add_adapter);
 
@@ -554,8 +560,19 @@ static int i2c_do_del_adapter(struct dev
 {
 	struct i2c_driver *driver = to_i2c_driver(d);
 	struct i2c_adapter *adapter = data;
+	struct i2c_client *client, *_n;
 	int res;
 
+	/* Remove the devices we created ourselves */
+	list_for_each_entry_safe(client, _n, &driver->clients, detected) {
+		if (client->adapter == adapter) {
+			dev_dbg(&adapter->dev, "Removing %s at 0x%x\n",
+				client->name, client->addr);
+			list_del(&client->detected);
+			i2c_unregister_device(client);
+		}
+	}
+
 	if (!driver->detach_adapter)
 		return 0;
 	res = driver->detach_adapter(adapter);
@@ -642,7 +659,11 @@ static int __attach_adapter(struct devic
 	struct i2c_adapter *adapter = to_i2c_adapter(dev);
 	struct i2c_driver *driver = data;
 
-	driver->attach_adapter(adapter);
+	i2c_detect(adapter, driver);
+
+	/* Legacy drivers scan i2c busses directly */
+	if (driver->attach_adapter)
+		driver->attach_adapter(adapter);
 
 	return 0;
 }
@@ -686,10 +707,9 @@ int i2c_register_driver(struct module *o
 
 	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
 
-	/* legacy drivers scan i2c busses directly */
-	if (driver->attach_adapter)
-		class_for_each_device(&i2c_adapter_class, driver,
-				      __attach_adapter);
+	INIT_LIST_HEAD(&driver->clients);
+	/* Walk the adapters that are already present */
+	class_for_each_device(&i2c_adapter_class, driver, __attach_adapter);
 
 	mutex_unlock(&core_lock);
 	return 0;
@@ -700,6 +720,17 @@ static int __detach_adapter(struct devic
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(dev);
 	struct i2c_driver *driver = data;
+	struct i2c_client *client, *_n;
+
+	list_for_each_entry_safe(client, _n, &driver->clients, detected) {
+		dev_dbg(&adapter->dev, "Removing %s at 0x%x\n",
+			client->name, client->addr);
+		list_del(&client->detected);
+		i2c_unregister_device(client);
+	}
+
+	if (is_newstyle_driver(driver))
+		return 0;
 
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver
@@ -738,10 +769,7 @@ void i2c_del_driver(struct i2c_driver *d
 {
 	mutex_lock(&core_lock);
 
-	/* legacy driver? */
-	if (!is_newstyle_driver(driver))
-		class_for_each_device(&i2c_adapter_class, driver,
-				      __detach_adapter);
+	class_for_each_device(&i2c_adapter_class, driver, __detach_adapter);
 
 	driver_unregister(&driver->driver);
 	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
@@ -1196,6 +1224,178 @@ int i2c_probe(struct i2c_adapter *adapte
 }
 EXPORT_SYMBOL(i2c_probe);
 
+/* Separate detection function for new-style drivers */
+static int i2c_detect_address(struct i2c_client *temp_client, int kind,
+			      struct i2c_driver *driver)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter = temp_client->adapter;
+	int addr = temp_client->addr;
+	int err;
+
+	/* Make sure the address is valid */
+	if (addr < 0x03 || addr > 0x77) {
+		dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
+			 addr);
+		return -EINVAL;
+	}
+
+	/* Skip if already in use */
+	if (i2c_check_addr(adapter, addr))
+		return 0;
+
+	/* Make sure there is something at this address, unless forced */
+	if (kind < 0) {
+		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
+				   I2C_SMBUS_QUICK, NULL) < 0)
+			return 0;
+
+		/* prevent 24RF08 corruption */
+		if ((addr & ~0x0f) == 0x50)
+			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
+				       I2C_SMBUS_QUICK, NULL);
+	}
+
+	/* Finally call the custom detection function */
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = addr;
+	err = driver->detect(temp_client, kind, &info);
+	if (err) {
+		/* -ENODEV is returned if the detection fails. We catch it
+		   here as this isn't an error. */
+		return err == -ENODEV ? 0 : err;
+	}
+
+	/* Consistency check */
+	if (info.type[0] == '\0') {
+		dev_err(&adapter->dev, "Detection function returned "
+			"inconsistent data for 0x%x\n", addr);
+	} else {
+		struct i2c_client *client;
+
+		/* Detection succeeded, instantiate the device */
+		dev_dbg(&adapter->dev, "Creating %s at 0x%02x\n",
+			info.type, info.addr);
+		client = i2c_new_device(adapter, &info);
+		if (client)
+			list_add_tail(&client->detected, &driver->clients);
+		else
+			dev_err(&adapter->dev, "Failed creating %s at 0x%02x\n",
+				info.type, info.addr);
+	}
+	return 0;
+}
+
+static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
+{
+	const struct i2c_client_address_data *address_data;
+	struct i2c_client *temp_client;
+	int i, err = 0;
+	int adap_id = i2c_adapter_id(adapter);
+
+	address_data = driver->address_data;
+	if (!driver->detect || !address_data)
+		return 0;
+
+	/* Set up a temporary client to help detect callback */
+	temp_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!temp_client)
+		return -ENOMEM;
+	temp_client->adapter = adapter;
+
+	/* Force entries are done first, and are not affected by ignore
+	   entries */
+	if (address_data->forces) {
+		const unsigned short * const *forces = address_data->forces;
+		int kind;
+
+		for (kind = 0; forces[kind]; kind++) {
+			for (i = 0; forces[kind][i] != I2C_CLIENT_END;
+			     i += 2) {
+				if (forces[kind][i] == adap_id
+				 || forces[kind][i] == ANY_I2C_BUS) {
+					dev_dbg(&adapter->dev, "found force "
+						"parameter for adapter %d, "
+						"addr 0x%02x, kind %d\n",
+						adap_id, forces[kind][i + 1],
+						kind);
+					temp_client->addr = forces[kind][i + 1];
+					err = i2c_detect_address(temp_client,
+						kind, driver);
+					if (err)
+						goto exit_free;
+				}
+			}
+		}
+	}
+
+	/* Stop here if we can't use SMBUS_QUICK */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
+		if (address_data->probe[0] == I2C_CLIENT_END
+		 && address_data->normal_i2c[0] == I2C_CLIENT_END)
+			goto exit_free;
+
+		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
+			 "can't probe for chips\n");
+		err = -EOPNOTSUPP;
+		goto exit_free;
+	}
+
+	/* Stop here if the classes do not match */
+	if (!(adapter->class & driver->class))
+		goto exit_free;
+
+	/* Probe entries are done second, and are not affected by ignore
+	   entries either */
+	for (i = 0; address_data->probe[i] != I2C_CLIENT_END; i += 2) {
+		if (address_data->probe[i] == adap_id
+		 || address_data->probe[i] == ANY_I2C_BUS) {
+			dev_dbg(&adapter->dev, "found probe parameter for "
+				"adapter %d, addr 0x%02x\n", adap_id,
+				address_data->probe[i + 1]);
+			temp_client->addr = address_data->probe[i + 1];
+			err = i2c_detect_address(temp_client, -1, driver);
+			if (err)
+				goto exit_free;
+		}
+	}
+
+	/* Normal entries are done last, unless shadowed by an ignore entry */
+	for (i = 0; address_data->normal_i2c[i] != I2C_CLIENT_END; i += 1) {
+		int j, ignore;
+
+		ignore = 0;
+		for (j = 0; address_data->ignore[j] != I2C_CLIENT_END;
+		     j += 2) {
+			if ((address_data->ignore[j] == adap_id ||
+			     address_data->ignore[j] == ANY_I2C_BUS)
+			 && address_data->ignore[j + 1]
+			    == address_data->normal_i2c[i]) {
+				dev_dbg(&adapter->dev, "found ignore "
+					"parameter for adapter %d, "
+					"addr 0x%02x\n", adap_id,
+					address_data->ignore[j + 1]);
+				ignore = 1;
+				break;
+			}
+		}
+		if (ignore)
+			continue;
+
+		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
+			"addr 0x%02x\n", adap_id,
+			address_data->normal_i2c[i]);
+		temp_client->addr = address_data->normal_i2c[i];
+		err = i2c_detect_address(temp_client, -1, driver);
+		if (err)
+			goto exit_free;
+	}
+
+ exit_free:
+	kfree(temp_client);
+	return err;
+}
+
 struct i2c_client *
 i2c_new_probed_device(struct i2c_adapter *adap,
 		      struct i2c_board_info *info,
--- linux-2.6.26-rc6.orig/include/linux/i2c.h	2008-06-16 13:26:02.000000000 +0200
+++ linux-2.6.26-rc6/include/linux/i2c.h	2008-06-16 18:39:57.000000000 +0200
@@ -43,6 +43,7 @@ struct i2c_adapter;
 struct i2c_client;
 struct i2c_driver;
 union i2c_smbus_data;
+struct i2c_board_info;
 
 /*
  * The master routines are the ones normally used to transmit data to devices
@@ -92,15 +93,33 @@ extern s32 i2c_smbus_write_i2c_block_dat
 					  u8 command, u8 length,
 					  const u8 *values);
 
-/*
- * A driver is capable of handling one or more physical devices present on
- * I2C adapters. This information is used to inform the driver of adapter
- * events.
+/**
+ * struct i2c_driver - represent an I2C device driver
+ * @class: What kind of i2c device we instantiate (for detect)
+ * @detect: Callback for device detection
+ * @address_data: The I2C addresses to probe, ignore or force (for detect)
+ * @clients: List of detected clients we created (for i2c-core use only)
  *
  * The driver.owner field should be set to the module owner of this driver.
  * The driver.name field should be set to the name of this driver.
+ *
+ * For automatic device detection, both @detect and @address_data must
+ * be defined. @class should also be set, otherwise only devices forced
+ * with module parameters will be created. The detect function must
+ * fill at least the name field of the i2c_board_info structure it is
+ * handed upon successful detection, and possibly also the flags field.
+ *
+ * If @detect is missing, the driver will still work fine for enumerated
+ * devices. Detected devices simply won't be supported. This is expected
+ * for the many I2C/SMBus devices which can't be detected reliably, and
+ * the ones which can always be enumerated in practice.
+ *
+ * The i2c_client structure which is handed to the @detect callback is
+ * not a real i2c_client. It is initialized just enough so that you can
+ * call i2c_smbus_read_byte_data and friends on it. Don't do anything
+ * else with it. In particular, calling dev_dbg and friends on it is
+ * not allowed.
  */
-
 struct i2c_driver {
 	int id;
 	unsigned int class;
@@ -140,6 +159,11 @@ struct i2c_driver {
 
 	struct device_driver driver;
 	const struct i2c_device_id *id_table;
+
+	/* Device detection callback for automatic device creation */
+	int (*detect)(struct i2c_client *, int kind, struct i2c_board_info *);
+	const struct i2c_client_address_data *address_data;
+	struct list_head clients;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
@@ -155,6 +179,7 @@ struct i2c_driver {
  * @dev: Driver model device node for the slave.
  * @irq: indicates the IRQ generated by this device (if any)
  * @list: list of active/busy clients (DEPRECATED)
+ * @detected: member of an i2c_driver.clients list
  * @released: used to synchronize client releases & detaches and references
  *
  * An i2c_client identifies a single device (i.e. chip) connected to an
@@ -172,6 +197,7 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
 	struct list_head list;		/* DEPRECATED */
+	struct list_head detected;
 	struct completion released;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
