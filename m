From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 3/9] eeprom: at24: tie up an additional address for at24cs series
Date: Tue, 24 Nov 2015 10:44:39 +0100
Message-ID: <1448358285-25016-4-git-send-email-bgolaszewski@baylibre.com>
References: <1448358285-25016-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34843 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbbKXJov (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Nov 2015 04:44:51 -0500
Received: by wmuu63 with SMTP id u63so88219276wmu.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2015 01:44:50 -0800 (PST)
In-Reply-To: <1448358285-25016-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

The at24cs series EEPROM chips have an additional read-only memory area,
that is visible on a different i2c slave address. Tie it up with a dummy
device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 5d7c090..08cc327 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -103,6 +103,8 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
 
 #define AT24_BITMASK(x) (BIT(x) - 1)
 
+#define AT24CS_SERIAL_ADDR(addr) (addr + 0x08)
+
 /* create non-zero magic value for given eeprom parameters */
 #define AT24_DEVICE_MAGIC(_len, _flags) 		\
 	((1 << AT24_SIZE_FLAGS | (_flags)) 		\
@@ -558,6 +560,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	if (chip.flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
+	else if (chip.flags & AT24_FLAG_SERIAL)
+		num_addresses = 2;
 	else
 		num_addresses =	DIV_ROUND_UP(chip.byte_len,
 			(chip.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
@@ -616,12 +620,30 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->client[0] = client;
 
 	/* use dummy devices for multiple-address chips */
-	for (i = 1; i < num_addresses; i++) {
-		at24->client[i] = i2c_new_dummy(client->adapter,
+	if (at24->chip.flags & AT24_FLAG_TAKE8ADDR) {
+		for (i = 1; i < num_addresses; i++) {
+			at24->client[i] = i2c_new_dummy(client->adapter,
+							client->addr + i);
+			if (!at24->client[i]) {
+				dev_err(&client->dev,
+					"address 0x%02x unavailable\n",
 					client->addr + i);
-		if (!at24->client[i]) {
+				err = -EADDRINUSE;
+				goto err_clients;
+			}
+		}
+	}
+
+	/*
+	 * at24cs series tie up an additional address for the memory area
+	 * contining the serial number
+	 */
+	if (at24->chip.flags & AT24_FLAG_SERIAL) {
+		at24->client[1] = i2c_new_dummy(client->adapter,
+					AT24CS_SERIAL_ADDR(client->addr));
+		if (!at24->client[1]) {
 			dev_err(&client->dev, "address 0x%02x unavailable\n",
-					client->addr + i);
+				AT24CS_SERIAL_ADDR(client->addr));
 			err = -EADDRINUSE;
 			goto err_clients;
 		}
-- 
2.1.4
