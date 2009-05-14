From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Limit core locking to the necessary sections
Date: Thu, 14 May 2009 21:04:36 +0200
Message-ID: <20090514210436.45171424@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-core code tends to hold the core lock for longer than it
should. Limit locking to the necessary sections for both performance
and clarity. This is also a requirement to support I2C multiplexers in
the future.

Testing was successful on my system but I would love to hear from other
testers. This kind of thing is easy to get wrong.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
---
Rodolfo, this should solve the deadlocks you had been encountering
while working on I2C multiplexing support. I would like you to give a
try to my current stack of i2c patches:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c.tar.gz

If it works OK, please rebase your multiplexing patches on top of it.
Then I'll review them. I'd like to have initial multiplexing support in
kernel 2.6.31, which doesn't leave us too much time.

 drivers/i2c/i2c-core.c |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

--- linux-2.6.30-rc5.orig/drivers/i2c/i2c-core.c	2009-05-14 14:52:24.000000000 +0200
+++ linux-2.6.30-rc5/drivers/i2c/i2c-core.c	2009-05-14 16:41:32.000000000 +0200
@@ -38,7 +38,8 @@
 #include "i2c-core.h"
 
 
-/* core_lock protects i2c_adapter_idr and userspace_devices, amongst others */
+/* core_lock protects i2c_adapter_idr, userspace_devices, and guarantees
+   that device detection and attach_adapter calls are serialized */
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 static LIST_HEAD(userspace_devices);
@@ -545,8 +546,6 @@ static int i2c_register_adapter(struct i
 
 	mutex_init(&adap->bus_lock);
 
-	mutex_lock(&core_lock);
-
 	/* Set default timeout to 1 second if not already set */
 	if (adap->timeout == 0)
 		adap->timeout = HZ;
@@ -565,16 +564,16 @@ static int i2c_register_adapter(struct i
 		i2c_scan_static_board_info(adap);
 
 	/* Notify drivers */
+	mutex_lock(&core_lock);
 	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 				 i2c_do_add_adapter);
-
-out_unlock:
 	mutex_unlock(&core_lock);
-	return res;
+
+	return 0;
 
 out_list:
 	idr_remove(&i2c_adapter_idr, adap->nr);
-	goto out_unlock;
+	return res;
 }
 
 /**
@@ -711,15 +710,16 @@ int i2c_del_adapter(struct i2c_adapter *
 	if (idr_find(&i2c_adapter_idr, adap->nr) != adap) {
 		pr_debug("i2c-core: attempting to delete unregistered "
 			 "adapter [%s]\n", adap->name);
-		res = -EINVAL;
-		goto out_unlock;
+		mutex_unlock(&core_lock);
+		return -EINVAL;
 	}
 
 	/* Tell drivers about this removal */
 	res = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 			       i2c_do_del_adapter);
+	mutex_unlock(&core_lock);
 	if (res)
-		goto out_unlock;
+		return res;
 
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
@@ -729,7 +729,9 @@ int i2c_del_adapter(struct i2c_adapter *
 	wait_for_completion(&adap->dev_released);
 
 	/* free bus id */
+	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
+	mutex_unlock(&core_lock);
 
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
@@ -737,9 +739,7 @@ int i2c_del_adapter(struct i2c_adapter *
 	   added again */
 	memset(&adap->dev, 0, sizeof(adap->dev));
 
- out_unlock:
-	mutex_unlock(&core_lock);
-	return res;
+	return 0;
 }
 EXPORT_SYMBOL(i2c_del_adapter);
 
@@ -784,16 +784,15 @@ int i2c_register_driver(struct module *o
 	if (res)
 		return res;
 
-	mutex_lock(&core_lock);
-
 	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
 
 	INIT_LIST_HEAD(&driver->clients);
 	/* Walk the adapters that are already present */
+	mutex_lock(&core_lock);
 	class_for_each_device(&i2c_adapter_class, NULL, driver,
 			      __attach_adapter);
-
 	mutex_unlock(&core_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL(i2c_register_driver);
@@ -831,14 +830,12 @@ static int __detach_adapter(struct devic
 void i2c_del_driver(struct i2c_driver *driver)
 {
 	mutex_lock(&core_lock);
-
 	class_for_each_device(&i2c_adapter_class, NULL, driver,
 			      __detach_adapter);
+	mutex_unlock(&core_lock);
 
 	driver_unregister(&driver->driver);
 	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
-
-	mutex_unlock(&core_lock);
 }
 EXPORT_SYMBOL(i2c_del_driver);
 


-- 
Jean Delvare
