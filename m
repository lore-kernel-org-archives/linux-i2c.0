From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Sat, 27 Jan 2018 14:32:09 +0100
Message-ID: <20180127133209.28995-1-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55641 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeA0Ncz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 27 Jan 2018 08:32:55 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Dell platform team told us that some (DMI whitelisted) Dell Latitude
machines have ST microelectronics accelerometer at i2c address 0x29.

Presence of that ST microelectronics accelerometer is verified by existence
of SMO88xx ACPI device which represent that accelerometer. Unfortunately
ACPI device does not specify i2c address.

This patch registers lis3lv02d device for selected Dell Latitude machines
at i2c address 0x29 after detection. And for Dell Vostro V131 machine at
i2c address 0x1d which was manually detected.

Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to
conflict with PCI BAR") allowed to use i2c-i801 driver on Dell machines so
lis3lv02d correctly initialize accelerometer.

Tested on Dell Latitude E6440.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
Changes since v1:
 * Added Dell Vostro V131 based on Michał Kępień testing
 * Changed DMI product structure to include also i2c address

I re-tested this patch against Debian's 4.9 kernel on E6440.
---
 drivers/i2c/busses/i2c-i801.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 8eac00efadc1..502678e8b8c0 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1136,6 +1136,107 @@ static void dmi_check_onboard_devices(const struct dmi_header *dm, void *adap)
 	}
 }
 
+static acpi_status check_acpi_smo88xx_device(acpi_handle obj_handle,
+					     u32 nesting_level,
+					     void *context,
+					     void **return_value)
+{
+	struct acpi_device_info *info;
+	acpi_status status;
+	char *hid;
+
+	status = acpi_get_object_info(obj_handle, &info);
+	if (!ACPI_SUCCESS(status) || !(info->valid & ACPI_VALID_HID))
+		return AE_OK;
+
+	hid = info->hardware_id.string;
+	if (!hid)
+		return AE_OK;
+
+	if (strlen(hid) < 7)
+		return AE_OK;
+
+	if (memcmp(hid, "SMO88", 5) != 0)
+		return AE_OK;
+
+	*((bool *)return_value) = true;
+	return AE_CTRL_TERMINATE;
+}
+
+static bool is_dell_system_with_lis3lv02d(void)
+{
+	bool found;
+	acpi_status status;
+	const char *vendor;
+
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	if (strcmp(vendor, "Dell Inc.") != 0)
+		return false;
+
+	/*
+	 * Check that ACPI device SMO88xx exists and is enabled. That ACPI
+	 * device represent our ST microelectronics lis3lv02d accelerometer but
+	 * unfortunately without any other information (like i2c address).
+	 */
+	found = false;
+	status = acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL,
+				  (void **)&found);
+	if (!ACPI_SUCCESS(status) || !found)
+		return false;
+
+	return true;
+}
+
+/*
+ * Accelerometer's i2c address is not specified in DMI nor ACPI,
+ * so it is needed to define mapping table based on DMI product names.
+ */
+static struct {
+	const char *dmi_product_name;
+	unsigned short i2c_addr;
+} dell_lis3lv02d_devices[] = {
+	/*
+	 * Dell platform team told us that these Latitude devices have
+	 * ST microelectronics accelerometer at i2c address 0x29.
+	 */
+	{ "Latitude E5250",     0x29 },
+	{ "Latitude E5450",     0x29 },
+	{ "Latitude E5550",     0x29 },
+	{ "Latitude E6440",     0x29 },
+	{ "Latitude E6440 ATG", 0x29 },
+	{ "Latitude E6540",     0x29 },
+	/*
+	 * Additional individual entries were added after verification.
+	 */
+	{ "Vostro V131",        0x1d },
+};
+
+static void register_dell_lis3lv02d_i2c_device(struct i801_priv *priv)
+{
+	struct i2c_board_info info;
+	const char *dmi_product_name;
+	int i;
+
+	dmi_product_name = dmi_get_system_info(DMI_PRODUCT_NAME);
+	for (i = 0; i < ARRAY_SIZE(dell_lis3lv02d_devices); ++i) {
+		if (strcmp(dmi_product_name,
+			   dell_lis3lv02d_devices[i].dmi_product_name) == 0)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(dell_lis3lv02d_devices)) {
+		dev_warn(&priv->pci_dev->dev,
+			 "Accelerometer lis3lv02d is present on i2c bus but its"
+			 " i2c address is unknown, skipping registration...\n");
+		return;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = dell_lis3lv02d_devices[i].i2c_addr;
+	strlcpy(info.type, "lis3lv02d", I2C_NAME_SIZE);
+	i2c_new_device(&priv->adapter, &info);
+}
+
 /* Register optional slaves */
 static void i801_probe_optional_slaves(struct i801_priv *priv)
 {
@@ -1154,6 +1255,9 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
 
 	if (dmi_name_in_vendors("FUJITSU"))
 		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
+
+	if (is_dell_system_with_lis3lv02d())
+		register_dell_lis3lv02d_i2c_device(priv);
 }
 #else
 static void __init input_apanel_init(void) {}
-- 
2.11.0
