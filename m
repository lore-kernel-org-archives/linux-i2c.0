From: minyard@acm.org
Subject: [PATCH 2/5] i2c-i801: Move hostcfg set/reset to i801_access()
Date: Tue, 19 Jan 2016 11:09:34 -0600
Message-ID: <1453223377-20608-3-git-send-email-minyard@acm.org>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:61026 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932952AbcASSKH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:10:07 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173017.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O1700L7JMC4MP70@vms173017.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:09:45 -0600 (CST)
In-reply-to: <1453223377-20608-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The HSTCFG register save/restore was done in i2c_block_transaction,
but all the checks were already done in i801_access, so move it into
those checks.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 62cf1e5..9143fcf 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -652,20 +652,6 @@ static int i801_block_transaction(struct i801_priv *priv,
 				  int command, int hwpec)
 {
 	int result = 0;
-	unsigned char hostc;
-
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
-		if (read_write == I2C_SMBUS_WRITE) {
-			/* set I2C_EN bit in configuration register */
-			pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &hostc);
-			pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
-					      hostc | SMBHSTCFG_I2C_EN);
-		} else if (!(priv->features & FEATURE_I2C_BLOCK_READ)) {
-			dev_err(&priv->pci_dev->dev,
-				"I2C block read is unsupported!\n");
-			return -EOPNOTSUPP;
-		}
-	}
 
 	if (read_write == I2C_SMBUS_WRITE
 	 || command == I2C_SMBUS_I2C_BLOCK_DATA) {
@@ -692,11 +678,6 @@ static int i801_block_transaction(struct i801_priv *priv,
 							     read_write,
 							     command);
 
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA
-	 && read_write == I2C_SMBUS_WRITE) {
-		/* restore saved configuration register value */
-		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
-	}
 	return result;
 }
 
@@ -710,6 +691,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int ret, xact = 0;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 	int result;
+	int hostc = -1;
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
@@ -757,9 +739,19 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		 * bit should be cleared here, even when reading */
 		outb_p((addr & 0x7f) << 1, SMBHSTADD(priv));
 		if (read_write == I2C_SMBUS_READ) {
+			unsigned char thostc;
 			/* NB: page 240 of ICH5 datasheet also shows
 			 * that DATA1 is the cmd field when reading */
 			outb_p(command, SMBHSTDAT1(priv));
+			/* set I2C_EN bit in configuration register */
+			pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &thostc);
+			pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
+					      thostc | SMBHSTCFG_I2C_EN);
+			hostc = thostc;
+		} else if (!(priv->features & FEATURE_I2C_BLOCK_READ)) {
+			dev_err(&priv->pci_dev->dev,
+				"I2C block read is unsupported!\n");
+			return -EOPNOTSUPP;
 		} else
 			outb_p(command, SMBHSTCMD(priv));
 		block = 1;
@@ -795,6 +787,9 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	if (hostc >= 0)
+		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
+
 	if (block)
 		return ret;
 	if (ret)
-- 
2.5.0
