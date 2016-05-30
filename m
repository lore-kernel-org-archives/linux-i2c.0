From: minyard@acm.org
Subject: [PATCH v2 03/10] i2c-i801: Move hwpec handling into block transaction
Date: Sun, 29 May 2016 20:08:57 -0500
Message-ID: <1464570544-975-4-git-send-email-minyard@acm.org>
References: <1464570544-975-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35052 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcE3BJP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 29 May 2016 21:09:15 -0400
In-Reply-To: <1464570544-975-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, minyard@acm.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Since hwpec is only used for block transactions, move it out of
i801_access() and into i801_block_transaction().

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 47 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 205f9d0..222be9c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -656,11 +656,22 @@ static int i801_set_block_buffer_mode(struct i801_priv *priv)
 }
 
 /* Block transaction function */
-static int i801_block_transaction(struct i801_priv *priv,
+static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
 				  union i2c_smbus_data *data, char read_write,
-				  int command, int hwpec)
+				  int command)
 {
 	int result = 0;
+	int hwpec = (priv->features & FEATURE_SMBUS_PEC)
+		&& (flags & I2C_CLIENT_PEC)
+		&& command != I2C_SMBUS_QUICK
+		&& command != I2C_SMBUS_I2C_BLOCK_DATA;
+
+	if (hwpec)	/* enable/disable hardware PEC */
+		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC,
+		       SMBAUXCTL(priv));
+	else
+		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
+		       SMBAUXCTL(priv));
 
 	if (read_write == I2C_SMBUS_WRITE
 	 || command == I2C_SMBUS_I2C_BLOCK_DATA) {
@@ -685,6 +696,16 @@ static int i801_block_transaction(struct i801_priv *priv,
 							     read_write,
 							     command);
 
+	/*
+	 * Some BIOSes don't like it when PEC is enabled at reboot or
+	 * resume time, so we forcibly disable it after every
+	 * transaction. Turn off E32B for the same reason.
+	 */
+	if (hwpec)
+		outb_p(inb_p(SMBAUXCTL(priv)) &
+		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
+		       SMBAUXCTL(priv));
+
 	return result;
 }
 
@@ -693,7 +714,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		       unsigned short flags, char read_write, u8 command,
 		       int size, union i2c_smbus_data *data)
 {
-	int hwpec;
 	int block = 0;
 	int ret = 0, xact = 0;
 	int hostc = -1;
@@ -701,10 +721,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 
 	pm_runtime_get_sync(&priv->pci_dev->dev);
 
-	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
-		&& size != I2C_SMBUS_QUICK
-		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
-
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -773,25 +789,12 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		goto out;
 	}
 
-	if (hwpec)	/* enable/disable hardware PEC */
-		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
-	else
-		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
-		       SMBAUXCTL(priv));
-
 	if (block)
-		ret = i801_block_transaction(priv, data, read_write, size,
-					     hwpec);
+		ret = i801_block_transaction(priv, flags, data, read_write,
+					     size);
 	else
 		ret = i801_transaction(priv, xact);
 
-	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
-	   time, so we forcibly disable it after every transaction. Turn off
-	   E32B for the same reason. */
-	if (hwpec || block)
-		outb_p(inb_p(SMBAUXCTL(priv)) &
-		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
-
 	if (hostc >= 0)
 		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
 
-- 
2.7.4
