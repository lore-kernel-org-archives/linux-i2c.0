From: Ben Gardner <gardner.ben@gmail.com>
Subject: [PATCH v3] eeprom/at24: use device_property_*() functions instead of of_get_property()
Date: Thu,  9 Feb 2017 11:09:59 -0600
Message-ID: <1486660199-30065-1-git-send-email-gardner.ben@gmail.com>
References: <CAE7DoPa1taAOWOO+g=A=QJ5wTy+GicjyL6GgdiTYQ94QWaX1Ug@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE7DoPa1taAOWOO+g=A=QJ5wTy+GicjyL6GgdiTYQ94QWaX1Ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Ben Gardner <gardner.ben@gmail.com>
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
 drivers/misc/eeprom/at24.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 051b147..c2d9969 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -19,7 +19,7 @@
 #include <linux/log2.h>
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
@@ -562,26 +562,26 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static void at24_get_ofdata(struct i2c_client *client,
-			    struct at24_platform_data *chip)
+static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
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
+	int err;
+	u32 val;
+
+	if (device_property_present(dev, "read-only"))
+		chip->flags |= AT24_FLAG_READONLY;
+
+	err = device_property_read_u32(dev, "pagesize", &val);
+	if (!err) {
+		chip->page_size = val;
+	} else {
+		/*
+		 * This is slow, but we can't know all eeproms, so we better
+		 * play safe. Specifying custom eeprom-types via platform_data
+		 * is recommended anyhow.
+		 */
+		chip.page_size = 1;
 	}
 }
-#else
-static void at24_get_ofdata(struct i2c_client *client,
-			    struct at24_platform_data *chip)
-{ }
-#endif /* CONFIG_OF */
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
@@ -613,15 +613,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		chip.byte_len = BIT(magic & AT24_BITMASK(AT24_SIZE_BYTELEN));
 		magic >>= AT24_SIZE_BYTELEN;
 		chip.flags = magic & AT24_BITMASK(AT24_SIZE_FLAGS);
-		/*
-		 * This is slow, but we can't know all eeproms, so we better
-		 * play safe. Specifying custom eeprom-types via platform_data
-		 * is recommended anyhow.
-		 */
-		chip.page_size = 1;
 
-		/* update chipdata if OF is present */
-		at24_get_ofdata(client, &chip);
+		at24_get_pdata(&client->dev, &chip);
 
 		chip.setup = NULL;
 		chip.context = NULL;
-- 
2.7.4
