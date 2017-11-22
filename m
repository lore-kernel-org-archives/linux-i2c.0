From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 7/7] eeprom: at24: remove now unneeded smbus-related code
Date: Wed, 22 Nov 2017 22:13:02 +0100
Message-ID: <8f1da8f7-859e-e3ab-f669-49ce977468da@gmail.com>
References: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41423 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdKVVNQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Nov 2017 16:13:16 -0500
Received: by mail-wr0-f196.google.com with SMTP id z14so15789777wrb.8
        for <linux-i2c@vger.kernel.org>; Wed, 22 Nov 2017 13:13:15 -0800 (PST)
In-Reply-To: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Remove remaining now unneeded code dealing with SMBUS details.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- rebased
v4:
- rebased
---
 drivers/misc/eeprom/at24.c | 52 ++++------------------------------------------
 1 file changed, 4 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c65169fdf..d80f36d70 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -513,8 +513,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_platform_data chip;
 	kernel_ulong_t magic = 0;
 	bool writable;
-	int use_smbus = 0;
-	int use_smbus_write = 0;
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
@@ -566,33 +564,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		dev_warn(&client->dev,
 			"page_size looks suspicious (no power of 2)!\n");
 
-	/* Use I2C operations unless we're stuck with SMBus extensions. */
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		if (chip.flags & AT24_FLAG_ADDR16)
-			return -EPFNOSUPPORT;
-
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		if (i2c_check_functionality(client->adapter,
-				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
-		} else if (i2c_check_functionality(client->adapter,
-				I2C_FUNC_SMBUS_READ_WORD_DATA)) {
-			use_smbus = I2C_SMBUS_WORD_DATA;
-		} else if (i2c_check_functionality(client->adapter,
-				I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
-			use_smbus = I2C_SMBUS_BYTE_DATA;
-		} else {
-			return -EPFNOSUPPORT;
-		}
-
-		if (i2c_check_functionality(client->adapter,
-				I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
-			use_smbus_write = I2C_SMBUS_I2C_BLOCK_DATA;
-		} else if (i2c_check_functionality(client->adapter,
-				I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
-			use_smbus_write = I2C_SMBUS_BYTE_DATA;
+				I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
 			chip.page_size = 1;
-		}
-	}
 
 	if (chip.flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
@@ -628,21 +603,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->offset_adj = at24_get_offset_adj(chip.flags);
 
 	writable = !(chip.flags & AT24_FLAG_READONLY);
-	if (writable) {
-		if (!use_smbus || use_smbus_write) {
-
-			unsigned write_max = chip.page_size;
-
-			if (write_max > io_limit)
-				write_max = io_limit;
-			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
-				write_max = I2C_SMBUS_BLOCK_MAX;
-			at24->write_max = write_max;
-		} else {
-			dev_warn(&client->dev,
-				"cannot write due to controller restrictions.");
-		}
-	}
+	if (writable)
+		at24->write_max = min_t(unsigned int, chip.page_size, io_limit);
 
 	/* use dummy devices for multiple-address chips */
 	for (i = 1; i < num_addresses; i++) {
@@ -703,12 +665,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	dev_info(&client->dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
 		chip.byte_len, client->name,
 		writable ? "writable" : "read-only", at24->write_max);
-	if (use_smbus == I2C_SMBUS_WORD_DATA ||
-	    use_smbus == I2C_SMBUS_BYTE_DATA) {
-		dev_notice(&client->dev, "Falling back to %s reads, "
-			   "performance will suffer\n", use_smbus ==
-			   I2C_SMBUS_WORD_DATA ? "word" : "byte");
-	}
 
 	/* export data to kernel code */
 	if (chip.setup)
-- 
2.15.0
