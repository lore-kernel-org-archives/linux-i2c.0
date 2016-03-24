From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/13] eeprom: at24: improve the device_id table readability
Date: Thu, 24 Mar 2016 15:45:56 +0100
Message-ID: <1458830767-23816-3-git-send-email-bgolaszewski@baylibre.com>
References: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34913 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbcCXOqO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 10:46:14 -0400
Received: by mail-wm0-f45.google.com with SMTP id l68so239767078wml.0
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 07:46:13 -0700 (PDT)
In-Reply-To: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

As part of the preparation for introducing support for more chips,
improve the readability of the device table by separating columns
with tabs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 001a9af..744c526 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -113,23 +113,23 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
 
 static const struct i2c_device_id at24_ids[] = {
 	/* needs 8 addresses as A0-A2 are ignored */
-	{ "24c00", AT24_DEVICE_MAGIC(128 / 8, AT24_FLAG_TAKE8ADDR) },
+	{ "24c00",	AT24_DEVICE_MAGIC(128 / 8,	AT24_FLAG_TAKE8ADDR) },
 	/* old variants can't be handled with this generic entry! */
-	{ "24c01", AT24_DEVICE_MAGIC(1024 / 8, 0) },
-	{ "24c02", AT24_DEVICE_MAGIC(2048 / 8, 0) },
+	{ "24c01",	AT24_DEVICE_MAGIC(1024 / 8,	0) },
+	{ "24c02",	AT24_DEVICE_MAGIC(2048 / 8,	0) },
 	/* spd is a 24c02 in memory DIMMs */
-	{ "spd", AT24_DEVICE_MAGIC(2048 / 8,
-		AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
-	{ "24c04", AT24_DEVICE_MAGIC(4096 / 8, 0) },
+	{ "spd",	AT24_DEVICE_MAGIC(2048 / 8,
+				AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
+	{ "24c04",	AT24_DEVICE_MAGIC(4096 / 8,	0) },
 	/* 24rf08 quirk is handled at i2c-core */
-	{ "24c08", AT24_DEVICE_MAGIC(8192 / 8, 0) },
-	{ "24c16", AT24_DEVICE_MAGIC(16384 / 8, 0) },
-	{ "24c32", AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16) },
-	{ "24c64", AT24_DEVICE_MAGIC(65536 / 8, AT24_FLAG_ADDR16) },
-	{ "24c128", AT24_DEVICE_MAGIC(131072 / 8, AT24_FLAG_ADDR16) },
-	{ "24c256", AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16) },
-	{ "24c512", AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16) },
-	{ "24c1024", AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16) },
+	{ "24c08",	AT24_DEVICE_MAGIC(8192 / 8,	0) },
+	{ "24c16",	AT24_DEVICE_MAGIC(16384 / 8,	0) },
+	{ "24c32",	AT24_DEVICE_MAGIC(32768 / 8,	AT24_FLAG_ADDR16) },
+	{ "24c64",	AT24_DEVICE_MAGIC(65536 / 8,	AT24_FLAG_ADDR16) },
+	{ "24c128",	AT24_DEVICE_MAGIC(131072 / 8,	AT24_FLAG_ADDR16) },
+	{ "24c256",	AT24_DEVICE_MAGIC(262144 / 8,	AT24_FLAG_ADDR16) },
+	{ "24c512",	AT24_DEVICE_MAGIC(524288 / 8,	AT24_FLAG_ADDR16) },
+	{ "24c1024",	AT24_DEVICE_MAGIC(1048576 / 8,	AT24_FLAG_ADDR16) },
 	{ "at24", 0 },
 	{ /* END OF LIST */ }
 };
-- 
2.7.4
