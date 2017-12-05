From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH resubmit 2/2] eeprom: at24: switch to device-managed version
 of i2c_new_dummy
Date: Tue, 5 Dec 2017 20:45:05 +0100
Message-ID: <723f192a-8401-4ed7-bf97-76a5a828a3c4@gmail.com>
References: <e70df557-3f71-9de2-6b1a-de566b47eb33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36509 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdLETpO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Dec 2017 14:45:14 -0500
In-Reply-To: <e70df557-3f71-9de2-6b1a-de566b47eb33@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Make use of recently introduced device-managed version of
i2c_new_dummy to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 625b00166..9e9fe69b4 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -621,9 +621,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* use dummy devices for multiple-address chips */
 	for (i = 1; i < num_addresses; i++) {
-		at24->client[i].client = i2c_new_dummy(client->adapter,
-						       client->addr + i);
-		if (!at24->client[i].client) {
+		at24->client[i].client = devm_i2c_new_dummy(&client->dev,
+							    client->adapter,
+							    client->addr + i);
+		if (IS_ERR(at24->client[i].client)) {
 			dev_err(&client->dev, "address 0x%02x unavailable\n",
 					client->addr + i);
 			err = -EADDRINUSE;
@@ -686,10 +687,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return 0;
 
 err_clients:
-	for (i = 1; i < num_addresses; i++)
-		if (at24->client[i].client)
-			i2c_unregister_device(at24->client[i].client);
-
 	pm_runtime_disable(&client->dev);
 
 	return err;
@@ -698,15 +695,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
