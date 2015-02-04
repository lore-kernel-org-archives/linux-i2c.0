From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] eeprom: at24: Add support for large EEPROMs connected to SMBus adapters
Date: Wed,  4 Feb 2015 08:23:37 -0800
Message-ID: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Large EEPROMS (24c32 and larger) require a two-byte data address
instead of just a single byte. Implement support for such EEPROMs
with SMBus commands.

Support has limitations (reads are not multi-master safe) and is slow,
but it works. Practical use is for a system with 24c32 connected to
Intel 82801I (ICH9).

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/misc/eeprom/at24.c | 52 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2d3db81..057d35c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -198,6 +198,8 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	case I2C_SMBUS_BYTE_DATA:
 		count = 1;
 		break;
+	case I2C_SMBUS_BYTE:
+		break;
 	default:
 		/*
 		 * When we have a better choice than SMBus calls, use a
@@ -249,6 +251,27 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 				status = count;
 			}
 			break;
+		case I2C_SMBUS_BYTE:
+			/*
+			 * 16-bit data address. Write data address as separate
+			 * write operation, then read data without setting
+			 * the address again. This is not multi-master safe,
+			 * but the best we can do.
+			 */
+			status = i2c_smbus_write_byte_data(client,
+							   offset >> 8,
+							   offset & 0xff);
+			if (status < 0)
+				break;
+			for (i = 0; i < count; i++) {
+				status = i2c_smbus_read_byte(client);
+				if (status < 0)
+					break;
+				buf[i] = status;
+			}
+			if (status >= 0)
+				status = count;
+			break;
 		default:
 			status = i2c_transfer(client->adapter, msg, 2);
 			if (status == 2)
@@ -372,6 +395,16 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 				status = i2c_smbus_write_i2c_block_data(client,
 						offset, count, buf);
 				break;
+			case I2C_SMBUS_WORD_DATA:
+				/*
+				 * 16-bit data address. Transmit data address
+				 * MSB as SMBus command, data address LSB as
+				 * first data byte.
+				 */
+				status = i2c_smbus_write_word_data(client,
+					offset >> 8,
+					(offset & 0xff) | (buf[0] << 8));
+				break;
 			case I2C_SMBUS_BYTE_DATA:
 				status = i2c_smbus_write_byte_data(client,
 						offset, buf[0]);
@@ -540,10 +573,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* Use I2C operations unless we're stuck with SMBus extensions. */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		if (chip.flags & AT24_FLAG_ADDR16)
-			return -EPFNOSUPPORT;
-
-		if (i2c_check_functionality(client->adapter,
+		if (chip.flags & AT24_FLAG_ADDR16) {
+			if (!i2c_check_functionality(client->adapter,
+						I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+						I2C_FUNC_SMBUS_READ_BYTE))
+				return -EPFNOSUPPORT;
+			use_smbus = I2C_SMBUS_BYTE;
+		} else if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
 		} else if (i2c_check_functionality(client->adapter,
@@ -559,7 +595,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* Use I2C operations unless we're stuck with SMBus extensions. */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		if (i2c_check_functionality(client->adapter,
+		if (chip.flags & AT24_FLAG_ADDR16) {
+			if (i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
+				use_smbus_write = I2C_SMBUS_WORD_DATA;
+				chip.page_size = 1;
+			}
+		} else if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
 			use_smbus_write = I2C_SMBUS_I2C_BLOCK_DATA;
 		} else if (i2c_check_functionality(client->adapter,
-- 
2.1.0
