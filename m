From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v2 02/22] eeprom: at24: Add OF device ID table
Date: Thu, 13 Apr 2017 15:28:19 -0300
Message-ID: <20170413182839.25381-3-javier@osg.samsung.com>
References: <20170413182839.25381-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413182839.25381-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Suggested-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Only add a single OF device ID entry for each device type (Wolfram Sang).

 drivers/misc/eeprom/at24.c | 69 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 764ff5df0dbc..56c75b3d01b4 100644
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
@@ -175,6 +176,68 @@ static const struct i2c_device_id at24_ids[] = {
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
+		.compatible = "atmel,24c02",
+		.data = (void *)AT24_DEVICE_MAGIC(16,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY)
+	},
+	{
+		.compatible = "at24,spd",
+		.data = (void *)AT24_DEVICE_MAGIC(2048 / 8,
+				AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
+	},
+	{
+		.compatible = "atmel,24c04",
+		.data = (void *)AT24_DEVICE_MAGIC(4096 / 8, 0)
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
+		.compatible = "atmel,24c32",
+		.data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "atmel,24c64",
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
+		.compatible = "atmel,24c256",
+		.data = (void *)AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "atmel,24c512",
+		.data = (void *)AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16)
+	},
+	{
+		.compatible = "atmel,24c1024",
+		.data = (void *)AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16)
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, at24_of_match);
+
 static const struct acpi_device_id at24_acpi_ids[] = {
 	{ "INT3499", AT24_DEVICE_MAGIC(8192 / 8, 0) },
 	{ }
@@ -598,7 +661,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -814,6 +880,7 @@ static int at24_remove(struct i2c_client *client)
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
+		.of_match_table = at24_of_match,
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
 	.probe = at24_probe,
-- 
2.9.3
