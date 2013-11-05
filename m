From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: [PATCH] of: i2c: Export single device registration method
Date: Tue,  5 Nov 2013 19:57:20 +0200
Message-ID: <1383674240-29491-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dynamically inserting i2c client device nodes requires the use
of a single device registration method. Rework and export it.

Don't be put off by the weird patch format, it's a simple move
of the operations applied on each device to a function.

Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 99 +++++++++++++++++++++++++++-----------------------
 include/linux/i2c.h    | 10 +++++
 2 files changed, 64 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3be58f8..9be6803 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -49,6 +49,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/acpi.h>
 #include <asm/uaccess.h>
+#include <linux/err.h>
 
 #include "i2c-core.h"
 
@@ -963,63 +964,71 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 /* OF support code */
 
 #if IS_ENABLED(CONFIG_OF)
-static void of_i2c_register_devices(struct i2c_adapter *adap)
+struct i2c_client *
+of_i2c_register_device(struct i2c_adapter *adap,
+		struct device_node *node)
 {
-	void *result;
-	struct device_node *node;
+	struct i2c_client *result;
+	struct i2c_board_info info = {};
+	struct dev_archdata dev_ad = {};
+	const __be32 *addr;
+	int len;
 
-	/* Only register child devices if the adapter has a node pointer set */
-	if (!adap->dev.of_node)
-		return;
+	dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
 
-	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
+	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
+		dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
+			node->full_name);
+		return ERR_PTR(-EINVAL);
+	}
 
-	for_each_available_child_of_node(adap->dev.of_node, node) {
-		struct i2c_board_info info = {};
-		struct dev_archdata dev_ad = {};
-		const __be32 *addr;
-		int len;
+	addr = of_get_property(node, "reg", &len);
+	if (!addr || (len < sizeof(int))) {
+		dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
+			node->full_name);
+		return ERR_PTR(-EINVAL);
+	}
 
-		dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
+	info.addr = be32_to_cpup(addr);
+	if (info.addr > (1 << 10) - 1) {
+		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
+			info.addr, node->full_name);
+		return ERR_PTR(-EINVAL);
+	}
 
-		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
-			dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
-				node->full_name);
-			continue;
-		}
+	info.irq = irq_of_parse_and_map(node, 0);
+	info.of_node = of_node_get(node);
+	info.archdata = &dev_ad;
 
-		addr = of_get_property(node, "reg", &len);
-		if (!addr || (len < sizeof(int))) {
-			dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
-				node->full_name);
-			continue;
-		}
+	if (of_get_property(node, "wakeup-source", NULL))
+		info.flags |= I2C_CLIENT_WAKE;
 
-		info.addr = be32_to_cpup(addr);
-		if (info.addr > (1 << 10) - 1) {
-			dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
-				info.addr, node->full_name);
-			continue;
-		}
+	request_module("%s%s", I2C_MODULE_PREFIX, info.type);
 
-		info.irq = irq_of_parse_and_map(node, 0);
-		info.of_node = of_node_get(node);
-		info.archdata = &dev_ad;
+	result = i2c_new_device(adap, &info);
+	if (result == NULL) {
+		dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
+			node->full_name);
+		of_node_put(node);
+		irq_dispose_mapping(info.irq);
+		return ERR_PTR(-EINVAL);
+	}
+	return result;
+}
+EXPORT_SYMBOL(of_i2c_register_device);
 
-		if (of_get_property(node, "wakeup-source", NULL))
-			info.flags |= I2C_CLIENT_WAKE;
+static void of_i2c_register_devices(struct i2c_adapter *adap)
+{
+	struct device_node *node;
 
-		request_module("%s%s", I2C_MODULE_PREFIX, info.type);
+	/* Only register child devices if the adapter has a node pointer set */
+	if (!adap->dev.of_node)
+		return;
 
-		result = i2c_new_device(adap, &info);
-		if (result == NULL) {
-			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
-				node->full_name);
-			of_node_put(node);
-			irq_dispose_mapping(info.irq);
-			continue;
-		}
-	}
+	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
+
+	for_each_available_child_of_node(adap->dev.of_node, node)
+		of_i2c_register_device(adap, node);
 }
 
 static int of_dev_node_match(struct device *dev, void *data)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 2ab11dc..10bcf86 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -545,6 +545,9 @@ static inline int i2c_adapter_id(struct i2c_adapter *adap)
 #endif /* I2C */
 
 #if IS_ENABLED(CONFIG_OF)
+struct i2c_client *
+of_i2c_register_device(struct i2c_adapter *adap, struct device_node *node);
+
 /* must call put_device() when done with returned i2c_client device */
 extern struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
 
@@ -553,6 +556,13 @@ extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 
 #else
 
+static inline struct i2c_client *
+of_i2c_register_device(struct i2c_adapter *adap,
+		struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 {
 	return NULL;
-- 
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
