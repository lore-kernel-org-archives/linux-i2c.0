From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c / ACPI: Pick the first address if device has multiple
Date: Mon, 29 Dec 2014 15:48:48 +0200
Message-ID: <1419860928-195404-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

ACPI specification allows I2C devices with multiple addresses. The current
implementation goes over all addresses and assigns the last one to the
device. This is typically not the primary address of the device.

Instead of doing that we assign the first address to the device and then
let the driver handle rest of the addresses as it wishes.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 39d25a8cb1ad..a06be43b7842 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -102,7 +102,7 @@ static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
 		struct acpi_resource_i2c_serialbus *sb;
 
 		sb = &ares->data.i2c_serial_bus;
-		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
+		if (!info->addr && sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
 			info->addr = sb->slave_address;
 			if (sb->access_mode == ACPI_I2C_10BIT_MODE)
 				info->flags |= I2C_CLIENT_TEN;
-- 
2.1.4
