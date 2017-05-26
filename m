From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/8] i2c: break out slave support into seperate file
Date: Fri, 26 May 2017 10:20:53 +0200
Message-ID: <20170526082101.4746-3-wsa@the-dreams.de>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Also removes some ifdeffery.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/Makefile         |   1 +
 drivers/i2c/i2c-core-base.c  | 102 +-------------------------------------
 drivers/i2c/i2c-core-slave.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.h       |   1 +
 4 files changed, 118 insertions(+), 101 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-slave.c

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index d459c7e5907607..6c54716e7f28ca 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
 i2c-core-objs 			:= i2c-core-base.o
+i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
 
 obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 82576aaccc909b..88c0ca664a7b8f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -24,7 +24,6 @@
    (c) 2013  Wolfram Sang <wsa@the-dreams.de>
    I2C ACPI code Copyright (C) 2014 Intel Corp
    Author: Lan Tianyu <tianyu.lan@intel.com>
-   I2C slave support (c) 2014 by Wolfram Sang <wsa@sang-engineering.com>
  */
 
 #define pr_fmt(fmt) "i2c-core: " fmt
@@ -1213,7 +1212,7 @@ static int i2c_check_addr_validity(unsigned addr, unsigned short flags)
  * device uses a reserved address, then it shouldn't be probed. 7-bit
  * addressing is assumed, 10-bit address devices are rare and should be
  * explicitly enumerated. */
