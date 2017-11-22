From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 5/7] eeprom: at24: add regmap-based read function
Date: Wed, 22 Nov 2017 08:05:58 +0100
Message-ID: <f9cc45de-ef6e-fd28-8851-512aba3bbfb2@gmail.com>
References: <bcf28969-c6a3-805f-7df9-670dfbd99631@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46772 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdKVHGU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Nov 2017 02:06:20 -0500
Received: by mail-wm0-f68.google.com with SMTP id u83so8054937wmb.5
        for <linux-i2c@vger.kernel.org>; Tue, 21 Nov 2017 23:06:20 -0800 (PST)
In-Reply-To: <bcf28969-c6a3-805f-7df9-670dfbd99631@gmail.com>
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
---
 drivers/misc/eeprom/at24.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 493e2b646..589e6d855 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -312,6 +312,57 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
+static void at24_adjust_read_offset(struct at24_data *at24,
+				    unsigned int *offset)
+{
+	u8 flags = at24->chip.flags;
+
+	if (flags & AT24_FLAG_MAC)
+		*offset += 0x90;
+	else if (flags & AT24_FLAG_SERIAL && flags & AT24_FLAG_ADDR16)
+		/*
+		 * For 16 bit address pointers, the word address must contain
+		 * a '10' sequence in bits 11 and 10 regardless of the
+		 * intended position of the address pointer.
+		 */
+		*offset |= BIT(11);
+	else if (flags & AT24_FLAG_SERIAL)
+		/*
+		 * Otherwise the word address must begin with a '10' sequence,
+		 * regardless of the intended address.
+		 */
+		*offset |= BIT(7);
+}
+
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
+	at24_adjust_read_offset(at24, &offset);
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
@@ -531,7 +582,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int	status;
 
-		status = at24->read_func(at24, buf, off, count);
+		status = at24_regmap_read(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(&client->dev);
-- 
2.15.0
