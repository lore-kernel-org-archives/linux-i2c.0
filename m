From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/3] i2c: core: Add function for finding the bus speed from ACPI
Date: Mon,  6 Jun 2016 14:26:22 +0300
Message-ID: <1465212383-24639-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45884 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbcFFL0h (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 6 Jun 2016 07:26:37 -0400
In-Reply-To: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

ACPI 5 specification doesn't have property for the I2C bus speed but
I2cSerialBus resource descriptors which define each controller-slave
connection define the maximum speed supported by that connection.

Thus finding the maximum safe speed for the bus is to walk all
I2cSerialBus resources that are associated to I2C controller and use
the speed of slowest connection.

Add function i2c_acpi_find_bus_speed() to the i2c-core that adapter
drivers can call prior registering itself to core.

This implies two-step walk through the I2cSerialBus resources: call to
i2c_acpi_find_bus_speed() does the first scan and finds the safe bus
speed that adapter drivers can set up. Adapter driver registration does
the second scan when i2c-core creates the I2C slaves by calling the
i2c_acpi_register_devices(). In that way the bus speed is set in case
slave device probe gets called during registration and does
communication.

Implement this by reusing the existing ACPI I2C walk routines in the
i2c-core. Extend them so that slowest connection speed is saved during
the walk and I2C slaves are registered only when calling through the
i2c_acpi_register_devices() with the i2c_adapter pointer.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/i2c-core.c | 74 ++++++++++++++++++++++++++++++++++++++++----------
 include/linux/i2c.h    |  9 ++++++
 2 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f6a85fa3f10a..99ae7dcf7768 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -103,11 +103,13 @@ struct gsb_buffer {
 
 struct i2c_acpi_lookup {
 	struct i2c_board_info *info;
+	struct i2c_adapter *adapter; /* set only when registering slaves */
 	acpi_handle adapter_handle;
 	acpi_handle device_handle;
+	u32 min_speed;
 };
 
-static int i2c_acpi_find_address(struct acpi_resource *ares, void *data)
+static int i2c_acpi_find_resource(struct acpi_resource *ares, void *data)
 {
 	struct i2c_acpi_lookup *lookup = data;
 	struct i2c_board_info *info = lookup->info;
@@ -133,17 +135,20 @@ static int i2c_acpi_find_address(struct acpi_resource *ares, void *data)
 		info->addr = sb->slave_address;
 		if (sb->access_mode == ACPI_I2C_10BIT_MODE)
 			info->flags |= I2C_CLIENT_TEN;
+		/* Save speed of the slowest device */
+		if (sb->connection_speed < lookup->min_speed)
+			lookup->min_speed = sb->connection_speed;
 	}
 
 	return 1;
 }
 
-static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
-				       void *data, void **return_value)
+static acpi_status i2c_acpi_slave_lookup(acpi_handle handle, u32 level,
+					 void *data, void **return_value)
 {
-	struct i2c_adapter *adapter = data;
+	struct i2c_acpi_lookup *lookup = data;
+	struct i2c_adapter *adapter = lookup->adapter;
 	struct list_head resource_list;
-	struct i2c_acpi_lookup lookup;
 	struct resource_entry *entry;
 	struct i2c_board_info info;
 	struct acpi_device *adev;
@@ -157,10 +162,8 @@ static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 	memset(&info, 0, sizeof(info));
 	info.fwnode = acpi_fwnode_handle(adev);
 
-	memset(&lookup, 0, sizeof(lookup));
-	lookup.adapter_handle = ACPI_HANDLE(&adapter->dev);
-	lookup.device_handle = handle;
-	lookup.info = &info;
+	lookup->device_handle = handle;
+	lookup->info = &info;
 
 	/*
 	 * Look up for I2cSerialBus resource with ResourceSource that
@@ -168,10 +171,10 @@ static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 	 */
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
-				     i2c_acpi_find_address, &lookup);
+				     i2c_acpi_find_resource, lookup);
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (ret < 0 || !info.addr)
+	if (ret < 0 || !info.addr || !lookup->adapter)
 		return AE_OK;
 
 	/* Then fill IRQ number if any */
@@ -202,6 +205,14 @@ static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 
 #define I2C_ACPI_MAX_SCAN_DEPTH 32
 
+static acpi_status i2c_acpi_walk(struct i2c_acpi_lookup *lookup)
+{
+	return acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				   I2C_ACPI_MAX_SCAN_DEPTH,
+				   i2c_acpi_slave_lookup, NULL,
+				   lookup, NULL);
+}
+
 /**
  * i2c_acpi_register_devices - enumerate I2C slave devices behind adapter
  * @adap: pointer to adapter
@@ -212,19 +223,52 @@ static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
  */
 static void i2c_acpi_register_devices(struct i2c_adapter *adap)
 {
+	struct i2c_acpi_lookup lookup;
 	acpi_status status;
 
 	if (!has_acpi_companion(&adap->dev))
 		return;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     I2C_ACPI_MAX_SCAN_DEPTH,
-				     i2c_acpi_add_device, NULL,
-				     adap, NULL);
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.adapter = adap;
+	lookup.adapter_handle = ACPI_HANDLE(&adap->dev);
+
+	status = i2c_acpi_walk(&lookup);
 	if (ACPI_FAILURE(status))
 		dev_warn(&adap->dev, "failed to enumerate I2C slaves\n");
 }
 
+/**
+ * i2c_acpi_find_bus_speed - find I2C bus speed from ACPI
+ * @dev: The device owning the bus
+ *
+ * Find the I2C bus speed by walking the ACPI namespace for all I2C slaves
+ * devices connected to this bus and use the speed of slowest device.
+ *
+ * Returns the speed in Hz or zero
+ */
+u32 i2c_acpi_find_bus_speed(struct device *dev)
+{
+	struct i2c_acpi_lookup lookup;
+	acpi_status status;
+
+	if (!has_acpi_companion(dev))
+		return 0;
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.adapter_handle = ACPI_HANDLE(dev);
+	lookup.min_speed = UINT_MAX;
+
+	status = i2c_acpi_walk(&lookup);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "unable to find I2C bus speed from ACPI\n");
+		return 0;
+	}
+
+	return lookup.min_speed != UINT_MAX ? lookup.min_speed : 0;
+}
+EXPORT_SYMBOL_GPL(i2c_acpi_find_bus_speed);
+
 #else /* CONFIG_ACPI */
 static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
 #endif /* CONFIG_ACPI */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 96a25ae14494..9959ba26bc37 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -753,4 +753,13 @@ static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node
 }
 #endif /* CONFIG_OF */
 
+#if IS_ENABLED(CONFIG_ACPI)
+u32 i2c_acpi_find_bus_speed(struct device *dev);
+#else
+static inline u32 i2c_acpi_find_bus_speed(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_ACPI */
+
 #endif /* _LINUX_I2C_H */
-- 
2.8.1
