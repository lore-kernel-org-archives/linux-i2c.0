From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Tue, 14 Mar 2017 12:16:38 -0300
Message-ID: <20170314151638.23132-5-javier@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314151638.23132-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Hello,

I added in the OF device ID table all the manufacturer,model combinations
that I found on either a DT bindings doc or Device Tree source files, but
the Documentation/devicetree/bindings/eeprom/eeprom.txt docs says that:

- compatible : should be "<manufacturer>,<type>", like these:

And give some examples. I wonder if such a lax definition for compatibles
is valid or if all possible combinations should be documented in the doc.

I would had expected the latter and keep both the OF device ID table and
bindings document updated as compatible EEPROM from a new vendor is used.

Best regards,
Javier

 drivers/misc/eeprom/at24.c | 189 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 764ff5df0dbc..b67b804855f9 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -175,6 +176,188 @@ static const struct i2c_device_id at24_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, at24_ids);
 
+static const struct of_device_id at24_of_match[] = {
+	{
+		.compatible = "atmel,24c00",
+		.data = (void *)AT24_DEVICE_MAGIC(128 / 8, AT24_FLAG_TAKE8ADDR)
+	},
+	{
+		.compatible = "atmel,24c01",
+		.data = (void *)AT24_DEVICE_MAGIC(1024 / 8, 0)
+	},
+	{
+		.compatible = "at24,24c02",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "atmel,24c02",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "microchip,24c02",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "nxp,24c02",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "renesas,24c02",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "renesas,r1ex24002",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "at24,spd",
+		.data = (void *)AT24_DEVICE_MAGIC(2048 / 8,
+				AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
+	},
+	{
+		.compatible = "at,24c04",
+		.data = (void *)AT24_DEVICE_MAGIC(4096 / 8, 0)
+	},
+	{
+		.compatible = "at24,24c04",
+		.data = (void *)AT24_DEVICE_MAGIC(4096 / 8, 0)
+	},
+	{
+		.compatible = "atmel,24c04",
+		.data = (void *)AT24_DEVICE_MAGIC(4096 / 8, 0)
+	},
+	{
+		.compatible = "at,24c08",
+		.data = (void *)AT24_DEVICE_MAGIC(8192 / 8, 0)
+	},
+	{
+		.compatible = "atmel,24c08",
+		.data = (void *)AT24_DEVICE_MAGIC(8192 / 8, 0)
+	},
+	{
+		.compatible = "atmel,24c16",
+		.data = (void *)AT24_DEVICE_MAGIC(16384 / 8, 0)
+	},
+	{
+		.compatible = "at,24c32",
+		.data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "at24,24c32",
+		.data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "atmel,24c32",
+		.data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "catalyst,24c32",
+		.data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "microchip,24c32",
+		.data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "at,24c64",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "at24,24c64",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "atmel,24c64",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "microchip,24c64",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "ramtron,24c64",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "st,24c64",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "atmel,24c128",
+		.data = (void *)AT24_DEVICE_MAGIC(131072 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "renesas,24c128",
+		.data = (void *)AT24_DEVICE_MAGIC(131072 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "at,24c256",
+		.data = (void *)AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "at24,24c256",
+		.data = (void *)AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "atmel,24c256",
+		.data = (void *)AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "st,24c256",
+		.data = (void *)AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "at24,24c512",
+		.data = (void *)AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "atmel,24c512",
+		.data = (void *)AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "microchip,24c512",
+		.data = (void *)AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "at,24c1024",
+		.data = (void *)AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "atmel,24c1024",
+		.data = (void *)AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "st,24c1024",
+		.data = (void *)AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16)
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, at24_of_match);
+
 static const struct acpi_device_id at24_acpi_ids[] = {
 	{ "INT3499", AT24_DEVICE_MAGIC(8192 / 8, 0) },
 	{ }
@@ -598,7 +781,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
 	} else {
-		if (id) {
+		if (client->dev.of_node) {
+			magic = (kernel_ulong_t)
+				of_device_get_match_data(&client->dev);
+		} else if (id) {
 			magic = id->driver_data;
 		} else {
 			const struct acpi_device_id *aid;
@@ -814,6 +1000,7 @@ static int at24_remove(struct i2c_client *client)
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
+		.of_match_table = of_match_ptr(at24_of_match),
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
 	.probe = at24_probe,
-- 
2.9.3
