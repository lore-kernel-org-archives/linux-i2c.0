From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Mon, 14 Jan 2008 14:42:48 -0800
Message-ID: <200801141442.49220.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801091321.29212.david-b@pacbell.net>
	<20080110143105.456ddaf0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080110143105.456ddaf0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 10 January 2008, Jean Delvare wrote:
> > (b) But don't remove that list from the deletion path until ...
> > =

> > (c) ... We have a solution that removes that wait_for_completion()
> > =A0 =A0 and its infrastructure. =A0(Note the similar i2c_adapter logic
> > =A0 =A0 too, sigh.)
> > =

> > (d) Meanwhile, come up with a different solution to the deadlock
> > =A0 =A0 observed with i2c_adapter.clist ... which for some unknown
> > =A0 =A0 reason has *NOT* shown up for me with lockdep.
> > =

> > Of course, if (c) happens soon soon, this problem simplifies. =A0And
> > maybe someone will come up with a non-invasive solution to that
> > problem ... but if nobody does so before, say, Monday, I'm thinking
> > that (d) becomes a priority.

Oh, and for the record ... here's the part of $SUBJECT patch that
does (b) without (c).  No (d) yet, sigh.  I suspect a few of these
cleanups could become mergable with some work, but certainly not
all of them.  Goes on top of what I just posted.

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	CUT
Finish removing i2c_adapter.clients and its support.

NOTE:  this has self-deadlock issues with legacy drivers.  The issue
seems to be an obsolete idiom whereby code deleting devices (in i2c-core
both i2c_client and i2c_adapter nodes have this problem) waits for a
completion event as a kind of synchronization.  That's problematic since
the driver model turns that kind of synchronization into a self-deadlock.

---
 drivers/i2c/i2c-core.c |  126 +++++++++++++++++++++-----------------------=
-----
 include/linux/i2c.h    |    4 -
 2 files changed, 54 insertions(+), 76 deletions(-)

