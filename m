From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 6/7] eeprom: at24: eeprom: at24: remove old read functions
Date: Thu, 16 Nov 2017 21:26:57 +0100
Message-ID: <cd0b0800-0825-6970-d76f-7dfaa57d5424@gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37783 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759050AbdKPU1Z (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Nov 2017 15:27:25 -0500
Received: by mail-wr0-f195.google.com with SMTP id k61so244942wrc.4
        for <linux-i2c@vger.kernel.org>; Thu, 16 Nov 2017 12:27:24 -0800 (PST)
In-Reply-To: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Remove the old and now unused read functions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
---
 drivers/misc/eeprom/at24.c | 177 ---------------------------------------------
 1 file changed, 177 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 391e0d998..a4e157b6b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -63,9 +63,6 @@ struct at24_client {
 
 struct at24_data {
 	struct at24_platform_data chip;
-	int use_smbus;
-
-	ssize_t (*read_func)(struct at24_data *, char *, unsigned int, size_t);
 
 	/*
 	 * Lock protects against activities from other Linux tasks,
@@ -279,37 +276,6 @@ static struct at24_client *at24_translate_offset(struct at24_data *at24,
 	return &at24->client[i];
 }
 
-static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
-				      unsigned int offset, size_t count)
-{
-	unsigned long timeout, read_time;
-	struct i2c_client *client;
-	int status;
-
-	client = at24_translate_offset(at24, &offset)->client;
-
-	if (count > io_limit)
-		count = io_limit;
-
-	/* Smaller eeproms can work given some SMBus extension calls */
-	if (count > I2C_SMBUS_BLOCK_MAX)
-		count = I2C_SMBUS_BLOCK_MAX;
-
-	loop_until_timeout(timeout, read_time) {
-		status = i2c_smbus_read_i2c_block_data_or_emulated(client,
-								   offset,
-								   count, buf);
-
-		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
-				count, offset, status, jiffies);
-
-		if (status == count)
-			return count;
-	}
-
-	return -ETIMEDOUT;
-}
-
 static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 				unsigned int offset, size_t count)
 {
@@ -363,139 +329,6 @@ static ssize_t at24_regmap_read_serial(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
-static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
-				    unsigned int offset, size_t count)
-{
-	unsigned long timeout, read_time;
-	struct i2c_client *client;
-	struct i2c_msg msg[2];
-	int status, i;
-	u8 msgbuf[2];
-
-	memset(msg, 0, sizeof(msg));
-	client = at24_translate_offset(at24, &offset)->client;
-
-	if (count > io_limit)
-		count = io_limit;
-
-	/*
-	 * When we have a better choice than SMBus calls, use a combined I2C
-	 * message. Write address; then read up to io_limit data bytes. Note
-	 * that read page rollover helps us here (unlike writes). msgbuf is
-	 * u8 and will cast to our needs.
-	 */
-	i = 0;
-	if (at24->chip.flags & AT24_FLAG_ADDR16)
-		msgbuf[i++] = offset >> 8;
-	msgbuf[i++] = offset;
-
-	msg[0].addr = client->addr;
-	msg[0].buf = msgbuf;
-	msg[0].len = i;
-
-	msg[1].addr = client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].buf = buf;
-	msg[1].len = count;
-
-	loop_until_timeout(timeout, read_time) {
-		status = i2c_transfer(client->adapter, msg, 2);
-		if (status == 2)
-			status = count;
-
-		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
-				count, offset, status, jiffies);
-
-		if (status == count)
-			return count;
-	}
-
-	return -ETIMEDOUT;
-}
-
-static ssize_t at24_eeprom_read_serial(struct at24_data *at24, char *buf,
-				       unsigned int offset, size_t count)
-{
-	unsigned long timeout, read_time;
-	struct i2c_client *client;
-	struct i2c_msg msg[2];
-	u8 addrbuf[2];
-	int status;
-
-	client = at24_translate_offset(at24, &offset)->client;
-
-	memset(msg, 0, sizeof(msg));
-	msg[0].addr = client->addr;
-	msg[0].buf = addrbuf;
-
-	/*
-	 * The address pointer of the device is shared between the regular
-	 * EEPROM array and the serial number block. The dummy write (part of
-	 * the sequential read protocol) ensures the address pointer is reset
-	 * to the desired position.
-	 */
-	if (at24->chip.flags & AT24_FLAG_ADDR16) {
-		/*
-		 * For 16 bit address pointers, the word address must contain
-		 * a '10' sequence in bits 11 and 10 regardless of the
-		 * intended position of the address pointer.
-		 */
-		addrbuf[0] = 0x08;
-		addrbuf[1] = offset;
-		msg[0].len = 2;
-	} else {
-		/*
-		 * Otherwise the word address must begin with a '10' sequence,
-		 * regardless of the intended address.
-		 */
-		addrbuf[0] = 0x80 + offset;
-		msg[0].len = 1;
-	}
-
-	msg[1].addr = client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].buf = buf;
-	msg[1].len = count;
-
-	loop_until_timeout(timeout, read_time) {
-		status = i2c_transfer(client->adapter, msg, 2);
-		if (status == 2)
-			return count;
-	}
-
-	return -ETIMEDOUT;
-}
-
-static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
-				    unsigned int offset, size_t count)
-{
-	unsigned long timeout, read_time;
-	struct i2c_client *client;
-	struct i2c_msg msg[2];
-	u8 addrbuf[2];
-	int status;
-
-	client = at24_translate_offset(at24, &offset)->client;
-
-	memset(msg, 0, sizeof(msg));
-	msg[0].addr = client->addr;
-	msg[0].buf = addrbuf;
-	addrbuf[0] = 0x90 + offset;
-	msg[0].len = 1;
-	msg[1].addr = client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].buf = buf;
-	msg[1].len = count;
-
-	loop_until_timeout(timeout, read_time) {
-		status = i2c_transfer(client->adapter, msg, 2);
-		if (status == 2)
-			return count;
-	}
-
-	return -ETIMEDOUT;
-}
-
 /*
  * Note that if the hardware write-protect pin is pulled high, the whole
  * chip is normally write protected. But there are plenty of product
@@ -769,7 +602,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -ENOMEM;
 
 	mutex_init(&at24->lock);
-	at24->use_smbus = use_smbus;
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
@@ -784,15 +616,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EINVAL;
 	}
 
-	if (chip.flags & AT24_FLAG_SERIAL) {
-		at24->read_func = at24_eeprom_read_serial;
-	} else if (chip.flags & AT24_FLAG_MAC) {
-		at24->read_func = at24_eeprom_read_mac;
-	} else {
-		at24->read_func = at24->use_smbus ? at24_eeprom_read_smbus
-						  : at24_eeprom_read_i2c;
-	}
-
 	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
 		if (!use_smbus || use_smbus_write) {
-- 
2.15.0
