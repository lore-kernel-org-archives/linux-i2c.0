From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch/rft 2.6.26-rc1] i2c-core: stop using
	i2c_adapter.clients
Date: Sun, 4 May 2008 21:24:45 -0700
Message-ID: <200805042124.45551.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This changes how the I2C core iterates devices connected to a given
i2c_adapter, making it use driver model facilities instead of the
deprecated i2c_adapter.clients list.  The two functions affected are
i2c_del_adapter() and i2c_del_driver().

This is something of a bugfix:  updates to that list are protected by a
lock (i2c_adapter.clist_lock) which is completly ignored by those two
iteration loops ...

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Builds fine, and I have a hard time seeing this break.  But this
hasn't really been tested.

 drivers/i2c/i2c-core.c |   91 +++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

--- g26.orig/drivers/i2c/i2c-core.c	2008-05-04 20:51:58.000000000 -0700
+++ g26/drivers/i2c/i2c-core.c	2008-05-04 20:55:46.000000000 -0700
@@ -725,6 +725,44 @@ static int i2c_do_del_adapter(struct dev
 	return res;
 }
 
+static int i2c_do_detach_client(struct device *dev, void *target)
+{
+	struct i2c_client	*client = i2c_verify_client(dev);
+	struct i2c_driver	*driver;
+	int			status;
+
+	/* ignore non-i2c nodes */
+	if (!client)
+		return 0;
+
+	/* we may care only about one specific (legacy) driver */
+	driver = client->driver;
+	if (target && driver != target)
+		return 0;
+
+	/* cleanup new-style nodes */
+	if (!driver || is_newstyle_driver(driver)) {
+		i2c_unregister_device(client);
+		return 0;
+	}
+
+	/* detach legacy drivers */
+	if (driver->detach_client)
+		status = driver->detach_client(client);
+	else
+		status = -EOPNOTSUPP;
+	if (status < 0)
+		dev_err(&client->adapter->dev,
+			"detach_client failed for client "
+			"[%s] at address 0x%02x\n",
+			client->name, client->addr);
+
+	/* backwards compat: ignore failure while removing a single
+	 * legacy driver; maybe we can disconnect it from other devs.
+	 */
+	return target ? 0 : status;
+}
+
 /**
  * i2c_del_adapter - unregister I2C adapter
  * @adap: the adapter being unregistered
@@ -735,8 +773,6 @@ static int i2c_do_del_adapter(struct dev
  */
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item, *_n;
-	struct i2c_client *client;
 	int res = 0;
 
 	mutex_lock(&core_lock);
@@ -749,34 +785,18 @@ int i2c_del_adapter(struct i2c_adapter *
 		goto out_unlock;
 	}
 
-	/* Tell drivers about this removal */
+	/* Tell legacy drivers about this removal.  They can fail...
+	 * in which case, give up.
+	 */
 	res = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 			       i2c_do_del_adapter);
 	if (res)
 		goto out_unlock;
 
-	/* detach any active clients. This must be done first, because
-	 * it can fail; in which case we give up. */
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
+	/* Detach any active clients, both legacy and new style. */
+	res = device_for_each_child(&adap->dev, NULL, i2c_do_detach_client);
+	if (res)
+		goto out_unlock;
 
 	if (adap->has_alert_irq) {
 		devm_free_irq(&adap->dev, adap->irq, adap);
@@ -868,8 +888,6 @@ EXPORT_SYMBOL(i2c_register_driver);
  */
 void i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item2, *_n;
-	struct i2c_client  *client;
 	struct i2c_adapter *adap;
 
 	mutex_lock(&core_lock);
@@ -890,22 +908,9 @@ void i2c_del_driver(struct i2c_driver *d
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
+					i2c_do_detach_client);
 	}
 	up(&i2c_adapter_class.sem);
 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
