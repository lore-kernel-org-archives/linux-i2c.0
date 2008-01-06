From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Sun, 6 Jan 2008 11:43:33 -0800
Message-ID: <200801061143.34020.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712291905.15160.david-b@pacbell.net>
	<20080106122356.78556b8a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080106122356.78556b8a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Remove further duplication between i2c core and driver model:  the
per-adapter list of clients (adapter->clients,  client->list) and
its lock (adapter->clist_lock) duplicate adapter->dev.children.

Add and use a new i2c_verify_client() routine to help code which
traverses the driver model tree.
 
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
LIGHTLY TESTED ... goes on top of two patches from Jean's I2C queue,

	i2c-remove-redundant-i2c_adapter-list.patch
	i2c-remove-redundant-i2c_driver-list.patch

Updated per Jean's comments.  (Note that the i2c_verify_client
bit might usefully be split out into a separate patch, to simplify
converting the V4L code that uses this i2c client list.)

 drivers/i2c/i2c-core.c |  202 ++++++++++++++++++++++++-------------------------
 drivers/i2c/i2c-dev.c  |   29 ++-----
 include/linux/i2c.h    |    9 --
 3 files changed, 114 insertions(+), 126 deletions(-)

--- at91.orig/drivers/i2c/i2c-core.c	2008-01-06 10:47:45.000000000 -0800
+++ at91/drivers/i2c/i2c-core.c	2008-01-06 11:08:00.000000000 -0800
@@ -197,6 +197,25 @@ static struct bus_type i2c_bus_type = {
 	.resume		= i2c_device_resume,
 };
 
