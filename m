From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 3/3 v2] at24: Support 16-bit devices on SMBus
Date: Mon, 21 Sep 2015 13:40:54 -0500 (CDT)
Message-ID: <1460773599.83116.1442860854813.JavaMail.zimbra@xes-inc.com>
References: <361739546.82254.1441310010061.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:13445 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471AbbIUSmA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 21 Sep 2015 14:42:00 -0400
In-Reply-To: <361739546.82254.1441310010061.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Jean Delvare <jdelvare@suse.com>, Nate Case <ncase@xes-inc.com>

Previously, the at24 driver would bail out in the case of a 16-bit
addressable EEPROM attached to an SMBus controller. This is because
SMBus block reads and writes don't map to I2C multi-byte reads and
writes when the offset portion is 2 bytes.

Instead of bailing out, this patch settles for functioning with single
byte read SMBus cycles. Writes can be block or single-byte, depending on
SMBus controller features.

Functionality has been tested with the following devices:

    AT24CM01 attached to Intel ISCH SMBus (1.8 KB/s)
    AT24C512 attached to Intel I801 SMBus (1.4 KB/s)

Signed-off-by: Nate Case <ncase@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 v2 - Account for changes related to introduction of
      i2c_smbus_read_i2c_block_data_or_emulated()

 drivers/misc/eeprom/Kconfig |  4 +++-
 drivers/misc/eeprom/at24.c  | 32 +++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 9536852f..08837ef 100644
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
index 32eca05..23c02bb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -268,7 +268,26 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	timeout = jiffies + msecs_to_jiffies(write_timeout);
 	do {
 		read_time = jiffies;
-		if (at24->use_smbus) {
+		if (at24->use_smbus && (at24->chip.flags & AT24_FLAG_ADDR16)) {
+			/*
+			 * Emulate I2C multi-byte read by using SMBus
+			 * "write byte" and "receive byte".  This isn't optimal
+			 * since there is an unnecessary STOP involved, but
+			 * it's the only way to work on many SMBus controllers
+			 * when talking to EEPROMs with multi-byte addresses.
+			 */
+			status = i2c_smbus_write_byte_data(client,
+				((offset >> 8) & 0xff), (offset & 0xff));
+			if (status < 0)
+				continue;
+
+			status = i2c_smbus_read_byte(client);
+			if (status < 0)
+				continue;
+
+			buf[0] = status;
+			count = status = 1;
+		} else if (at24->use_smbus) {
 			status = i2c_smbus_read_i2c_block_data_or_emulated(client, offset,
 									   count, buf);
 		} else {
@@ -559,10 +578,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
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
