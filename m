Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4813D75AB
	for <linux-i2c@vger.kernel.org>; Thu, 14 May 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746290; cv=none; b=tt9jhAHJBoDNe8VjmkdlRKlf1FtAX9vfC8EmcfGWQPWR3TQgqkLYQpjbUO0tG2yZLdym7gha6ABBtr/WHBQXNQGPR+nI3ULEwZ0Cot4NrX4vyxSlDxgQxs6vLb9sTJljqBGfbJcmQCFJuTwY48j9OrVfPcyHer/aIeQQG+7j7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746290; c=relaxed/simple;
	bh=U//E7I30FjLVtgMkHJDQw8vBZF8jcZ/5zKHlmgTSVNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFjtOHN9/TmKJ558iwxt7q41mC6k3iAbvi/oXyUt6w9G8Y4YxWAZUSnne4URfczq+RCAcCH1GEJZzAbGzT20sv6N3iIF6olsRYYrNYsJR3wgMI+1HFEPIeU356mt5FYlNgXyegIdCEcLs2vjbWplM2FtYyLD0FCchYwaUwwoHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bohner.me; spf=fail smtp.mailfrom=bohner.me; dkim=pass (2048-bit key) header.d=bohner.me header.i=@bohner.me header.b=XcIagduv; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bohner.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bohner.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bohner.me header.i=@bohner.me header.b="XcIagduv"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gGNMG613dz9smc;
	Thu, 14 May 2026 10:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bohner.me; s=MBO0001;
	t=1778746282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ODaFCS4h3QNHuYgo/ABzTYcwON0UWqdW9vneBDFdOeo=;
	b=XcIagduvxArCTXT5Qo60gsp9WrGQWsD9sXdMO0pqhqqq9jNvANdaMO8M76oJTMFiGhbdO8
	eO7K3HcsIiNey6azhHjeArkDflPP4wOS6T9IPaqd4Ip8B8t+CY7botgNAwkbQuZ5CDIz9b
	FUll++AORhaWMEhqSrnMrE8w7RTK+y6jeFptu2xaDpWlG70K06eFavKCQPOeuBeX8iHF5O
	5DyQmLh/M0We9HNfxw7//bVXHaVL3t25lWAHURWKFZ/lKoHX68UEm1fsA2kWn2U9o3thXd
	nHrtdEYrAPTS8MB93vfx8sF1HKyVStfFUdMH1YEly8oqDSXVDArcLnyJCSO+5g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=fail (outgoing_mbo_mout: domain of peter@bohner.me does not designate 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=peter@bohner.me
From: Peter Bohner <peter@bohner.me>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	linux-i2c@vger.kernel.org
Cc: Peter Bohner <peter@bohner.me>
Subject: [PATCH] i2c: i2c-stub: support for I2C_FUNC_I2C
Date: Thu, 14 May 2026 10:11:00 +0200
Message-ID: <20260514081100.381043-1-peter@bohner.me>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4gGNMG613dz9smc

Make the i2c-stub driver optionally minimal support I2C transactions, when
enabling I2C_FUNC_I2C.
I2C reads/writes act on a dynamically expanded buffer that is separate
from the data of the SMBus commands.

Signed-off-by: Peter Bohner <peter@bohner.me>
---
 Documentation/i2c/i2c-stub.rst |  8 ++-
 drivers/i2c/i2c-stub.c         | 90 +++++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 13 deletions(-)

diff --git a/Documentation/i2c/i2c-stub.rst b/Documentation/i2c/i2c-stub.rst
index a6fc6916d6bc..8b427a9579dd 100644
--- a/Documentation/i2c/i2c-stub.rst
+++ b/Documentation/i2c/i2c-stub.rst
@@ -7,7 +7,8 @@ Description
 
 This module is a very simple fake I2C/SMBus driver.  It implements six
 types of SMBus commands: write quick, (r/w) byte, (r/w) byte data, (r/w)
-word data, (r/w) I2C block data, and (r/w) SMBus block data.
+word data, (r/w) I2C block data, and (r/w) SMBus block data, as-well as
+I2C transactions.
 
 You need to provide chip addresses as a module parameter when loading this
 driver, which will then only react to SMBus commands to these addresses.
@@ -30,6 +31,11 @@ SMBus block commands must be written to configure an SMBus command for
 SMBus block operations. Writes can be partial. Block read commands always
 return the number of bytes selected with the largest write so far.
 
+Support for I2C transactions using the I2C_RDWR ioctl must also be explicitly
+enabled by setting I2C_FUNC_I2C (0x00000001) in the functionality parameter.
+When enabled, the message data is written to and read from the beginning of a
+buffer, that is separate from the SMBus commands.
+
 The typical use-case is like this:
 
 	1. load this module
diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index 04314e3ed24c..bf718bd6110c 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -4,7 +4,7 @@
 
     Copyright (c) 2004 Mark M. Hoffman <mhoffman@lightlink.com>
     Copyright (C) 2007-2014 Jean Delvare <jdelvare@suse.de>
-
+    Copyright (c) 2026 Peter Bohner <peter@bohner.me>
 */
 
 #define pr_fmt(fmt) "i2c-stub: " fmt
@@ -23,6 +23,7 @@
  * Support for I2C_FUNC_SMBUS_BLOCK_DATA is disabled by default and must
  * be enabled explicitly by setting the I2C_FUNC_SMBUS_BLOCK_DATA bits
  * in the 'functionality' module parameter.
+ * The same applies to I2C_FUNC_I2C.
  */
 #define STUB_FUNC_DEFAULT \
 		(I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | \
@@ -30,7 +31,7 @@
 		 I2C_FUNC_SMBUS_I2C_BLOCK)
 
 #define STUB_FUNC_ALL \
-		(STUB_FUNC_DEFAULT | I2C_FUNC_SMBUS_BLOCK_DATA)
+		(STUB_FUNC_DEFAULT | I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_I2C)
 
 static unsigned short chip_addr[MAX_CHIPS];
 module_param_array(chip_addr, ushort, NULL, S_IRUGO);
@@ -81,6 +82,9 @@ struct stub_chip {
 	u8 bank_end;
 	u16 bank_size;
 	u16 *bank_words;	/* Room for bank_mask * bank_size registers */
+
+	u8 *i2c_rw_data;
+	u16 i2c_rw_size;
 };
 
 static struct stub_chip *stub_chips;
@@ -119,23 +123,82 @@ static u16 *stub_get_wordp(struct stub_chip *chip, u8 offset)
 		return chip->words + offset;
 }
 
