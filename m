From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Sat, 29 Dec 2007 19:05:14 -0800
Message-ID: <200712291905.15160.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712281230.17840.david-b@pacbell.net>
	<57e2b00712281645y70f6ec74s57945dc53f113ec8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <57e2b00712281645y70f6ec74s57945dc53f113ec8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> > OK, but why don't I get the warnings you get?
> >
> > That's not just on ARM, note.
> >
> >
> > Making i2c_attach_client() not use the lock that way should be
> > easy enough, I'll have a look at that, but I'm concerned about
> > the seeming lockdep misbehavior here... as in, if it gets this
> > wrong then how else is it broken and what other bugs has it
> > been hiding?

I still don't know why you get lockdep warnings and I don't ...
but here's a patch that should help, by removing that lock!  :)

- Dave


================
Remove further duplication between i2c core and driver model:  the
per-adapter list of clients (adapter->clients,  client->list) and
its lock (adapter->clist_lock) duplicate adapter->dev.children.
 
LIGHTLY TESTED ... goes on top of two patches from Jean's I2C queue,

	i2c-remove-redundant-i2c_adapter-list.patch
	i2c-remove-redundant-i2c_driver-list.patch

Continuing in that naming scheme, this might be called

	i2c-remove-redundant-i2c_client-list.patch

