From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.28-rc5] i2c:  remove i2c_adapter.clist_lock
Date: Thu, 20 Nov 2008 14:38:08 -0800
Message-ID: <200811201438.08788.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Move list add/remove operations now protected by i2c_adapter.clist_lock
into the driver model probe() and remove() calls, where driver model
locking protects them.  This is a minor code and data shrink.

Note that the adapter "child list" is still protected inconsistently;
this patch just simplifies locking, and makes this list more directly
mirror the one maintained by the driver model.  Removing this list may
need to wait until the legacy I2C driver binding model is removed.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   17 ++++-------------
 include/linux/i2c.h    |    1 -
 2 files changed, 4 insertions(+), 14 deletions(-)

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -116,6 +116,8 @@ static int i2c_device_probe(struct devic
 	status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status)
 		client->driver = NULL;
+	else
+		list_add_tail(&client->list, &client->adapter->clients);
 	return status;
 }
 
@@ -125,6 +127,8 @@ static int i2c_device_remove(struct devi
 	struct i2c_driver	*driver;
 	int			status;
 
+	list_del(&client->list);
+
 	if (!dev->driver)
 		return 0;
 
@@ -315,10 +319,6 @@ void i2c_unregister_device(struct i2c_cl
 		}
 	}
 
-	mutex_lock(&adapter->clist_lock);
-	list_del(&client->list);
-	mutex_unlock(&adapter->clist_lock);
-
 	device_unregister(&client->dev);
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
@@ -445,7 +445,6 @@ static int i2c_register_adapter(struct i
 		return -EAGAIN;
 
 	mutex_init(&adap->bus_lock);
-	mutex_init(&adap->clist_lock);
 	INIT_LIST_HEAD(&adap->clients);
 
 	mutex_lock(&core_lock);
@@ -851,10 +850,6 @@ int i2c_attach_client(struct i2c_client 
 	if (res)
 		goto out_err;
 
-	mutex_lock(&adapter->clist_lock);
-	list_add_tail(&client->list, &adapter->clients);
-	mutex_unlock(&adapter->clist_lock);
-
 	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
 		client->name, client->dev.bus_id);
 
@@ -890,10 +885,6 @@ int i2c_detach_client(struct i2c_client 
 		}
 	}
 
-	mutex_lock(&adapter->clist_lock);
-	list_del(&client->list);
-	mutex_unlock(&adapter->clist_lock);
-
 	init_completion(&client->released);
 	device_unregister(&client->dev);
 	wait_for_completion(&client->released);
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -359,7 +359,6 @@ struct i2c_adapter {
 	/* data fields that are valid for all devices	*/
 	u8 level; 			/* nesting level for lockdep */
 	struct mutex bus_lock;
-	struct mutex clist_lock;
 
 	int timeout;
 	int retries;
