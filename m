From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/13] eeprom: at24: call read and write routines via function pointers
Date: Thu, 24 Mar 2016 15:46:02 +0100
Message-ID: <1458830767-23816-9-git-send-email-bgolaszewski@baylibre.com>
References: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

In order to support non-standard read/write functions (as part of the
at24cs series support) introduce two function pointers in struct
at24_data to which different implementations can be assigned.

For now we continue to use the regular read/write routines by default.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index a7d6c15..5b484bc 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -59,6 +59,9 @@ struct at24_data {
 	int use_smbus;
 	int use_smbus_write;
 
+	int (*read_func)(struct at24_data *, char *, loff_t, size_t);
+	int (*write_func)(struct at24_data *, const char *, loff_t, size_t);
+
 	u8 *writebuf;
 	struct mutex wrbuf_lock;
 	unsigned write_max;
@@ -458,7 +461,7 @@ static int at24_regmap_read(void *context, const void *reg, size_t reg_size,
 	off_t offset = *(u32 *)reg;
 	int err;
 
-	err = at24_read(at24, val, offset, val_size);
+	err = at24->read_func(at24, val, offset, val_size);
 	if (err)
 		return err;
 	return 0;
@@ -476,7 +479,7 @@ static int at24_regmap_write(void *context, const void *data, size_t count)
 	buf = (const char *)data + sizeof(offset);
 	len = count - sizeof(offset);
 
-	err = at24_write(at24, buf, offset, len);
+	err = at24->write_func(at24, buf, offset, len);
 	if (err)
 		return err;
 	return 0;
@@ -611,6 +614,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
