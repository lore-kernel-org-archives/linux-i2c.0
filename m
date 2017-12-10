From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] eeprom: at24: code shrink
Date: Sun, 10 Dec 2017 20:29:47 +0100
Message-ID: <20171210192947.32211-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

A regmap_config struct is pretty big and declaring two of them
statically just to tweak the reg_bits value adds unnecessary bloat.

Declare the regmap config locally in at24_probe() instead.

Bloat-o-meter output:

add/remove: 0/2 grow/shrink: 1/0 up/down: 20/-272 (-252)
Function                                     old     new   delta
at24_probe                                  1564    1584     +20
regmap_config_8                              136       -    -136
regmap_config_16                             136       -    -136
Total: Before=7010, After=6758, chg -3.59%

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ded86474b3de..5ecddbc74732 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -518,20 +518,6 @@ static void at24_regmap_lock_unlock_none(void *map)
 
 }
 
-static const struct regmap_config regmap_config_8 = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.lock = at24_regmap_lock_unlock_none,
-	.unlock = at24_regmap_lock_unlock_none,
-};
-
-static const struct regmap_config regmap_config_16 = {
-	.reg_bits = 16,
-	.val_bits = 8,
-	.lock = at24_regmap_lock_unlock_none,
-	.unlock = at24_regmap_lock_unlock_none,
-};
-
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct at24_platform_data chip;
@@ -540,7 +526,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
-	const struct regmap_config *config;
+	struct regmap_config config = { };
 	u8 test_byte;
 
 	if (client->dev.platform_data) {
@@ -609,10 +595,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		num_addresses =	DIV_ROUND_UP(chip.byte_len,
 			(chip.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
 
-	if (chip.flags & AT24_FLAG_ADDR16)
-		config = &regmap_config_16;
-	else
-		config = &regmap_config_8;
+	config.val_bits = 8;
+	config.lock = config.unlock = at24_regmap_lock_unlock_none;
+	config.reg_bits = (chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
 
 	at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
 		num_addresses * sizeof(struct at24_client), GFP_KERNEL);
@@ -625,7 +610,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->offset_adj = at24_get_offset_adj(chip.flags, chip.byte_len);
 
 	at24->client[0].client = client;
-	at24->client[0].regmap = devm_regmap_init_i2c(client, config);
+	at24->client[0].regmap = devm_regmap_init_i2c(client, &config);
 	if (IS_ERR(at24->client[0].regmap))
 		return PTR_ERR(at24->client[0].regmap);
 
@@ -654,7 +639,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			goto err_clients;
 		}
 		at24->client[i].regmap = devm_regmap_init_i2c(
-					at24->client[i].client, config);
+					at24->client[i].client, &config);
 		if (IS_ERR(at24->client[i].regmap)) {
 			err = PTR_ERR(at24->client[i].regmap);
 			goto err_clients;
-- 
2.15.1
