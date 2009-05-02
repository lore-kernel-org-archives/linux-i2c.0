From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/6] i2c: Kill client_register and client_unregister methods
Date: Sat, 2 May 2009 11:39:43 +0200
Message-ID: <20090502113943.0bef134e@hyperion.delvare>
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

These methods were useful in the legacy binding model but no longer in
the new (standard) binding model. There are no users left so we can
drop them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 Documentation/feature-removal-schedule.txt |    3 --
 drivers/i2c/i2c-core.c                     |   30 ----------------------------
 include/linux/i2c.h                        |    4 ---
 3 files changed, 2 insertions(+), 35 deletions(-)

--- linux-2.6.30-rc3.orig/Documentation/feature-removal-schedule.txt	2009-04-29 16:52:07.000000000 +0200
+++ linux-2.6.30-rc3/Documentation/feature-removal-schedule.txt	2009-04-29 17:10:36.000000000 +0200
@@ -354,8 +354,7 @@ Who:  Krzysztof Piotr Oledzki <ole@ans.p
 
 ---------------------------
 
-What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client(),
-	i2c_adapter->client_register(), i2c_adapter->client_unregister
+What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client()
 When:	2.6.30
 Check:	i2c_attach_client i2c_detach_client
 Why:	Deprecated by the new (standard) device driver binding model. Use
--- linux-2.6.30-rc3.orig/drivers/i2c/i2c-core.c	2009-04-29 16:52:07.000000000 +0200
+++ linux-2.6.30-rc3/drivers/i2c/i2c-core.c	2009-04-29 17:37:34.000000000 +0200
@@ -309,14 +309,6 @@ void i2c_unregister_device(struct i2c_cl
 		return;
 	}
 
-	if (adapter->client_unregister) {
-		if (adapter->client_unregister(client)) {
-			dev_warn(&client->dev,
-				 "client_unregister [%s] failed\n",
-				 client->name);
-		}
-	}
-
 	mutex_lock(&adapter->clist_lock);
 	list_del(&client->list);
 	mutex_unlock(&adapter->clist_lock);
@@ -867,14 +859,6 @@ int i2c_attach_client(struct i2c_client
 	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
 		client->name, dev_name(&client->dev));
 
-	if (adapter->client_register)  {
-		if (adapter->client_register(client)) {
-			dev_dbg(&adapter->dev, "client_register "
-				"failed for client [%s] at 0x%02x\n",
-				client->name, client->addr);
-		}
-	}
-
 	return 0;
 
 out_err:
@@ -887,17 +871,6 @@ EXPORT_SYMBOL(i2c_attach_client);
 int i2c_detach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int res = 0;
-
-	if (adapter->client_unregister)  {
-		res = adapter->client_unregister(client);
-		if (res) {
-			dev_err(&client->dev,
-				"client_unregister [%s] failed, "
-				"client not detached\n", client->name);
-			goto out;
-		}
-	}
 
 	mutex_lock(&adapter->clist_lock);
 	list_del(&client->list);
@@ -907,8 +880,7 @@ int i2c_detach_client(struct i2c_client
 	device_unregister(&client->dev);
 	wait_for_completion(&client->released);
 
- out:
-	return res;
+	return 0;
 }
 EXPORT_SYMBOL(i2c_detach_client);
 
--- linux-2.6.30-rc3.orig/include/linux/i2c.h	2009-04-29 16:52:07.000000000 +0200
+++ linux-2.6.30-rc3/include/linux/i2c.h	2009-04-29 17:12:14.000000000 +0200
@@ -352,10 +352,6 @@ struct i2c_adapter {
 	const struct i2c_algorithm *algo; /* the algorithm to access the bus */
 	void *algo_data;
 
-	/* --- administration stuff. */
-	int (*client_register)(struct i2c_client *) __deprecated;
-	int (*client_unregister)(struct i2c_client *) __deprecated;
-
 	/* data fields that are valid for all devices	*/
 	u8 level; 			/* nesting level for lockdep */
 	struct mutex bus_lock;

-- 
Jean Delvare
