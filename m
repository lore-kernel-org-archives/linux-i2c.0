From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Mon, 14 Jan 2008 14:20:48 -0800
Message-ID: <200801141420.49274.david-b@pacbell.net>
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
> On Wed, 9 Jan 2008 13:21:28 -0800, David Brownell wrote:
> > Right now I'm thinking that we'll need a multi-phase approach:
> > =

> > (a) Start phasing out users of i2c_client.list and its lock, ASAP;
> > =A0 =A0 merging those DVB driver patches, and some i2c-core changes.
> =

> Fine with me. Can you please send the i2c-core patch? It would include
> i2c_verify_client(), then I can deal with the V4L drivers patch and
> these 2 patches can be pushed to -mm quickly.

OK, here's the trimmed-down patch that leaves the deletion
paths untouched until we have a better solution.  I've only
build-tested it, but it's basically $SUBJECT without those
troublesome paths.

- Dave

=3D=3D=3D=3D=3D=3D=3D	CUT HERE
The i2c_adapter.clients list of i2c_client nodes duplicates driver
model state.  This patch starts removing that list, letting us remove
most existing users of those i2c-core lists.

 * The core I2C code now iterates over the driver model's list instead
   of the i2c-internal one in some places where it's safe:
      - Passing a command/ioctl to each client, a mechanims
        used almost exclusively by DVB adapters;
      - Device address checking, in both i2c-core and i2c-dev.

 * Provide i2c_verify_client() to use with driver model iterators.

 * Flag the relevant i2c_adapter and i2c_client fields as deprecated,
   to help prevent new users from appearing.

For the moment the list needs to stick around, since some issues show
up when deleting devices created by legacy I2C drivers.  (They don't
follow standard driver model rules.  Removing those devices can cause
self-deadlocks.)

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   78 ++++++++++++++++++++++++++++----------------=
-----
 drivers/i2c/i2c-dev.c  |   29 +++++++-----------
 include/linux/i2c.h    |    8 +++--
 3 files changed, 63 insertions(+), 52 deletions(-)

--- at91.orig/drivers/i2c/i2c-core.c	2008-01-14 13:56:28.000000000 -0800
+++ at91/drivers/i2c/i2c-core.c	2008-01-14 14:01:50.000000000 -0800
@@ -197,6 +197,25 @@ static struct bus_type i2c_bus_type =3D {
 	.resume		=3D i2c_device_resume,
 };
 =

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
+	return (dev->bus =3D=3D &i2c_bus_type)
+			? to_i2c_client(dev)
+			: NULL;
+}
+EXPORT_SYMBOL(i2c_verify_client);
+
+
 /**
  * i2c_new_device - instantiate an i2c device for use with a new style dri=
ver
  * @adap: the adapter managing the device
@@ -713,28 +732,19 @@ EXPORT_SYMBOL(i2c_del_driver);
 =

 /* -----------------------------------------------------------------------=
-- */
 =

-static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
+static int __i2c_check_addr(struct device *dev, void *addrp)
 {
-	struct list_head   *item;
-	struct i2c_client  *client;
+	struct i2c_client	*client =3D i2c_verify_client(dev);
+	int			addr =3D *(int *)addrp;
 =

-	list_for_each(item,&adapter->clients) {
-		client =3D list_entry(item, struct i2c_client, list);
-		if (client->addr =3D=3D addr)
-			return -EBUSY;
-	}
+	if (client && client->addr =3D=3D addr)
+		return -EBUSY;
 	return 0;
 }
 =

 static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
 {
-	int rval;
-
-	mutex_lock(&adapter->clist_lock);
-	rval =3D __i2c_check_addr(adapter, addr);
-	mutex_unlock(&adapter->clist_lock);
-
-	return rval;
+	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
 }
 =

 int i2c_attach_client(struct i2c_client *client)
