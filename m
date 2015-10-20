From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 6/9] eeprom: at24: improve the device_id table readability
Date: Tue, 20 Oct 2015 10:43:24 +0200
Message-ID: <1445330607-12470-7-git-send-email-bgolaszewski@baylibre.com>
References: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

Improve the readability of the device table by separating columns with
tabs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0eded22..0d34b94 100644
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
2.1.4
