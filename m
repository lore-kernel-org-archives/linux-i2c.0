From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 5/7] eeprom: at24: add regmap-based read function
Date: Wed, 22 Nov 2017 22:12:57 +0100
Message-ID: <011081f7-f2af-0e78-f21b-c40493d63a70@gmail.com>
References: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41555 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdKVVNN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Nov 2017 16:13:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so12994807wmd.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Nov 2017 13:13:12 -0800 (PST)
In-Reply-To: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Add regmap-based read function and instead of using three different
read functions (standard, mac, serial) use just one and factor out the
read offset adjustment for mac and serial to at24_adjust_read_offset.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- improve readability
- re-introduce debug message
- introduce at24_adjust_read_offset
v4:
- move offset adjustment calculation to probe function
---
 drivers/misc/eeprom/at24.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 493e2b646..c16a9a495 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -75,6 +75,7 @@ struct at24_data {
 
 	unsigned write_max;
 	unsigned num_addresses;
+	unsigned int offset_adj;
 
 	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
@@ -312,6 +313,36 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
+static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
+				unsigned int offset, size_t count)
+{
+	unsigned long timeout, read_time;
+	struct at24_client *at24_client;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	int ret;
+
+	at24_client = at24_translate_offset(at24, &offset);
+	regmap = at24_client->regmap;
+	client = at24_client->client;
+
+	if (count > io_limit)
+		count = io_limit;
+
+	/* adjust offset for mac and serial read ops */
+	offset += at24->offset_adj;
+
+	loop_until_timeout(timeout, read_time) {
+		ret = regmap_bulk_read(regmap, offset, buf, count);
+		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
+			count, offset, ret, jiffies);
+		if (!ret)
+			return count;
+	}
+
+	return -ETIMEDOUT;
+}
+
 static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
 				    unsigned int offset, size_t count)
 {
@@ -531,7 +562,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int	status;
 
-		status = at24->read_func(at24, buf, off, count);
+		status = at24_regmap_read(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(&client->dev);
@@ -621,6 +652,27 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 	}
 }
 
+static unsigned int at24_get_offset_adj(u8 flags)
+{
+	if (flags & AT24_FLAG_MAC)
+		return 0x90;
+	else if (flags & AT24_FLAG_SERIAL && flags & AT24_FLAG_ADDR16)
+		/*
+		 * For 16 bit address pointers, the word address must contain
+		 * a '10' sequence in bits 11 and 10 regardless of the
+		 * intended position of the address pointer.
+		 */
+		return BIT(11);
+	else if (flags & AT24_FLAG_SERIAL)
+		/*
+		 * Otherwise the word address must begin with a '10' sequence,
+		 * regardless of the intended address.
+		 */
+		return BIT(7);
+	else
+		return 0;
+}
+
 static const struct regmap_config regmap_config_8 = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -749,6 +801,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EINVAL;
 	}
 
+	at24->offset_adj = at24_get_offset_adj(chip.flags);
+
 	if (chip.flags & AT24_FLAG_SERIAL) {
 		at24->read_func = at24_eeprom_read_serial;
 	} else if (chip.flags & AT24_FLAG_MAC) {
-- 
2.15.0