---
 drivers/i2c/i2c-core.c |  189 ++++++++++++++++++++++---------------------------
 drivers/i2c/i2c-dev.c  |   33 ++++----
 include/linux/i2c.h    |    4 -
 3 files changed, 102 insertions(+), 124 deletions(-)

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -256,7 +256,6 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
  */
 void i2c_unregister_device(struct i2c_client *client)
 {
-	struct i2c_adapter	*adapter = client->adapter;
 	struct i2c_driver	*driver = client->driver;
 
 	if (driver && !is_newstyle_driver(driver)) {
@@ -265,11 +264,6 @@ void i2c_unregister_device(struct i2c_cl
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
@@ -381,8 +375,6 @@ static int i2c_register_adapter(struct i
 	int res = 0, dummy;
 
 	mutex_init(&adap->bus_lock);
-	mutex_init(&adap->clist_lock);
-	INIT_LIST_HEAD(&adap->clients);
 
 	mutex_lock(&core_lists);
 
@@ -525,6 +517,38 @@ static int i2c_do_del_adapter(struct dev
 	return res;
 }
 
+static struct i2c_client *verify_client(struct device *dev)
+{
+	if (dev->bus != &i2c_bus_type)
+		return NULL;
+	return to_i2c_client(dev);
+}
+
+static int detach_all_clients(struct device *dev, void *x)
+{
+	struct i2c_client	*client = verify_client(dev);
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
@@ -535,8 +559,6 @@ static int i2c_do_del_adapter(struct dev
  */
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item, *_n;
-	struct i2c_client *client;
 	int res = 0;
 
 	mutex_lock(&core_lists);
@@ -557,26 +579,9 @@ int i2c_del_adapter(struct i2c_adapter *
 
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
@@ -655,6 +660,20 @@ int i2c_register_driver(struct module *o
 }
 EXPORT_SYMBOL(i2c_register_driver);
 
+static int detach_legacy_clients(struct device *dev, void *driver)
+{
+	struct i2c_client	*client = verify_client(dev);
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
@@ -662,8 +681,6 @@ EXPORT_SYMBOL(i2c_register_driver);
  */
 void i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item2, *_n;
-	struct i2c_client  *client;
 	struct i2c_adapter *adap;
 
 	mutex_lock(&core_lists);
@@ -684,22 +701,9 @@ void i2c_del_driver(struct i2c_driver *d
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
 
@@ -713,28 +717,19 @@ EXPORT_SYMBOL(i2c_del_driver);
 
 /* ------------------------------------------------------------------------- */
 
-static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
+static int i2c_checkaddr(struct device *dev, void *addrp)
 {
-	struct list_head   *item;
-	struct i2c_client  *client;
+	struct i2c_client	*client = verify_client(dev);
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
+	return device_for_each_child(&adapter->dev, &addr, i2c_checkaddr);
 }
 
 int i2c_attach_client(struct i2c_client *client)
@@ -742,13 +737,6 @@ int i2c_attach_client(struct i2c_client 
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
@@ -765,12 +753,16 @@ int i2c_attach_client(struct i2c_client 
 
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
@@ -781,14 +773,6 @@ int i2c_attach_client(struct i2c_client 
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
 
@@ -813,11 +797,8 @@ int i2c_detach_client(struct i2c_client 
 		}
 	}
 
-	mutex_lock(&adapter->clist_lock);
-	list_del(&client->list);
 	init_completion(&client->released);
 	device_unregister(&client->dev);
-	mutex_unlock(&adapter->clist_lock);
 	wait_for_completion(&client->released);
 
  out:
@@ -873,24 +854,28 @@ int i2c_release_client(struct i2c_client
 }
 EXPORT_SYMBOL(i2c_release_client);
 
+struct i2c_cmd_arg {
+	unsigned	cmd;
+	void		*arg;
+};
+
+static int i2c_cmd(struct device *dev, void *_arg)
+{
+	struct i2c_client	*client = verify_client(dev);
+	struct i2c_cmd_arg	*arg = _arg;
+
+	if (client)
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
 
@@ -1151,7 +1136,6 @@ i2c_new_probed_device(struct i2c_adapter
 		return NULL;
 	}
 
-	mutex_lock(&adap->clist_lock);
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */
 		if (addr_list[i] < 0x03 || addr_list[i] > 0x77) {
@@ -1161,7 +1145,7 @@ i2c_new_probed_device(struct i2c_adapter
 		}
 
 		/* Check address availability */
-		if (__i2c_check_addr(adap, addr_list[i])) {
+		if (i2c_check_addr(adap, addr_list[i])) {
 			dev_dbg(&adap->dev, "Address 0x%02x already in "
 				"use, not probing\n", addr_list[i]);
 			continue;
@@ -1189,7 +1173,6 @@ i2c_new_probed_device(struct i2c_adapter
 				break;
 		}
 	}
-	mutex_unlock(&adap->clist_lock);
 
 	if (addr_list[i] == I2C_CLIENT_END) {
 		dev_dbg(&adap->dev, "Probing failed, no device found\n");
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -182,27 +182,26 @@ static ssize_t i2cdev_write (struct file
 	return ret;
 }
 
-/* This address checking function differs from the one in i2c-core
-   in that it considers an address with a registered device, but no
-   bounded driver, as NOT busy. */
-static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int addr)
+static int i2cdev_check(struct device *dev, void *addrp)
 {
-	struct list_head *item;
 	struct i2c_client *client;
-	int res = 0;
 
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
+	if (!dev->bus || strcmp("i2c", dev->bus->name) != 0)
+		return 0;
 
-	return res;
+	client = to_i2c_client(dev);
+	if (client->addr != *(unsigned int *)addrp)
+		return 0;
+
+	return dev->driver ? -EBUSY : 0;
+}
+
+/* This address checking function differs from the one in i2c-core
+   in that it considers an address with a registered device, but no
+   driver to it, as NOT busy. */
+static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int addr)
+{
+	return device_for_each_child(&adapter->dev, &addr, i2cdev_check);
 }
 
 static int i2cdev_ioctl(struct inode *inode, struct file *file,
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -159,7 +159,6 @@ struct i2c_driver {
  * @irq: indicates the IRQ generated by this device (if any)
  * @driver_name: Identifies new-style driver used with this device; also
  *	used as the module name for hotplug/coldplug modprobe support.
- * @list: list of active/busy clients
  * @released: used to synchronize client releases & detaches and references
  *
  * An i2c_client identifies a single device (i.e. chip) connected to an
@@ -179,7 +178,6 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
 	char driver_name[KOBJ_NAME_LEN];
-	struct list_head list;
 	struct completion released;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
@@ -317,14 +315,12 @@ struct i2c_adapter {
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
