From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v6 3/3] eeprom: at24: switch to device-managed version of
 i2c_new_dummy
Date: Wed, 20 Dec 2017 07:24:25 +0100
Message-ID: <d8a5aeef-cc14-5b80-3434-8991d3f57000@gmail.com>
References: <5a66eaa1-9735-4b63-be66-b640f993bd21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42755 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754405AbdLTGYi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 01:24:38 -0500
In-Reply-To: <5a66eaa1-9735-4b63-be66-b640f993bd21@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

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
v6:
- rebased
---
 drivers/misc/eeprom/at24.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b44a3d2b2..6232765bb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -626,21 +626,19 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
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
-						at24->client[i].client,
-						&regmap_config);
-		if (IS_ERR(at24->client[i].regmap)) {
-			err = PTR_ERR(at24->client[i].regmap);
-			goto err_clients;
+				client->addr + i);
+			return PTR_ERR(cl->client);
 		}
+		cl->regmap = devm_regmap_init_i2c(cl->client, &regmap_config);
+		if (IS_ERR(cl->regmap))
+			return PTR_ERR(cl->regmap);
 	}
 
 	i2c_set_clientdata(client, at24);
@@ -692,10 +690,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return 0;
 
 err_clients:
-	for (i = 1; i < num_addresses; i++)
-		if (at24->client[i].client)
-			i2c_unregister_device(at24->client[i].client);
-
 	pm_runtime_disable(&client->dev);
 
 	return err;
@@ -704,15 +698,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
