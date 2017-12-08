From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v2 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 16:25:05 -0500
Message-ID: <1512768306-14816-2-git-send-email-svendev@arcx.com>
References: <1512768306-14816-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512768306-14816-1-git-send-email-svendev@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Fundamental properties such as capacity and page size differ
among at24-type chips. But these chips do not have an id register,
so this can't be discovered at runtime.

Traditionally, at24-type eeprom properties were determined in two ways:
- by passing a 'struct at24_platform_data' via platform_data, or
- by naming the chip type in the devicetree, which passes a
	'magic number' to probe(), which is then converted to
	a 'struct at24_platform_data'.

Recently a bug was discovered because the magic number rounds down
all chip sizes to the lowest power of two. This was addressed by
a work-around, with the wish that magic numbers should over time
be converted to structs.

This patch replaces the magic numbers with 'struct at24_chip_data'.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/misc/eeprom/at24.c | 230 ++++++++++++++++++++++-----------------------
 1 file changed, 110 insertions(+), 120 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 06ffa11..c3759cb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -105,16 +105,6 @@ struct at24_data {
 module_param(write_timeout, uint, 0);
 MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
 
-#define AT24_SIZE_BYTELEN 5
-#define AT24_SIZE_FLAGS 8
-
-#define AT24_BITMASK(x) (BIT(x) - 1)
-
-/* create non-zero magic value for given eeprom parameters */
-#define AT24_DEVICE_MAGIC(_len, _flags) 		\
-	((1 << AT24_SIZE_FLAGS | (_flags)) 		\
-	    << AT24_SIZE_BYTELEN | ilog2(_len))
-
 /*
  * Both reads and writes fail if the previous write didn't complete yet. This
  * macro loops a few times waiting at least long enough for one entire page
@@ -131,113 +121,119 @@ struct at24_data {
 	     op_time ? time_before(op_time, tout) : true;		\
 	     usleep_range(1000, 1500), op_time = jiffies)
 
+struct at24_chip_data {
+	/*
+	 * these fields mirror their equivalents in
+	 * struct at24_platform_data
+	 */
+	u32 byte_len;
+	u8 flags;
+};
+
+#define AT24_CHIP_DATA(_name, _len, _flags) \
+	static const struct at24_chip_data at24_data_##_name = { \
+		.byte_len = _len, .flags = _flags, \
+	}
+
+#define AT24_I2C_DEVICE_ID(_name) \
+	{ #_name, (kernel_ulong_t)&at24_data_##_name }
+
+#define AT24_ACPI_DEVICE_ID(_name) \
+	{ #_name, (kernel_ulong_t)&at24_data_##_name }
+
+#define AT24_OF_DEVICE_ID(_of_compat, _name) \
+	{ .compatible = _of_compat, .data = &at24_data_##_name }
+
+/* needs 8 addresses as A0-A2 are ignored */
+AT24_CHIP_DATA(24c00, 128 / 8, AT24_FLAG_TAKE8ADDR);
+/* old variants can't be handled with this generic entry! */
+AT24_CHIP_DATA(24c01, 1024 / 8, 0);
+AT24_CHIP_DATA(24cs01, 16, AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
+AT24_CHIP_DATA(24c02, 2048 / 8,	0);
+AT24_CHIP_DATA(24cs02, 16, AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
+AT24_CHIP_DATA(24mac402, 48 / 8,
+	AT24_FLAG_MAC | AT24_FLAG_READONLY);
+AT24_CHIP_DATA(24mac602, 64 / 8,
+	AT24_FLAG_MAC | AT24_FLAG_READONLY);
+/* spd is a 24c02 in memory DIMMs */
+AT24_CHIP_DATA(spd, 2048 / 8,
+	AT24_FLAG_READONLY | AT24_FLAG_IRUGO);
+AT24_CHIP_DATA(24c04, 4096 / 8,	0);
+AT24_CHIP_DATA(24cs04, 16,
+	AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
+/* 24rf08 quirk is handled at i2c-core */
+AT24_CHIP_DATA(24c08, 8192 / 8,	0);
+AT24_CHIP_DATA(24cs08, 16,
+	AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
+AT24_CHIP_DATA(24c16, 16384 / 8, 0);
+AT24_CHIP_DATA(24cs16, 16,
+	AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
+AT24_CHIP_DATA(24c32, 32768 / 8,	AT24_FLAG_ADDR16);
+AT24_CHIP_DATA(24cs32, 16,
+	AT24_FLAG_ADDR16 |
+	AT24_FLAG_SERIAL |
+	AT24_FLAG_READONLY);
+AT24_CHIP_DATA(24c64, 65536 / 8,	AT24_FLAG_ADDR16);
+AT24_CHIP_DATA(24cs64, 16,
+	AT24_FLAG_ADDR16 |
+	AT24_FLAG_SERIAL |
+	AT24_FLAG_READONLY);
+AT24_CHIP_DATA(24c128, 131072 / 8,	AT24_FLAG_ADDR16);
+AT24_CHIP_DATA(24c256, 262144 / 8,	AT24_FLAG_ADDR16);
+AT24_CHIP_DATA(24c512, 524288 / 8,	AT24_FLAG_ADDR16);
+AT24_CHIP_DATA(24c1024, 1048576 / 8,	AT24_FLAG_ADDR16);
+/* identical to 24c08 ? */
+AT24_CHIP_DATA(INT3499, 8192 / 8, 0);
+
 static const struct i2c_device_id at24_ids[] = {
-	/* needs 8 addresses as A0-A2 are ignored */
-	{ "24c00",	AT24_DEVICE_MAGIC(128 / 8,	AT24_FLAG_TAKE8ADDR) },
-	/* old variants can't be handled with this generic entry! */
-	{ "24c01",	AT24_DEVICE_MAGIC(1024 / 8,	0) },
-	{ "24cs01",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
-	{ "24c02",	AT24_DEVICE_MAGIC(2048 / 8,	0) },
-	{ "24cs02",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
-	{ "24mac402",	AT24_DEVICE_MAGIC(48 / 8,
-				AT24_FLAG_MAC | AT24_FLAG_READONLY) },
-	{ "24mac602",	AT24_DEVICE_MAGIC(64 / 8,
-				AT24_FLAG_MAC | AT24_FLAG_READONLY) },
-	/* spd is a 24c02 in memory DIMMs */
-	{ "spd",	AT24_DEVICE_MAGIC(2048 / 8,
-				AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
-	{ "24c04",	AT24_DEVICE_MAGIC(4096 / 8,	0) },
-	{ "24cs04",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
-	/* 24rf08 quirk is handled at i2c-core */
-	{ "24c08",	AT24_DEVICE_MAGIC(8192 / 8,	0) },
-	{ "24cs08",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
-	{ "24c16",	AT24_DEVICE_MAGIC(16384 / 8,	0) },
-	{ "24cs16",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
-	{ "24c32",	AT24_DEVICE_MAGIC(32768 / 8,	AT24_FLAG_ADDR16) },
-	{ "24cs32",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_ADDR16 |
-				AT24_FLAG_SERIAL |
-				AT24_FLAG_READONLY) },
-	{ "24c64",	AT24_DEVICE_MAGIC(65536 / 8,	AT24_FLAG_ADDR16) },
-	{ "24cs64",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_ADDR16 |
-				AT24_FLAG_SERIAL |
-				AT24_FLAG_READONLY) },
-	{ "24c128",	AT24_DEVICE_MAGIC(131072 / 8,	AT24_FLAG_ADDR16) },
-	{ "24c256",	AT24_DEVICE_MAGIC(262144 / 8,	AT24_FLAG_ADDR16) },
-	{ "24c512",	AT24_DEVICE_MAGIC(524288 / 8,	AT24_FLAG_ADDR16) },
-	{ "24c1024",	AT24_DEVICE_MAGIC(1048576 / 8,	AT24_FLAG_ADDR16) },
+	AT24_I2C_DEVICE_ID(24c00),
+	AT24_I2C_DEVICE_ID(24c01),
+	AT24_I2C_DEVICE_ID(24cs01),
+	AT24_I2C_DEVICE_ID(24c02),
+	AT24_I2C_DEVICE_ID(24cs02),
+	AT24_I2C_DEVICE_ID(24mac402),
+	AT24_I2C_DEVICE_ID(24mac602),
+	AT24_I2C_DEVICE_ID(spd),
+	AT24_I2C_DEVICE_ID(24c04),
+	AT24_I2C_DEVICE_ID(24cs04),
+	AT24_I2C_DEVICE_ID(24c08),
+	AT24_I2C_DEVICE_ID(24cs08),
+	AT24_I2C_DEVICE_ID(24c16),
+	AT24_I2C_DEVICE_ID(24cs16),
+	AT24_I2C_DEVICE_ID(24c32),
+	AT24_I2C_DEVICE_ID(24cs32),
+	AT24_I2C_DEVICE_ID(24c64),
+	AT24_I2C_DEVICE_ID(24cs64),
+	AT24_I2C_DEVICE_ID(24c128),
+	AT24_I2C_DEVICE_ID(24c256),
+	AT24_I2C_DEVICE_ID(24c512),
+	AT24_I2C_DEVICE_ID(24c1024),
 	{ "at24", 0 },
 	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(i2c, at24_ids);
 
 static const struct of_device_id at24_of_match[] = {
-	{
-		.compatible = "atmel,24c00",
-		.data = (void *)AT24_DEVICE_MAGIC(128 / 8, AT24_FLAG_TAKE8ADDR)
-	},
-	{
-		.compatible = "atmel,24c01",
-		.data = (void *)AT24_DEVICE_MAGIC(1024 / 8, 0)
-	},
-	{
-		.compatible = "atmel,24c02",
-		.data = (void *)AT24_DEVICE_MAGIC(2048 / 8, 0)
-	},
-	{
-		.compatible = "atmel,spd",
-		.data = (void *)AT24_DEVICE_MAGIC(2048 / 8,
-				AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
-	},
-	{
-		.compatible = "atmel,24c04",
-		.data = (void *)AT24_DEVICE_MAGIC(4096 / 8, 0)
-	},
-	{
-		.compatible = "atmel,24c08",
-		.data = (void *)AT24_DEVICE_MAGIC(8192 / 8, 0)
-	},
-	{
-		.compatible = "atmel,24c16",
-		.data = (void *)AT24_DEVICE_MAGIC(16384 / 8, 0)
-	},
-	{
-		.compatible = "atmel,24c32",
-		.data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
-	},
-	{
-		.compatible = "atmel,24c64",
-		.data = (void *)AT24_DEVICE_MAGIC(65536 / 8, AT24_FLAG_ADDR16)
-	},
-	{
-		.compatible = "atmel,24c128",
-		.data = (void *)AT24_DEVICE_MAGIC(131072 / 8, AT24_FLAG_ADDR16)
-	},
-	{
-		.compatible = "atmel,24c256",
-		.data = (void *)AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16)
-	},
-	{
-		.compatible = "atmel,24c512",
-		.data = (void *)AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16)
-	},
-	{
-		.compatible = "atmel,24c1024",
-		.data = (void *)AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16)
-	},
-	{ },
+	AT24_OF_DEVICE_ID("atmel,24c00", 24c00),
+	AT24_OF_DEVICE_ID("atmel,24c01", 24c01),
+	AT24_OF_DEVICE_ID("atmel,24c02", 24c02),
+	AT24_OF_DEVICE_ID("atmel,spd", spd),
+	AT24_OF_DEVICE_ID("atmel,24c04", 24c04),
+	AT24_OF_DEVICE_ID("atmel,24c08", 24c08),
+	AT24_OF_DEVICE_ID("atmel,24c16", 24c16),
+	AT24_OF_DEVICE_ID("atmel,24c32", 24c32),
+	AT24_OF_DEVICE_ID("atmel,24c64", 24c64),
+	AT24_OF_DEVICE_ID("atmel,24c128", 24c128),
+	AT24_OF_DEVICE_ID("atmel,24c256", 24c256),
+	AT24_OF_DEVICE_ID("atmel,24c512", 24c512),
+	AT24_OF_DEVICE_ID("atmel,24c1024", 24c1024),
+	{ /* END OF LIST */ },
 };
 MODULE_DEVICE_TABLE(of, at24_of_match);
 
 static const struct acpi_device_id at24_acpi_ids[] = {
-	{ "INT3499", AT24_DEVICE_MAGIC(8192 / 8, 0) },
-	{ }
+	AT24_ACPI_DEVICE_ID(INT3499),
+	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
 
@@ -525,8 +521,8 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct at24_platform_data chip;
-	kernel_ulong_t magic = 0;
+	struct at24_platform_data chip = { 0 };
+	const struct at24_chip_data *cd = NULL;
 	bool writable;
 	struct at24_data *at24;
 	int err;
@@ -544,28 +540,22 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 */
 		if (client->dev.of_node &&
 		    of_match_device(at24_of_match, &client->dev)) {
-			magic = (kernel_ulong_t)
-				of_device_get_match_data(&client->dev);
+			cd = of_device_get_match_data(&client->dev);
 		} else if (id) {
-			magic = id->driver_data;
+			cd = (void *)id->driver_data;
 		} else {
 			const struct acpi_device_id *aid;
 
 			aid = acpi_match_device(at24_acpi_ids, &client->dev);
 			if (aid)
-				magic = aid->driver_data;
+				cd = (void *)aid->driver_data;
 		}
-		if (!magic)
+		if (!cd)
 			return -ENODEV;
 
-		chip.byte_len = BIT(magic & AT24_BITMASK(AT24_SIZE_BYTELEN));
-		magic >>= AT24_SIZE_BYTELEN;
-		chip.flags = magic & AT24_BITMASK(AT24_SIZE_FLAGS);
-
+		chip.byte_len = cd->byte_len;
+		chip.flags = cd->flags;
 		at24_get_pdata(&client->dev, &chip);
-
-		chip.setup = NULL;
-		chip.context = NULL;
 	}
 
 	if (!is_power_of_2(chip.byte_len))
-- 
1.9.1
