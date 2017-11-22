From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 1/7] eeprom: at24: add basic regmap_i2c support
Date: Wed, 22 Nov 2017 08:02:33 +0100
Message-ID: <706d90a9-781f-0bff-6aff-edfd57d59de1@gmail.com>
References: <bcf28969-c6a3-805f-7df9-670dfbd99631@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42658 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdKVHGQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Nov 2017 02:06:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id l188so6249552wma.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Nov 2017 23:06:15 -0800 (PST)
In-Reply-To: <bcf28969-c6a3-805f-7df9-670dfbd99631@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

This patch adds basic regmap support to be used by subsequent
patches of this series.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- no changes
---
 drivers/misc/eeprom/Kconfig |  1 +
 drivers/misc/eeprom/at24.c  | 53 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index de5876209..68a1ac929 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -4,6 +4,7 @@ config EEPROM_AT24
 	tristate "I2C EEPROMs / RAMs / ROMs from most vendors"
 	depends on I2C && SYSFS
 	select NVMEM
+	select REGMAP_I2C
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs
 	  and compatible devices like FRAMs, SRAMs, ROMs etc. After you
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e0b4b36ef..911cce8ec 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -24,6 +24,7 @@
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
+#include <linux/regmap.h>
 #include <linux/platform_data/at24.h>
 #include <linux/pm_runtime.h>
 
@@ -55,6 +56,11 @@
  * which won't work on pure SMBus systems.
  */
 
+struct at24_client {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
 struct at24_data {
 	struct at24_platform_data chip;
 	int use_smbus;
@@ -81,7 +87,7 @@ struct at24_data {
 	 * Some chips tie up multiple I2C addresses; dummy devices reserve
 	 * them for us, and we'll use them with SMBus calls.
 	 */
-	struct i2c_client *client[];
+	struct at24_client client[];
 };
 
 /*
@@ -274,7 +280,7 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 		*offset &= 0xff;
 	}
 
-	return at24->client[i];
+	return at24->client[i].client;
 }
 
 static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
@@ -673,6 +679,16 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 	}
 }
 
+static const struct regmap_config regmap_config_8 = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct regmap_config regmap_config_16 = {
+	.reg_bits = 16,
+	.val_bits = 8,
+};
+
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct at24_platform_data chip;
@@ -683,6 +699,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
+	const struct regmap_config *config;
 	u8 test_byte;
 
 	if (client->dev.platform_data) {
@@ -764,8 +781,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		num_addresses =	DIV_ROUND_UP(chip.byte_len,
 			(chip.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
 
+	if (chip.flags & AT24_FLAG_ADDR16)
+		config = &regmap_config_16;
+	else
+		config = &regmap_config_8;
+
 	at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
-		num_addresses * sizeof(struct i2c_client *), GFP_KERNEL);
+		num_addresses * sizeof(struct at24_client), GFP_KERNEL);
 	if (!at24)
 		return -ENOMEM;
 
@@ -775,6 +797,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
+	at24->client[0].client = client;
+	at24->client[0].regmap = devm_regmap_init_i2c(client, config);
+	if (IS_ERR(at24->client[0].regmap))
+		return PTR_ERR(at24->client[0].regmap);
+
 	if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
 		dev_err(&client->dev,
 			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
@@ -822,18 +849,22 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	at24->client[0] = client;
-
 	/* use dummy devices for multiple-address chips */
 	for (i = 1; i < num_addresses; i++) {
-		at24->client[i] = i2c_new_dummy(client->adapter,
-					client->addr + i);
-		if (!at24->client[i]) {
+		at24->client[i].client = i2c_new_dummy(client->adapter,
+						       client->addr + i);
+		if (!at24->client[i].client) {
 			dev_err(&client->dev, "address 0x%02x unavailable\n",
 					client->addr + i);
 			err = -EADDRINUSE;
 			goto err_clients;
 		}
+		at24->client[i].regmap = devm_regmap_init_i2c(
+					at24->client[i].client, config);
+		if (IS_ERR(at24->client[i].regmap)) {
+			err = PTR_ERR(at24->client[i].regmap);
+			goto err_clients;
+		}
 	}
 
 	i2c_set_clientdata(client, at24);
@@ -892,8 +923,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 err_clients:
 	for (i = 1; i < num_addresses; i++)
-		if (at24->client[i])
-			i2c_unregister_device(at24->client[i]);
+		if (at24->client[i].client)
+			i2c_unregister_device(at24->client[i].client);
 
 	pm_runtime_disable(&client->dev);
 
@@ -910,7 +941,7 @@ static int at24_remove(struct i2c_client *client)
 	nvmem_unregister(at24->nvmem);
 
 	for (i = 1; i < at24->num_addresses; i++)
-		i2c_unregister_device(at24->client[i]);
+		i2c_unregister_device(at24->client[i].client);
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-- 
2.15.0
