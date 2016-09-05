From: David Lechner <david@lechnology.com>
Subject: [PATCH 3/3] i2c: expose adapter probe and remove probed functions
Date: Mon,  5 Sep 2016 15:40:14 -0500
Message-ID: <1473108014-30787-4-git-send-email-david@lechnology.com>
References: <1473108014-30787-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473108014-30787-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: David Lechner <david@lechnology.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Publicly expose functions for detecting devices and removing detected
devices.

Currently an i2c adapter only probes/detects new devices when the adapter
is added or when a new i2c driver is added. This adds a new function,
i2c_adapter_probe(), that allows detecting sensors at any time.

Furthermore, the function i2c_adapter_remove_probed() is added to remove
the devices added by i2c_adapter_probe() at any time.

The intended use of these functions is for LEGO MINDSTORMS sensors. These
are hot-plugable I2C devices. When a sensor is connected, i2c_adapter_probe()
is called to automatically configure the sensor. When the sensor is
disconnected, i2c_adapter_remove_probed() is called to remove the
automatically configured device.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/i2c/i2c-core.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/i2c.h    |  3 +++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 28436d9..2781a88 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1691,6 +1691,23 @@ static int __process_new_adapter(struct device_driver *d, void *data)
 	return i2c_do_add_adapter(to_i2c_driver(d), data);
 }
 
+/**
+ * i2c_adapter_probe - probe adapter for clients
+ * @adap: The i2c adapter.
+ *
+ * This calls the detect function of each driver that matches the class of the
+ * adapter. This function is called when an adapter is added, so there is no
+ * need to call this manually, unless you have hot-plugable i2c devices that
+ * are connected after the adapter is created.
+ */
+void i2c_adapter_probe(struct i2c_adapter *adap)
+{
+	mutex_lock(&core_lock);
+	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_new_adapter);
+	mutex_unlock(&core_lock);
+}
+EXPORT_SYMBOL(i2c_adapter_probe);
+
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = -EINVAL;
@@ -1759,9 +1776,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		i2c_scan_static_board_info(adap);
 
 	/* Notify drivers */
-	mutex_lock(&core_lock);
-	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_new_adapter);
-	mutex_unlock(&core_lock);
+	i2c_adapter_probe(adap);
 
 	return 0;
 
@@ -1904,6 +1919,25 @@ static int __process_removed_adapter(struct device_driver *d, void *data)
 }
 
 /**
+ * i2c_adapter_remove_probed - Remove clients that were automatically detected.
+ * @adap: The i2c adapter.
+ *
+ * This removes all i2c clients from this adapter that were added via driver
+ * detect() functions. This function is called when an adapter is removed, so
+ * there is no need to call this manually, unless you have hot-plugable i2c
+ * devices that are disconnected before the adapter is destroyed.
+ *
+ * Any clients that were added manually (e.g. via sysfs) are not removed.
+ */
+void i2c_adapter_remove_probed(struct i2c_adapter *adap)
+{
+	mutex_lock(&core_lock);
+	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_removed_adapter);
+	mutex_unlock(&core_lock);
+}
+EXPORT_SYMBOL(i2c_adapter_remove_probed);
+
+/**
  * i2c_del_adapter - unregister I2C adapter
  * @adap: the adapter being unregistered
  * Context: can sleep
@@ -1927,10 +1961,7 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	acpi_i2c_remove_space_handler(adap);
 	/* Tell drivers about this removal */
-	mutex_lock(&core_lock);
-	bus_for_each_drv(&i2c_bus_type, NULL, adap,
-			       __process_removed_adapter);
-	mutex_unlock(&core_lock);
+	i2c_adapter_remove_probed(adap);
 
 	/* Remove devices instantiated from sysfs */
 	mutex_lock_nested(&adap->userspace_clients_lock,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 3eab858..0016623 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -657,6 +657,9 @@ extern int i2c_add_adapter(struct i2c_adapter *);
 extern void i2c_del_adapter(struct i2c_adapter *);
 extern int i2c_add_numbered_adapter(struct i2c_adapter *);
 
+extern void i2c_adapter_probe(struct i2c_adapter *adap);
+extern void i2c_adapter_remove_probed(struct i2c_adapter *adap);
+
 extern int i2c_register_driver(struct module *, struct i2c_driver *);
 extern void i2c_del_driver(struct i2c_driver *);
 
-- 
2.7.4
