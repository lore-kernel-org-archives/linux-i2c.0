From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i2c: acpi: Do not create i2c-clients for LNXVIDEO ACPI devices
Date: Tue,  4 Jul 2017 14:46:13 +0200
Message-ID: <20170704124613.14591-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751536AbdGDMqR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 08:46:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

ACPI video devices get tagged by the kernel with the custom LNXVIDEO
HID so that normal pnp-id matching can be used and are handled by the
acpi-video driver.

Sometimes the ACPI nodes describing these contain a SERIAL_TYPE_I2C ACPI
resource. Before this commit the presence of this resource would cause the
i2c-core to create a /sys/bus/i2c/devices/i2c-LNXVIDEO:00 device for this
with a modalias of: "i2c:LNXVIDEO:00".

There is no i2c driver for this custom HID, the acpi-video driver binds
directly to the ACPI device /sys/bus/acpi/devices/LNXVIDEO\:00 which has
a modalias of "acpi:LNXVIDEO:" .

Not only is the creation of an i2c-client for this undesirable, it is
actually causing problems. This weird pseudo-resource claims an i2c
speed of 100KHz and typically points to the i2c bus which is used by the
touchscreen controller. Some touchscreen controllers only work properly at
400KHz, at 100KHz they cause errors like these:

i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
silead_ts i2c-MSSL1680:00: Registers clear error -11

This commit makes the i2c-core ignore LNXVIDEO compatible ACPI devices
which has 2 positive results:

1) The bogus i2c-client for these is no longer created.
2) i2c_acpi_lookup_speed now ignores the 100KHz speed from the pseudo
i2c-resouce and properly returns 400KHz as speed for the touchscreen
i2c bus, fixing the touchscreen not working on various devies.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Rebase on top of linux-i2c/for-next
---
 drivers/i2c/i2c-core-acpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 052005579ed6..bda281293d28 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -82,11 +82,22 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 	struct i2c_board_info *info = lookup->info;
 	struct list_head resource_list;
 	int ret;
+	static const struct acpi_device_id video_device_ids[] = {
+		{ ACPI_VIDEO_HID, 0 },
+		{}
+	};
 
 	if (acpi_bus_get_status(adev) || !adev->status.present ||
 	    acpi_device_enumerated(adev))
 		return -EINVAL;
 
+	/*
+	 * ACPI video acpi_devices, which are handled by the acpi-video driver
+	 * sometimes contain a SERIAL_TYPE_I2C ACPI resource, ignore these.
+	 */
+	if (acpi_match_device_ids(adev, video_device_ids) == 0)
+		return -ENODEV;
+
 	memset(info, 0, sizeof(*info));
 	lookup->device_handle = acpi_device_handle(adev);
 
-- 
2.13.0
