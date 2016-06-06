From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 11/14] eeprom: at24: add the at24cs series to the list of supported devices
Date: Mon,  6 Jun 2016 10:48:53 +0200
Message-ID: <1465202936-16832-12-git-send-email-bgolaszewski@baylibre.com>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

The infrastructure for reading of the factory-programmed serial number
for at24cs EEPROM series is now in place. Add the chips that are actually
equipped with the serial number memory area to the list of supported
devices.

The chips from the at24cs family have two memory areas - a regular
read-write block and a read-only area containing the serial number.

The latter is visible on a different slave address (the address of the
rw memory block + 0x08). In order to access both blocks the user needs
to instantiate a regular at24c device for the rw block address and a
corresponding at24cs device on the serial number block address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 29bbdad..0b5240d 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -134,16 +134,34 @@ static const struct i2c_device_id at24_ids[] = {
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
