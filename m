From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 09/13] eeprom: at24: use at24cs_serial_read()
Date: Thu, 24 Mar 2016 17:19:39 +0100
Message-ID: <1458836383-6668-10-git-send-email-bgolaszewski@baylibre.com>
References: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32969 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845AbcCXQT6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:19:58 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so282414494wml.0
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 09:19:55 -0700 (PDT)
In-Reply-To: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Assign at24cs_serial_read() to at24->read_func if the chip allows serial
number read operation.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 4c868a2..d3e4d66 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -163,9 +163,8 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 	return at24->client[i];
 }
 
-static ssize_t __attribute__((unused))
-at24cs_serial_read(struct at24_data *at24,
-		   char *buf, loff_t off, size_t count)
+static ssize_t at24cs_serial_read(struct at24_data *at24,
+				  char *buf, loff_t off, size_t count)
 {
 	unsigned long timeout, read_time;
 	struct i2c_client *client;
@@ -615,8 +614,12 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
-	at24->read_func = at24_read;
-	at24->write_func = at24_write;
+	if (chip.flags & AT24_FLAG_SERIAL) {
+		at24->read_func = at24cs_serial_read;
+	} else {
+		at24->read_func = at24_read;
+		at24->write_func = at24_write;
+	}
 
 	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
-- 
2.7.4
