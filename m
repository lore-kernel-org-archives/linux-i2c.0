From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/2] i2c / ACPI: Create device on a valid first address
Date: Fri,  5 Sep 2014 08:21:05 -0700
Message-ID: <1409930466-31746-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1409930466-31746-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409930466-31746-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The ACPI spec allows multiple I2cSerialBus addresses for a single
device. The current logic creates a i2c device for the last
I2cSerialBus address. In many configuration the first address
is valid not the last one.
But in some configuration it is possible that the chosen address
is not valid, so skip to next address and create a device on it.

Examples:
1.
Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
{
        Name (RBUF, ResourceTemplate ()
        {
		I2cSerialBus (0x0068, ControllerInitiated, 0x00061A80,
			AddressingMode7Bit, "\\_SB.I2C5",
			0x00, ResourceConsumer, ,
		)
		I2cSerialBus (0x000C, ControllerInitiated, 0x00061A80,
			AddressingMode7Bit, "\\_SB.I2C5",
			0x00, ResourceConsumer, ,
		)
		Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
		{
			0x00000044,
		}
	})
	Return (RBUF)
}
This device is a combo device, where the first address is a valid address
of the main controller device. So this change will create i2c device
for 0x068, the first address.

2.
Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
{
	Name (SBUF, ResourceTemplate ()
	{
		I2cSerialBus (0x000C, ControllerInitiated, 0x00061A80,
			AddressingMode7Bit, "\\_SB.I2C3",
			0x00, ResourceConsumer, ,
		)
		I2cSerialBus (0x0048, ControllerInitiated, 0x00061A80,
			AddressingMode7Bit, "\\_SB.I2C3",
			0x00, ResourceConsumer, ,
		)
		Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
		{
			0x00000033,
		}
	})
	Return (SBUF)
}
This device is a SMBUS compliant, where 0x0C is address of alert response
address (ARA). This patch will skip 0x0C, as this is reserved address,
and will create an i2c device at 0x48.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-acpi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/i2c/i2c-acpi.c b/drivers/i2c/i2c-acpi.c
index 0dbc18c..83db880 100644
--- a/drivers/i2c/i2c-acpi.c
+++ b/drivers/i2c/i2c-acpi.c
@@ -37,6 +37,28 @@ struct gsb_buffer {
 	};
 } __packed;
 
+static int acpi_i2c_smbus_match_reserved_addr(unsigned short addr)
+{
+	/*
+	 * Reserved addresses per SMBUS specification
+	 * in addition to i2c reserved addresses:
+	 *  0x08	SMBUS Host
+	 *  0x0C	ARA
+	 *  0x61	Device default address
+	 *  0x28	Access bus host
+	 *  0x37	Access bus default addr
+	 */
+	int i;
+	u8 resvd_addrs[] = {0x08, 0x0C, 0x061, 0x28, 0x37};
+
+	for (i = 0; i < ARRAY_SIZE(resvd_addrs); ++i) {
+		if (resvd_addrs[i] == addr)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct i2c_board_info *info = data;
@@ -46,6 +68,20 @@ static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
 
 		sb = &ares->data.i2c_serial_bus;
 		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
+			if (info->addr) {
+				/*
+				 * We have multiple I2cSerialBus present. Check
+				 * the validity of last parsed address.
+				 * i2c device create rejects reserved address
+				 * for i2C. But if the last address was an
+				 * invalid SMBUS reserved address, skip to next
+				 * valid address in the list and call
+				 * i2c_new_device for this address instead.
+				 */
+				if (acpi_i2c_smbus_match_reserved_addr(
+								info->addr))
+					return 1; /* last addr was valid */
+			}
 			info->addr = sb->slave_address;
 			if (sb->access_mode == ACPI_I2C_10BIT_MODE)
 				info->flags |= I2C_CLIENT_TEN;
-- 
1.9.3
