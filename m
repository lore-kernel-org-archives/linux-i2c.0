From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH v6] at24: Support SMBus read/write of 16-bit devices
Date: Mon, 16 Nov 2015 18:02:19 -0600 (CST)
Message-ID: <1637462042.105214.1447718539047.JavaMail.zimbra@xes-inc.com>
References: <1914980865.104978.1447718293775.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:51442 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbbKQAD3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 Nov 2015 19:03:29 -0500
In-Reply-To: <1914980865.104978.1447718293775.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
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
Reviewed-by: Jean Delvare <jdelvare@suse.de>
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
 v4 - Address 16-bit safety in Kconfig
    - Set "count" to zero later in at24_smbus_read_block_data()
    - Fix over-80-columns issues in at24_eeprom_read()
    - Fix write_max off-by-one in at24_probe()
    - Check SMBus functionality needed for 16-bit device reads
    - Homogenize indentation of SMBus functionality checks for SMBus write
 v5 - 16-bit device read needs READ_BYTE not READ_BYTE_DATA
    - Clarify write_max limiting with smbus_max
    - Add X-ES copyright
 v6 - Update comment associated with SMBus functionality testing for 16-bit
      device read (READ_BYTE not READ_BYTE_DATA)

 drivers/misc/eeprom/Kconfig |   5 +-
 drivers/misc/eeprom/at24.c  | 132 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 122 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 04f2e1f..cc0f86c 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -22,7 +22,10 @@ config EEPROM_AT24
 
 	  If you use this with an SMBus adapter instead of an I2C adapter,
 	  full functionality is not available.  Only smaller devices are
-	  supported (24c16 and below, max 4 kByte).
+	  supported via block reads (24c16 and below, max 4 kByte).
+	  Larger devices that use 16-bit addresses will only work with
+	  individual byte reads, which is very slow in general and is unsafe
+	  in multi-master SMBus topologies.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called at24.
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 5d7c090..52cb707 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2005-2007 David Brownell
  * Copyright (C) 2008 Wolfram Sang, Pengutronix
+ * Copyright (C) 2015 Extreme Engineering Solutions, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -50,7 +51,7 @@
  * Other than binding model, current differences from "eeprom" driver are
  * that this one handles write access and isn't restricted to 24c02 devices.
  * It also handles larger devices (32 kbit and up) with two-byte addresses,
- * which won't work on pure SMBus systems.
+ * which don't work without risks on pure SMBus systems.
  */
 
 struct at24_data {
@@ -141,6 +142,87 @@ MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
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
+	int count;
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
+	count = 0;
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
@@ -229,8 +311,8 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	do {
 		read_time = jiffies;
 		if (at24->use_smbus) {
-			status = i2c_smbus_read_i2c_block_data_or_emulated(client, offset,
-									   count, buf);
+			status = at24_smbus_read_block_data(at24, client,
+							    offset, count, buf);
 		} else {
 			status = i2c_transfer(client->adapter, msg, 2);
 			if (status == 2)
@@ -351,12 +433,12 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
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
 
@@ -527,10 +609,19 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* Use I2C operations unless we're stuck with SMBus extensions. */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		if (chip.flags & AT24_FLAG_ADDR16)
-			return -EPFNOSUPPORT;
-
-		if (i2c_check_functionality(client->adapter,
+		if ((chip.flags & AT24_FLAG_ADDR16) &&
+		    i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_READ_BYTE |
+				I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+			/*
+			 * We need SMBUS_WRITE_BYTE_DATA and SMBUS_READ_BYTE to
+			 * implement byte reads for 16-bit address devices.
+			 * This will be slow, but better than nothing (e.g.
+			 * read @ 3.6 KiB/s). It is also unsafe in a multi-
+			 * master topology.
+			 */
+			use_smbus = I2C_SMBUS_BYTE_DATA;
+		} else if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
 		} else if (i2c_check_functionality(client->adapter,
@@ -549,7 +640,17 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
 			use_smbus_write = I2C_SMBUS_I2C_BLOCK_DATA;
-		} else if (i2c_check_functionality(client->adapter,
+		} else if ((chip.flags & AT24_FLAG_ADDR16) &&
+			   i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
+			/*
+			 * We need SMBUS_WRITE_WORD_DATA to implement
+			 * byte writes for 16-bit address devices.
+			 */
+			use_smbus_write = I2C_SMBUS_BYTE_DATA;
+			chip.page_size = 1;
+		} else if (!(chip.flags & AT24_FLAG_ADDR16) &&
+			   i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
 			use_smbus_write = I2C_SMBUS_BYTE_DATA;
 			chip.page_size = 1;
@@ -590,6 +691,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (!use_smbus || use_smbus_write) {
 
 			unsigned write_max = chip.page_size;
+			unsigned smbus_max = (chip.flags & AT24_FLAG_ADDR16) ?
+					     I2C_SMBUS_BLOCK_MAX - 1 :
+					     I2C_SMBUS_BLOCK_MAX;
 
 			at24->macc.write = at24_macc_write;
 
@@ -598,8 +702,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 			if (write_max > io_limit)
 				write_max = io_limit;
-			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
-				write_max = I2C_SMBUS_BLOCK_MAX;
+			if (use_smbus && write_max > smbus_max)
+				write_max = smbus_max;
 			at24->write_max = write_max;
 
 			/* buffer (data + address at the beginning) */
-- 
1.9.1
