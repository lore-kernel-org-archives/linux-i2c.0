From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
Date: Mon, 20 May 2019 09:10:41 +0200
Message-ID: <20190520071042.21072-2-brgl@bgdev.pl>
References: <20190520071042.21072-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520071042.21072-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that it's upstream, use the resource managed version
of i2c_new_dummy_device().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 63aa541c9608..bdeec0777029 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -507,14 +507,6 @@ static const struct at24_chip_data *at24_get_chip_data(struct device *dev)
 	return cdata;
 }
 
-static void at24_remove_dummy_clients(struct at24_data *at24)
-{
-	int i;
-
-	for (i = 1; i < at24->num_addresses; i++)
-		i2c_unregister_device(at24->client[i].client);
-}
-
 static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,
 				  struct regmap_config *regmap_config)
 {
@@ -527,18 +519,14 @@ static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,
 	dev = &base_client->dev;
 	addr = base_client->addr + index;
 
-	dummy_client = i2c_new_dummy(base_client->adapter,
-				     base_client->addr + index);
-	if (!dummy_client) {
-		dev_err(dev, "address 0x%02x unavailable\n", addr);
-		return -EADDRINUSE;
-	}
+	dummy_client = devm_i2c_new_dummy_device(dev, base_client->adapter,
+						 base_client->addr + index);
+	if (IS_ERR(dummy_client))
+		return PTR_ERR(dummy_client);
 
 	regmap = devm_regmap_init_i2c(dummy_client, regmap_config);
-	if (IS_ERR(regmap)) {
-		i2c_unregister_device(dummy_client);
+	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-	}
 
 	at24->client[index].client = dummy_client;
 	at24->client[index].regmap = regmap;
@@ -693,10 +681,8 @@ static int at24_probe(struct i2c_client *client)
 	/* use dummy devices for multiple-address chips */
 	for (i = 1; i < num_addresses; i++) {
 		err = at24_make_dummy_client(at24, i, &regmap_config);
-		if (err) {
-			at24_remove_dummy_clients(at24);
+		if (err)
 			return err;
-		}
 	}
 
 	i2c_set_clientdata(client, at24);
@@ -713,7 +699,7 @@ static int at24_probe(struct i2c_client *client)
 	pm_runtime_idle(dev);
 	if (err) {
 		err = -ENODEV;
-		goto err_clients;
+		goto err_runtime_pm;
 	}
 
 	nvmem_config.name = dev_name(dev);
@@ -733,7 +719,7 @@ static int at24_probe(struct i2c_client *client)
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
-		goto err_clients;
+		goto err_runtime_pm;
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
@@ -742,8 +728,7 @@ static int at24_probe(struct i2c_client *client)
 
 	return 0;
 
-err_clients:
-	at24_remove_dummy_clients(at24);
+err_runtime_pm:
 	pm_runtime_disable(dev);
 
 	return err;
@@ -751,11 +736,6 @@ static int at24_probe(struct i2c_client *client)
 
 static int at24_remove(struct i2c_client *client)
 {
-	struct at24_data *at24;
-
-	at24 = i2c_get_clientdata(client);
-
-	at24_remove_dummy_clients(at24);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.21.0
