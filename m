From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] at24: Support 16-bit devices on SMBus
Date: Thu, 3 Sep 2015 14:53:30 -0500 (CDT)
Message-ID: <361739546.82254.1441310010061.JavaMail.zimbra@xes-inc.com>
References: <1001500768.63909.1441302107931.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1001500768.63909.1441302107931.JavaMail.zimbra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Previously, the at24 driver would bail out in the case of a 16-bit
addressable EEPROM attached to an SMBus controller. This is because
SMBus block reads and writes don't map to I2C multi-byte reads and
writes when the offset portion is 2 bytes.

Instead of bailing out, this patch settles for functioning with single
byte read SMBus cycles. Writes can be block or single-byte, depending on
SMBus controller features.

This patch introduces at24_smbus_read_byte_data to transparently handle
single-byte reads from 8-bit and 16-bit devices.

Functionality has been tested with the following devices:

    AT24CM01 attached to Intel ISCH SMBus (1.8 KB/s)
    AT24C512 attached to Intel I801 SMBus (1.4 KB/s)

Signed-off-by: Nate Case <ncase-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/misc/eeprom/Kconfig |  4 +++-
 drivers/misc/eeprom/at24.c  | 40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 04f2e1f..bc79a44 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -22,7 +22,9 @@ config EEPROM_AT24
 
 	  If you use this with an SMBus adapter instead of an I2C adapter,
 	  full functionality is not available.  Only smaller devices are
-	  supported (24c16 and below, max 4 kByte).
+	  supported via block reads (24c16 and below, max 4 kByte).
+	  Larger devices that use 16-bit addresses will only work with
+	  individual byte reads, which is very slow.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called at24.
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b92ee6e..457f49c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -134,6 +134,32 @@ MODULE_DEVICE_TABLE(i2c, at24_ids);
 /*-------------------------------------------------------------------------*/
 
 /*
+ * Read a byte from an AT24 device using SMBus cycles.
+ */
+static inline s32 at24_smbus_read_byte_data(struct at24_data *at24,
+	struct i2c_client *client, u16 offset)
+{
+	s32 res;
+
+	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
+		return i2c_smbus_read_byte_data(client, offset);
+
+	/*
+	 * Emulate I2C multi-byte read by using SMBus "write byte" and
+	 * "receive byte".  This isn't optimal since there is an
+	 * unnecessary STOP involved, but it's the only way to
+	 * work on many SMBus controllers when talking to EEPROMs
+	 * with multi-byte addresses.
+	 */
+	res = i2c_smbus_write_byte_data(client,
+		((offset >> 8) & 0xff), (offset & 0xff));
+	if (res)
+		return res;
+
+	return i2c_smbus_read_byte(client);
+}
+
+/*
  * Write a byte to an AT24 device using SMBus cycles.
  */
 static inline s32 at24_smbus_write_byte_data(struct at24_data *at24,
@@ -290,7 +316,8 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 			}
 			break;
 		case I2C_SMBUS_BYTE_DATA:
-			status = i2c_smbus_read_byte_data(client, offset);
+			status = at24_smbus_read_byte_data(at24,
+				client, offset);
 			if (status >= 0) {
 				buf[0] = status;
 				status = count;
@@ -584,10 +611,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* Use I2C operations unless we're stuck with SMBus extensions. */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		if (chip.flags & AT24_FLAG_ADDR16)
-			return -EPFNOSUPPORT;
-
-		if (i2c_check_functionality(client->adapter,
+		if (chip.flags & AT24_FLAG_ADDR16) {
+			/*
+			 * This will be slow, but better than nothing
+			 * (e.g. read @ 1.4 KiB/s).
+			 */
+			use_smbus = I2C_SMBUS_BYTE_DATA;
+		} else if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
 		} else if (i2c_check_functionality(client->adapter,
-- 
1.9.1
