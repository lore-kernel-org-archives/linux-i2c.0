From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 2/7] eeprom: at24: change at24_translate_offset return type
Date: Thu, 16 Nov 2017 21:26:06 +0100
Message-ID: <9b0019a9-f272-e345-d814-fcb05f978554@gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44241 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759003AbdKPU1U (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Nov 2017 15:27:20 -0500
Received: by mail-wr0-f196.google.com with SMTP id l22so228715wrc.11
        for <linux-i2c@vger.kernel.org>; Thu, 16 Nov 2017 12:27:19 -0800 (PST)
In-Reply-To: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Change return type of at24_translate_offset to *at24_client to make
member regmap accessible for subsequent patches of this series.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
---
 drivers/misc/eeprom/at24.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 911cce8ec..1411fa029 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -267,8 +267,8 @@ MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
  * one "eeprom" file not four, but larger reads would fail when
  * they crossed certain pages.
  */
-static struct i2c_client *at24_translate_offset(struct at24_data *at24,
-						unsigned int *offset)
+static struct at24_client *at24_translate_offset(struct at24_data *at24,
+						 unsigned int *offset)
 {
 	unsigned i;
 
@@ -280,7 +280,7 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 		*offset &= 0xff;
 	}
 
-	return at24->client[i].client;
+	return &at24->client[i];
 }
 
 static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
@@ -290,7 +290,7 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
 	struct i2c_client *client;
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	if (count > io_limit)
 		count = io_limit;
@@ -324,7 +324,7 @@ static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
 	u8 msgbuf[2];
 
 	memset(msg, 0, sizeof(msg));
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	if (count > io_limit)
 		count = io_limit;
@@ -373,7 +373,7 @@ static ssize_t at24_eeprom_read_serial(struct at24_data *at24, char *buf,
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -426,7 +426,7 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -481,7 +481,7 @@ static ssize_t at24_eeprom_write_smbus_block(struct at24_data *at24,
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
 	loop_until_timeout(timeout, write_time) {
@@ -508,7 +508,7 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	loop_until_timeout(timeout, write_time) {
 		status = i2c_smbus_write_byte_data(client, offset, buf[0]);
@@ -534,7 +534,7 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 	ssize_t status = 0;
 	int i = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
 	msg.addr = client->addr;
@@ -574,7 +574,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return count;
 
-	client = at24_translate_offset(at24, &off);
+	client = at24_translate_offset(at24, &off)->client;
 
 	ret = pm_runtime_get_sync(&client->dev);
 	if (ret < 0) {
@@ -619,7 +619,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return -EINVAL;
 
-	client = at24_translate_offset(at24, &off);
+	client = at24_translate_offset(at24, &off)->client;
 
 	ret = pm_runtime_get_sync(&client->dev);
 	if (ret < 0) {
-- 
2.15.0
