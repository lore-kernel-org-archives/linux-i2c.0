From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/8] i2c: break out OF support into seperate file
Date: Fri, 26 May 2017 10:20:55 +0200
Message-ID: <20170526082101.4746-5-wsa@the-dreams.de>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Also removes some ifdeffery.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/Makefile        |   1 +
 drivers/i2c/i2c-core-base.c | 265 +-----------------------------------------
 drivers/i2c/i2c-core-of.c   | 276 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.h      |   8 ++
 4 files changed, 286 insertions(+), 264 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-of.c

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index a6a90fe2db887a..189e0e6476f0a6 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
 i2c-core-objs 			:= i2c-core-base.o i2c-core-smbus.o
 i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
+i2c-core-$(CONFIG_OF) 		+= i2c-core-of.o
 
 obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 70fc4624c69c25..461451da106504 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -16,9 +16,6 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>.
    Mux support by Rodolfo Giometti <giometti@enneenne.com> and
    Michael Lawnick <michael.lawnick.ext@nsn.com>
-   OF support is copyright (c) 2008 Jochen Friedrich <jochen@scram.de>
-   (based on a previous patch from Jon Smirl <jonsmirl@gmail.com>) and
-   (c) 2013  Wolfram Sang <wsa@the-dreams.de>
    I2C ACPI code Copyright (C) 2014 Intel Corp
    Author: Lan Tianyu <tianyu.lan@intel.com>
  */
@@ -1191,7 +1188,7 @@ static unsigned short i2c_encode_flags_to_addr(struct i2c_client *client)
 
 /* This is a permissive address validity check, I2C address map constraints
  * are purposely not enforced, except for the general call address. */
