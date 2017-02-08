From: Ben Gardner <gardner.ben@gmail.com>
Subject: [PATCH] eeprom/at24: use device_property_*() functions instead of of_get_property()
Date: Wed,  8 Feb 2017 13:53:56 -0600
Message-ID: <1486583636-8940-1-git-send-email-gardner.ben@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Gardner <gardner.ben@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Allow the at24 driver to get configuration information from both OF and
ACPI by using the more generic device_property functions.
This change was inspired by the at25.c driver.

I have a custom board with a ST M24C02 EEPROM attached to an I2C bus.
With the following ACPI construct, this patch instantiates a working
instance of the driver.

Device (EEP0) {
 Name (_HID, "PRP0001")
 Name (_DSD, Package () {
  ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
  Package () {
   Package () {"compatible", Package () {"st,24c02"}},
   Package () {"size", 256},
   Package () {"pagesize", 16},
  },
 })
 Name (_CRS, ResourceTemplate () {
  I2cSerialBus (
   0x0057, ControllerInitiated, 400000,
   AddressingMode7Bit, "\\_SB.PCI0.I2C3", 0x00,
   ResourceConsumer,,)
 })
}

Note: Matching the driver to the I2C device requires another patch.
 http://www.spinics.net/lists/linux-acpi/msg71914.html

Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
---
 drivers/misc/eeprom/at24.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 051b147..9cb8904 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -19,7 +19,6 @@
 #include <linux/log2.h>
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
-#include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
@@ -562,26 +561,17 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static void at24_get_ofdata(struct i2c_client *client,
+static void at24_fw_to_chip(struct device *dev,
 			    struct at24_platform_data *chip)
 {
-	const __be32 *val;
-	struct device_node *node = client->dev.of_node;
-
-	if (node) {
-		if (of_get_property(node, "read-only", NULL))
-			chip->flags |= AT24_FLAG_READONLY;
-		val = of_get_property(node, "pagesize", NULL);
-		if (val)
-			chip->page_size = be32_to_cpup(val);
-	}
+	u32 val;
+
+	if (device_property_present(dev, "read-only"))
+		chip->flags |= AT24_FLAG_READONLY;
+
+	if (device_property_read_u32(dev, "pagesize", &val) == 0)
+		chip->page_size = val;
 }
-#else
-static void at24_get_ofdata(struct i2c_client *client,
-			    struct at24_platform_data *chip)
-{ }
-#endif /* CONFIG_OF */
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
@@ -621,7 +611,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		chip.page_size = 1;
 
 		/* update chipdata if OF is present */
-		at24_get_ofdata(client, &chip);
+		at24_fw_to_chip(&client->dev, &chip);
 
 		chip.setup = NULL;
 		chip.context = NULL;
-- 
2.7.4
