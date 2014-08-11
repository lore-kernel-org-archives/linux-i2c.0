From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/2] i2c / ACPI: Add support for extracting multiple I2C addresses
Date: Mon, 11 Aug 2014 14:28:55 -0700
Message-ID: <1407792535-21681-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1407792535-21681-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407792535-21681-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Some I2C devices can have multiple addresses and this is allowed by the
ACPI specification as well. However, it doesn't specify how these addresses
should be interpreted but leaves it up to the OS/drivers to deal with.

Since we can't tell in a generic code whether it is a single device with
multiple addresses (like I2C attached EEPROM) or a multifunction device, we
let the corresponding first level device's driver to decide how to best
handle the addresses assigned to it.

To make driver writers life a bit easier, we add two new helper functions:
i2c_address_by_index() and i2c_num_addressess() which can be used to
extract all addresses for a given device.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |   5 ++
 2 files changed, 173 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 31b9341..abd45c6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1122,6 +1122,113 @@ static void of_i2c_register_devices(struct i2c_adapter *adap) { }
 /* ACPI support code */
 
 #if IS_ENABLED(CONFIG_ACPI)
+struct acpi_i2c_lookup {
+	struct i2c_board_info *info;
+	struct i2c_adapter *adapter;
+	bool found;
+	int index;
+	int n;
+};
+
+static int acpi_i2c_match_adapter(struct device *dev, void *data)
+{
+	return !!i2c_verify_adapter(dev);
+}
+
+static int acpi_i2c_find(struct acpi_resource *ares, void *data)
+{
+	struct acpi_i2c_lookup *lookup = data;
+	struct acpi_resource_i2c_serialbus *sb;
+	struct acpi_device_physical_node *phys;
+	struct acpi_device *adev;
+	acpi_status status;
+	acpi_handle handle;
+	char *path;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	sb = &ares->data.i2c_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
+		return 1;
+
+	if (lookup->n++ != lookup->index)
+		return 1;
+
+	/*
+	 * Need to look up the adapter from ACPI namespace and translate it
+	 * to a physical device. That device should be existing I2C
+	 * adapter.
+	 */
+	path = sb->resource_source.string_ptr;
+	status = acpi_get_handle(ACPI_ROOT_OBJECT, path, &handle);
+	if (ACPI_FAILURE(status) || acpi_bus_get_device(handle, &adev))
+		return 1;
+
+	mutex_lock(&adev->physical_node_lock);
+	list_for_each_entry(phys, &adev->physical_node_list, node) {
+		struct device *dev;
+
+		dev = device_find_child(phys->dev, NULL,
+					acpi_i2c_match_adapter);
+		if (dev) {
+			lookup->adapter = to_i2c_adapter(dev);
+			break;
+		}
+	}
+	mutex_unlock(&adev->physical_node_lock);
+
+	if (!lookup->adapter)
+		return 1;
+
+	if (lookup->info) {
+		lookup->info->addr = sb->slave_address;
+		if (sb->access_mode == ACPI_I2C_10BIT_MODE)
+			lookup->info->flags |= I2C_CLIENT_TEN;
+	}
+
+	lookup->found = true;
+	return 1;
+}
+
+static int acpi_i2c_address_by_index(struct i2c_client *client, int index,
+				     struct i2c_board_info *info,
+				     struct i2c_adapter **adapter)
+{
+	struct acpi_i2c_lookup lookup;
+	struct acpi_device *adev;
+	LIST_HEAD(resources);
+	int ret;
+
+	adev = ACPI_COMPANION(&client->dev);
+	if (!adev)
+		return -ENODEV;
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.index = index;
+	lookup.info = info;
+
+	ret = acpi_dev_get_resources(adev, &resources, acpi_i2c_find, &lookup);
+	acpi_dev_free_resource_list(&resources);
+	if (ret < 0)
+		return ret;
+
+	if (lookup.found) {
+		if (!adapter) {
+			/*
+			 * Caller is not interested in the adapter so we
+			 * will release it now. Otherwise it is up to the
+			 * caller to call put_device() for it.
+			 */
+			put_device(&lookup.adapter->dev);
+		} else {
+			*adapter = lookup.adapter;
+		}
+	}
+
+	return lookup.found ? 0 : -EADDRNOTAVAIL;
+}
+
 static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct i2c_board_info *info = data;
@@ -1230,6 +1337,67 @@ static void acpi_i2c_register_devices(struct i2c_adapter *adap)
 static inline void acpi_i2c_register_devices(struct i2c_adapter *adap) {}
 #endif /* CONFIG_ACPI */
 
+/**
+ * i2c_address_by_index - Return an I2C address for a device
+ * @client: the client with multiple addresses
+ * @index: index of the additional address
+ * @info: pointer to board info which is filled in
+ * @adapter: adapter on which bus the address is is stored here
+ *
+ * In case of an I2C device with multiple addresses this function can be
+ * used to look up those additional addresses. Returns %0 if the address
+ * with given @index is found or %-EADDRNOTAVAIL if no such address is
+ * found. Note that the function returns address of the current @client as
+ * well so callers need to check against that if necessary.
+ *
+ * Note that the caller must do put_device() to the @adapter->dev once it
+ * is not used anymore.
+ */
+int i2c_address_by_index(struct i2c_client *client, int index,
+			 struct i2c_board_info *info,
+			 struct i2c_adapter **adapter)
+{
+	if (IS_ENABLED(CONFIG_ACPI))
+		return acpi_i2c_address_by_index(client, index, info, adapter);
+
+	/*
+	 * Normal case means that the address at index zero is the address
+	 * of the current client device.
+	 */
+	if (!index) {
+		if (info) {
+			info->addr = client->addr;
+			info->flags = client->flags;
+			info->irq = client->irq;
+		}
+		if (adapter)
+			*adapter = client->adapter;
+
+		return 0;
+	}
+
+	return -EADDRNOTAVAIL;
+}
+EXPORT_SYMBOL_GPL(i2c_address_by_index);
+
+/**
+ * i2c_num_addresses - Returns number of addresses given device has
+ * @client: the client with multiple addresses
+ *
+ * An I2C device that has multiple addresses can use this function to find
+ * out how many of them it has. For single address devices the function
+ * always returns %1.
+ */
+size_t i2c_num_addresses(struct i2c_client *client)
+{
+	size_t n = 0;
+
+	while (!i2c_address_by_index(client, n, NULL, NULL))
+		n++;
+	return n;
+}
+EXPORT_SYMBOL_GPL(i2c_num_addresses);
+
 static int i2c_do_add_adapter(struct i2c_driver *driver,
 			      struct i2c_adapter *adap)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b556e0a..0139d3e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -322,6 +322,11 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
 extern struct i2c_client *
 i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
+extern int i2c_address_by_index(struct i2c_client *client, int index,
+				struct i2c_board_info *info,
+				struct i2c_adapter **adapter);
+extern size_t i2c_num_addresses(struct i2c_client *client);
+
 extern void i2c_unregister_device(struct i2c_client *);
 #endif /* I2C */
 
-- 
1.7.11.7
