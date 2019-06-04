From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v4] i2c: i801: Register optional lis3lv02d I2C device on Dell machines
Date: Wed,  5 Jun 2019 00:33:03 +0200
Message-ID: <20190604223303.31945-1-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dell platform team told us that some (DMI whitelisted) Dell Latitude
machines have ST microelectronics accelerometer at I2C address 0x29.

Presence of that ST microelectronics accelerometer is verified by existence
of SMO88xx ACPI device which represent that accelerometer. Unfortunately
ACPI device does not specify I2C address.

This patch registers lis3lv02d device for selected Dell Latitude machines
at I2C address 0x29 after detection. And for Dell Vostro V131 machine at
I2C address 0x1d which was manually detected.

Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to
conflict with PCI BAR") allowed to use i2c-i801 driver on Dell machines so
lis3lv02d correctly initialize accelerometer.

Tested on Dell Latitude E6440.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

---
Changes since v3:
 * Use char * [] type for list of acpi ids
 * Check that SMO88xx acpi device is present, enabled and functioning
 * Simplify usage of acpi_get_devices()
 * Change i2c to I2C
 * Make dell_lis3lv02d_devices const

Changes since v2:
 * Use explicit list of SMOxx ACPI devices

Changes since v1:
 * Added Dell Vostro V131 based on Michał Kępień testing
 * Changed DMI product structure to include also i2c address
---
 drivers/i2c/busses/i2c-i801.c       | 123 ++++++++++++++++++++++++++++++++++++
 drivers/platform/x86/dell-smo8800.c |   1 +
 2 files changed, 124 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ac7f7817dc89..9060d4b16f4f 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1134,6 +1134,126 @@ static void dmi_check_onboard_devices(const struct dmi_header *dm, void *adap)
 	}
 }
 
+/* NOTE: Keep this list in sync with drivers/platform/x86/dell-smo8800.c */
+static const char *const acpi_smo8800_ids[] = {
+	"SMO8800",
+	"SMO8801",
+	"SMO8810",
+	"SMO8811",
+	"SMO8820",
+	"SMO8821",
+	"SMO8830",
+	"SMO8831",
+};
+
+static acpi_status check_acpi_smo88xx_device(acpi_handle obj_handle,
+					     u32 nesting_level,
+					     void *context,
+					     void **return_value)
+{
+	struct acpi_device_info *info;
+	unsigned long long sta;
+	acpi_status status;
+	char *hid;
+	int i;
+
+	status = acpi_bus_get_status_handle(obj_handle, &sta);
+	if (!ACPI_SUCCESS(status))
+		return AE_OK;
+	if (!(sta & (ACPI_STA_DEVICE_PRESENT |
+		     ACPI_STA_DEVICE_ENABLED |
+		     ACPI_STA_DEVICE_FUNCTIONING)))
+		return AE_OK;
+
+	status = acpi_get_object_info(obj_handle, &info);
+	if (!ACPI_SUCCESS(status) || !(info->valid & ACPI_VALID_HID))
+		return AE_OK;
+
+	hid = info->hardware_id.string;
+	if (!hid)
+		return AE_OK;
+
+	for (i = 0; i < ARRAY_SIZE(acpi_smo8800_ids); ++i) {
+		if (strcmp(hid, acpi_smo8800_ids[i]) == 0) {
+			*((bool *)return_value) = true;
+			return AE_CTRL_TERMINATE;
+		}
+	}
+
+	return AE_OK;
+}
+
+static bool is_dell_system_with_lis3lv02d(void)
+{
+	bool found;
+	const char *vendor;
+
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	if (strcmp(vendor, "Dell Inc.") != 0)
+		return false;
+
+	/*
+	 * Check that ACPI device SMO88xx exists and is enabled. That ACPI
+	 * device represent our ST microelectronics lis3lv02d accelerometer but
+	 * unfortunately without any other information (like I2C address).
+	 */
+	found = false;
+	acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL,
+				  (void **)&found);
+
+	return found;
+}
+
+/*
+ * Accelerometer's I2C address is not specified in DMI nor ACPI,
+ * so it is needed to define mapping table based on DMI product names.
+ */
+static const struct {
+	const char *dmi_product_name;
+	unsigned short i2c_addr;
+} dell_lis3lv02d_devices[] = {
+	/*
+	 * Dell platform team told us that these Latitude devices have
+	 * ST microelectronics accelerometer at I2C address 0x29.
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
+			 "Accelerometer lis3lv02d is present on SMBus but its"
+			 " address is unknown, skipping registration\n");
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
@@ -1152,6 +1272,9 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
 
 	if (dmi_name_in_vendors("FUJITSU"))
 		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
+
+	if (is_dell_system_with_lis3lv02d())
+		register_dell_lis3lv02d_i2c_device(priv);
 }
 #else
 static void __init input_apanel_init(void) {}
diff --git a/drivers/platform/x86/dell-smo8800.c b/drivers/platform/x86/dell-smo8800.c
index 5cdb09cba077..bfcc1d1b9b96 100644
--- a/drivers/platform/x86/dell-smo8800.c
+++ b/drivers/platform/x86/dell-smo8800.c
@@ -198,6 +198,7 @@ static int smo8800_remove(struct acpi_device *device)
 	return 0;
 }
 
+/* NOTE: Keep this list in sync with drivers/i2c/busses/i2c-i801.c */
 static const struct acpi_device_id smo8800_ids[] = {
 	{ "SMO8800", 0 },
 	{ "SMO8801", 0 },
-- 
2.11.0
