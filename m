From: minyard@acm.org
Subject: [PATCH 3/5] i2c-i801: Move PEC handling into i2c_block_transaction()
Date: Tue, 19 Jan 2016 11:09:35 -0600
Message-ID: <1453223377-20608-4-git-send-email-minyard@acm.org>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:53555 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778AbcASSKQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:10:16 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173019.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O17007DMMC4G8G0@vms173019.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:09:45 -0600 (CST)
In-reply-to: <1453223377-20608-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

PEC is only used on real block transactions, moving it into the block
transaction code allows removal of some if statements and the proper
setting of SMBAUXCTL.  PEC was being set in the byte-by-byte block
transaction, though it wasn't valid in that situation.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 52 ++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9143fcf..7567a96 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -669,14 +669,31 @@ static int i801_block_transaction(struct i801_priv *priv,
 	if ((priv->features & FEATURE_BLOCK_BUFFER)
 	 && command != I2C_SMBUS_I2C_BLOCK_DATA
 	 && i801_set_block_buffer_mode(priv) == 0) {
-		if (hwpec)
+		if (hwpec) {	/* enable/disable hardware PEC */
+			outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC,
+			       SMBAUXCTL(priv));
 			priv->xact_extra |= SMBHSTCNT_PEC_EN;
+		} else
+			outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
+			       SMBAUXCTL(priv));
+
 		result = i801_block_transaction_by_block(priv, data,
 							 read_write);
-	} else
+	} else {
+		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
+		       SMBAUXCTL(priv));
 		result = i801_block_transaction_byte_by_byte(priv, data,
 							     read_write,
 							     command);
+	}
+
+	/*
+	 * Some BIOSes don't like it when PEC is enabled at reboot or resume
+	 * time, so we forcibly disable it after every transaction. Turn off
+	 * E32B for the same reason.
+	 */
+	outb_p(inb_p(SMBAUXCTL(priv)) &
+	       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
 	return result;
 }
@@ -686,17 +703,12 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		       unsigned short flags, char read_write, u8 command,
 		       int size, union i2c_smbus_data *data)
 {
-	int hwpec;
 	int block = 0;
 	int ret, xact = 0;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 	int result;
 	int hostc = -1;
 
-	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
-		&& size != I2C_SMBUS_QUICK
-		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
-
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -766,26 +778,20 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	if (result < 0)
 		return result;
 
-	if (hwpec) {	/* enable/disable hardware PEC */
-		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
-	} else {
-		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
-		       SMBAUXCTL(priv));
-		priv->xact_extra &= ~SMBHSTCNT_PEC_EN;
-	}
+	priv->xact_extra &= ~SMBHSTCNT_PEC_EN;
+	if (block) {
+		int hwpec = (priv->features & FEATURE_SMBUS_PEC) &&
+			(flags & I2C_CLIENT_PEC)
+			&& size != I2C_SMBUS_QUICK
+			&& size != I2C_SMBUS_I2C_BLOCK_DATA;
 
-	if (block)
 		ret = i801_block_transaction(priv, data, read_write, size,
 					     hwpec);
-	else
+	} else {
+		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
+		       SMBAUXCTL(priv));
 		ret = i801_transaction(priv, xact);
-
-	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
-	   time, so we forcibly disable it after every transaction. Turn off
-	   E32B for the same reason. */
-	if (hwpec || block)
-		outb_p(inb_p(SMBAUXCTL(priv)) &
-		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
+	}
 
 	if (hostc >= 0)
 		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
-- 
2.5.0
