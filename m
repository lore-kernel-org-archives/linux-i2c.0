From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH (Option 1)] of/i2c: fix module load order issue caused by
	of_i2c.c
Date: Fri, 24 Sep 2010 16:14:53 -0600
Message-ID: <20100924221313.28357.61419.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, mikpe-1zs4UD6AkMk@public.gmane.org
Cc: rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Commit 959e85f7, "i2c: add OF-style registration and binding" caused a
module dependency loop where of_i2c.c calls functions in i2c-core, and
i2c-core calls of_i2c_register_devices() in of_i2c.  This means that
when i2c support is built as a module when CONFIG_OF is set, then
neither i2c_core nor of_i2c are able to be loaded.

This patch fixes the problem by moving the of_i2c_register_devices()
function into the body of i2c_core and renaming it to
i2c_scan_of_devices (of_i2c_register_devices is analogous to the
existing i2c_scan_static_board_info function and so should be named
similarly).  This function isn't called by any code outside of
i2c_core, and it must always be present when CONFIG_OF is selected, so
it makes sense to locate it there.  When CONFIG_OF is not selected,
of_i2c_register_devices() becomes a no-op.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/of/of_i2c.c    |   57 ---------------------------------------------
 include/linux/of_i2c.h |    7 ------
 3 files changed, 59 insertions(+), 66 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6649176..64a261b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -32,8 +32,8 @@
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/mutex.h>
-#include <linux/of_i2c.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/completion.h>
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
@@ -818,6 +818,63 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 	up_read(&__i2c_board_lock);
 }
 
+#ifdef CONFIG_OF
+void i2c_scan_of_devices(struct i2c_adapter *adap)
+{
+	void *result;
+	struct device_node *node;
+
+	/* Only register child devices if the adapter has a node pointer set */
+	if (!adap->dev.of_node)
+		return;
+
+	for_each_child_of_node(adap->dev.of_node, node) {
+		struct i2c_board_info info = {};
+		struct dev_archdata dev_ad = {};
+		const __be32 *addr;
+		int len;
+
+		dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
+		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
+			dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
+				node->full_name);
+			continue;
+		}
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || (len < sizeof(int))) {
+			dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
+				node->full_name);
+			continue;
+		}
+
+		info.addr = be32_to_cpup(addr);
+		if (info.addr > (1 << 10) - 1) {
+			dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
+				info.addr, node->full_name);
+			continue;
+		}
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		info.of_node = of_node_get(node);
+		info.archdata = &dev_ad;
+
+		request_module("%s", info.type);
+
+		result = i2c_new_device(adap, &info);
+		if (result == NULL) {
+			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
+			        node->full_name);
+			of_node_put(node);
+			irq_dispose_mapping(info.irq);
+			continue;
+		}
+	}
+}
+#else
+static inline void i2c_scan_of_devices(struct i2c_adapter *adap) { }
+#endif
+
 static int i2c_do_add_adapter(struct i2c_driver *driver,
 			      struct i2c_adapter *adap)
 {
@@ -877,7 +934,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		i2c_scan_static_board_info(adap);
 
 	/* Register devices from the device tree */
-	of_i2c_register_devices(adap);
+	i2c_scan_of_devices(adap);
 
 	/* Notify drivers */
 	mutex_lock(&core_lock);
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 0a694de..e0c3841 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -17,63 +17,6 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 
-void of_i2c_register_devices(struct i2c_adapter *adap)
-{
-	void *result;
-	struct device_node *node;
-
-	/* Only register child devices if the adapter has a node pointer set */
-	if (!adap->dev.of_node)
-		return;
-
-	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
-
-	for_each_child_of_node(adap->dev.of_node, node) {
-		struct i2c_board_info info = {};
-		struct dev_archdata dev_ad = {};
-		const __be32 *addr;
-		int len;
-
-		dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
-
-		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
-			dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
-				node->full_name);
-			continue;
-		}
-
-		addr = of_get_property(node, "reg", &len);
-		if (!addr || (len < sizeof(int))) {
-			dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
-				node->full_name);
-			continue;
-		}
-
-		info.addr = be32_to_cpup(addr);
-		if (info.addr > (1 << 10) - 1) {
-			dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
-				info.addr, node->full_name);
-			continue;
-		}
-
-		info.irq = irq_of_parse_and_map(node, 0);
-		info.of_node = of_node_get(node);
-		info.archdata = &dev_ad;
-
-		request_module("%s", info.type);
-
-		result = i2c_new_device(adap, &info);
-		if (result == NULL) {
-			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
-			        node->full_name);
-			of_node_put(node);
-			irq_dispose_mapping(info.irq);
-			continue;
-		}
-	}
-}
-EXPORT_SYMBOL(of_i2c_register_devices);
-
 static int of_dev_node_match(struct device *dev, void *data)
 {
         return dev->of_node == data;
diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 0efe8d4..1998cf8 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -15,16 +15,9 @@
 #if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
 #include <linux/i2c.h>
 
-extern void of_i2c_register_devices(struct i2c_adapter *adap);
-
 /* must call put_device() when done with returned i2c_client device */
 extern struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
 
-#else
-static inline void of_i2c_register_devices(struct i2c_adapter *adap)
-{
-	return;
-}
 #endif /* CONFIG_OF_I2C */
 
 #endif /* __LINUX_OF_I2C_H */
