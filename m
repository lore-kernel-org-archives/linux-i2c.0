From: "Frkuska, Joshua" <joshua_frkuska-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 1/1] i2c: core: add of_get_i2c_adapter_by_node
Date: Mon, 29 Jun 2015 15:36:19 +0900
Message-ID: <5590E763.3090703@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This adds of_get_i2c_adapter_by_node which both finds and properly
increments the adapter reference count.

This is different from of_find_i2c_device_by_node which does not
increment the adapter reference counter.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joshua Frkuska <joshua_frkuska-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
  drivers/i2c/i2c-core.c | 20 ++++++++++++++++++++
  1 file changed, 20 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124..97caec6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1347,6 +1347,26 @@ struct i2c_adapter 
*of_find_i2c_adapter_by_node(struct device_node *node)
      return i2c_verify_adapter(dev);
  }
  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
+
+/* must call put_device() when done with returned i2c_adapter device */
+struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
+{
+    struct device *dev;
+    struct i2c_adapter *adapter;
+
+    dev = bus_find_device(&i2c_bus_type, NULL, node,
+                of_dev_node_match);
+    if (!dev)
+        return NULL;
+
+    adapter = i2c_verify_adapter(dev);
+
+    if (adapter && !try_module_get(adapter->owner))
+        adapter = NULL;
+
+    return adapter;
+}
+EXPORT_SYMBOL(of_get_i2c_adapter_by_node);
  #else
  static void of_i2c_register_devices(struct i2c_adapter *adap) { }
  #endif /* CONFIG_OF */

-- 
Joshua Frkuska | Embedded Software Engineer
Mentor Embedded Software Division
Mentor Graphics Japan Co., ltd.
