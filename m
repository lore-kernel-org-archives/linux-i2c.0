From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 7/7] eeprom: at24: don't check page_size for read-only chips
 and reorder checks
Date: Thu, 30 Nov 2017 07:49:13 +0100
Message-ID: <314c04db-33b9-2cd2-c254-be7071cafdab@gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37333 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbdK3Gt0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 01:49:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id f140so10271374wmd.2
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 22:49:25 -0800 (PST)
In-Reply-To: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Currently we check for a proper page_size value also for read-only chips
where this value isn't used. Therefore remove these checks for read-only
chips.

In addition reorder checks to do sanity checking first. 
 
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 74d2347a1..2348da953 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -535,16 +535,28 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		at24_get_pdata(dev, &chip);
 	}
 
+	if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
+		dev_err(dev, "invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
+		return -EINVAL;
+	}
+
 	/* both flags imply read-only */
 	if (chip.flags & AT24_FLAG_SERIAL || chip.flags & AT24_FLAG_MAC)
 		chip.flags |= AT24_FLAG_READONLY;
 
-	if (!chip.page_size) {
-		dev_err(dev, "page_size must not be 0!\n");
-		return -EINVAL;
+	writable = !(chip.flags & AT24_FLAG_READONLY);
+	if (writable) {
+		if (!chip.page_size) {
+			dev_err(dev, "page_size must not be 0!\n");
+			return -EINVAL;
+		}
+		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
+		    !i2c_check_functionality(client->adapter,
+					     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
+			chip.page_size = 1;
+		if (!is_power_of_2(chip.page_size))
+			dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 	}
-	if (!is_power_of_2(chip.page_size))
-		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
 	/*
 	 * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
@@ -556,11 +568,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (chip.flags & AT24_FLAG_MAC && chip.byte_len == 4)
 		chip.byte_len = 6;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
-	    !i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
-		chip.page_size = 1;
-
 	if (chip.flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
 	else
@@ -587,12 +594,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (IS_ERR(at24->client[0].regmap))
 		return PTR_ERR(at24->client[0].regmap);
 
-	if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
-		dev_err(dev, "invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
-		return -EINVAL;
-	}
-
-	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
 		at24->write_max = min_t(unsigned int, chip.page_size, io_limit);
 		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
-- 
2.15.0
