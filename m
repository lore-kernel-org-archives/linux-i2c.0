From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/3] i2c: core: Cleanup I2C ACPI namespace
Date: Mon,  6 Jun 2016 14:26:21 +0300
Message-ID: <1465212383-24639-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45884 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbcFFL0e (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 6 Jun 2016 07:26:34 -0400
In-Reply-To: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

I2C ACPI enumeration was originally implemented in another module under
drivers/acpi/ but was later moved into i2c-core with added support for
I2C ACPI operation region.

Rename these acpi_i2c_ prefixed functions, structures and defines in
i2c-core to i2c_acpi_ in order to have more consistent name space.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/i2c-core.c | 54 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index af11b658984d..f6a85fa3f10a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -86,7 +86,7 @@ void i2c_transfer_trace_unreg(void)
 }
 
 #if defined(CONFIG_ACPI)
-struct acpi_i2c_handler_data {
+struct i2c_acpi_handler_data {
 	struct acpi_connection_info info;
 	struct i2c_adapter *adapter;
 };
@@ -101,15 +101,15 @@ struct gsb_buffer {
 	};
 } __packed;
 
-struct acpi_i2c_lookup {
+struct i2c_acpi_lookup {
 	struct i2c_board_info *info;
 	acpi_handle adapter_handle;
 	acpi_handle device_handle;
 };
 
-static int acpi_i2c_find_address(struct acpi_resource *ares, void *data)
+static int i2c_acpi_find_address(struct acpi_resource *ares, void *data)
 {
-	struct acpi_i2c_lookup *lookup = data;
+	struct i2c_acpi_lookup *lookup = data;
 	struct i2c_board_info *info = lookup->info;
 	struct acpi_resource_i2c_serialbus *sb;
 	acpi_handle adapter_handle;
@@ -138,12 +138,12 @@ static int acpi_i2c_find_address(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
-static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
+static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 				       void *data, void **return_value)
 {
 	struct i2c_adapter *adapter = data;
 	struct list_head resource_list;
-	struct acpi_i2c_lookup lookup;
+	struct i2c_acpi_lookup lookup;
 	struct resource_entry *entry;
 	struct i2c_board_info info;
 	struct acpi_device *adev;
@@ -168,7 +168,7 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	 */
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
-				     acpi_i2c_find_address, &lookup);
+				     i2c_acpi_find_address, &lookup);
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (ret < 0 || !info.addr)
@@ -200,17 +200,17 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
-#define ACPI_I2C_MAX_SCAN_DEPTH 32
+#define I2C_ACPI_MAX_SCAN_DEPTH 32
 
 /**
- * acpi_i2c_register_devices - enumerate I2C slave devices behind adapter
+ * i2c_acpi_register_devices - enumerate I2C slave devices behind adapter
  * @adap: pointer to adapter
  *
  * Enumerate all I2C slave devices behind this adapter by walking the ACPI
  * namespace. When a device is found it will be added to the Linux device
  * model and bound to the corresponding ACPI handle.
  */
-static void acpi_i2c_register_devices(struct i2c_adapter *adap)
+static void i2c_acpi_register_devices(struct i2c_adapter *adap)
 {
 	acpi_status status;
 
@@ -218,15 +218,15 @@ static void acpi_i2c_register_devices(struct i2c_adapter *adap)
 		return;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_I2C_MAX_SCAN_DEPTH,
-				     acpi_i2c_add_device, NULL,
+				     I2C_ACPI_MAX_SCAN_DEPTH,
+				     i2c_acpi_add_device, NULL,
 				     adap, NULL);
 	if (ACPI_FAILURE(status))
 		dev_warn(&adap->dev, "failed to enumerate I2C slaves\n");
 }
 
 #else /* CONFIG_ACPI */
-static inline void acpi_i2c_register_devices(struct i2c_adapter *adap) { }
+static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
 #endif /* CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_I2C_OPREGION
@@ -291,12 +291,12 @@ static int acpi_gsb_i2c_write_bytes(struct i2c_client *client,
 }
 
 static acpi_status
-acpi_i2c_space_handler(u32 function, acpi_physical_address command,
+i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 			u32 bits, u64 *value64,
 			void *handler_context, void *region_context)
 {
 	struct gsb_buffer *gsb = (struct gsb_buffer *)value64;
-	struct acpi_i2c_handler_data *data = handler_context;
+	struct i2c_acpi_handler_data *data = handler_context;
 	struct acpi_connection_info *info = &data->info;
 	struct acpi_resource_i2c_serialbus *sb;
 	struct i2c_adapter *adapter = data->adapter;
@@ -414,10 +414,10 @@ acpi_i2c_space_handler(u32 function, acpi_physical_address command,
 }
 
 
-static int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
+static int i2c_acpi_install_space_handler(struct i2c_adapter *adapter)
 {
 	acpi_handle handle;
-	struct acpi_i2c_handler_data *data;
+	struct i2c_acpi_handler_data *data;
 	acpi_status status;
 
 	if (!adapter->dev.parent)
@@ -428,7 +428,7 @@ static int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 	if (!handle)
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct acpi_i2c_handler_data),
+	data = kzalloc(sizeof(struct i2c_acpi_handler_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -442,7 +442,7 @@ static int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 
 	status = acpi_install_address_space_handler(handle,
 				ACPI_ADR_SPACE_GSBUS,
-				&acpi_i2c_space_handler,
+				&i2c_acpi_space_handler,
 				NULL,
 				data);
 	if (ACPI_FAILURE(status)) {
@@ -456,10 +456,10 @@ static int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 	return 0;
 }
 
-static void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter)
+static void i2c_acpi_remove_space_handler(struct i2c_adapter *adapter)
 {
 	acpi_handle handle;
-	struct acpi_i2c_handler_data *data;
+	struct i2c_acpi_handler_data *data;
 	acpi_status status;
 
 	if (!adapter->dev.parent)
@@ -472,7 +472,7 @@ static void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter)
 
 	acpi_remove_address_space_handler(handle,
 				ACPI_ADR_SPACE_GSBUS,
-				&acpi_i2c_space_handler);
+				&i2c_acpi_space_handler);
 
 	status = acpi_bus_get_private_data(handle, (void **)&data);
 	if (ACPI_SUCCESS(status))
@@ -481,10 +481,10 @@ static void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter)
 	acpi_bus_detach_private_data(handle);
 }
 #else /* CONFIG_ACPI_I2C_OPREGION */
-static inline void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter)
+static inline void i2c_acpi_remove_space_handler(struct i2c_adapter *adapter)
 { }
 
-static inline int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
+static inline int i2c_acpi_install_space_handler(struct i2c_adapter *adapter)
 { return 0; }
 #endif /* CONFIG_ACPI_I2C_OPREGION */
 
@@ -1606,8 +1606,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 exit_recovery:
 	/* create pre-declared device nodes */
 	of_i2c_register_devices(adap);
-	acpi_i2c_register_devices(adap);
-	acpi_i2c_install_space_handler(adap);
+	i2c_acpi_register_devices(adap);
+	i2c_acpi_install_space_handler(adap);
 
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
@@ -1781,7 +1781,7 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 		return;
 	}
 
-	acpi_i2c_remove_space_handler(adap);
+	i2c_acpi_remove_space_handler(adap);
 	/* Tell drivers about this removal */
 	mutex_lock(&core_lock);
 	bus_for_each_drv(&i2c_bus_type, NULL, adap,
-- 
2.8.1
