From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC 3/7] eeprom: at24: add regmap-based write function
Date: Thu, 17 Aug 2017 07:59:11 +0200
Message-ID: <f0410125-4b65-3ce6-8ac4-8210fb961344@gmail.com>
References: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35769 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHQF7k (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Aug 2017 01:59:40 -0400
Received: by mail-wr0-f196.google.com with SMTP id p8so442624wrf.2
        for <linux-i2c@vger.kernel.org>; Wed, 16 Aug 2017 22:59:40 -0700 (PDT)
In-Reply-To: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Add a regmap-based write function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 7cd746de..4e4225b2 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -465,6 +465,22 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
 	return -ETIMEDOUT;
 }
 
+static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
+				 unsigned int offset, size_t count)
+{
+	unsigned long timeout, write_time;
+	struct regmap *regmap;
+
+	regmap = at24_translate_offset(at24, &offset)->regmap;
+	count = at24_adjust_write_count(at24, offset, count);
+
+	loop_until_timeout(timeout, write_time)
+		if (!regmap_bulk_write(regmap, offset, buf, count))
+			return count;
+
+	return -ETIMEDOUT;
+}
+
 static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 				     unsigned int offset, size_t count)
 {
@@ -553,7 +569,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int status;
 
-		status = at24->write_func(at24, buf, off, count);
+		status = at24_regmap_write(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			return status;
-- 
2.14.1
