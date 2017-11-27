From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 2/7] eeprom: at24: change at24_translate_offset return type
Date: Mon, 27 Nov 2017 21:34:19 +0100
Message-ID: <d463abdf-d9f7-1aa4-187a-5a506e0c5d2b@gmail.com>
References: <2c379f45-d5e3-71af-eb20-ca51e09d9257@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:41652 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdK0Ueq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 15:34:46 -0500
Received: by mail-wm0-f68.google.com with SMTP id b189so36667806wmd.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 12:34:45 -0800 (PST)
In-Reply-To: <2c379f45-d5e3-71af-eb20-ca51e09d9257@gmail.com>
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
v3:
- improve readability
v4:
- no changes
v5:
- no changes
---
 drivers/misc/eeprom/at24.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 3700b0383..e4bace389 100644
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
 
@@ -280,17 +280,19 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 		*offset &= 0xff;
 	}
 
-	return at24->client[i].client;
+	return &at24->client[i];
 }
 
 static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
 				      unsigned int offset, size_t count)
 {
 	unsigned long timeout, read_time;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	at24_client = at24_translate_offset(at24, &offset);
+	client = at24_client->client;
 
 	if (count > io_limit)
 		count = io_limit;
@@ -318,13 +320,15 @@ static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
 				    unsigned int offset, size_t count)
 {
 	unsigned long timeout, read_time;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	struct i2c_msg msg[2];
 	int status, i;
 	u8 msgbuf[2];
 
 	memset(msg, 0, sizeof(msg));
-	client = at24_translate_offset(at24, &offset);
+	at24_client = at24_translate_offset(at24, &offset);
+	client = at24_client->client;
 
 	if (count > io_limit)
 		count = io_limit;
@@ -368,12 +372,14 @@ static ssize_t at24_eeprom_read_serial(struct at24_data *at24, char *buf,
 				       unsigned int offset, size_t count)
 {
 	unsigned long timeout, read_time;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	struct i2c_msg msg[2];
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	at24_client = at24_translate_offset(at24, &offset);
+	client = at24_client->client;
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -421,12 +427,14 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
 				    unsigned int offset, size_t count)
 {
 	unsigned long timeout, read_time;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	struct i2c_msg msg[2];
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	at24_client = at24_translate_offset(at24, &offset);
+	client = at24_client->client;
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -478,10 +486,12 @@ static ssize_t at24_eeprom_write_smbus_block(struct at24_data *at24,
 					     unsigned int offset, size_t count)
 {
 	unsigned long timeout, write_time;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	at24_client = at24_translate_offset(at24, &offset);
+	client = at24_client->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
 	loop_until_timeout(timeout, write_time) {
@@ -505,10 +515,12 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
 					    unsigned int offset, size_t count)
 {
 	unsigned long timeout, write_time;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	at24_client = at24_translate_offset(at24, &offset);
+	client = at24_client->client;
 
 	loop_until_timeout(timeout, write_time) {
 		status = i2c_smbus_write_byte_data(client, offset, buf[0]);
@@ -529,12 +541,14 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 				     unsigned int offset, size_t count)
 {
 	unsigned long timeout, write_time;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	struct i2c_msg msg;
 	ssize_t status = 0;
 	int i = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	at24_client = at24_translate_offset(at24, &offset);
+	client = at24_client->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
 	msg.addr = client->addr;
@@ -567,6 +581,7 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	char *buf = val;
 	int ret;
@@ -577,7 +592,8 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	if (off + count > at24->chip.byte_len)
 		return -EINVAL;
 
-	client = at24_translate_offset(at24, &off);
+	at24_client = at24_translate_offset(at24, &off);
+	client = at24_client->client;
 
 	ret = pm_runtime_get_sync(&client->dev);
 	if (ret < 0) {
@@ -615,6 +631,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
+	struct at24_client *at24_client;
 	struct i2c_client *client;
 	char *buf = val;
 	int ret;
@@ -625,7 +642,8 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	if (off + count > at24->chip.byte_len)
 		return -EINVAL;
 
-	client = at24_translate_offset(at24, &off);
+	at24_client = at24_translate_offset(at24, &off);
+	client = at24_client->client;
 
 	ret = pm_runtime_get_sync(&client->dev);
 	if (ret < 0) {
-- 
2.15.0