-static int i2c_check_addr_validity(unsigned addr, unsigned short flags)
+int i2c_check_addr_validity(unsigned addr, unsigned short flags)
 {
 	if (flags & I2C_CLIENT_TEN) {
 		/* 10-bit address, all values are valid */
@@ -1760,210 +1757,6 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 	up_read(&__i2c_board_lock);
 }
 
-/* OF support code */
-
-#if IS_ENABLED(CONFIG_OF)
-static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
-						 struct device_node *node)
-{
-	struct i2c_client *result;
-	struct i2c_board_info info = {};
-	struct dev_archdata dev_ad = {};
-	const __be32 *addr_be;
-	u32 addr;
-	int len;
-
-	dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
-
-	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
-		dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
-			node->full_name);
-		return ERR_PTR(-EINVAL);
-	}
-
-	addr_be = of_get_property(node, "reg", &len);
-	if (!addr_be || (len < sizeof(*addr_be))) {
-		dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
-			node->full_name);
-		return ERR_PTR(-EINVAL);
-	}
-
-	addr = be32_to_cpup(addr_be);
-	if (addr & I2C_TEN_BIT_ADDRESS) {
-		addr &= ~I2C_TEN_BIT_ADDRESS;
-		info.flags |= I2C_CLIENT_TEN;
-	}
-
-	if (addr & I2C_OWN_SLAVE_ADDRESS) {
-		addr &= ~I2C_OWN_SLAVE_ADDRESS;
-		info.flags |= I2C_CLIENT_SLAVE;
-	}
-
-	if (i2c_check_addr_validity(addr, info.flags)) {
-		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
-			addr, node->full_name);
-		return ERR_PTR(-EINVAL);
-	}
-
-	info.addr = addr;
-	info.of_node = of_node_get(node);
-	info.archdata = &dev_ad;
-
-	if (of_property_read_bool(node, "host-notify"))
-		info.flags |= I2C_CLIENT_HOST_NOTIFY;
-
-	if (of_get_property(node, "wakeup-source", NULL))
-		info.flags |= I2C_CLIENT_WAKE;
-
-	result = i2c_new_device(adap, &info);
-	if (result == NULL) {
-		dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
-			node->full_name);
-		of_node_put(node);
-		return ERR_PTR(-EINVAL);
-	}
-	return result;
-}
-
-static void of_i2c_register_devices(struct i2c_adapter *adap)
-{
-	struct device_node *bus, *node;
-	struct i2c_client *client;
-
-	/* Only register child devices if the adapter has a node pointer set */
-	if (!adap->dev.of_node)
-		return;
-
-	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
-
-	bus = of_get_child_by_name(adap->dev.of_node, "i2c-bus");
-	if (!bus)
-		bus = of_node_get(adap->dev.of_node);
-
-	for_each_available_child_of_node(bus, node) {
-		if (of_node_test_and_set_flag(node, OF_POPULATED))
-			continue;
-
-		client = of_i2c_register_device(adap, node);
-		if (IS_ERR(client)) {
-			dev_warn(&adap->dev,
-				 "Failed to create I2C device for %s\n",
-				 node->full_name);
-			of_node_clear_flag(node, OF_POPULATED);
-		}
-	}
-
-	of_node_put(bus);
-}
-
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-/* must call put_device() when done with returned i2c_client device */
-struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
-{
-	struct device *dev;
-	struct i2c_client *client;
-
-	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
-	if (!dev)
-		return NULL;
-
-	client = i2c_verify_client(dev);
-	if (!client)
-		put_device(dev);
-
-	return client;
-}
-EXPORT_SYMBOL(of_find_i2c_device_by_node);
-
-/* must call put_device() when done with returned i2c_adapter device */
-struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
-{
-	struct device *dev;
-	struct i2c_adapter *adapter;
-
-	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
-	if (!dev)
-		return NULL;
-
-	adapter = i2c_verify_adapter(dev);
-	if (!adapter)
-		put_device(dev);
-
-	return adapter;
-}
-EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
-
-/* must call i2c_put_adapter() when done with returned i2c_adapter device */
-struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
-{
-	struct i2c_adapter *adapter;
-
-	adapter = of_find_i2c_adapter_by_node(node);
-	if (!adapter)
-		return NULL;
-
-	if (!try_module_get(adapter->owner)) {
-		put_device(&adapter->dev);
-		adapter = NULL;
-	}
-
-	return adapter;
-}
-EXPORT_SYMBOL(of_get_i2c_adapter_by_node);
-
-static const struct of_device_id*
-i2c_of_match_device_sysfs(const struct of_device_id *matches,
-				  struct i2c_client *client)
-{
-	const char *name;
-
-	for (; matches->compatible[0]; matches++) {
-		/*
-		 * Adding devices through the i2c sysfs interface provides us
-		 * a string to match which may be compatible with the device
-		 * tree compatible strings, however with no actual of_node the
-		 * of_match_device() will not match
-		 */
-		if (sysfs_streq(client->name, matches->compatible))
-			return matches;
-
-		name = strchr(matches->compatible, ',');
-		if (!name)
-			name = matches->compatible;
-		else
-			name++;
-
-		if (sysfs_streq(client->name, name))
-			return matches;
-	}
-
-	return NULL;
-}
-
-const struct of_device_id
-*i2c_of_match_device(const struct of_device_id *matches,
-		     struct i2c_client *client)
-{
-	const struct of_device_id *match;
-
-	if (!(client && matches))
-		return NULL;
-
-	match = of_match_device(matches, &client->dev);
-	if (match)
-		return match;
-
-	return i2c_of_match_device_sysfs(matches, client);
-}
-EXPORT_SYMBOL_GPL(i2c_of_match_device);
-#else
-static void of_i2c_register_devices(struct i2c_adapter *adap) { }
-#endif /* CONFIG_OF */
-
 static int i2c_do_add_adapter(struct i2c_driver *driver,
 			      struct i2c_adapter *adap)
 {
@@ -2558,62 +2351,6 @@ void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void *arg)
 }
 EXPORT_SYMBOL(i2c_clients_command);
 
