From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC 5/7] eeprom: at24: add regmap-based read functions
Date: Thu, 17 Aug 2017 07:59:18 +0200
Message-ID: <50dc4441-3975-bd30-3514-54fe106a0040@gmail.com>
References: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36151 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHQF7n (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Aug 2017 01:59:43 -0400
Received: by mail-wr0-f193.google.com with SMTP id y67so6487665wrb.3
        for <linux-i2c@vger.kernel.org>; Wed, 16 Aug 2017 22:59:42 -0700 (PDT)
In-Reply-To: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Add regmap-based read functions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 6c5e5538..55b35007 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -250,6 +250,59 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
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
@@ -442,7 +495,10 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int	status;
 
-		status = at24->read_func(at24, buf, off, count);
+		if (at24->chip.flags & AT24_FLAG_SERIAL)
+			status = at24_regmap_read_serial(at24, buf, off, count);
+		else
+			status = at24_regmap_read(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			return status;
-- 
2.14.1
