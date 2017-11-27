From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 4/7] eeprom: at24: remove old write functions
Date: Mon, 27 Nov 2017 21:34:24 +0100
Message-ID: <8b47f81e-ad98-626c-cb96-8f2a325b1ce6@gmail.com>
References: <2c379f45-d5e3-71af-eb20-ca51e09d9257@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36144 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbdK0Ues (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 15:34:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so37777489wmr.1
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 12:34:48 -0800 (PST)
In-Reply-To: <2c379f45-d5e3-71af-eb20-ca51e09d9257@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Remove the old and now unused write functions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- rebased
v4:
- no changes
v5:
- no changes
---
 drivers/misc/eeprom/at24.c | 117 ---------------------------------------------
 1 file changed, 117 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ca80424f3..3df2301a9 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -64,11 +64,8 @@ struct at24_client {
 struct at24_data {
 	struct at24_platform_data chip;
 	int use_smbus;
-	int use_smbus_write;
 
 	ssize_t (*read_func)(struct at24_data *, char *, unsigned int, size_t);
-	ssize_t (*write_func)(struct at24_data *,
-			      const char *, unsigned int, size_t);
 
 	/*
 	 * Lock protects against activities from other Linux tasks,
@@ -76,7 +73,6 @@ struct at24_data {
 	 */
 	struct mutex lock;
 
-	u8 *writebuf;
 	unsigned write_max;
 	unsigned num_addresses;
 
@@ -481,62 +477,6 @@ static size_t at24_adjust_write_count(struct at24_data *at24,
 	return count;
 }
 
-static ssize_t at24_eeprom_write_smbus_block(struct at24_data *at24,
-					     const char *buf,
-					     unsigned int offset, size_t count)
-{
-	unsigned long timeout, write_time;
-	struct at24_client *at24_client;
-	struct i2c_client *client;
-	ssize_t status = 0;
-
-	at24_client = at24_translate_offset(at24, &offset);
-	client = at24_client->client;
-	count = at24_adjust_write_count(at24, offset, count);
-
-	loop_until_timeout(timeout, write_time) {
-		status = i2c_smbus_write_i2c_block_data(client,
-							offset, count, buf);
-		if (status == 0)
-			status = count;
-
-		dev_dbg(&client->dev, "write %zu@%d --> %zd (%ld)\n",
-				count, offset, status, jiffies);
-
-		if (status == count)
-			return count;
-	}
-
-	return -ETIMEDOUT;
-}
-
-static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
-					    const char *buf,
-					    unsigned int offset, size_t count)
-{
-	unsigned long timeout, write_time;
-	struct at24_client *at24_client;
-	struct i2c_client *client;
-	ssize_t status = 0;
-
-	at24_client = at24_translate_offset(at24, &offset);
-	client = at24_client->client;
-
-	loop_until_timeout(timeout, write_time) {
-		status = i2c_smbus_write_byte_data(client, offset, buf[0]);
-		if (status == 0)
-			status = count;
-
-		dev_dbg(&client->dev, "write %zu@%d --> %zd (%ld)\n",
-				count, offset, status, jiffies);
-
-		if (status == count)
-			return count;
-	}
-
-	return -ETIMEDOUT;
-}
-
 static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 				 unsigned int offset, size_t count)
 {
@@ -562,47 +502,6 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 	return -ETIMEDOUT;
 }
 
-static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
-				     unsigned int offset, size_t count)
-{
-	unsigned long timeout, write_time;
-	struct at24_client *at24_client;
-	struct i2c_client *client;
-	struct i2c_msg msg;
-	ssize_t status = 0;
-	int i = 0;
-
-	at24_client = at24_translate_offset(at24, &offset);
-	client = at24_client->client;
-	count = at24_adjust_write_count(at24, offset, count);
-
-	msg.addr = client->addr;
-	msg.flags = 0;
-
-	/* msg.buf is u8 and casts will mask the values */
-	msg.buf = at24->writebuf;
-	if (at24->chip.flags & AT24_FLAG_ADDR16)
-		msg.buf[i++] = offset >> 8;
-
-	msg.buf[i++] = offset;
-	memcpy(&msg.buf[i], buf, count);
-	msg.len = i + count;
-
-	loop_until_timeout(timeout, write_time) {
-		status = i2c_transfer(client->adapter, &msg, 1);
-		if (status == 1)
-			status = count;
-
-		dev_dbg(&client->dev, "write %zu@%d --> %zd (%ld)\n",
-				count, offset, status, jiffies);
-
-		if (status == count)
-			return count;
-	}
-
-	return -ETIMEDOUT;
-}
-
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
@@ -842,7 +741,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	mutex_init(&at24->lock);
 	at24->use_smbus = use_smbus;
-	at24->use_smbus_write = use_smbus_write;
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
@@ -866,15 +764,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 						  : at24_eeprom_read_i2c;
 	}
 
-	if (at24->use_smbus) {
-		if (at24->use_smbus_write == I2C_SMBUS_I2C_BLOCK_DATA)
-			at24->write_func = at24_eeprom_write_smbus_block;
-		else
-			at24->write_func = at24_eeprom_write_smbus_byte;
-	} else {
-		at24->write_func = at24_eeprom_write_i2c;
-	}
-
 	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
 		if (!use_smbus || use_smbus_write) {
@@ -886,12 +775,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
 				write_max = I2C_SMBUS_BLOCK_MAX;
 			at24->write_max = write_max;
-
-			/* buffer (data + address at the beginning) */
-			at24->writebuf = devm_kzalloc(&client->dev,
-				write_max + 2, GFP_KERNEL);
-			if (!at24->writebuf)
-				return -ENOMEM;
 		} else {
 			dev_warn(&client->dev,
 				"cannot write due to controller restrictions.");
-- 
2.15.0
