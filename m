From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 11/21] eeprom: at24: rename chip to pdata in at24_probe()
Date: Mon, 19 Mar 2018 10:17:11 +0100
Message-ID: <20180319091721.18193-12-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Reflect the purpose of this variable: it contains platform data so name
it such.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index dad5b0f0606e..93431d1296d9 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -516,7 +516,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
 	const struct at24_chip_data *cd = NULL;
-	struct at24_platform_data chip = { };
+	struct at24_platform_data pdata = { };
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	bool writable;
@@ -524,7 +524,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int err;
 
 	if (client->dev.platform_data) {
-		chip = *(struct at24_platform_data *)client->dev.platform_data;
+		pdata = *(struct at24_platform_data *)client->dev.platform_data;
 	} else {
 		/*
 		 * The I2C core allows OF nodes compatibles to match against the
@@ -546,32 +546,32 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (!cd)
 			return -ENODEV;
 
-		chip.byte_len = cd->byte_len;
-		chip.flags = cd->flags;
-		at24_properties_to_pdata(&client->dev, &chip);
+		pdata.byte_len = cd->byte_len;
+		pdata.flags = cd->flags;
+		at24_properties_to_pdata(&client->dev, &pdata);
 	}
 
-	if (!chip.page_size) {
+	if (!pdata.page_size) {
 		dev_err(&client->dev, "page_size must not be 0!\n");
 		return -EINVAL;
 	}
-	if (!is_power_of_2(chip.page_size))
+	if (!is_power_of_2(pdata.page_size))
 		dev_warn(&client->dev,
 			"page_size looks suspicious (no power of 2)!\n");
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
 	    !i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
-		chip.page_size = 1;
+		pdata.page_size = 1;
 
-	if (chip.flags & AT24_FLAG_TAKE8ADDR)
+	if (pdata.flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
 	else
-		num_addresses =	DIV_ROUND_UP(chip.byte_len,
-			(chip.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+		num_addresses =	DIV_ROUND_UP(pdata.byte_len,
+			(pdata.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
 
 	regmap_config.val_bits = 8;
-	regmap_config.reg_bits = (chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
 	at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
@@ -580,9 +580,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -ENOMEM;
 
 	mutex_init(&at24->lock);
-	at24->chip = chip;
+	at24->chip = pdata;
 	at24->num_addresses = num_addresses;
-	at24->offset_adj = at24_get_offset_adj(chip.flags, chip.byte_len);
+	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
 
 	at24->wp_gpio = devm_gpiod_get_optional(&client->dev,
 						"wp", GPIOD_OUT_HIGH);
@@ -594,16 +594,16 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (IS_ERR(at24->client[0].regmap))
 		return PTR_ERR(at24->client[0].regmap);
 
-	if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
+	if ((pdata.flags & AT24_FLAG_SERIAL) && (pdata.flags & AT24_FLAG_MAC)) {
 		dev_err(&client->dev,
 			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
 		return -EINVAL;
 	}
 
-	writable = !(chip.flags & AT24_FLAG_READONLY);
+	writable = !(pdata.flags & AT24_FLAG_READONLY);
 	if (writable) {
 		at24->write_max = min_t(unsigned int,
-					chip.page_size, at24_io_limit);
+					pdata.page_size, at24_io_limit);
 		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
 		    at24->write_max > I2C_SMBUS_BLOCK_MAX)
 			at24->write_max = I2C_SMBUS_BLOCK_MAX;
@@ -657,7 +657,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	nvmem_config.priv = at24;
 	nvmem_config.stride = 1;
 	nvmem_config.word_size = 1;
-	nvmem_config.size = chip.byte_len;
+	nvmem_config.size = pdata.byte_len;
 
 	at24->nvmem = nvmem_register(&nvmem_config);
 
@@ -667,12 +667,12 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	dev_info(&client->dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
-		chip.byte_len, client->name,
+		pdata.byte_len, client->name,
 		writable ? "writable" : "read-only", at24->write_max);
 
 	/* export data to kernel code */
-	if (chip.setup)
-		chip.setup(at24->nvmem, chip.context);
+	if (pdata.setup)
+		pdata.setup(at24->nvmem, pdata.context);
 
 	return 0;
 
-- 
2.16.1
