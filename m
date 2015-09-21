From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 2/3 v2] at24: Support SMBus byte writes to 16-bit devices
Date: Mon, 21 Sep 2015 13:39:39 -0500 (CDT)
Message-ID: <575662845.82856.1442860779860.JavaMail.zimbra@xes-inc.com>
References: <865272709.82219.1441309998483.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:34558 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932383AbbIUSkp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 21 Sep 2015 14:40:45 -0400
In-Reply-To: <865272709.82219.1441309998483.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Jean Delvare <jdelvare@suse.com>, Nate Case <ncase@xes-inc.com>

Introduce at24_smbus_write_byte_data() to allow very slow (e.g.
248 B/s) write access to 16-bit EEPROM devices attached to SMBus
controllers like the Intel SCH.

Signed-off-by: Nate Case <ncase@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 v2 - Unchanged from v1

 drivers/misc/eeprom/at24.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c3d3add..32eca05 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -134,6 +134,25 @@ MODULE_DEVICE_TABLE(i2c, at24_ids);
 /*-------------------------------------------------------------------------*/
 
 /*
+ * Write a byte to an AT24 device using SMBus cycles.
+ */
+static inline s32 at24_smbus_write_byte_data(struct at24_data *at24,
+	struct i2c_client *client, u16 offset, u8 value)
+{
+	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
+		return i2c_smbus_write_byte_data(client, offset, value);
+
+	/*
+	 * Emulate I2C multi-byte write by using SMBus "write word"
+	 * cycle.  We split up the 16-bit offset among the "command"
+	 * byte and the first data byte.
+	 */
+	return i2c_smbus_write_word_data(client,
+		((offset >> 8) & 0xff),
+		(value << 8) | (offset & 0xff));
+}
+
+/*
  * Write block data to an AT24 device using SMBus cycles.
  */
 static inline s32 at24_smbus_write_i2c_block_data(struct at24_data *at24,
@@ -376,8 +395,8 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 						client, offset, count, buf);
 				break;
 			case I2C_SMBUS_BYTE_DATA:
-				status = i2c_smbus_write_byte_data(client,
-						offset, buf[0]);
+				status = at24_smbus_write_byte_data(at24,
+						client, offset, buf[0]);
 				break;
 			}
 
@@ -562,7 +581,17 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
 			use_smbus_write = I2C_SMBUS_I2C_BLOCK_DATA;
-		} else if (i2c_check_functionality(client->adapter,
+		} else if (chip.flags & AT24_FLAG_ADDR16 &&
+		    i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
+			/*
+			 * We need SMBUS_WRITE_WORD_DATA to implement
+			 * byte writes for 16-bit address devices.
+			 */
+			use_smbus_write = I2C_SMBUS_BYTE_DATA;
+			chip.page_size = 1;
+		} else if (!(chip.flags & AT24_FLAG_ADDR16) &&
+			i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
 			use_smbus_write = I2C_SMBUS_BYTE_DATA;
 			chip.page_size = 1;
-- 
1.9.1
