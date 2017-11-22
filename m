From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 3/7] eeprom: at24: add regmap-based write function
Date: Wed, 22 Nov 2017 22:12:51 +0100
Message-ID: <81dfdad5-562c-665c-a749-e785d3da7189@gmail.com>
References: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39882 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdKVVNL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Nov 2017 16:13:11 -0500
Received: by mail-wr0-f195.google.com with SMTP id 11so12443561wrb.6
        for <linux-i2c@vger.kernel.org>; Wed, 22 Nov 2017 13:13:10 -0800 (PST)
In-Reply-To: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Add a regmap-based write function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- improve readability
- re-introduce debug message
v4:
- no changes
---
 drivers/misc/eeprom/at24.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index fe4393ad6..86a36482a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -537,6 +537,31 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
 	return -ETIMEDOUT;
 }
 
+static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
+				 unsigned int offset, size_t count)
+{
+	unsigned long timeout, write_time;
+	struct at24_client *at24_client;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	int ret;
+
+	at24_client = at24_translate_offset(at24, &offset);
+	regmap = at24_client->regmap;
+	client = at24_client->client;
+	count = at24_adjust_write_count(at24, offset, count);
+
+	loop_until_timeout(timeout, write_time) {
+		ret = regmap_bulk_write(regmap, offset, buf, count);
+		dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
+			count, offset, ret, jiffies);
+		if (!ret)
+			return count;
+	}
+
+	return -ETIMEDOUT;
+}
+
 static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 				     unsigned int offset, size_t count)
 {
@@ -654,7 +679,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int status;
 
-		status = at24->write_func(at24, buf, off, count);
+		status = at24_regmap_write(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(&client->dev);
-- 
2.15.0
