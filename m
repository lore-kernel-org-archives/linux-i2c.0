From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] at24: Support SMBus byte writes to 16-bit devices
Date: Thu, 3 Sep 2015 14:53:18 -0500 (CDT)
Message-ID: <865272709.82219.1441309998483.JavaMail.zimbra@xes-inc.com>
References: <170373713.64425.1441302468753.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <170373713.64425.1441302468753.JavaMail.zimbra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Introduce at24_smbus_write_byte_data() to allow very slow (e.g.
248 B/s) write access to 16-bit EEPROM devices attached to SMBus
controllers like the Intel SCH.

Signed-off-by: Nate Case <ncase-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/misc/eeprom/at24.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 4cf53a0..2ee1301 100644
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
@@ -401,8 +420,8 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 						client, offset, count, buf);
 				break;
 			case I2C_SMBUS_BYTE_DATA:
-				status = i2c_smbus_write_byte_data(client,
-						offset, buf[0]);
+				status = at24_smbus_write_byte_data(at24,
+						client, offset, buf[0]);
 				break;
 			}
 
@@ -590,7 +609,17 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
