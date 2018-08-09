From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 2/4] ACPI / scan: Create platform device for fwnodes with multiple i2c devices
Date: Thu,  9 Aug 2018 13:40:44 +0200
Message-ID: <20180809114046.21366-3-hdegoede@redhat.com>
References: <20180809114046.21366-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809114046.21366-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Some devices have multiple I2cSerialBus resources and for things to work
an i2c-client must be instantiated for each, each with its own
i2c_device_id.

Normally we only instantiate an i2c-client for the first resource, using
the ACPI HID as id.

This commit adds a list of HIDs of devices, which need multiple i2c-clients
instantiated from a single fwnode, to acpi_device_enumeration_by_parent and
makes acpi_device_enumeration_by_parent return false for these devices so
that a platform device will be instantiated.

This allows the drivers/platform/x86/i2c-multi-instantiate.c driver, which
knows which i2c_device_id to use for each resource, to bind to the fwnode
and initiate an i2c-client for each resource.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-New patch in v3 of this patch-set

Changes in v4:
-Some small code-style fixes
---
 drivers/acpi/scan.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 6799d00dd790..b51913372e21 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1540,6 +1540,18 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 {
 	struct list_head resource_list;
 	bool is_serial_bus_slave = false;
+	/*
+	 * These devices have multiple I2cSerialBus resources and an i2c-client
+	 * must be instantiated for each, each with its own i2c_device_id.
+	 * Normally we only instantiate an i2c-client for the first resource,
+	 * using the ACPI HID as id. These special cases are handled by the
+	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
+	 * which i2c_device_id to use for each resource.
+	 */
+	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
+		{"BSG1160", },
+		{}
+	};
 
 	if (acpi_is_indirect_io_slave(device))
 		return true;
@@ -1551,6 +1563,10 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
+	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind to */
+	if (!acpi_match_device_ids(device, i2c_multi_instantiate_ids))
+		return false;
+
 	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list,
 			       acpi_check_serial_bus_slave,
-- 
2.18.0