-#if IS_ENABLED(CONFIG_OF_DYNAMIC)
-static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
-			 void *arg)
-{
-	struct of_reconfig_data *rd = arg;
-	struct i2c_adapter *adap;
-	struct i2c_client *client;
-
-	switch (of_reconfig_get_state_change(action, rd)) {
-	case OF_RECONFIG_CHANGE_ADD:
-		adap = of_find_i2c_adapter_by_node(rd->dn->parent);
-		if (adap == NULL)
-			return NOTIFY_OK;	/* not for us */
-
-		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
-			put_device(&adap->dev);
-			return NOTIFY_OK;
-		}
-
-		client = of_i2c_register_device(adap, rd->dn);
-		put_device(&adap->dev);
-
-		if (IS_ERR(client)) {
-			dev_err(&adap->dev, "failed to create client for '%s'\n",
-				 rd->dn->full_name);
-			of_node_clear_flag(rd->dn, OF_POPULATED);
-			return notifier_from_errno(PTR_ERR(client));
-		}
-		break;
-	case OF_RECONFIG_CHANGE_REMOVE:
-		/* already depopulated? */
-		if (!of_node_check_flag(rd->dn, OF_POPULATED))
-			return NOTIFY_OK;
-
-		/* find our device by node */
-		client = of_find_i2c_device_by_node(rd->dn);
-		if (client == NULL)
-			return NOTIFY_OK;	/* no? not meant for us */
-
-		/* unregister takes one ref away */
-		i2c_unregister_device(client);
-
-		/* and put the reference of the find */
-		put_device(&client->dev);
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-static struct notifier_block i2c_of_notifier = {
-	.notifier_call = of_i2c_notify,
-};
-#else
-extern struct notifier_block i2c_of_notifier;
-#endif /* CONFIG_OF_DYNAMIC */
-
 static int __init i2c_init(void)
 {
 	int retval;
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
new file mode 100644
index 00000000000000..ccf82fdbcd8e7b
--- /dev/null
+++ b/drivers/i2c/i2c-core-of.c
@@ -0,0 +1,276 @@
+/*
+ * Linux I2C core OF support code
+ *
+ * Copyright (C) 2008 Jochen Friedrich <jochen@scram.de>
+ * based on a previous patch from Jon Smirl <jonsmirl@gmail.com>
+ *
+ * Copyright (C) 2013 Wolfram Sang <wsa@the-dreams.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <dt-bindings/i2c/i2c.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "i2c-core.h"
+
+static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
+						 struct device_node *node)
+{
+	struct i2c_client *result;
+	struct i2c_board_info info = {};
+	struct dev_archdata dev_ad = {};
+	const __be32 *addr_be;
+	u32 addr;
+	int len;
+
+	dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
+
+	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
+		dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
+			node->full_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	addr_be = of_get_property(node, "reg", &len);
+	if (!addr_be || (len < sizeof(*addr_be))) {
+		dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
+			node->full_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	addr = be32_to_cpup(addr_be);
+	if (addr & I2C_TEN_BIT_ADDRESS) {
+		addr &= ~I2C_TEN_BIT_ADDRESS;
+		info.flags |= I2C_CLIENT_TEN;
+	}
+
+	if (addr & I2C_OWN_SLAVE_ADDRESS) {
+		addr &= ~I2C_OWN_SLAVE_ADDRESS;
+		info.flags |= I2C_CLIENT_SLAVE;
+	}
+
+	if (i2c_check_addr_validity(addr, info.flags)) {
+		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
+			addr, node->full_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	info.addr = addr;
+	info.of_node = of_node_get(node);
+	info.archdata = &dev_ad;
+
+	if (of_property_read_bool(node, "host-notify"))
+		info.flags |= I2C_CLIENT_HOST_NOTIFY;
+
+	if (of_get_property(node, "wakeup-source", NULL))
+		info.flags |= I2C_CLIENT_WAKE;
+
+	result = i2c_new_device(adap, &info);
+	if (result == NULL) {
+		dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
+			node->full_name);
+		of_node_put(node);
+		return ERR_PTR(-EINVAL);
+	}
+	return result;
+}
+
+void of_i2c_register_devices(struct i2c_adapter *adap)
+{
+	struct device_node *bus, *node;
+	struct i2c_client *client;
+
+	/* Only register child devices if the adapter has a node pointer set */
+	if (!adap->dev.of_node)
+		return;
+
+	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
+
+	bus = of_get_child_by_name(adap->dev.of_node, "i2c-bus");
+	if (!bus)
+		bus = of_node_get(adap->dev.of_node);
+
+	for_each_available_child_of_node(bus, node) {
+		if (of_node_test_and_set_flag(node, OF_POPULATED))
+			continue;
+
+		client = of_i2c_register_device(adap, node);
+		if (IS_ERR(client)) {
+			dev_warn(&adap->dev,
+				 "Failed to create I2C device for %s\n",
+				 node->full_name);
+			of_node_clear_flag(node, OF_POPULATED);
+		}
+	}
+
+	of_node_put(bus);
+}
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+/* must call put_device() when done with returned i2c_client device */
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	struct device *dev;
+	struct i2c_client *client;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	if (!dev)
+		return NULL;
+
+	client = i2c_verify_client(dev);
+	if (!client)
+		put_device(dev);
+
+	return client;
+}
+EXPORT_SYMBOL(of_find_i2c_device_by_node);
+
+/* must call put_device() when done with returned i2c_adapter device */
+struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
+{
+	struct device *dev;
+	struct i2c_adapter *adapter;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	if (!dev)
+		return NULL;
+
+	adapter = i2c_verify_adapter(dev);
+	if (!adapter)
+		put_device(dev);
+
+	return adapter;
+}
+EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
+
+/* must call i2c_put_adapter() when done with returned i2c_adapter device */
+struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
+{
+	struct i2c_adapter *adapter;
+
+	adapter = of_find_i2c_adapter_by_node(node);
+	if (!adapter)
+		return NULL;
+
+	if (!try_module_get(adapter->owner)) {
+		put_device(&adapter->dev);
+		adapter = NULL;
+	}
+
+	return adapter;
+}
+EXPORT_SYMBOL(of_get_i2c_adapter_by_node);
+
+static const struct of_device_id*
+i2c_of_match_device_sysfs(const struct of_device_id *matches,
+				  struct i2c_client *client)
+{
+	const char *name;
+
+	for (; matches->compatible[0]; matches++) {
+		/*
+		 * Adding devices through the i2c sysfs interface provides us
+		 * a string to match which may be compatible with the device
+		 * tree compatible strings, however with no actual of_node the
+		 * of_match_device() will not match
+		 */
+		if (sysfs_streq(client->name, matches->compatible))
+			return matches;
+
+		name = strchr(matches->compatible, ',');
+		if (!name)
+			name = matches->compatible;
+		else
+			name++;
+
+		if (sysfs_streq(client->name, name))
+			return matches;
+	}
+
+	return NULL;
+}
+
+const struct of_device_id
+*i2c_of_match_device(const struct of_device_id *matches,
+		     struct i2c_client *client)
+{
+	const struct of_device_id *match;
+
+	if (!(client && matches))
+		return NULL;
+
+	match = of_match_device(matches, &client->dev);
+	if (match)
+		return match;
+
+	return i2c_of_match_device_sysfs(matches, client);
+}
+EXPORT_SYMBOL_GPL(i2c_of_match_device);
+
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
+			 void *arg)
+{
+	struct of_reconfig_data *rd = arg;
+	struct i2c_adapter *adap;
+	struct i2c_client *client;
+
+	switch (of_reconfig_get_state_change(action, rd)) {
+	case OF_RECONFIG_CHANGE_ADD:
+		adap = of_find_i2c_adapter_by_node(rd->dn->parent);
+		if (adap == NULL)
+			return NOTIFY_OK;	/* not for us */
+
+		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
+			put_device(&adap->dev);
+			return NOTIFY_OK;
+		}
+
+		client = of_i2c_register_device(adap, rd->dn);
+		put_device(&adap->dev);
+
+		if (IS_ERR(client)) {
+			dev_err(&adap->dev, "failed to create client for '%s'\n",
+				 rd->dn->full_name);
+			of_node_clear_flag(rd->dn, OF_POPULATED);
+			return notifier_from_errno(PTR_ERR(client));
+		}
+		break;
+	case OF_RECONFIG_CHANGE_REMOVE:
+		/* already depopulated? */
+		if (!of_node_check_flag(rd->dn, OF_POPULATED))
+			return NOTIFY_OK;
+
+		/* find our device by node */
+		client = of_find_i2c_device_by_node(rd->dn);
+		if (client == NULL)
+			return NOTIFY_OK;	/* no? not meant for us */
+
+		/* unregister takes one ref away */
+		i2c_unregister_device(client);
+
+		/* and put the reference of the find */
+		put_device(&client->dev);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+struct notifier_block i2c_of_notifier = {
+	.notifier_call = of_i2c_notify,
+};
+#endif /* CONFIG_OF_DYNAMIC */
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 77c22b03ff951e..22151c88e88599 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -27,4 +27,12 @@ extern struct rw_semaphore	__i2c_board_lock;
 extern struct list_head	__i2c_board_list;
 extern int		__i2c_first_dynamic_bus_num;
 
+int i2c_check_addr_validity(unsigned addr, unsigned short flags);
 int i2c_check_7bit_addr_validity_strict(unsigned short addr);
+
+#ifdef CONFIG_OF
+void of_i2c_register_devices(struct i2c_adapter *adap);
+#else
+static inline void of_i2c_register_devices(struct i2c_adapter *adap) { }
+#endif
+extern struct notifier_block i2c_of_notifier;
-- 
2.11.0
