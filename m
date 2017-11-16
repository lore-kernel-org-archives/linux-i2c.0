From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 5/7] eeprom: at24: add regmap-based read functions
Date: Thu, 16 Nov 2017 21:26:44 +0100
Message-ID: <055dce44-43fb-c90f-6e94-ca8035b16832@gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43523 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759041AbdKPU1X (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Nov 2017 15:27:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id x63so2620132wmf.2
        for <linux-i2c@vger.kernel.org>; Thu, 16 Nov 2017 12:27:23 -0800 (PST)
In-Reply-To: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Add regmap-based read functions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
---
 drivers/misc/eeprom/at24.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 28ea1a950..391e0d998 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -310,6 +310,59 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
+static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
+				unsigned int offset, size_t count)
+{
+	unsigned long timeout, read_time;
+	struct regmap *regmap;
+
+	regmap = at24_translate_offset(at24, &offset)->regmap;
+
+	if (count > io_limit)
+		count = io_limit;
+
+	if (at24->chip.flags & AT24_FLAG_MAC)
+		offset += 0x90;
+
+	loop_until_timeout(timeout, read_time)
+		if (!regmap_bulk_read(regmap, offset, buf, count))
+			return count;
+
+	return -ETIMEDOUT;
+}
+
+static ssize_t at24_regmap_read_serial(struct at24_data *at24, char *buf,
+				       unsigned int offset, size_t count)
+{
+	unsigned long timeout, read_time;
+	struct regmap *regmap;
+
+	regmap = at24_translate_offset(at24, &offset)->regmap;
+
+	if (count > io_limit)
+		count = io_limit;
+
+	if (at24->chip.flags & AT24_FLAG_ADDR16)
+		/*
+		 * For 16 bit address pointers, the word address must contain
+		 * a '10' sequence in bits 11 and 10 regardless of the
+		 * intended position of the address pointer.
+		 */
+		offset |= BIT(11);
+	else
+		/*
+		 * Otherwise the word address must begin with a '10' sequence,
+		 * regardless of the intended address.
+		 */
+		offset |= BIT(7);
+
+	loop_until_timeout(timeout, read_time)
+		if (!regmap_bulk_read(regmap, offset, buf, count))
+			return count;
+
+	return -ETIMEDOUT;
+}
+
 static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
 				    unsigned int offset, size_t count)
 {
@@ -512,7 +565,10 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int	status;
 
-		status = at24->read_func(at24, buf, off, count);
+		if (at24->chip.flags & AT24_FLAG_SERIAL)
+			status = at24_regmap_read_serial(at24, buf, off, count);
+		else
+			status = at24_regmap_read(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(&client->dev);
-- 
2.15.0
