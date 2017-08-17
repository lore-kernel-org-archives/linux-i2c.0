From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC 7/7] eeprom: at24: remove now unneeded smbus-related code
Date: Thu, 17 Aug 2017 07:59:26 +0200
Message-ID: <26a09a4b-2f2d-2f9d-b252-d0f3cf85bffa@gmail.com>
References: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36164 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdHQF7p (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Aug 2017 01:59:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id y67so6487810wrb.3
        for <linux-i2c@vger.kernel.org>; Wed, 16 Aug 2017 22:59:44 -0700 (PDT)
In-Reply-To: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Remove remaining now unneeded code dealing with SMBUS details.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 52 ++++------------------------------------------
 1 file changed, 4 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 8f2106d3..db8524b5 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -414,8 +414,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_platform_data chip;
 	kernel_ulong_t magic = 0;
 	bool writable;
-	int use_smbus = 0;
-	int use_smbus_write = 0;
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
@@ -458,33 +456,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -518,21 +493,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
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
@@ -588,12 +550,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
2.14.1
