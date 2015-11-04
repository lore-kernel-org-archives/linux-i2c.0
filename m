From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH v3] at24: Support SMBus read/write of 16-bit devices
Date: Wed, 4 Nov 2015 11:28:29 -0600 (CST)
Message-ID: <1356526136.43504.1446658109674.JavaMail.zimbra@xes-inc.com>
References: <1653456806.31875.1446652951693.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:24327 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbbKDR3h (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 4 Nov 2015 12:29:37 -0500
In-Reply-To: <1653456806.31875.1446652951693.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Nate Case <ncase@xes-inc.com>

Previously, the at24 driver would bail out in the case of a 16-bit
addressable EEPROM attached to an SMBus controller. This is because
SMBus block reads and writes don't map to I2C multi-byte reads and
writes when the offset portion is 2 bytes.

Instead of bailing out, this patch settles for functioning with single
byte read SMBus cycles. Writes can be block or single-byte, depending
on SMBus controller features.

Read access is not without some risk. Multiple SMBus cycles are
required to read even one byte. If the SMBus has multiple masters and
one accesses this EEPROM between the dummy address write and the
subsequent current-address-read cycle(s), this driver will receive
data from the wrong address.

Functionality has been tested with the following devices:

    AT24CM01 attached to Intel ISCH SMBus
    AT24C512 attached to Intel I801 SMBus

Read performance:
    3.6 KB/s with 32-byte* access

    *limited to 32-bytes by I2C_SMBUS_BLOCK_MAX.

Write performance:
    248 B/s with 1-byte page (default)
    3.9 KB/s with 128-byte* page (via platform data)

    *limited to 31-bytes by I2C_SMBUS_BLOCK_MAX - 1.

Signed-off-by: Nate Case <ncase@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 v2 - Account for changes related to introduction of
      i2c_smbus_read_i2c_block_data_or_emulated()
 v3 - Consolidate three patches into one
    - Expand comments regarding SMBus multi-master read risks.
    - Rely on current-address-read for improved read performance (i.e. one
      dummy address write followed by multiple individual byte reads).
      This improves performance from 1.4 KiB/s to 3.6 KiB/s.
    - Use struct at24_data's writebuf instead of kzalloc-ing
    - Only limit write_max by 1-byte when accessing a 16-bit device with
      block writes instead of attempting to preserve a power-of-two.
    - Style fixes (indentation, parentheses, unnecessary masking, etc.)

 drivers/misc/eeprom/Kconfig |   4 +-
 drivers/misc/eeprom/at24.c  | 118 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 13 deletions(-)

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
index 5d7c090..35c5c83 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -50,7 +50,7 @@
  * Other than binding model, current differences from "eeprom" driver are
  * that this one handles write access and isn't restricted to 24c02 devices.
  * It also handles larger devices (32 kbit and up) with two-byte addresses,
- * which won't work on pure SMBus systems.
+ * which don't work without risks on pure SMBus systems.
  */
 
 struct at24_data {
@@ -141,6 +141,86 @@ MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
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
+		offset >> 8, (value << 8) | (offset & 0xff));
+}
+
+/*
+ * Write block data to an AT24 device using SMBus cycles.
+ */
+static inline s32 at24_smbus_write_i2c_block_data(struct at24_data *at24,
+	const struct i2c_client *client, u16 off, u8 len, const u8 *vals)
+{
+	s32 res;
+
+	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
+		return i2c_smbus_write_i2c_block_data(client, off, len, vals);
+
+	/* Insert extra address byte into data stream */
+	at24->writebuf[0] = off & 0xff;
+	memcpy(&at24->writebuf[1], vals, len);
+
+	res = i2c_smbus_write_i2c_block_data(client,
+		off >> 8, len + 1, at24->writebuf);
+
+	return res;
+}
+
+/*
+ * Read block data from an AT24 device using SMBus cycles.
+ */
+static inline s32 at24_smbus_read_block_data(struct at24_data *at24,
+	const struct i2c_client *client, u16 off, u8 len, u8 *vals)
+{
+	int count = 0;
+	s32 res;
+
+	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
+		return i2c_smbus_read_i2c_block_data_or_emulated(client,
+				off, len, vals);
+
+	/*
+	 * Emulate I2C multi-byte read by using SMBus "write byte" and
+	 * "receive byte".  This is slightly unsafe since there is an
+	 * additional STOP involved, which exposes the SMBus and (this
+	 * device!) to takeover by another bus master. However, it's the
+	 * only way to work on SMBus-only controllers when talking to
+	 * EEPROMs with multi-byte addresses.
+	 */
+
+	/* Address "dummy" write */
+	res = i2c_smbus_write_byte_data(client, off >> 8, off & 0xff);
+	if (res < 0)
+		return res;
+
+	do {
+		/* Current Address Read */
+		res = i2c_smbus_read_byte(client);
+		if (res < 0)
+			break;
+
+		*(vals++) = res;
+		count++;
+		len--;
+	} while (len > 0);
+
+	return count;
+}
+
+/*
  * This routine supports chips which consume multiple I2C addresses. It
  * computes the addressing information to be used for a given r/w request.
  * Assumes that sanity checks for offset happened at sysfs-layer.
@@ -229,7 +309,7 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	do {
 		read_time = jiffies;
 		if (at24->use_smbus) {
-			status = i2c_smbus_read_i2c_block_data_or_emulated(client, offset,
+			status = at24_smbus_read_block_data(at24, client, offset,
 									   count, buf);
 		} else {
 			status = i2c_transfer(client->adapter, msg, 2);
@@ -351,12 +431,12 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 		if (at24->use_smbus_write) {
 			switch (at24->use_smbus_write) {
 			case I2C_SMBUS_I2C_BLOCK_DATA:
-				status = i2c_smbus_write_i2c_block_data(client,
-						offset, count, buf);
+				status = at24_smbus_write_i2c_block_data(at24,
+						client, offset, count, buf);
 				break;
 			case I2C_SMBUS_BYTE_DATA:
-				status = i2c_smbus_write_byte_data(client,
-						offset, buf[0]);
+				status = at24_smbus_write_byte_data(at24,
+						client, offset, buf[0]);
 				break;
 			}
 
@@ -527,10 +607,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* Use I2C operations unless we're stuck with SMBus extensions. */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		if (chip.flags & AT24_FLAG_ADDR16)
-			return -EPFNOSUPPORT;
-
-		if (i2c_check_functionality(client->adapter,
+		if (chip.flags & AT24_FLAG_ADDR16) {
+			/*
+			 * This will be slow, but better than nothing
+			 * (e.g. read @ 3.6 KiB/s).
+			 */
+			use_smbus = I2C_SMBUS_BYTE_DATA;
+		} else if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
 		} else if (i2c_check_functionality(client->adapter,
@@ -549,7 +632,17 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
 			use_smbus_write = I2C_SMBUS_I2C_BLOCK_DATA;
-		} else if (i2c_check_functionality(client->adapter,
+		} else if ((chip.flags & AT24_FLAG_ADDR16) &&
+		    i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
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
@@ -599,7 +692,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			if (write_max > io_limit)
 				write_max = io_limit;
 			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
-				write_max = I2C_SMBUS_BLOCK_MAX;
+				write_max = I2C_SMBUS_BLOCK_MAX -
+					!!(chip.flags & AT24_FLAG_ADDR16);
 			at24->write_max = write_max;
 
 			/* buffer (data + address at the beginning) */
-- 
1.9.1
