From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/3] i2c: core: Allow getting acpi info by index
Date: Sat, 11 Mar 2017 00:57:01 +0100
Message-ID: <20170310235703.29984-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755108AbdCJX5I (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Mar 2017 18:57:08 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Modify struct i2c_acpi_lookup and i2c_acpi_fill_info() to allow
using them to get the info from a certain index in the acpi-resource
list rather then taking the first I2cSerialBus resource.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d2402bb..32b58fb 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -112,6 +112,8 @@ struct i2c_acpi_lookup {
 	acpi_handle adapter_handle;
 	acpi_handle device_handle;
 	acpi_handle search_handle;
+	int n;
+	int index;
 	u32 speed;
 	u32 min_speed;
 };
@@ -123,6 +125,9 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 	struct acpi_resource_i2c_serialbus *sb;
 	acpi_status status;
 
+	if (lookup->index != -1 && lookup->n++ != lookup->index)
+		return 1;
+
 	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
 		return 1;
 
@@ -182,6 +187,7 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
+	lookup.index = -1;
 
 	ret = i2c_acpi_do_lookup(adev, &lookup);
 	if (ret)
@@ -328,6 +334,7 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 	lookup.search_handle = ACPI_HANDLE(dev);
 	lookup.min_speed = UINT_MAX;
 	lookup.info = &dummy;
+	lookup.index = -1;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     I2C_ACPI_MAX_SCAN_DEPTH,
-- 
2.9.3
