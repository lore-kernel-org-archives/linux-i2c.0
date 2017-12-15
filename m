From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 3/3] eeprom: at24: switch to device-managed version of
 i2c_new_dummy
Date: Sat, 16 Dec 2017 00:07:18 +0100
Message-ID: <1a7cd44c-529a-6bbd-c07c-19d3f93a73c1@gmail.com>
References: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Make use of recently introduced device-managed version of
i2c_new_dummy to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- small improvements regarding code readability
v3:
- no changes
v4:
- no changes
v5:
- no changes
---
 drivers/misc/eeprom/at24.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 848fda8be..fce00fbe4 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -636,20 +636,19 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* use dummy devices for multiple-address chips */
 	for (i = 1; i < num_addresses; i++) {
-		at24->client[i].client = i2c_new_dummy(client->adapter,
-						       client->addr + i);
-		if (!at24->client[i].client) {
+		struct at24_client *cl;
+
+		cl = &at24->client[i];
+		cl->client = devm_i2c_new_dummy(&client->dev, client->adapter,
+						client->addr + i);
+		if (IS_ERR(cl->client)) {
 			dev_err(&client->dev, "address 0x%02x unavailable\n",
-					client->addr + i);
-			err = -EADDRINUSE;
-			goto err_clients;
-		}
-		at24->client[i].regmap = devm_regmap_init_i2c(
-					at24->client[i].client, config);
-		if (IS_ERR(at24->client[i].regmap)) {
-			err = PTR_ERR(at24->client[i].regmap);
-			goto err_clients;
+				client->addr + i);
+			return PTR_ERR(cl->client);
 		}
+		cl->regmap = devm_regmap_init_i2c(cl->client, config);
+		if (IS_ERR(cl->regmap))
+			return PTR_ERR(cl->regmap);
 	}
 
 	i2c_set_clientdata(client, at24);
@@ -701,10 +700,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return 0;
 
 err_clients:
-	for (i = 1; i < num_addresses; i++)
-		if (at24->client[i].client)
-			i2c_unregister_device(at24->client[i].client);
-
 	pm_runtime_disable(&client->dev);
 
 	return err;
@@ -713,15 +708,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 static int at24_remove(struct i2c_client *client)
 {
 	struct at24_data *at24;
-	int i;
 
 	at24 = i2c_get_clientdata(client);
 
 	nvmem_unregister(at24->nvmem);
 
-	for (i = 1; i < at24->num_addresses; i++)
-		i2c_unregister_device(at24->client[i].client);
-
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.15.1
