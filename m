From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 08/13] eeprom: at24: call read and write routines via function pointers
Date: Mon, 11 Apr 2016 11:57:24 -0700
Message-ID: <1460401049-25459-9-git-send-email-bgolaszewski@baylibre.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36387 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbcDKS57 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Apr 2016 14:57:59 -0400
Received: by mail-pa0-f53.google.com with SMTP id bx7so110363843pad.3
        for <linux-i2c@vger.kernel.org>; Mon, 11 Apr 2016 11:57:59 -0700 (PDT)
In-Reply-To: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to support non-standard read/write functions (as part of the
at24cs series support) introduce two function pointers in struct
at24_data to which different implementations can be assigned.

For now we continue to use the regular read/write routines by default.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index fda5c56..4c868a2 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -59,6 +59,10 @@ struct at24_data {
 	int use_smbus;
 	int use_smbus_write;
 
+	ssize_t (*read_func)(struct at24_data *, char *, loff_t, size_t);
+	ssize_t (*write_func)(struct at24_data *,
+			      const char *, loff_t, size_t);
+
 	u8 *writebuf;
 	struct mutex wrbuf_lock;
 	unsigned write_max;
@@ -458,7 +462,7 @@ static int at24_regmap_read(void *context, const void *reg, size_t reg_size,
 	off_t offset = *(u32 *)reg;
 	int err;
 
-	err = at24_read(at24, val, offset, val_size);
+	err = at24->read_func(at24, val, offset, val_size);
 	if (err)
 		return err;
 	return 0;
@@ -476,7 +480,7 @@ static int at24_regmap_write(void *context, const void *data, size_t count)
 	buf = (const char *)data + sizeof(offset);
 	len = count - sizeof(offset);
 
-	err = at24_write(at24, buf, offset, len);
+	err = at24->write_func(at24, buf, offset, len);
 	if (err)
 		return err;
 	return 0;
@@ -611,6 +615,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
+	at24->read_func = at24_read;
+	at24->write_func = at24_write;
+
 	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
 		if (!use_smbus || use_smbus_write) {
-- 
2.7.4
