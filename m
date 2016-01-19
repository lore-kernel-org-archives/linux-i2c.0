From: minyard@acm.org
Subject: [PATCH 4/5] i2c-i801: clean up block transaction
Date: Tue, 19 Jan 2016 11:09:36 -0600
Message-ID: <1453223377-20608-5-git-send-email-minyard@acm.org>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:53555 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558AbcASSKN (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:10:13 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173019.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O1700JBHMC44Z80@vms173019.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:09:45 -0600 (CST)
In-reply-to: <1453223377-20608-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The block transaction code looked a little messy, pull out the
code to copy to/from the buffer into separate functions to make
it a little neater.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 54 +++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 7567a96..840656c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -425,37 +425,51 @@ static int i801_transaction(struct i801_priv *priv, int xact)
 	return i801_check_post(priv, status);
 }
 
+static void i801_write_block(struct i801_priv *priv, union i2c_smbus_data *data)
+{
+	int i, len;
+
+	len = data->block[0];
+	outb_p(len, SMBHSTDAT0(priv));
+	for (i = 0; i < len; i++)
+		outb_p(data->block[i+1], SMBBLKDAT(priv));
+}
+
+static int i801_read_block(struct i801_priv *priv, union i2c_smbus_data *data)
+{
+	int i, len;
+
+	len = inb_p(SMBHSTDAT0(priv));
+	if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
+		return -EPROTO;
+
+	data->block[0] = len;
+	for (i = 0; i < len; i++)
+		data->block[i + 1] = inb_p(SMBBLKDAT(priv));
+
+	return 0;
+}
+
 static int i801_block_transaction_by_block(struct i801_priv *priv,
 					   union i2c_smbus_data *data,
 					   char read_write)
 {
-	int i, len;
-	int status;
+	int result;
 
 	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
 
 	/* Use 32-byte buffer to process this transaction */
-	if (read_write == I2C_SMBUS_WRITE) {
-		len = data->block[0];
-		outb_p(len, SMBHSTDAT0(priv));
-		for (i = 0; i < len; i++)
-			outb_p(data->block[i+1], SMBBLKDAT(priv));
-	}
+	if (read_write == I2C_SMBUS_WRITE)
+		i801_write_block(priv, data);
 
-	status = i801_transaction(priv, I801_BLOCK_DATA);
-	if (status)
-		return status;
+	result = i801_transaction(priv, I801_BLOCK_DATA);
+	if (result)
+		return result;
 
-	if (read_write == I2C_SMBUS_READ) {
-		len = inb_p(SMBHSTDAT0(priv));
-		if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
-			return -EPROTO;
+	if (read_write == I2C_SMBUS_READ)
+		result = i801_read_block(priv, data);
 
-		data->block[0] = len;
-		for (i = 0; i < len; i++)
-			data->block[i + 1] = inb_p(SMBBLKDAT(priv));
-	}
-	return 0;
+	return result;
 }
 
 static void i801_isr_byte_done(struct i801_priv *priv)
-- 
2.5.0