-/* Return negative errno on error. */
-static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
-	char read_write, u8 command, int size, union i2c_smbus_data *data)
+static struct stub_chip *stub_addr_to_chip(u16 addr)
 {
-	s32 ret;
-	int i, len;
+	int i;
 	struct stub_chip *chip = NULL;
-	struct smbus_block_data *b;
-	u16 *wordp;
 
-	/* Search for the right chip */
 	for (i = 0; i < stub_chips_nr; i++) {
+		/* we do not need to handle I2C_FUNC_10BIT_ADDR explicitly */
 		if (addr == chip_addr[i]) {
 			chip = stub_chips + i;
 			break;
 		}
 	}
+	return chip;
+}
+
+static s32 stub_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	int i;
+	u8 *new_rw_mem;
+	struct stub_chip *chip = NULL;
+	struct i2c_msg *msg;
+
+	for (i = 0; i < num; i++) {
+		msg = msgs + i;
+		chip = stub_addr_to_chip(msg->addr);
+		if (!chip)
+			return -ENODEV;
+
+		/* len is guaranteed to be <= 8192 by i2cdev_ioctl_rdwr */
+		if (chip->i2c_rw_size < msg->len) {
+			new_rw_mem =
+				krelloc_array(chip->i2c_rw_data, msg->len, 1,
+					      GFP_KERNEL | __GFP_ZERO);
+			if (!new_rw_mem)
+				return -ENOMEM;
+			chip->i2c_rw_data = new_rw_mem;
+			chip->i2c_rw_size = msg->len;
+		}
+
+		/* read, size determined by slave */
+		if ((msg->flags & I2C_M_RD) && (msg->flags & I2C_M_RECV_LEN)) {
+			/* i2cdev_ioctl_rdwr expects this as a maximum, even
+			 * though 0xff would be the theoretically possible
+			 */
+			msg->len = min(chip->i2c_rw_size, I2C_SMBUS_BLOCK_MAX);
+			msg->buf[0] = msg->len - 1;
+			dev_dbg(&adap->dev,
+				"i2c read with RECV_LEN - addr 0x%02x, read %u bytes\n",
+				msg->addr, msg->len);
+			memcpy(msg->buf + 1, chip->i2c_rw_data, msg->len - 1);
+		} else if (msg->flags & I2C_M_RD) {
+			dev_dbg(&adap->dev,
+				"i2c read - addr 0x%02x, read %u bytes\n",
+				msg->addr, msg->len);
+			memcpy(msg->buf, chip->i2c_rw_data, msg->len);
+		} else {
+			dev_dbg(&adap->dev,
+				"i2c write - addr 0x%02x, wrote %u bytes\n",
+				msg->addr, msg->len);
+			memcpy(chip->i2c_rw_data, msg->buf, msg->len);
+		}
+	}
+	return num;
+}
+
+/* Return negative errno on error. */
+static s32 stub_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
+			   char read_write, u8 command, int size, union i2c_smbus_data *data)
+{
+	s32 ret;
+	int i, len;
+	struct stub_chip *chip;
+	struct smbus_block_data *b;
+	u16 *wordp;
+
+	chip = stub_addr_to_chip(addr);
 	if (!chip)
 		return -ENODEV;
 
@@ -308,7 +371,8 @@ static u32 stub_func(struct i2c_adapter *adapter)
 
 static const struct i2c_algorithm smbus_algorithm = {
 	.functionality	= stub_func,
-	.smbus_xfer	= stub_xfer,
+	.smbus_xfer	= stub_smbus_xfer,
+	.xfer           = stub_xfer,
 };
 
 static struct i2c_adapter stub_adapter = {
@@ -351,8 +415,10 @@ static void i2c_stub_free(void)
 {
 	int i;
 
-	for (i = 0; i < stub_chips_nr; i++)
+	for (i = 0; i < stub_chips_nr; i++) {
 		kfree(stub_chips[i].bank_words);
+		kfree(stub_chips[i].i2c_rw_data);
+	}
 	kfree(stub_chips);
 }
 
-- 
2.54.0