+
+/**
+ * i2c_verify_client - return parameter as i2c_client, or NULL
+ * @dev: device, probably from some driver model iterator
+ *
+ * When traversing the driver model tree, perhaps using driver model
+ * iterators like @device_for_each_child(), you can't assume very much
+ * about the nodes you find.  Use this function to avoid oopses caused
+ * by wrongly treating some non-I2C device as an i2c_client.
+ */
+struct i2c_client *i2c_verify_client(struct device *dev)
+{
+	return (dev->bus == &i2c_bus_type)
+			? to_i2c_client(dev)
+			: NULL;
+}
+EXPORT_SYMBOL(i2c_verify_client);
+
+
 /**
  * i2c_new_device - instantiate an i2c device for use with a new style driver
  * @adap: the adapter managing the device
@@ -256,7 +275,6 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
  */
 void i2c_unregister_device(struct i2c_client *client)
 {
-	struct i2c_adapter	*adapter = client->adapter;
 	struct i2c_driver	*driver = client->driver;
 
 	if (driver && !is_newstyle_driver(driver)) {
@@ -265,11 +283,6 @@ void i2c_unregister_device(struct i2c_cl
 		WARN_ON(1);
 		return;
 	}
-
-	mutex_lock(&adapter->clist_lock);
-	list_del(&client->list);
-	mutex_unlock(&adapter->clist_lock);
-
 	device_unregister(&client->dev);
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
@@ -381,8 +394,6 @@ static int i2c_register_adapter(struct i
 	int res = 0, dummy;
 
 	mutex_init(&adap->bus_lock);
-	mutex_init(&adap->clist_lock);
-	INIT_LIST_HEAD(&adap->clients);
 
 	mutex_lock(&core_lists);
 
@@ -525,6 +536,32 @@ static int i2c_do_del_adapter(struct dev
 	return res;
 }
 
+
+static int detach_all_clients(struct device *dev, void *x)
+{
+	struct i2c_client	*client = i2c_verify_client(dev);
+	struct i2c_driver	*driver;
+	int			res;
+
+	if (!client)
+		return 0;
+
+	driver = client->driver;
+
+	/* new style, follow standard driver model */
+	if (!driver || is_newstyle_driver(driver)) {
+		i2c_unregister_device(client);
+		return 0;
+	}
+
+	/* legacy drivers create and remove clients themselves */
+	if ((res = driver->detach_client(client)))
+		dev_err(dev, "detach_client [%s] failed at address 0x%02x\n",
+			client->name, client->addr);
+
+	return res;
+}
+
 /**
  * i2c_del_adapter - unregister I2C adapter
  * @adap: the adapter being unregistered
@@ -535,8 +572,6 @@ static int i2c_do_del_adapter(struct dev
  */
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item, *_n;
-	struct i2c_client *client;
 	int res = 0;
 
 	mutex_lock(&core_lists);
@@ -557,26 +592,9 @@ int i2c_del_adapter(struct i2c_adapter *
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give up. */
-	list_for_each_safe(item, _n, &adap->clients) {
-		struct i2c_driver	*driver;
-
-		client = list_entry(item, struct i2c_client, list);
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
+	res = device_for_each_child(&adap->dev, NULL, detach_all_clients);
+	if (res)
+		goto out_unlock;
 
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
@@ -655,6 +673,20 @@ int i2c_register_driver(struct module *o
 }
 EXPORT_SYMBOL(i2c_register_driver);
 
+static int detach_legacy_clients(struct device *dev, void *driver)
+{
+	struct i2c_client	*client = i2c_verify_client(dev);
+
+	if (client && client->driver == driver) {
+		dev_dbg(dev, "detaching client [%s] at 0x%02x\n",
+				client->name, client->addr);
+		if (client->driver->detach_client(client))
+			dev_err(dev, "failed detach_client [%s] at 0x%02x\n",
+				client->name, client->addr);
+	}
+	return 0;
+}
+
 /**
  * i2c_del_driver - unregister I2C driver
  * @driver: the driver being unregistered
@@ -662,8 +694,6 @@ EXPORT_SYMBOL(i2c_register_driver);
  */
 void i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item2, *_n;
-	struct i2c_client  *client;
 	struct i2c_adapter *adap;
 
 	mutex_lock(&core_lists);
@@ -684,22 +714,9 @@ void i2c_del_driver(struct i2c_driver *d
 					"for driver [%s]\n",
 					driver->driver.name);
 			}
-		} else {
-			list_for_each_safe(item2, _n, &adap->clients) {
-				client = list_entry(item2, struct i2c_client, list);
-				if (client->driver != driver)
-					continue;
-				dev_dbg(&adap->dev, "detaching client [%s] "
-					"at 0x%02x\n", client->name,
-					client->addr);
-				if (driver->detach_client(client)) {
-					dev_err(&adap->dev, "detach_client "
-						"failed for client [%s] at "
-						"0x%02x\n", client->name,
-						client->addr);
-				}
-			}
-		}
+		} else
+			device_for_each_child(&adap->dev, driver,
+					detach_legacy_clients);
 	}
 	up(&i2c_adapter_class.sem);
 
@@ -713,28 +730,19 @@ EXPORT_SYMBOL(i2c_del_driver);
 
 /* ------------------------------------------------------------------------- */
 
-static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
+static int __i2c_check_addr(struct device *dev, void *addrp)
 {
-	struct list_head   *item;
-	struct i2c_client  *client;
+	struct i2c_client	*client = i2c_verify_client(dev);
+	int			addr = *(int *)addrp;
 
-	list_for_each(item,&adapter->clients) {
-		client = list_entry(item, struct i2c_client, list);
-		if (client->addr == addr)
-			return -EBUSY;
-	}
+	if (client && client->addr == addr)
+		return -EBUSY;
 	return 0;
 }
 
 static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
 {
-	int rval;
-
-	mutex_lock(&adapter->clist_lock);
-	rval = __i2c_check_addr(adapter, addr);
-	mutex_unlock(&adapter->clist_lock);
-
-	return rval;
+	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
 }
 
 int i2c_attach_client(struct i2c_client *client)
@@ -742,13 +750,6 @@ int i2c_attach_client(struct i2c_client 
 	struct i2c_adapter *adapter = client->adapter;
 	int res = 0;
 
-	mutex_lock(&adapter->clist_lock);
-	if (__i2c_check_addr(client->adapter, client->addr)) {
-		res = -EBUSY;
-		goto out_unlock;
-	}
-	list_add_tail(&client->list,&adapter->clients);
-
 	client->usage_count = 0;
 
 	client->dev.parent = &client->adapter->dev;
@@ -765,12 +766,16 @@ int i2c_attach_client(struct i2c_client 
 
 	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
+	res = device_register(&client->dev);
+	if (res) {
+		dev_err(&adapter->dev,
+			"Failed to register i2c client %s at 0x%02x (%d)\n",
+			client->name, client->addr, res);
+		return res;
+	}
+
 	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
 		client->name, client->dev.bus_id);
-	res = device_register(&client->dev);
-	if (res)
-		goto out_list;
-	mutex_unlock(&adapter->clist_lock);
 
 	if (adapter->client_register)  {
 		if (adapter->client_register(client)) {
@@ -781,14 +786,6 @@ int i2c_attach_client(struct i2c_client 
 	}
 
 	return 0;
-
-out_list:
-	list_del(&client->list);
-	dev_err(&adapter->dev, "Failed to attach i2c client %s at 0x%02x "
-		"(%d)\n", client->name, client->addr, res);
-out_unlock:
-	mutex_unlock(&adapter->clist_lock);
-	return res;
 }
 EXPORT_SYMBOL(i2c_attach_client);
 
@@ -813,11 +810,8 @@ int i2c_detach_client(struct i2c_client 
 		}
 	}
 
-	mutex_lock(&adapter->clist_lock);
-	list_del(&client->list);
 	init_completion(&client->released);
 	device_unregister(&client->dev);
-	mutex_unlock(&adapter->clist_lock);
 	wait_for_completion(&client->released);
 
  out:
@@ -873,24 +867,28 @@ int i2c_release_client(struct i2c_client
 }
 EXPORT_SYMBOL(i2c_release_client);
 
+struct i2c_cmd_arg {
+	unsigned	cmd;
+	void		*arg;
+};
+
+static int i2c_cmd(struct device *dev, void *_arg)
+{
+	struct i2c_client	*client = i2c_verify_client(dev);
+	struct i2c_cmd_arg	*arg = _arg;
+
+	if (client && client->driver->command)
+		client->driver->command(client, arg->cmd, arg->arg);
+	return 0;
+}
+
 void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void *arg)
 {
-	struct list_head  *item;
-	struct i2c_client *client;
+	struct i2c_cmd_arg	cmd_arg;
 
-	mutex_lock(&adap->clist_lock);
-	list_for_each(item,&adap->clients) {
-		client = list_entry(item, struct i2c_client, list);
-		if (!try_module_get(client->driver->driver.owner))
-			continue;
-		if (NULL != client->driver->command) {
-			mutex_unlock(&adap->clist_lock);
-			client->driver->command(client,cmd,arg);
-			mutex_lock(&adap->clist_lock);
-		}
-		module_put(client->driver->driver.owner);
-       }
-       mutex_unlock(&adap->clist_lock);
+	cmd_arg.cmd = cmd;
+	cmd_arg.arg = arg;
+	device_for_each_child(&adap->dev, &cmd_arg, i2c_cmd);
 }
 EXPORT_SYMBOL(i2c_clients_command);
 
@@ -1151,7 +1149,6 @@ i2c_new_probed_device(struct i2c_adapter
 		return NULL;
 	}
 
-	mutex_lock(&adap->clist_lock);
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */
 		if (addr_list[i] < 0x03 || addr_list[i] > 0x77) {
@@ -1161,7 +1158,7 @@ i2c_new_probed_device(struct i2c_adapter
 		}
 
 		/* Check address availability */
-		if (__i2c_check_addr(adap, addr_list[i])) {
+		if (i2c_check_addr(adap, addr_list[i])) {
 			dev_dbg(&adap->dev, "Address 0x%02x already in "
 				"use, not probing\n", addr_list[i]);
 			continue;
@@ -1189,7 +1186,6 @@ i2c_new_probed_device(struct i2c_adapter
 				break;
 		}
 	}
-	mutex_unlock(&adap->clist_lock);
 
 	if (addr_list[i] == I2C_CLIENT_END) {
 		dev_dbg(&adap->dev, "Probing failed, no device found\n");
--- at91.orig/drivers/i2c/i2c-dev.c	2008-01-05 16:17:06.000000000 -0800
+++ at91/drivers/i2c/i2c-dev.c	2008-01-06 11:22:30.000000000 -0800
@@ -182,27 +182,22 @@ static ssize_t i2cdev_write (struct file
 	return ret;
 }
 
+static int i2cdev_check(struct device *dev, void *addrp)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+
+	if (!client || client->addr != *(unsigned int *)addrp)
+		return 0;
+
+	return dev->driver ? -EBUSY : 0;
+}
+
 /* This address checking function differs from the one in i2c-core
    in that it considers an address with a registered device, but no
-   bounded driver, as NOT busy. */
+   driver to it, as NOT busy. */
 static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int addr)
 {
-	struct list_head *item;
-	struct i2c_client *client;
-	int res = 0;
-
-	mutex_lock(&adapter->clist_lock);
-	list_for_each(item, &adapter->clients) {
-		client = list_entry(item, struct i2c_client, list);
-		if (client->addr == addr) {
-			if (client->driver)
-				res = -EBUSY;
-			break;
-		}
-	}
-	mutex_unlock(&adapter->clist_lock);
-
-	return res;
+	return device_for_each_child(&adapter->dev, &addr, i2cdev_check);
 }
 
 static int i2cdev_ioctl(struct inode *inode, struct file *file,
--- at91.orig/include/linux/i2c.h	2008-01-06 10:47:45.000000000 -0800
+++ at91/include/linux/i2c.h	2008-01-06 11:10:38.000000000 -0800
@@ -159,7 +159,6 @@ struct i2c_driver {
  * @irq: indicates the IRQ generated by this device (if any)
  * @driver_name: Identifies new-style driver used with this device; also
  *	used as the module name for hotplug/coldplug modprobe support.
- * @list: list of active/busy clients
  * @released: used to synchronize client releases & detaches and references
  *
  * An i2c_client identifies a single device (i.e. chip) connected to an
@@ -179,15 +178,15 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
 	char driver_name[KOBJ_NAME_LEN];
-	struct list_head list;
 	struct completion released;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
+extern struct i2c_client *i2c_verify_client(struct device *dev);
+
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
-	struct device * const dev = container_of(kobj, struct device, kobj);
-	return to_i2c_client(dev);
+	return i2c_verify_client(container_of(kobj, struct device, kobj));
 }
 
 static inline void *i2c_get_clientdata (struct i2c_client *dev)
@@ -317,14 +316,12 @@ struct i2c_adapter {
 	/* data fields that are valid for all devices	*/
 	u8 level; 			/* nesting level for lockdep */
 	struct mutex bus_lock;
-	struct mutex clist_lock;
 
 	int timeout;
 	int retries;
 	struct device dev;		/* the adapter device */
 
 	int nr;
-	struct list_head clients;
 	char name[48];
 	struct completion dev_released;
 };
