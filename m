From: minyard@acm.org
Subject: [PATCH v2 06/10] i2c-i801: Pass around a boolean read/write variable
Date: Sun, 29 May 2016 20:09:00 -0500
Message-ID: <1464570544-975-7-git-send-email-minyard@acm.org>
References: <1464570544-975-1-git-send-email-minyard@acm.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464570544-975-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, minyard@acm.org
Cc: Corey Minyard <cminyard@mvista.com>
List-Id: linux-i2c@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

The code was passing around read_write, which required comparison
with a constant, but was effectively a bool.  Pass around an
is_read bool instead.  This also makes it consistent with the
priv->is_read used for interrupt handling.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 51 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 56db310..ae1e60a 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -432,7 +432,7 @@ static int i801_transaction(struct i801_priv *priv, int xact)
 
 static int i801_block_transaction_by_block(struct i801_priv *priv,
 					   union i2c_smbus_data *data,
-					   char read_write, int hwpec)
+					   bool is_read, int hwpec)
 {
 	int i, len;
 	int status;
@@ -440,7 +440,7 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
 
 	/* Use 32-byte buffer to process this transaction */
-	if (read_write == I2C_SMBUS_WRITE) {
+	if (!is_read) {
 		len = data->block[0];
 		outb_p(len, SMBHSTDAT0(priv));
 		for (i = 0; i < len; i++)
@@ -452,7 +452,7 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 	if (status < 0 || status & STATUS_ERROR_FLAGS)
 		return status;
 
-	if (read_write == I2C_SMBUS_READ) {
+	if (is_read) {
 		len = priv->len = inb_p(SMBHSTDAT0(priv));
 		if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
 			return -EPROTO;
@@ -555,7 +555,7 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
  */
 static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 					       union i2c_smbus_data *data,
-					       char read_write, int command)
+					       bool is_read, int command)
 {
 	int i, len;
 	int smbcmd;
@@ -565,20 +565,19 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 
 	len = data->block[0];
 
-	if (read_write == I2C_SMBUS_WRITE) {
+	if (!is_read) {
 		outb_p(len, SMBHSTDAT0(priv));
 		outb_p(data->block[1], SMBBLKDAT(priv));
 	}
 
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA &&
-	    read_write == I2C_SMBUS_READ)
+	if (command == I2C_SMBUS_I2C_BLOCK_DATA && is_read)
 		smbcmd = I801_I2C_BLOCK_DATA;
 	else
 		smbcmd = I801_BLOCK_DATA;
 
 	if (priv->features & FEATURE_IRQ) {
-		priv->is_read = (read_write == I2C_SMBUS_READ);
-		if (len == 1 && priv->is_read)
+		priv->is_read = is_read;
+		if (len == 1 && is_read)
 			smbcmd |= SMBHSTCNT_LAST_BYTE;
 		priv->cmd = smbcmd | SMBHSTCNT_INTREN;
 		priv->len = len;
@@ -599,7 +598,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 	}
 
 	for (i = 1; i <= len; i++) {
-		if (i == len && read_write == I2C_SMBUS_READ)
+		if (i == len && is_read)
 			smbcmd |= SMBHSTCNT_LAST_BYTE;
 		outb_p(smbcmd, SMBHSTCNT(priv));
 
@@ -611,7 +610,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		if (status)
 			return status;
 
-		if (i == 1 && read_write == I2C_SMBUS_READ
+		if (i == 1 && is_read
 		 && command != I2C_SMBUS_I2C_BLOCK_DATA) {
 			priv->len = inb_p(SMBHSTDAT0(priv));
 			if (priv->len < 1 || priv->len > I2C_SMBUS_BLOCK_MAX)
@@ -620,9 +619,9 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		}
 
 		/* Retrieve/store value in SMBBLKDAT */
-		if (read_write == I2C_SMBUS_READ)
+		if (is_read)
 			data->block[i] = inb_p(SMBBLKDAT(priv));
-		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
+		else if (i+1 <= len)
 			outb_p(data->block[i+1], SMBBLKDAT(priv));
 
 		/* signals SMBBLKDAT ready */
@@ -642,7 +641,7 @@ static int i801_set_block_buffer_mode(struct i801_priv *priv)
 
 /* Block transaction function */
 static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
-				  union i2c_smbus_data *data, char read_write,
+				  union i2c_smbus_data *data, bool is_read,
 				  int command)
 {
 	int result = 0;
@@ -658,8 +657,7 @@ static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
 		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
 		       SMBAUXCTL(priv));
 
-	if (read_write == I2C_SMBUS_WRITE
-	 || command == I2C_SMBUS_I2C_BLOCK_DATA) {
+	if (!is_read || command == I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (data->block[0] < 1)
 			data->block[0] = 1;
 		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
@@ -674,12 +672,11 @@ static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
 	if ((priv->features & FEATURE_BLOCK_BUFFER)
 	 && command != I2C_SMBUS_I2C_BLOCK_DATA
 	 && i801_set_block_buffer_mode(priv) == 0)
-		result = i801_block_transaction_by_block(priv, data,
-							 read_write, hwpec);
+		result = i801_block_transaction_by_block(priv, data, is_read,
+							 hwpec);
 	else
 		result = i801_block_transaction_byte_by_byte(priv, data,
-							     read_write,
-							     command);
+							     is_read, command);
 
 	/*
 	 * Some BIOSes don't like it when PEC is enabled at reboot or
@@ -702,6 +699,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int block = 0;
 	int ret = 0, xact = 0;
 	int hostc = -1;
+	bool is_read = (read_write == I2C_SMBUS_READ);
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 
 	pm_runtime_get_sync(&priv->pci_dev->dev);
@@ -715,7 +713,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	case I2C_SMBUS_BYTE:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
-		if (read_write == I2C_SMBUS_WRITE)
+		if (!is_read)
 			outb_p(command, SMBHSTCMD(priv));
 		xact = I801_BYTE;
 		break;
@@ -723,7 +721,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
-		if (read_write == I2C_SMBUS_WRITE)
+		if (!is_read)
 			outb_p(data->byte, SMBHSTDAT0(priv));
 		xact = I801_BYTE_DATA;
 		break;
@@ -731,7 +729,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
-		if (read_write == I2C_SMBUS_WRITE) {
+		if (!is_read) {
 			outb_p(data->word & 0xff, SMBHSTDAT0(priv));
 			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1(priv));
 		}
@@ -747,7 +745,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		/* NB: page 240 of ICH5 datasheet shows that the R/#W
 		 * bit should be cleared here, even when reading */
 		outb_p((addr & 0x7f) << 1, SMBHSTADD(priv));
-		if (read_write == I2C_SMBUS_WRITE) {
+		if (!is_read) {
 			unsigned char thostc;
 
 			outb_p(command, SMBHSTCMD(priv));
@@ -779,8 +777,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		goto out;
 
 	if (block)
-		ret = i801_block_transaction(priv, flags, data, read_write,
-					     size);
+		ret = i801_block_transaction(priv, flags, data, is_read, size);
 	else
 		ret = i801_transaction(priv, xact);
 
@@ -797,7 +794,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		goto out;
 	if (ret)
 		goto out;
-	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
+	if (!is_read || (xact == I801_QUICK))
 		goto out;
 
 	switch (xact & 0x7f) {
-- 
2.7.4