-static int i2c_check_7bit_addr_validity_strict(unsigned short addr)
+int i2c_check_7bit_addr_validity_strict(unsigned short addr)
 {
 	/*
 	 * Reserved addresses per I2C specification:
@@ -3727,105 +3726,6 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 }
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);
 
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
-int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
-{
-	int ret;
-
-	if (!client || !slave_cb) {
-		WARN(1, "insufficient data\n");
-		return -EINVAL;
-	}
-
-	if (!(client->flags & I2C_CLIENT_SLAVE))
-		dev_warn(&client->dev, "%s: client slave flag not set. You might see address collisions\n",
-			 __func__);
-
-	if (!(client->flags & I2C_CLIENT_TEN)) {
-		/* Enforce stricter address checking */
-		ret = i2c_check_7bit_addr_validity_strict(client->addr);
-		if (ret) {
-			dev_err(&client->dev, "%s: invalid address\n", __func__);
-			return ret;
-		}
-	}
-
-	if (!client->adapter->algo->reg_slave) {
-		dev_err(&client->dev, "%s: not supported by adapter\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	client->slave_cb = slave_cb;
-
-	i2c_lock_adapter(client->adapter);
-	ret = client->adapter->algo->reg_slave(client);
-	i2c_unlock_adapter(client->adapter);
-
-	if (ret) {
-		client->slave_cb = NULL;
-		dev_err(&client->dev, "%s: adapter returned error %d\n", __func__, ret);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(i2c_slave_register);
-
-int i2c_slave_unregister(struct i2c_client *client)
-{
-	int ret;
-
-	if (!client->adapter->algo->unreg_slave) {
-		dev_err(&client->dev, "%s: not supported by adapter\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	i2c_lock_adapter(client->adapter);
-	ret = client->adapter->algo->unreg_slave(client);
-	i2c_unlock_adapter(client->adapter);
-
-	if (ret == 0)
-		client->slave_cb = NULL;
-	else
-		dev_err(&client->dev, "%s: adapter returned error %d\n", __func__, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(i2c_slave_unregister);
-
-/**
- * i2c_detect_slave_mode - detect operation mode
- * @dev: The device owning the bus
- *
- * This checks the device nodes for an I2C slave by checking the address
- * used in the reg property. If the address match the I2C_OWN_SLAVE_ADDRESS
- * flag this means the device is configured to act as a I2C slave and it will
- * be listening at that address.
- *
- * Returns true if an I2C own slave address is detected, otherwise returns
- * false.
- */
-bool i2c_detect_slave_mode(struct device *dev)
-{
-	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
-		struct device_node *child;
-		u32 reg;
-
-		for_each_child_of_node(dev->of_node, child) {
-			of_property_read_u32(child, "reg", &reg);
-			if (reg & I2C_OWN_SLAVE_ADDRESS) {
-				of_node_put(child);
-				return true;
-			}
-		}
-	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
-		dev_dbg(dev, "ACPI slave is not supported yet\n");
-	}
-	return false;
-}
-EXPORT_SYMBOL_GPL(i2c_detect_slave_mode);
-
-#endif
-
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
new file mode 100644
index 00000000000000..4a78c65e997133
--- /dev/null
+++ b/drivers/i2c/i2c-core-slave.c
@@ -0,0 +1,115 @@
+/*
+ * Linux I2C core slave support code
+ *
+ * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <dt-bindings/i2c/i2c.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+
+#include "i2c-core.h"
+
+int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
+{
+	int ret;
+
+	if (!client || !slave_cb) {
+		WARN(1, "insufficient data\n");
+		return -EINVAL;
+	}
+
+	if (!(client->flags & I2C_CLIENT_SLAVE))
+		dev_warn(&client->dev, "%s: client slave flag not set. You might see address collisions\n",
+			 __func__);
+
+	if (!(client->flags & I2C_CLIENT_TEN)) {
+		/* Enforce stricter address checking */
+		ret = i2c_check_7bit_addr_validity_strict(client->addr);
+		if (ret) {
+			dev_err(&client->dev, "%s: invalid address\n", __func__);
+			return ret;
+		}
+	}
+
+	if (!client->adapter->algo->reg_slave) {
+		dev_err(&client->dev, "%s: not supported by adapter\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	client->slave_cb = slave_cb;
+
+	i2c_lock_adapter(client->adapter);
+	ret = client->adapter->algo->reg_slave(client);
+	i2c_unlock_adapter(client->adapter);
+
+	if (ret) {
+		client->slave_cb = NULL;
+		dev_err(&client->dev, "%s: adapter returned error %d\n", __func__, ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_slave_register);
+
+int i2c_slave_unregister(struct i2c_client *client)
+{
+	int ret;
+
+	if (!client->adapter->algo->unreg_slave) {
+		dev_err(&client->dev, "%s: not supported by adapter\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	i2c_lock_adapter(client->adapter);
+	ret = client->adapter->algo->unreg_slave(client);
+	i2c_unlock_adapter(client->adapter);
+
+	if (ret == 0)
+		client->slave_cb = NULL;
+	else
+		dev_err(&client->dev, "%s: adapter returned error %d\n", __func__, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+
+/**
+ * i2c_detect_slave_mode - detect operation mode
+ * @dev: The device owning the bus
+ *
+ * This checks the device nodes for an I2C slave by checking the address
+ * used in the reg property. If the address match the I2C_OWN_SLAVE_ADDRESS
+ * flag this means the device is configured to act as a I2C slave and it will
+ * be listening at that address.
+ *
+ * Returns true if an I2C own slave address is detected, otherwise returns
+ * false.
+ */
+bool i2c_detect_slave_mode(struct device *dev)
+{
+	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
+		struct device_node *child;
+		u32 reg;
+
+		for_each_child_of_node(dev->of_node, child) {
+			of_property_read_u32(child, "reg", &reg);
+			if (reg & I2C_OWN_SLAVE_ADDRESS) {
+				of_node_put(child);
+				return true;
+			}
+		}
+	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
+		dev_dbg(dev, "ACPI slave is not supported yet\n");
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(i2c_detect_slave_mode);
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 17700bfddcf58f..77c22b03ff951e 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -27,3 +27,4 @@ extern struct rw_semaphore	__i2c_board_lock;
 extern struct list_head	__i2c_board_list;
 extern int		__i2c_first_dynamic_bus_num;
 
+int i2c_check_7bit_addr_validity_strict(unsigned short addr);
-- 
2.11.0
