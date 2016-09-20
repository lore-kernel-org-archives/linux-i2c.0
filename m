From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs to another adapter
Date: Tue, 20 Sep 2016 16:59:25 +0300
Message-ID: <20160920135925.45450-1-mika.westerberg@linux.intel.com>
References: <874m5ax3o4.fsf@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <874m5ax3o4.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

When enumerating I2C devices connected to an I2C adapter we scan the whole
namespace (as it is possible to have devices anywhere in that namespace,
not just below the I2C adapter device) and add each found device to the I2C
bus in question.

Now after commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI
reconfigure notifications") checking of the adapter handle to the one found
in the I2cSerialBus() resource was moved to happen after resources of the
I2C device has been parsed. This means that if the I2cSerialBus() resource
points to an adapter that does not exists in the system we still parse
those resources. This is problematic in particular because
acpi_dev_resource_interrupt() tries to configure GSI if the device also has
an Interrupt() resource. Failing to do that results errrors like this to be
printed on the console:

  [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37

To fix this we pass the I2C adapter to i2c_acpi_get_info() and make sure
the handle matches the one in the I2cSerialBus() resource before doing
anything else to the device.

Reported-and-tested-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:
  * Require that ACPI adapter device is present if !adapter
  * Fill in adapter_handle only if not NULL
  * Remove passing of adapter_handle in i2c_acpi_add_device()

 drivers/i2c/i2c-core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c61c961cf8f9..5476f906b9e0 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -168,6 +168,7 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 
 static int i2c_acpi_get_info(struct acpi_device *adev,
 			     struct i2c_board_info *info,
+			     struct i2c_adapter *adapter,
 			     acpi_handle *adapter_handle)
 {
 	struct list_head resource_list;
@@ -182,8 +183,24 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 	if (ret)
 		return ret;
 
+	if (adapter) {
+		/* The adapter must match the one in I2cSerialBus() connector */
+		if (ACPI_HANDLE(&adapter->dev) != lookup.adapter_handle)
+			return -ENODEV;
+	} else {
+		struct acpi_device *adapter_adev;
+
+		/* The adapter must be present */
+		if (acpi_bus_get_device(lookup.adapter_handle, &adapter_adev))
+			return -ENODEV;
+		if (acpi_bus_get_status(adapter_adev) ||
+		    !adapter_adev->status.present)
+			return -ENODEV;
+	}
+
 	info->fwnode = acpi_fwnode_handle(adev);
-	*adapter_handle = lookup.adapter_handle;
+	if (adapter_handle)
+		*adapter_handle = lookup.adapter_handle;
 
 	/* Then fill IRQ number if any */
 	INIT_LIST_HEAD(&resource_list);
@@ -225,16 +242,12 @@ static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 {
 	struct i2c_adapter *adapter = data;
 	struct acpi_device *adev;
-	acpi_handle adapter_handle;
 	struct i2c_board_info info;
 
 	if (acpi_bus_get_device(handle, &adev))
 		return AE_OK;
 
-	if (i2c_acpi_get_info(adev, &info, &adapter_handle))
-		return AE_OK;
-
-	if (adapter_handle != ACPI_HANDLE(&adapter->dev))
+	if (i2c_acpi_get_info(adev, &info, adapter, NULL))
 		return AE_OK;
 
 	i2c_acpi_register_device(adapter, adev, &info);
@@ -368,7 +381,7 @@ static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
 
 	switch (value) {
 	case ACPI_RECONFIG_DEVICE_ADD:
-		if (i2c_acpi_get_info(adev, &info, &adapter_handle))
+		if (i2c_acpi_get_info(adev, &info, NULL, &adapter_handle))
 			break;
 
 		adapter = i2c_acpi_find_adapter_by_handle(adapter_handle);
-- 
2.9.3
