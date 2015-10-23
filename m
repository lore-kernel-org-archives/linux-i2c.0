From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/5] at24: enable ACPI device found on Galileo Gen2
Date: Fri, 23 Oct 2015 12:16:44 +0300
Message-ID: <1445591805-28886-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

There is a 24c08 chip connected to i2c bus on Intel Galileo Gen2 board. Enable
it via ACPI ID INT3499.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at24.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c6cb7f8..5d7c090 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
 
@@ -131,6 +132,12 @@ static const struct i2c_device_id at24_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, at24_ids);
 
+static const struct acpi_device_id at24_acpi_ids[] = {
+	{ "INT3499", AT24_DEVICE_MAGIC(8192 / 8, 0) },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -467,21 +474,29 @@ static void at24_get_ofdata(struct i2c_client *client,
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct at24_platform_data chip;
+	kernel_ulong_t magic = 0;
 	bool writable;
 	int use_smbus = 0;
 	int use_smbus_write = 0;
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
-	kernel_ulong_t magic;
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
 	} else {
-		if (!id->driver_data)
+		if (id) {
+			magic = id->driver_data;
+		} else {
+			const struct acpi_device_id *aid;
+
+			aid = acpi_match_device(at24_acpi_ids, &client->dev);
+			if (aid)
+				magic = aid->driver_data;
+		}
+		if (!magic)
 			return -ENODEV;
 
-		magic = id->driver_data;
 		chip.byte_len = BIT(magic & AT24_BITMASK(AT24_SIZE_BYTELEN));
 		magic >>= AT24_SIZE_BYTELEN;
 		chip.flags = magic & AT24_BITMASK(AT24_SIZE_FLAGS);
@@ -661,6 +676,7 @@ static int at24_remove(struct i2c_client *client)
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
+		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
 	.probe = at24_probe,
 	.remove = at24_remove,
-- 
2.6.1

