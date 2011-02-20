From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] i2c: Export i2c_for_each_dev
Date: Sun, 20 Feb 2011 15:08:09 +0100
Message-ID: <20110220150809.0ab84224@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Introduce i2c_for_each_dev(), an i2c device iterator with proper
locking for use by i2c-dev. This is needed so that we can get rid of
the attach_adapter and detach_adapter legacy callback functions.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   20 ++++++++++++++------
 include/linux/i2c.h    |    2 ++
 2 files changed, 16 insertions(+), 6 deletions(-)

--- linux-2.6.38-rc5.orig/drivers/i2c/i2c-core.c	2011-02-20 15:01:30.000000000 +0100
+++ linux-2.6.38-rc5/drivers/i2c/i2c-core.c	2011-02-20 15:04:47.000000000 +0100
@@ -1093,6 +1093,18 @@ EXPORT_SYMBOL(i2c_del_adapter);
 
 /* ------------------------------------------------------------------------- */
 
+int i2c_for_each_dev(void *data, int (*fn)(struct device *, void *))
+{
+	int res;
+
+	mutex_lock(&core_lock);
+	res = bus_for_each_dev(&i2c_bus_type, NULL, data, fn);
+	mutex_unlock(&core_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(i2c_for_each_dev);
+
 static int __process_new_driver(struct device *dev, void *data)
 {
 	if (dev->type != &i2c_adapter_type)
@@ -1136,9 +1148,7 @@ int i2c_register_driver(struct module *o
 
 	INIT_LIST_HEAD(&driver->clients);
 	/* Walk the adapters that are already present */
-	mutex_lock(&core_lock);
-	bus_for_each_dev(&i2c_bus_type, NULL, driver, __process_new_driver);
-	mutex_unlock(&core_lock);
+	i2c_for_each_dev(driver, __process_new_driver);
 
 	return 0;
 }
@@ -1158,9 +1168,7 @@ static int __process_removed_driver(stru
  */
 void i2c_del_driver(struct i2c_driver *driver)
 {
-	mutex_lock(&core_lock);
-	bus_for_each_dev(&i2c_bus_type, NULL, driver, __process_removed_driver);
-	mutex_unlock(&core_lock);
+	i2c_for_each_dev(driver, __process_removed_driver);
 
 	driver_unregister(&driver->driver);
 	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
--- linux-2.6.38-rc5.orig/include/linux/i2c.h	2011-02-20 15:04:30.000000000 +0100
+++ linux-2.6.38-rc5/include/linux/i2c.h	2011-02-20 15:04:47.000000000 +0100
@@ -397,6 +397,8 @@ i2c_parent_is_i2c_adapter(const struct i
 		return NULL;
 }
 
+int i2c_for_each_dev(void *data, int (*fn)(struct device *, void *));
+
 /* Adapter locking functions, exported for shared pin cases */
 void i2c_lock_adapter(struct i2c_adapter *);
 void i2c_unlock_adapter(struct i2c_adapter *);


-- 
Jean Delvare