@@ -743,7 +753,7 @@ int i2c_attach_client(struct i2c_client =

 	int res =3D 0;
 =

 	mutex_lock(&adapter->clist_lock);
-	if (__i2c_check_addr(client->adapter, client->addr)) {
+	if (i2c_check_addr(client->adapter, client->addr)) {
 		res =3D -EBUSY;
 		goto out_unlock;
 	}
@@ -873,24 +883,28 @@ int i2c_release_client(struct i2c_client
 }
 EXPORT_SYMBOL(i2c_release_client);
 =

+struct i2c_cmd_arg {
+	unsigned	cmd;
+	void		*arg;
+};
+
+static int i2c_cmd(struct device *dev, void *_arg)
+{
+	struct i2c_client	*client =3D i2c_verify_client(dev);
+	struct i2c_cmd_arg	*arg =3D _arg;
+
+	if (client && client->driver && client->driver->command)
+		client->driver->command(client, arg->cmd, arg->arg);
+	return 0;
+}
+
 void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void =
*arg)
 {
-	struct list_head  *item;
-	struct i2c_client *client;
+	struct i2c_cmd_arg	cmd_arg;
 =

-	mutex_lock(&adap->clist_lock);
-	list_for_each(item,&adap->clients) {
-		client =3D list_entry(item, struct i2c_client, list);
-		if (!try_module_get(client->driver->driver.owner))
-			continue;
-		if (NULL !=3D client->driver->command) {
-			mutex_unlock(&adap->clist_lock);
-			client->driver->command(client,cmd,arg);
-			mutex_lock(&adap->clist_lock);
-		}
-		module_put(client->driver->driver.owner);
-       }
-       mutex_unlock(&adap->clist_lock);
+	cmd_arg.cmd =3D cmd;
+	cmd_arg.arg =3D arg;
+	device_for_each_child(&adap->dev, &cmd_arg, i2c_cmd);
 }
 EXPORT_SYMBOL(i2c_clients_command);
 =

@@ -1161,7 +1175,7 @@ i2c_new_probed_device(struct i2c_adapter
 		}
 =

 		/* Check address availability */
-		if (__i2c_check_addr(adap, addr_list[i])) {
+		if (i2c_check_addr(adap, addr_list[i])) {
 			dev_dbg(&adap->dev, "Address 0x%02x already in "
 				"use, not probing\n", addr_list[i]);
 			continue;
--- at91.orig/drivers/i2c/i2c-dev.c	2008-01-14 13:54:05.000000000 -0800
+++ at91/drivers/i2c/i2c-dev.c	2008-01-14 14:03:43.000000000 -0800
@@ -182,27 +182,22 @@ static ssize_t i2cdev_write (struct file
 	return ret;
 }
 =

+static int i2cdev_check(struct device *dev, void *addrp)
+{
+	struct i2c_client *client =3D i2c_verify_client(dev);
+
+	if (!client || client->addr !=3D *(unsigned int *)addrp)
+		return 0;
+
+	return dev->driver ? -EBUSY : 0;
+}
+
 /* This address checking function differs from the one in i2c-core
    in that it considers an address with a registered device, but no
-   bounded driver, as NOT busy. */
+   driver bound to it, as NOT busy. */
 static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int add=
r)
 {
-	struct list_head *item;
-	struct i2c_client *client;
-	int res =3D 0;
-
-	mutex_lock(&adapter->clist_lock);
-	list_for_each(item, &adapter->clients) {
-		client =3D list_entry(item, struct i2c_client, list);
-		if (client->addr =3D=3D addr) {
-			if (client->driver)
-				res =3D -EBUSY;
-			break;
-		}
-	}
-	mutex_unlock(&adapter->clist_lock);
-
-	return res;
+	return device_for_each_child(&adapter->dev, &addr, i2cdev_check);
 }
 =

 static int i2cdev_ioctl(struct inode *inode, struct file *file,
--- at91.orig/include/linux/i2c.h	2008-01-14 13:56:28.000000000 -0800
+++ at91/include/linux/i2c.h	2008-01-14 13:56:29.000000000 -0800
@@ -159,7 +159,7 @@ struct i2c_driver {
  * @irq: indicates the IRQ generated by this device (if any)
  * @driver_name: Identifies new-style driver used with this device; also
  *	used as the module name for hotplug/coldplug modprobe support.
- * @list: list of active/busy clients
+ * @list: list of active/busy clients (DEPRECATED)
  * @released: used to synchronize client releases & detaches and references
  *
  * An i2c_client identifies a single device (i.e. chip) connected to an
@@ -179,11 +179,13 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
 	char driver_name[KOBJ_NAME_LEN];
-	struct list_head list;
+	struct list_head list;		/* DEPRECATED */
 	struct completion released;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 =

+extern struct i2c_client *i2c_verify_client(struct device *dev);
+
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
 	struct device * const dev =3D container_of(kobj, struct device, kobj);
@@ -324,7 +326,7 @@ struct i2c_adapter {
 	struct device dev;		/* the adapter device */
 =

 	int nr;
-	struct list_head clients;
+	struct list_head clients;	/* DEPRECATED */
 	char name[48];
 	struct completion dev_released;
 };

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
