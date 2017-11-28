From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v6 5/7] eeprom: at24: add regmap-based read function
Date: Tue, 28 Nov 2017 21:51:50 +0100
Message-ID: <edcbceee-e5ee-1345-0e4c-b0827b67c1dd@gmail.com>
References: <328f770d-e79d-cbb5-1cd7-238862aa8e1c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40806 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbdK1UwM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Nov 2017 15:52:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id v19so2014919wmh.5
        for <linux-i2c@vger.kernel.org>; Tue, 28 Nov 2017 12:52:11 -0800 (PST)
In-Reply-To: <328f770d-e79d-cbb5-1cd7-238862aa8e1c@gmail.com>
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
v5:
- small style improvements to at24_get_offset_adj
v6:
- rebased
- add byte_len parameter to at24_get_offset_adj
---
 drivers/misc/eeprom/at24.c | 57 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index fa28d87f7..8172ca627 100644
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
@@ -535,7 +566,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int	status;
 
-		status = at24->read_func(at24, buf, off, count);
+		status = at24_regmap_read(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(&client->dev);
@@ -628,6 +659,29 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 	}
 }
 
+static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
+{
+	if (flags & AT24_FLAG_MAC) {
+		/* EUI-48 starts from 0x9a, EUI-64 from 0x98 */
+		return 0xa0 - byte_len;
+	} else if (flags & AT24_FLAG_SERIAL && flags & AT24_FLAG_ADDR16) {
+		/*
+		 * For 16 bit address pointers, the word address must contain
+		 * a '10' sequence in bits 11 and 10 regardless of the
+		 * intended position of the address pointer.
+		 */
+		return 0x0800;
+	} else if (flags & AT24_FLAG_SERIAL) {
+		/*
+		 * Otherwise the word address must begin with a '10' sequence,
+		 * regardless of the intended address.
+		 */
+		return 0x0080;
+	} else {
+		return 0;
+	}
+}
+
 static const struct regmap_config regmap_config_8 = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -754,6 +808,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->use_smbus = use_smbus;
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
+	at24->offset_adj = at24_get_offset_adj(chip.flags, chip.byte_len);
 
 	at24->client[0].client = client;
 	at24->client[0].regmap = devm_regmap_init_i2c(client, config);
-- 
2.15.0
