From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC 2/7] eeprom: at24: change at24_translate_offset return
 type
Date: Thu, 17 Aug 2017 07:59:07 +0200
Message-ID: <e104181e-4a8b-043b-adaa-633329f4ada5@gmail.com>
References: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37683 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdHQF7j (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Aug 2017 01:59:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id z91so3444010wrc.4
        for <linux-i2c@vger.kernel.org>; Wed, 16 Aug 2017 22:59:39 -0700 (PDT)
In-Reply-To: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Change return type of at24_translate_offset to *at24_client to make
member regmap accessible for subsequent patches of this series.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e615bafa..7cd746de 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -207,8 +207,8 @@ MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
  * one "eeprom" file not four, but larger reads would fail when
  * they crossed certain pages.
  */
-static struct i2c_client *at24_translate_offset(struct at24_data *at24,
-						unsigned int *offset)
+static struct at24_client *at24_translate_offset(struct at24_data *at24,
+						 unsigned int *offset)
 {
 	unsigned i;
 
@@ -220,7 +220,7 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 		*offset &= 0xff;
 	}
 
-	return at24->client[i].client;
+	return &at24->client[i];
 }
 
 static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
@@ -230,7 +230,7 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
 	struct i2c_client *client;
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	if (count > io_limit)
 		count = io_limit;
@@ -264,7 +264,7 @@ static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
 	u8 msgbuf[2];
 
 	memset(msg, 0, sizeof(msg));
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	if (count > io_limit)
 		count = io_limit;
@@ -313,7 +313,7 @@ static ssize_t at24_eeprom_read_serial(struct at24_data *at24, char *buf,
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -366,7 +366,7 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -421,7 +421,7 @@ static ssize_t at24_eeprom_write_smbus_block(struct at24_data *at24,
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
 	loop_until_timeout(timeout, write_time) {
@@ -448,7 +448,7 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 
 	loop_until_timeout(timeout, write_time) {
 		status = i2c_smbus_write_byte_data(client, offset, buf[0]);
@@ -474,7 +474,7 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 	ssize_t status = 0;
 	int i = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset)->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
 	msg.addr = client->addr;
-- 
2.14.1
