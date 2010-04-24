From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-core: Use per-adapter userspace device lists
Date: Sat, 24 Apr 2010 20:19:14 +0200
Message-ID: <20100424201914.08b3f008@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Using a single list for all userspace devices leads to a dead lock
on multiplexed buses in some circumstances (mux chip instantiated
from userspace). This is solved by using a separate list for each
bus segment.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Acked-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   34 ++++++++++++++++++----------------
 include/linux/i2c.h    |    2 ++
 2 files changed, 20 insertions(+), 16 deletions(-)

--- linux-2.6.34-rc5.orig/drivers/i2c/i2c-core.c	2010-04-23 18:45:23.000000000 +0200
+++ linux-2.6.34-rc5/drivers/i2c/i2c-core.c	2010-04-24 13:02:24.000000000 +0200
@@ -40,12 +40,11 @@
 #include "i2c-core.h"
 
 
-/* core_lock protects i2c_adapter_idr, userspace_devices, and guarantees
+/* core_lock protects i2c_adapter_idr, and guarantees
    that device detection, deletion of detected devices, and attach_adapter
    and detach_adapter calls are serialized */
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
-static LIST_HEAD(userspace_devices);
 
 static struct device_type i2c_client_type;
 static int i2c_check_addr(struct i2c_adapter *adapter, int addr);
@@ -542,9 +541,9 @@ i2c_sysfs_new_device(struct device *dev,
 		return -EEXIST;
 
 	/* Keep track of the added device */
-	mutex_lock(&core_lock);
-	list_add_tail(&client->detected, &userspace_devices);
-	mutex_unlock(&core_lock);
+	i2c_lock_adapter(adap);
+	list_add_tail(&client->detected, &adap->userspace_clients);
+	i2c_unlock_adapter(adap);
 	dev_info(dev, "%s: Instantiated device %s at 0x%02hx\n", "new_device",
 		 info.type, info.addr);
 
@@ -583,9 +582,10 @@ i2c_sysfs_delete_device(struct device *d
 
 	/* Make sure the device was added through sysfs */
 	res = -ENOENT;
-	mutex_lock(&core_lock);
-	list_for_each_entry_safe(client, next, &userspace_devices, detected) {
-		if (client->addr == addr && client->adapter == adap) {
+	i2c_lock_adapter(adap);
+	list_for_each_entry_safe(client, next, &adap->userspace_clients,
+				 detected) {
+		if (client->addr == addr) {
 			dev_info(dev, "%s: Deleting device %s at 0x%02hx\n",
 				 "delete_device", client->name, client->addr);
 
@@ -595,7 +595,7 @@ i2c_sysfs_delete_device(struct device *d
 			break;
 		}
 	}
-	mutex_unlock(&core_lock);
+	i2c_unlock_adapter(adap);
 
 	if (res < 0)
 		dev_err(dev, "%s: Can't find device in list\n",
@@ -677,6 +677,7 @@ static int i2c_register_adapter(struct i
 	}
 
 	rt_mutex_init(&adap->bus_lock);
+	INIT_LIST_HEAD(&adap->userspace_clients);
 
 	/* Set default timeout to 1 second if not already set */
 	if (adap->timeout == 0)
@@ -879,14 +880,15 @@ int i2c_del_adapter(struct i2c_adapter *
 		return res;
 
 	/* Remove devices instantiated from sysfs */
-	list_for_each_entry_safe(client, next, &userspace_devices, detected) {
-		if (client->adapter == adap) {
-			dev_dbg(&adap->dev, "Removing %s at 0x%x\n",
-				client->name, client->addr);
-			list_del(&client->detected);
-			i2c_unregister_device(client);
-		}
+	i2c_lock_adapter(adap);
+	list_for_each_entry_safe(client, next, &adap->userspace_clients,
+				 detected) {
+		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,
+			client->addr);
+		list_del(&client->detected);
+		i2c_unregister_device(client);
 	}
+	i2c_unlock_adapter(adap);
 
 	/* Detach any active clients. This can't fail, thus we do not
 	   checking the returned value. */
--- linux-2.6.34-rc5.orig/include/linux/i2c.h	2010-04-23 18:45:22.000000000 +0200
+++ linux-2.6.34-rc5/include/linux/i2c.h	2010-04-24 13:02:24.000000000 +0200
@@ -355,6 +355,8 @@ struct i2c_adapter {
 	int nr;
 	char name[48];
 	struct completion dev_released;
+
+	struct list_head userspace_clients;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 


-- 
Jean Delvare
