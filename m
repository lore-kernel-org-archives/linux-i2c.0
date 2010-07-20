From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Use a separate mutex for userspace client lists
Date: Tue, 20 Jul 2010 14:22:27 +0200
Message-ID: <20100720142227.14bb11bb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Moving userspace-instantiated clients to separate lists wasn't nearly
enough to avoid deadlocks in multiplexed bus cases. We also want to
have a dedicated mutex to protect each list.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Michael, this should solve any deadlock issue related to userspace
devices we've been discussing lately. I should probably have done this
from the beginning. This also has the benefit of making your own patch
slightly smaller - I'll update it myself.

 drivers/i2c/i2c-core.c |   13 +++++++------
 include/linux/i2c.h    |    1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

--- linux-2.6.35-rc5.orig/drivers/i2c/i2c-core.c	2010-07-19 09:11:51.000000000 +0200
+++ linux-2.6.35-rc5/drivers/i2c/i2c-core.c	2010-07-20 13:08:51.000000000 +0200
@@ -656,9 +656,9 @@ i2c_sysfs_new_device(struct device *dev,
 		return -EINVAL;
 
 	/* Keep track of the added device */
-	i2c_lock_adapter(adap);
+	mutex_lock(&adap->userspace_clients_lock);
 	list_add_tail(&client->detected, &adap->userspace_clients);
-	i2c_unlock_adapter(adap);
+	mutex_unlock(&adap->userspace_clients_lock);
 	dev_info(dev, "%s: Instantiated device %s at 0x%02hx\n", "new_device",
 		 info.type, info.addr);
 
@@ -697,7 +697,7 @@ i2c_sysfs_delete_device(struct device *d
 
 	/* Make sure the device was added through sysfs */
 	res = -ENOENT;
-	i2c_lock_adapter(adap);
+	mutex_lock(&adap->userspace_clients_lock);
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		if (client->addr == addr) {
@@ -710,7 +710,7 @@ i2c_sysfs_delete_device(struct device *d
 			break;
 		}
 	}
-	i2c_unlock_adapter(adap);
+	mutex_unlock(&adap->userspace_clients_lock);
 
 	if (res < 0)
 		dev_err(dev, "%s: Can't find device in list\n",
@@ -792,6 +792,7 @@ static int i2c_register_adapter(struct i
 	}
 
 	rt_mutex_init(&adap->bus_lock);
+	mutex_init(&adap->userspace_clients_lock);
 	INIT_LIST_HEAD(&adap->userspace_clients);
 
 	/* Set default timeout to 1 second if not already set */
@@ -994,7 +995,7 @@ int i2c_del_adapter(struct i2c_adapter *
 		return res;
 
 	/* Remove devices instantiated from sysfs */
-	i2c_lock_adapter(adap);
+	mutex_lock(&adap->userspace_clients_lock);
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,
@@ -1002,7 +1003,7 @@ int i2c_del_adapter(struct i2c_adapter *
 		list_del(&client->detected);
 		i2c_unregister_device(client);
 	}
-	i2c_unlock_adapter(adap);
+	mutex_unlock(&adap->userspace_clients_lock);
 
 	/* Detach any active clients. This can't fail, thus we do not
 	   checking the returned value. */
--- linux-2.6.35-rc5.orig/include/linux/i2c.h	2010-07-19 09:11:50.000000000 +0200
+++ linux-2.6.35-rc5/include/linux/i2c.h	2010-07-20 12:58:08.000000000 +0200
@@ -366,6 +366,7 @@ struct i2c_adapter {
 	char name[48];
 	struct completion dev_released;
 
+	struct mutex userspace_clients_lock;
 	struct list_head userspace_clients;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)

-- 
Jean Delvare
