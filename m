From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 1/3 v2] at24: Support SMBus block writes to 16-bit devices
Date: Mon, 21 Sep 2015 13:39:11 -0500 (CDT)
Message-ID: <634653382.82806.1442860751404.JavaMail.zimbra@xes-inc.com>
References: <1888937035.82162.1441309955075.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:37425 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140AbbIUSkS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 21 Sep 2015 14:40:18 -0400
In-Reply-To: <1888937035.82162.1441309955075.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Jean Delvare <jdelvare@suse.com>, Nate Case <ncase@xes-inc.com>

Introduce at24_smbus_write_i2c_block_data() to allow very slow write
access to 16-bit EEPROM devices attached to SMBus controllers like
the Intel I801.

With an AT24C512 device:
    248 B/s with 1-byte page (default)
    3.9 KB/s with 128-byte* page (via platform data)

*limited to 16-bytes by I2C_SMBUS_BLOCK_MAX / 2.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 v2 - Unchanged from v1

 drivers/misc/eeprom/at24.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c6cb7f8..c3d3add 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -134,6 +134,34 @@ MODULE_DEVICE_TABLE(i2c, at24_ids);
 /*-------------------------------------------------------------------------*/
 
 /*
+ * Write block data to an AT24 device using SMBus cycles.
+ */
+static inline s32 at24_smbus_write_i2c_block_data(struct at24_data *at24,
+	const struct i2c_client *client, u16 off, u8 len, const u8 *vals)
+{
+	u8 *addr16;
+	s32 res;
+
+	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
+		return i2c_smbus_write_i2c_block_data(client, off, len, vals);
+
+	addr16 = kzalloc(len + 1, GFP_KERNEL);
+	if (!addr16)
+		return -ENOMEM;
+
+	/* Insert extra address byte into data stream */
+	addr16[0] = off & 0xff;
+	memcpy(addr16 + 1, vals, len);
+
+	res = i2c_smbus_write_i2c_block_data(client,
+		(off >> 8) & 0xff, len + 1, addr16);
+
+	kfree(addr16);
+
+	return res;
+}
+
+/*
  * This routine supports chips which consume multiple I2C addresses. It
  * computes the addressing information to be used for a given r/w request.
  * Assumes that sanity checks for offset happened at sysfs-layer.
@@ -344,8 +372,8 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 		if (at24->use_smbus_write) {
 			switch (at24->use_smbus_write) {
 			case I2C_SMBUS_I2C_BLOCK_DATA:
-				status = i2c_smbus_write_i2c_block_data(client,
-						offset, count, buf);
+				status = at24_smbus_write_i2c_block_data(at24,
+						client, offset, count, buf);
 				break;
 			case I2C_SMBUS_BYTE_DATA:
 				status = i2c_smbus_write_byte_data(client,
@@ -584,7 +612,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			if (write_max > io_limit)
 				write_max = io_limit;
 			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
-				write_max = I2C_SMBUS_BLOCK_MAX;
+				write_max = I2C_SMBUS_BLOCK_MAX >>
+					!!(chip.flags & AT24_FLAG_ADDR16);
 			at24->write_max = write_max;
 
 			/* buffer (data + address at the beginning) */
-- 
1.9.1
