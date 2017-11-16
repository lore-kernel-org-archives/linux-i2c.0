From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 3/7] eeprom: at24: add regmap-based write function
Date: Thu, 16 Nov 2017 21:26:19 +0100
Message-ID: <a4c705cc-69e8-35f8-2131-f7c610111d77@gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39199 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759008AbdKPU1V (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Nov 2017 15:27:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id l8so2558275wmg.4
        for <linux-i2c@vger.kernel.org>; Thu, 16 Nov 2017 12:27:20 -0800 (PST)
In-Reply-To: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Add a regmap-based write function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
---
 drivers/misc/eeprom/at24.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 1411fa029..c0c59575e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -525,6 +525,22 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
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
@@ -636,7 +652,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	while (count) {
 		int status;
 
-		status = at24->write_func(at24, buf, off, count);
+		status = at24_regmap_write(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(&client->dev);
-- 
2.15.0
