From: minyard@acm.org
Subject: [PATCH 1/5] i2c-i801: hwpec and check_pre cleanups
Date: Tue, 19 Jan 2016 11:09:33 -0600
Message-ID: <1453223377-20608-2-git-send-email-minyard@acm.org>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173025pub.verizon.net ([206.46.173.25]:62032 "EHLO
	vms173025pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932933AbcASSJ6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:09:58 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173025.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O1700LX5MC4TW30@vms173025.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:09:41 -0600 (CST)
In-reply-to: <1453223377-20608-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Add an "xact_extra" variable and use it to carry the PEC enable and
interrupt flags .

Also move i801_check_pre() to i801_access()  That consolidates it to
one call, and there's no point in doing all the work if the hardware
isn't ready.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 51 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f62d697..62cf1e5 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -230,6 +230,7 @@ struct i801_priv {
 	/* isr processing */
 	wait_queue_head_t waitq;
 	u8 status;
+	u8 xact_extra; /* Used to set INTREN if irqs enabled, and HWPEC */
 
 	/* Command state used by isr for byte-by-byte block transactions */
 	u8 cmd;
@@ -401,13 +402,13 @@ static int i801_transaction(struct i801_priv *priv, int xact)
 	int result;
 	const struct i2c_adapter *adap = &priv->adapter;
 
-	result = i801_check_pre(priv);
-	if (result < 0)
-		return result;
+	/*
+	 * the current contents of SMBHSTCNT can be overwritten, since PEC,
+	 * SMBSCMD are passed in xact
+	 */
+	outb_p(xact | priv->xact_extra | SMBHSTCNT_START,  SMBHSTCNT(priv));
 
 	if (priv->features & FEATURE_IRQ) {
-		outb_p(xact | SMBHSTCNT_INTREN | SMBHSTCNT_START,
-		       SMBHSTCNT(priv));
 		result = wait_event_timeout(priv->waitq,
 					    (status = priv->status),
 					    adap->timeout);
@@ -420,17 +421,13 @@ static int i801_transaction(struct i801_priv *priv, int xact)
 		return i801_check_post(priv, status);
 	}
 
-	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
-	 * SMBSCMD are passed in xact */
-	outb_p(xact | SMBHSTCNT_START, SMBHSTCNT(priv));
-
 	status = i801_wait_intr(priv);
 	return i801_check_post(priv, status);
 }
 
 static int i801_block_transaction_by_block(struct i801_priv *priv,
 					   union i2c_smbus_data *data,
-					   char read_write, int hwpec)
+					   char read_write)
 {
 	int i, len;
 	int status;
@@ -445,8 +442,7 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 			outb_p(data->block[i+1], SMBBLKDAT(priv));
 	}
 
-	status = i801_transaction(priv, I801_BLOCK_DATA |
-				  (hwpec ? SMBHSTCNT_PEC_EN : 0));
+	status = i801_transaction(priv, I801_BLOCK_DATA);
 	if (status)
 		return status;
 
@@ -553,8 +549,7 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
  */
 static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 					       union i2c_smbus_data *data,
-					       char read_write, int command,
-					       int hwpec)
+					       char read_write, int command)
 {
 	int i, len;
 	int smbcmd;
@@ -562,10 +557,6 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 	int result;
 	const struct i2c_adapter *adap = &priv->adapter;
 
-	result = i801_check_pre(priv);
-	if (result < 0)
-		return result;
-
 	len = data->block[0];
 
 	if (read_write == I2C_SMBUS_WRITE) {
@@ -583,7 +574,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		priv->is_read = (read_write == I2C_SMBUS_READ);
 		if (len == 1 && priv->is_read)
 			smbcmd |= SMBHSTCNT_LAST_BYTE;
-		priv->cmd = smbcmd | SMBHSTCNT_INTREN;
+		priv->cmd = smbcmd | priv->xact_extra;
 		priv->len = len;
 		priv->count = 0;
 		priv->data = &data->block[1];
@@ -691,13 +682,15 @@ static int i801_block_transaction(struct i801_priv *priv,
 	   doesn't mention this limitation. */
 	if ((priv->features & FEATURE_BLOCK_BUFFER)
 	 && command != I2C_SMBUS_I2C_BLOCK_DATA
-	 && i801_set_block_buffer_mode(priv) == 0)
+	 && i801_set_block_buffer_mode(priv) == 0) {
+		if (hwpec)
+			priv->xact_extra |= SMBHSTCNT_PEC_EN;
 		result = i801_block_transaction_by_block(priv, data,
-							 read_write, hwpec);
-	else
+							 read_write);
+	} else
 		result = i801_block_transaction_byte_by_byte(priv, data,
 							     read_write,
-							     command, hwpec);
+							     command);
 
 	if (command == I2C_SMBUS_I2C_BLOCK_DATA
 	 && read_write == I2C_SMBUS_WRITE) {
@@ -716,6 +709,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int block = 0;
 	int ret, xact = 0;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
+	int result;
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
@@ -776,11 +770,17 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		return -EOPNOTSUPP;
 	}
 
-	if (hwpec)	/* enable/disable hardware PEC */
+	result = i801_check_pre(priv);
+	if (result < 0)
+		return result;
+
+	if (hwpec) {	/* enable/disable hardware PEC */
 		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
-	else
+	} else {
 		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
 		       SMBAUXCTL(priv));
+		priv->xact_extra &= ~SMBHSTCNT_PEC_EN;
+	}
 
 	if (block)
 		ret = i801_block_transaction(priv, data, read_write, size,
@@ -1381,6 +1381,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	if (priv->features & FEATURE_IRQ) {
+		priv->xact_extra |= SMBHSTCNT_INTREN;
 		init_waitqueue_head(&priv->waitq);
 
 		err = devm_request_irq(&dev->dev, dev->irq, i801_isr,
-- 
2.5.0
