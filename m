From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/6] i2c: Merge i2c_attach_client into i2c_new_device
Date: Sat, 2 May 2009 11:42:31 +0200
Message-ID: <20090502114231.6f5cdf47@hyperion.delvare>
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

Now that i2c_attach_client is no longer exported, it doesn't need to
be a separate function. Merge it into its only user, i2c_new_device.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/i2c-core.c |  100 +++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 59 deletions(-)

--- linux-2.6.30-rc4.orig/drivers/i2c/i2c-core.c	2009-04-30 18:02:02.000000000 +0200
+++ linux-2.6.30-rc4/drivers/i2c/i2c-core.c	2009-04-30 18:02:04.000000000 +0200
@@ -44,7 +44,7 @@ static DEFINE_IDR(i2c_adapter_idr);
 
 #define is_newstyle_driver(d) ((d)->probe || (d)->remove || (d)->detect)
 
-static int i2c_attach_client(struct i2c_client *client);
+static int i2c_check_addr(struct i2c_adapter *adapter, int addr);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 /* ------------------------------------------------------------------------- */
@@ -242,15 +242,17 @@ EXPORT_SYMBOL(i2c_verify_client);
 
 
 /**
- * i2c_new_device - instantiate an i2c device for use with a new style driver
+ * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
  * @info: describes one I2C device; bus_num is ignored
  * Context: can sleep
  *
- * Create a device to work with a new style i2c driver, where binding is
- * handled through driver model probe()/remove() methods.  This call is not
- * appropriate for use by mainboad initialization logic, which usually runs
- * during an arch_initcall() long before any i2c_adapter could exist.
+ * Create an i2c device. Binding is handled through driver model
+ * probe()/remove() methods.  A driver may be bound to this device when we
+ * return from this function, or any later moment (e.g. maybe hotplugging will
+ * load the driver module).  This call is not appropriate for use by mainboard
+ * initialization logic, which usually runs during an arch_initcall() long
+ * before any i2c_adapter could exist.
  *
  * This returns the new i2c client, which may be saved for later use with
  * i2c_unregister_device(); or NULL to indicate an error.
@@ -278,17 +280,40 @@ i2c_new_device(struct i2c_adapter *adap,
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
-	/* a new style driver may be bound to this device when we
-	 * return from this function, or any later moment (e.g. maybe
-	 * hotplugging will load the driver module).  and the device
-	 * refcount model is the standard driver model one.
-	 */
-	status = i2c_attach_client(client);
-	if (status < 0) {
-		kfree(client);
-		client = NULL;
-	}
+	/* Check for address business */
+	status = i2c_check_addr(adap, client->addr);
+	if (status)
+		goto out_err;
+
+	client->dev.parent = &client->adapter->dev;
+	client->dev.bus = &i2c_bus_type;
+
+	if (client->driver && !is_newstyle_driver(client->driver)) {
+		client->dev.release = i2c_client_release;
+		dev_set_uevent_suppress(&client->dev, 1);
+	} else
+		client->dev.release = i2c_client_dev_release;
+
+	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
+		     client->addr);
+	status = device_register(&client->dev);
+	if (status)
+		goto out_err;
+
+	mutex_lock(&adap->clist_lock);
+	list_add_tail(&client->list, &adap->clients);
+	mutex_unlock(&adap->clist_lock);
+
+	dev_dbg(&adap->dev, "client [%s] registered with bus id %s\n",
+		client->name, dev_name(&client->dev));
+
 	return client;
+
+out_err:
+	dev_err(&adap->dev, "Failed to register i2c client %s at 0x%02x "
+		"(%d)\n", client->name, client->addr, status);
+	kfree(client);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(i2c_new_device);
 
@@ -770,49 +795,6 @@ static int i2c_check_addr(struct i2c_ada
 	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
 }
 
-static int i2c_attach_client(struct i2c_client *client)
-{
-	struct i2c_adapter *adapter = client->adapter;
-	int res;
-
-	/* Check for address business */
-	res = i2c_check_addr(adapter, client->addr);
-	if (res)
-		return res;
-
-	client->dev.parent = &client->adapter->dev;
-	client->dev.bus = &i2c_bus_type;
-
-	if (client->driver)
-		client->dev.driver = &client->driver->driver;
-
-	if (client->driver && !is_newstyle_driver(client->driver)) {
-		client->dev.release = i2c_client_release;
-		dev_set_uevent_suppress(&client->dev, 1);
-	} else
-		client->dev.release = i2c_client_dev_release;
-
-	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adapter),
-		     client->addr);
-	res = device_register(&client->dev);
-	if (res)
-		goto out_err;
-
-	mutex_lock(&adapter->clist_lock);
-	list_add_tail(&client->list, &adapter->clients);
-	mutex_unlock(&adapter->clist_lock);
-
-	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
-		client->name, dev_name(&client->dev));
-
-	return 0;
-
-out_err:
-	dev_err(&adapter->dev, "Failed to attach i2c client %s at 0x%02x "
-		"(%d)\n", client->name, client->addr, res);
-	return res;
-}
-
 /**
  * i2c_use_client - increments the reference count of the i2c client structure
  * @client: the client being referenced

-- 
Jean Delvare
