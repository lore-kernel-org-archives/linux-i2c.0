From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v6 7/7] eeprom: at24: remove now unneeded smbus-related code
Date: Tue, 28 Nov 2017 21:51:54 +0100
Message-ID: <3a69ee9f-974a-1333-a8a2-4ce3bd198942@gmail.com>
References: <328f770d-e79d-cbb5-1cd7-238862aa8e1c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40815 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbdK1UwO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Nov 2017 15:52:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id v19so2015115wmh.5
        for <linux-i2c@vger.kernel.org>; Tue, 28 Nov 2017 12:52:14 -0800 (PST)
In-Reply-To: <328f770d-e79d-cbb5-1cd7-238862aa8e1c@gmail.com>
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
v5:
- rebased
v6:
- re-introduce check for I2C_SMBUS_BLOCK_MAX
---
 drivers/misc/eeprom/at24.c | 56 +++++++---------------------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ad43f4ca1..cd87f1b21 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -521,8 +521,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_platform_data chip;
 	kernel_ulong_t magic = 0;
 	bool writable;
-	int use_smbus = 0;
-	int use_smbus_write = 0;
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
@@ -584,33 +582,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (chip.flags & AT24_FLAG_MAC && chip.byte_len == 4)
 		chip.byte_len = 6;
 
-	/* Use I2C operations unless we're stuck with SMBus extensions. */
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		if (chip.flags & AT24_FLAG_ADDR16)
-			return -EPFNOSUPPORT;
-
-		if (i2c_check_functionality(client->adapter,
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
-			chip.page_size = 1;
-		}
-	}
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
+	    !i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
+		chip.page_size = 1;
 
 	if (chip.flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
@@ -646,19 +621,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
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
+		at24->write_max = min_t(unsigned int, chip.page_size, io_limit);
+		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
+		    at24->write_max > I2C_SMBUS_BLOCK_MAX)
+			at24->write_max = I2C_SMBUS_BLOCK_MAX;
 	}
 
 	/* use dummy devices for multiple-address chips */
@@ -720,12 +686,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