--- at91.orig/drivers/i2c/i2c-core.c	2008-01-14 14:32:00.000000000 -0800
+++ at91/drivers/i2c/i2c-core.c	2008-01-14 14:32:19.000000000 -0800
@@ -275,7 +275,6 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
  */
 void i2c_unregister_device(struct i2c_client *client)
 {
-	struct i2c_adapter	*adapter =3D client->adapter;
 	struct i2c_driver	*driver =3D client->driver;
 =

 	if (driver && !is_newstyle_driver(driver)) {
@@ -284,11 +283,6 @@ void i2c_unregister_device(struct i2c_cl
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
@@ -400,8 +394,6 @@ static int i2c_register_adapter(struct i
 	int res =3D 0, dummy;
 =

 	mutex_init(&adap->bus_lock);
-	mutex_init(&adap->clist_lock);
-	INIT_LIST_HEAD(&adap->clients);
 =

 	mutex_lock(&core_lists);
 =

@@ -544,6 +536,32 @@ static int i2c_do_del_adapter(struct dev
 	return res;
 }
 =

+
+static int detach_all_clients(struct device *dev, void *x)
+{
+	struct i2c_client	*client =3D i2c_verify_client(dev);
+	struct i2c_driver	*driver;
+	int			res;
+
+	if (!client)
+		return 0;
+
+	driver =3D client->driver;
+
+	/* new style, follow standard driver model */
+	if (!driver || is_newstyle_driver(driver)) {
+		i2c_unregister_device(client);
+		return 0;
+	}
+
+	/* legacy drivers create and remove clients themselves */
+	if ((res =3D driver->detach_client(client)))
+		dev_err(dev, "detach_client [%s] failed at address 0x%02x\n",
+			client->name, client->addr);
+
+	return res;
+}
+
 /**
  * i2c_del_adapter - unregister I2C adapter
  * @adap: the adapter being unregistered
@@ -554,8 +572,6 @@ static int i2c_do_del_adapter(struct dev
  */
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item, *_n;
-	struct i2c_client *client;
 	int res =3D 0;
 =

 	mutex_lock(&core_lists);
@@ -576,26 +592,9 @@ int i2c_del_adapter(struct i2c_adapter *
 =

 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give up. */
-	list_for_each_safe(item, _n, &adap->clients) {
-		struct i2c_driver	*driver;
-
-		client =3D list_entry(item, struct i2c_client, list);
-		driver =3D client->driver;
-
-		/* new style, follow standard driver model */
-		if (!driver || is_newstyle_driver(driver)) {
-			i2c_unregister_device(client);
-			continue;
-		}
-
-		/* legacy drivers create and remove clients themselves */
-		if ((res =3D driver->detach_client(client))) {
-			dev_err(&adap->dev, "detach_client failed for client "
-				"[%s] at address 0x%02x\n", client->name,
-				client->addr);
-			goto out_unlock;
-		}
-	}
+	res =3D device_for_each_child(&adap->dev, NULL, detach_all_clients);
+	if (res)
+		goto out_unlock;
 =

 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
@@ -674,6 +673,20 @@ int i2c_register_driver(struct module *o
 }
 EXPORT_SYMBOL(i2c_register_driver);
 =

+static int detach_legacy_clients(struct device *dev, void *driver)
+{
+	struct i2c_client	*client =3D i2c_verify_client(dev);
+
+	if (client && client->driver =3D=3D driver) {
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
@@ -681,8 +694,6 @@ EXPORT_SYMBOL(i2c_register_driver);
  */
 void i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item2, *_n;
-	struct i2c_client  *client;
 	struct i2c_adapter *adap;
 =

 	mutex_lock(&core_lists);
@@ -703,22 +714,9 @@ void i2c_del_driver(struct i2c_driver *d
 					"for driver [%s]\n",
 					driver->driver.name);
 			}
-		} else {
-			list_for_each_safe(item2, _n, &adap->clients) {
-				client =3D list_entry(item2, struct i2c_client, list);
-				if (client->driver !=3D driver)
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
 =

@@ -752,13 +750,6 @@ int i2c_attach_client(struct i2c_client =

 	struct i2c_adapter *adapter =3D client->adapter;
 	int res =3D 0;
 =

-	mutex_lock(&adapter->clist_lock);
-	if (i2c_check_addr(client->adapter, client->addr)) {
-		res =3D -EBUSY;
-		goto out_unlock;
-	}
-	list_add_tail(&client->list,&adapter->clients);
-
 	client->usage_count =3D 0;
 =

 	client->dev.parent =3D &client->adapter->dev;
@@ -775,12 +766,16 @@ int i2c_attach_client(struct i2c_client =

 =

 	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
+	res =3D device_register(&client->dev);
+	if (res) {
+		dev_err(&adapter->dev,
+			"Failed to register i2c client %s at 0x%02x (%d)\n",
+			client->name, client->addr, res);
+		return res;
+	}
+
 	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
 		client->name, client->dev.bus_id);
-	res =3D device_register(&client->dev);
-	if (res)
-		goto out_list;
-	mutex_unlock(&adapter->clist_lock);
 =

 	if (adapter->client_register)  {
 		if (adapter->client_register(client)) {
@@ -791,14 +786,6 @@ int i2c_attach_client(struct i2c_client =

 	}
 =

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
 =

@@ -823,11 +810,8 @@ int i2c_detach_client(struct i2c_client =

 		}
 	}
 =

-	mutex_lock(&adapter->clist_lock);
-	list_del(&client->list);
 	init_completion(&client->released);
 	device_unregister(&client->dev);
-	mutex_unlock(&adapter->clist_lock);
 	wait_for_completion(&client->released);
 =

  out:
@@ -1165,7 +1149,6 @@ i2c_new_probed_device(struct i2c_adapter
 		return NULL;
 	}
 =

-	mutex_lock(&adap->clist_lock);
 	for (i =3D 0; addr_list[i] !=3D I2C_CLIENT_END; i++) {
 		/* Check address validity */
 		if (addr_list[i] < 0x03 || addr_list[i] > 0x77) {
@@ -1203,7 +1186,6 @@ i2c_new_probed_device(struct i2c_adapter
 				break;
 		}
 	}
-	mutex_unlock(&adap->clist_lock);
 =

 	if (addr_list[i] =3D=3D I2C_CLIENT_END) {
 		dev_dbg(&adap->dev, "Probing failed, no device found\n");
--- at91.orig/include/linux/i2c.h	2008-01-14 14:32:00.000000000 -0800
+++ at91/include/linux/i2c.h	2008-01-14 14:32:19.000000000 -0800
@@ -159,7 +159,6 @@ struct i2c_driver {
  * @irq: indicates the IRQ generated by this device (if any)
  * @driver_name: Identifies new-style driver used with this device; also
  *	used as the module name for hotplug/coldplug modprobe support.
- * @list: list of active/busy clients (DEPRECATED)
  * @released: used to synchronize client releases & detaches and references
  *
  * An i2c_client identifies a single device (i.e. chip) connected to an
@@ -179,7 +178,6 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
 	char driver_name[KOBJ_NAME_LEN];
-	struct list_head list;		/* DEPRECATED */
 	struct completion released;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
@@ -319,14 +317,12 @@ struct i2c_adapter {
 	/* data fields that are valid for all devices	*/
 	u8 level; 			/* nesting level for lockdep */
 	struct mutex bus_lock;
-	struct mutex clist_lock;
 =

 	int timeout;
 	int retries;
 	struct device dev;		/* the adapter device */
 =

 	int nr;
-	struct list_head clients;	/* DEPRECATED */
 	char name[48];
 	struct completion dev_released;
 };


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
