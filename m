From: minyard@acm.org
Subject: [PATCH v2 07/10] i2c-i801: Fix some inconsistent variable names
Date: Sun, 29 May 2016 20:09:01 -0500
Message-ID: <1464570544-975-8-git-send-email-minyard@acm.org>
References: <1464570544-975-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34990 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbcE3BJR (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 29 May 2016 21:09:17 -0400
In-Reply-To: <1464570544-975-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, minyard@acm.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The priv->cmd is called subcmd elsewhere, and that's a more
appropriate name for it, so rename it.

The "size" parameter passed in to i801_access is passed to other
functions and those name is "command".  This is confusing with the
"command" parameter passed in to i801_access.  Rename it to "size"
everywhere.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ae1e60a..b415948 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -233,7 +233,7 @@ struct i801_priv {
 	u8 status;
 
 	/* Command state used by isr for byte-by-byte block transactions */
-	u8 cmd;
+	u8 subcmd;
 	bool is_read;
 	int count;
 	int len;
@@ -468,7 +468,7 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 {
 	if (priv->is_read) {
 		/* For SMBus block reads, length is received with first byte */
-		if (((priv->cmd & 0x1c) == I801_BLOCK_DATA) &&
+		if (((priv->subcmd & 0x1c) == I801_BLOCK_DATA) &&
 		    (priv->count == 0)) {
 			priv->len = inb_p(SMBHSTDAT0(priv));
 			if (priv->len < 1 || priv->len > I2C_SMBUS_BLOCK_MAX) {
@@ -494,7 +494,7 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 
 		/* Set LAST_BYTE for last byte of read transaction */
 		if (priv->count == priv->len - 1)
-			outb_p(priv->cmd | SMBHSTCNT_LAST_BYTE,
+			outb_p(priv->subcmd | SMBHSTCNT_LAST_BYTE,
 			       SMBHSTCNT(priv));
 	} else if (priv->count < priv->len - 1) {
 		/* Write next byte, except for IRQ after last byte */
@@ -555,7 +555,7 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
  */
 static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 					       union i2c_smbus_data *data,
-					       bool is_read, int command)
+					       bool is_read, int size)
 {
 	int i, len;
 	int smbcmd;
@@ -570,7 +570,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		outb_p(data->block[1], SMBBLKDAT(priv));
 	}
 
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA && is_read)
+	if (size == I2C_SMBUS_I2C_BLOCK_DATA && is_read)
 		smbcmd = I801_I2C_BLOCK_DATA;
 	else
 		smbcmd = I801_BLOCK_DATA;
@@ -579,12 +579,12 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		priv->is_read = is_read;
 		if (len == 1 && is_read)
 			smbcmd |= SMBHSTCNT_LAST_BYTE;
-		priv->cmd = smbcmd | SMBHSTCNT_INTREN;
+		priv->subcmd = smbcmd | SMBHSTCNT_INTREN;
 		priv->len = len;
 		priv->count = 0;
 		priv->data = &data->block[1];
 
-		outb_p(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
+		outb_p(priv->subcmd | SMBHSTCNT_START, SMBHSTCNT(priv));
 		result = wait_event_timeout(priv->waitq,
 					    (status = priv->status),
 					    adap->timeout);
@@ -610,8 +610,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		if (status)
 			return status;
 
-		if (i == 1 && is_read
-		 && command != I2C_SMBUS_I2C_BLOCK_DATA) {
+		if (i == 1 && is_read && size != I2C_SMBUS_I2C_BLOCK_DATA) {
 			priv->len = inb_p(SMBHSTDAT0(priv));
 			if (priv->len < 1 || priv->len > I2C_SMBUS_BLOCK_MAX)
 				return -EPROTO;
@@ -642,13 +641,13 @@ static int i801_set_block_buffer_mode(struct i801_priv *priv)
 /* Block transaction function */
 static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
 				  union i2c_smbus_data *data, bool is_read,
-				  int command)
+				  int size)
 {
 	int result = 0;
 	int hwpec = (priv->features & FEATURE_SMBUS_PEC)
 		&& (flags & I2C_CLIENT_PEC)
-		&& command != I2C_SMBUS_QUICK
-		&& command != I2C_SMBUS_I2C_BLOCK_DATA;
+		&& size != I2C_SMBUS_QUICK
+		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
 
 	if (hwpec)	/* enable/disable hardware PEC */
 		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC,
@@ -657,7 +656,7 @@ static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
 		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
 		       SMBAUXCTL(priv));
 
-	if (!is_read || command == I2C_SMBUS_I2C_BLOCK_DATA) {
+	if (!is_read || size == I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (data->block[0] < 1)
 			data->block[0] = 1;
 		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
@@ -670,13 +669,13 @@ static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
 	   SMBus (not I2C) block transactions, even though the datasheet
 	   doesn't mention this limitation. */
 	if ((priv->features & FEATURE_BLOCK_BUFFER)
-	 && command != I2C_SMBUS_I2C_BLOCK_DATA
+	 && size != I2C_SMBUS_I2C_BLOCK_DATA
 	 && i801_set_block_buffer_mode(priv) == 0)
 		result = i801_block_transaction_by_block(priv, data, is_read,
 							 hwpec);
 	else
 		result = i801_block_transaction_byte_by_byte(priv, data,
-							     is_read, command);
+							     is_read, size);
 
 	/*
 	 * Some BIOSes don't like it when PEC is enabled at reboot or
-- 
2.7.4
