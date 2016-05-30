From: minyard@acm.org
Subject: [PATCH v2 02/10] i2c-i801: Move hostcfg set/reset to i801_access()
Date: Sun, 29 May 2016 20:08:56 -0500
Message-ID: <1464570544-975-3-git-send-email-minyard@acm.org>
References: <1464570544-975-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35848 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbcE3BJP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 29 May 2016 21:09:15 -0400
In-Reply-To: <1464570544-975-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, minyard@acm.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The HSTCFG register save/restore was done in i2c_block_transaction,
but all the checks were already done in i801_access, so move it into
those checks.

This results in a small savings of code, and moves some special
handing for I2C transactions into code that is already handling
special things for I2C transactions.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 818c0c8..205f9d0 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -661,20 +661,6 @@ static int i801_block_transaction(struct i801_priv *priv,
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
@@ -699,11 +685,6 @@ static int i801_block_transaction(struct i801_priv *priv,
 							     read_write,
 							     command);
 
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA
-	 && read_write == I2C_SMBUS_WRITE) {
-		/* restore saved configuration register value */
-		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
-	}
 	return result;
 }
 
@@ -715,6 +696,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int hwpec;
 	int block = 0;
 	int ret = 0, xact = 0;
+	int hostc = -1;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 
 	pm_runtime_get_sync(&priv->pci_dev->dev);
@@ -764,12 +746,24 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		/* NB: page 240 of ICH5 datasheet shows that the R/#W
 		 * bit should be cleared here, even when reading */
 		outb_p((addr & 0x7f) << 1, SMBHSTADD(priv));
-		if (read_write == I2C_SMBUS_READ) {
+		if (read_write == I2C_SMBUS_WRITE) {
+			unsigned char thostc;
+
+			outb_p(command, SMBHSTCMD(priv));
+			/* set I2C_EN bit in configuration register */
+			pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &thostc);
+			pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
+					      thostc | SMBHSTCFG_I2C_EN);
+			hostc = thostc;
+		} else if (!(priv->features & FEATURE_I2C_BLOCK_READ)) {
+			dev_err(&priv->pci_dev->dev,
+				"I2C block read is unsupported!\n");
+			ret = -EOPNOTSUPP;
+			goto out;
+		} else
 			/* NB: page 240 of ICH5 datasheet also shows
 			 * that DATA1 is the cmd field when reading */
 			outb_p(command, SMBHSTDAT1(priv));
-		} else
-			outb_p(command, SMBHSTCMD(priv));
 		block = 1;
 		break;
 	default:
@@ -798,6 +792,9 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	if (hostc >= 0)
+		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
+
 	if (block)
 		goto out;
 	if (ret)
-- 
2.7.4
