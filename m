From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 10/13] eeprom: at24: add the at24cs series to the list of supported devices
Date: Thu, 24 Mar 2016 17:19:40 +0100
Message-ID: <1458836383-6668-11-git-send-email-bgolaszewski@baylibre.com>
References: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38040 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbcCXQT5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:19:57 -0400
Received: by mail-wm0-f43.google.com with SMTP id l68so73706266wml.1
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 09:19:56 -0700 (PDT)
In-Reply-To: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

The infrastructure for reading of the factory-programmed serial number
for at24cs EEPROM series is now in place. Add the chips that are actually
equipped with the serial number memory area to the list of supported
devices.

The chips from the at24cs family have two memory areas - a regular
read-write block and a read-only area containing the serial number.

The latter is visible on a different slave address (the address of the
wr memory block + 0x08). In order to access both blocks the user needs
to instantiate a regular at24c device for the wr block address and a
corresponding at24cs device on the serial number block address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d3e4d66..281dd48 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -115,16 +115,34 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c00",	AT24_DEVICE_MAGIC(128 / 8,	AT24_FLAG_TAKE8ADDR) },
 	/* old variants can't be handled with this generic entry! */
 	{ "24c01",	AT24_DEVICE_MAGIC(1024 / 8,	0) },
+	{ "24cs01",	AT24_DEVICE_MAGIC(128 / 8,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
 	{ "24c02",	AT24_DEVICE_MAGIC(2048 / 8,	0) },
+	{ "24cs02",	AT24_DEVICE_MAGIC(128 / 8,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
 	/* spd is a 24c02 in memory DIMMs */
 	{ "spd",	AT24_DEVICE_MAGIC(2048 / 8,
 				AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
 	{ "24c04",	AT24_DEVICE_MAGIC(4096 / 8,	0) },
+	{ "24cs04",	AT24_DEVICE_MAGIC(128 / 8,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
 	/* 24rf08 quirk is handled at i2c-core */
 	{ "24c08",	AT24_DEVICE_MAGIC(8192 / 8,	0) },
+	{ "24cs08",	AT24_DEVICE_MAGIC(128 / 8,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
 	{ "24c16",	AT24_DEVICE_MAGIC(16384 / 8,	0) },
+	{ "24cs16",	AT24_DEVICE_MAGIC(128 / 8,
+				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
 	{ "24c32",	AT24_DEVICE_MAGIC(32768 / 8,	AT24_FLAG_ADDR16) },
+	{ "24cs32",	AT24_DEVICE_MAGIC(128 / 8,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY) },
 	{ "24c64",	AT24_DEVICE_MAGIC(65536 / 8,	AT24_FLAG_ADDR16) },
+	{ "24cs64",	AT24_DEVICE_MAGIC(128 / 8,
+				AT24_FLAG_ADDR16 |
+				AT24_FLAG_SERIAL |
+				AT24_FLAG_READONLY) },
 	{ "24c128",	AT24_DEVICE_MAGIC(131072 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c256",	AT24_DEVICE_MAGIC(262144 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c512",	AT24_DEVICE_MAGIC(524288 / 8,	AT24_FLAG_ADDR16) },
-- 
2.7.4
