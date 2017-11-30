From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/7] eeprom: at24: consider that SERIAL and MAC flags imply
 read-only
Date: Thu, 30 Nov 2017 07:49:00 +0100
Message-ID: <a2ff2cad-0901-f0f7-353f-f9dbcd293ce1@gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35062 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbdK3GtT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 01:49:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id f9so10342992wmh.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 22:49:19 -0800 (PST)
In-Reply-To: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Flags AT24_FLAG_SERIAL and AT24_FLAG_MAC imply read-only.
Therefore handle this in the code instead of specifying
AT24_FLAG_READONLY in the config data in these cases.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c75bb9b45..90fefd1cf 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -131,38 +131,29 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c00",	AT24_DEVICE_MAGIC(128 / 8,	AT24_FLAG_TAKE8ADDR) },
 	/* old variants can't be handled with this generic entry! */
 	{ "24c01",	AT24_DEVICE_MAGIC(1024 / 8,	0) },
-	{ "24cs01",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
+	{ "24cs01",	AT24_DEVICE_MAGIC(16,		AT24_FLAG_SERIAL) },
 	{ "24c02",	AT24_DEVICE_MAGIC(2048 / 8,	0) },
-	{ "24cs02",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
-	{ "24mac402",	AT24_DEVICE_MAGIC(48 / 8,
-				AT24_FLAG_MAC | AT24_FLAG_READONLY) },
-	{ "24mac602",	AT24_DEVICE_MAGIC(64 / 8,
-				AT24_FLAG_MAC | AT24_FLAG_READONLY) },
+	{ "24cs02",	AT24_DEVICE_MAGIC(16,		AT24_FLAG_SERIAL) },
+	{ "24mac402",	AT24_DEVICE_MAGIC(48 / 8,	AT24_FLAG_MAC) },
+	{ "24mac602",	AT24_DEVICE_MAGIC(64 / 8,	AT24_FLAG_MAC) },
 	/* spd is a 24c02 in memory DIMMs */
 	{ "spd",	AT24_DEVICE_MAGIC(2048 / 8,
 				AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
 	{ "24c04",	AT24_DEVICE_MAGIC(4096 / 8,	0) },
-	{ "24cs04",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
+	{ "24cs04",	AT24_DEVICE_MAGIC(16,	AT24_FLAG_SERIAL) },
 	/* 24rf08 quirk is handled at i2c-core */
 	{ "24c08",	AT24_DEVICE_MAGIC(8192 / 8,	0) },
-	{ "24cs08",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
+	{ "24cs08",	AT24_DEVICE_MAGIC(16,	AT24_FLAG_SERIAL) },
 	{ "24c16",	AT24_DEVICE_MAGIC(16384 / 8,	0) },
-	{ "24cs16",	AT24_DEVICE_MAGIC(16,
-				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
+	{ "24cs16",	AT24_DEVICE_MAGIC(16,		AT24_FLAG_SERIAL) },
 	{ "24c32",	AT24_DEVICE_MAGIC(32768 / 8,	AT24_FLAG_ADDR16) },
 	{ "24cs32",	AT24_DEVICE_MAGIC(16,
 				AT24_FLAG_ADDR16 |
-				AT24_FLAG_SERIAL |
-				AT24_FLAG_READONLY) },
+				AT24_FLAG_SERIAL) },
 	{ "24c64",	AT24_DEVICE_MAGIC(65536 / 8,	AT24_FLAG_ADDR16) },
 	{ "24cs64",	AT24_DEVICE_MAGIC(16,
 				AT24_FLAG_ADDR16 |
-				AT24_FLAG_SERIAL |
-				AT24_FLAG_READONLY) },
+				AT24_FLAG_SERIAL) },
 	{ "24c128",	AT24_DEVICE_MAGIC(131072 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c256",	AT24_DEVICE_MAGIC(262144 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c512",	AT24_DEVICE_MAGIC(524288 / 8,	AT24_FLAG_ADDR16) },
@@ -556,6 +547,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		chip.context = NULL;
 	}
 
+	/* both flags imply read-only */
+	if (chip.flags & AT24_FLAG_SERIAL || chip.flags & AT24_FLAG_MAC)
+		chip.flags |= AT24_FLAG_READONLY;
+
 	if (!is_power_of_2(chip.byte_len))
 		dev_warn(&client->dev,
 			"byte_len looks suspicious (no power of 2)!\n");
-- 
2.15.0
