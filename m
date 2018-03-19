From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 12/21] eeprom: at24: use a helper variable for dev
Date: Mon, 19 Mar 2018 10:17:12 +0100
Message-ID: <20180319091721.18193-13-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

We use the &client->dev construct all over in at24_probe(). Use
a helper variable which is more readable and allows to avoid a couple
unnecessary line breaks.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 48 ++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 93431d1296d9..e4c1997c2b56 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -517,29 +517,29 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct nvmem_config nvmem_config = { };
 	const struct at24_chip_data *cd = NULL;
 	struct at24_platform_data pdata = { };
+	struct device *dev = &client->dev;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	bool writable;
 	u8 test_byte;
 	int err;
 
-	if (client->dev.platform_data) {
-		pdata = *(struct at24_platform_data *)client->dev.platform_data;
+	if (dev->platform_data) {
+		pdata = *(struct at24_platform_data *)dev->platform_data;
 	} else {
 		/*
 		 * The I2C core allows OF nodes compatibles to match against the
 		 * I2C device ID table as a fallback, so check not only if an OF
 		 * node is present but also if it matches an OF device ID entry.
 		 */
-		if (client->dev.of_node &&
-		    of_match_device(at24_of_match, &client->dev)) {
-			cd = of_device_get_match_data(&client->dev);
+		if (dev->of_node && of_match_device(at24_of_match, dev)) {
+			cd = of_device_get_match_data(dev);
 		} else if (id) {
 			cd = (void *)id->driver_data;
 		} else {
 			const struct acpi_device_id *aid;
 
-			aid = acpi_match_device(at24_acpi_ids, &client->dev);
+			aid = acpi_match_device(at24_acpi_ids, dev);
 			if (aid)
 				cd = (void *)aid->driver_data;
 		}
@@ -548,16 +548,15 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 		pdata.byte_len = cd->byte_len;
 		pdata.flags = cd->flags;
-		at24_properties_to_pdata(&client->dev, &pdata);
+		at24_properties_to_pdata(dev, &pdata);
 	}
 
 	if (!pdata.page_size) {
-		dev_err(&client->dev, "page_size must not be 0!\n");
+		dev_err(dev, "page_size must not be 0!\n");
 		return -EINVAL;
 	}
 	if (!is_power_of_2(pdata.page_size))
-		dev_warn(&client->dev,
-			"page_size looks suspicious (no power of 2)!\n");
+		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
 	    !i2c_check_functionality(client->adapter,
@@ -574,8 +573,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
-	at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
-		num_addresses * sizeof(struct at24_client), GFP_KERNEL);
+	at24 = devm_kzalloc(dev, sizeof(struct at24_data) + num_addresses *
+			    sizeof(struct at24_client), GFP_KERNEL);
 	if (!at24)
 		return -ENOMEM;
 
@@ -584,8 +583,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->num_addresses = num_addresses;
 	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
 
-	at24->wp_gpio = devm_gpiod_get_optional(&client->dev,
-						"wp", GPIOD_OUT_HIGH);
+	at24->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_HIGH);
 	if (IS_ERR(at24->wp_gpio))
 		return PTR_ERR(at24->wp_gpio);
 
@@ -595,7 +593,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return PTR_ERR(at24->client[0].regmap);
 
 	if ((pdata.flags & AT24_FLAG_SERIAL) && (pdata.flags & AT24_FLAG_MAC)) {
-		dev_err(&client->dev,
+		dev_err(dev,
 			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
 		return -EINVAL;
 	}
@@ -614,8 +612,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		at24->client[i].client = i2c_new_dummy(client->adapter,
 						       client->addr + i);
 		if (!at24->client[i].client) {
-			dev_err(&client->dev, "address 0x%02x unavailable\n",
-					client->addr + i);
+			dev_err(dev, "address 0x%02x unavailable\n",
+				client->addr + i);
 			err = -EADDRINUSE;
 			goto err_clients;
 		}
@@ -631,27 +629,27 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	i2c_set_clientdata(client, at24);
 
 	/* enable runtime pm */
-	pm_runtime_set_active(&client->dev);
-	pm_runtime_enable(&client->dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	/*
 	 * Perform a one-byte test read to verify that the
 	 * chip is functional.
 	 */
 	err = at24_read(at24, 0, &test_byte, 1);
-	pm_runtime_idle(&client->dev);
+	pm_runtime_idle(dev);
 	if (err) {
 		err = -ENODEV;
 		goto err_clients;
 	}
 
-	nvmem_config.name = dev_name(&client->dev);
-	nvmem_config.dev = &client->dev;
+	nvmem_config.name = dev_name(dev);
+	nvmem_config.dev = dev;
 	nvmem_config.read_only = !writable;
 	nvmem_config.root_only = true;
 	nvmem_config.owner = THIS_MODULE;
 	nvmem_config.compat = true;
-	nvmem_config.base_dev = &client->dev;
+	nvmem_config.base_dev = dev;
 	nvmem_config.reg_read = at24_read;
 	nvmem_config.reg_write = at24_write;
 	nvmem_config.priv = at24;
@@ -666,7 +664,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto err_clients;
 	}
 
-	dev_info(&client->dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
+	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
 		pdata.byte_len, client->name,
 		writable ? "writable" : "read-only", at24->write_max);
 
@@ -681,7 +679,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (at24->client[i].client)
 			i2c_unregister_device(at24->client[i].client);
 
-	pm_runtime_disable(&client->dev);
+	pm_runtime_disable(dev);
 
 	return err;
 }
-- 
2.16.1
