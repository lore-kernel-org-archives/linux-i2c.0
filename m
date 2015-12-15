From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH v2 1/2] i2c: xlr: fix extra read/write at end of rx transfer
Date: Tue, 15 Dec 2015 23:15:05 +0000
Message-ID: <1450221306-5289-1-git-send-email-mans@mansr.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:41842 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbbLOXPR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 15 Dec 2015 18:15:17 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

The BYTECNT register holds the transfer size minus one.  Setting it to
the correct value removes the need for a dummy read/write at the end of
each transfer.  As zero-length transfers are not supported, do not
advertise I2C_FUNC_SMBUS_QUICK.

In other words, this patch makes the driver transfer the number of bytes
requested unless this is zero, which is not supported by the hardware
and is thus refused.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changes:
- refuse zero-length transfers and stop advertising I2C_FUNC_SMBUS_QUICK
---
 drivers/i2c/busses/i2c-xlr.c | 50 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 10fb916..2cfaba7 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -89,38 +89,43 @@ static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 	unsigned long timeout, stoptime, checktime;
 	u32 i2c_status;
 	int pos, timedout;
-	u8 offset, byte;
+	u8 offset;
+	u32 xfer;
+
+	if (!len)
+		return -EOPNOTSUPP;
 
 	offset = buf[0];
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG,
 			XLR_I2C_CFG_ADDR | priv->cfg->cfg_extra);
-	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
 
 	timeout = msecs_to_jiffies(XLR_I2C_TIMEOUT);
 	stoptime = jiffies + timeout;
 	timedout = 0;
-	pos = 1;
-retry:
+
 	if (len == 1) {
-		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
-				XLR_I2C_STARTXFR_ND);
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
+		xfer = XLR_I2C_STARTXFR_ND;
+		pos = 1;
 	} else {
-		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
-		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
-				XLR_I2C_STARTXFR_WR);
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 2);
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[1]);
+		xfer = XLR_I2C_STARTXFR_WR;
+		pos = 2;
 	}
 
+retry:
+	/* retry can only happen on the first byte */
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR, xfer);
+
 	while (!timedout) {
 		checktime = jiffies;
 		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
 
-		if (i2c_status & XLR_I2C_SDOEMPTY) {
-			pos++;
-			/* need to do a empty dataout after the last byte */
-			byte = (pos < len) ? buf[pos] : 0;
-			xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, byte);
+		if ((i2c_status & XLR_I2C_SDOEMPTY) && pos < len) {
+			xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos++]);
 
 			/* reset timeout on successful xmit */
 			stoptime = jiffies + timeout;
@@ -149,11 +154,13 @@ static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
 	u32 i2c_status;
 	unsigned long timeout, stoptime, checktime;
 	int nbytes, timedout;
-	u8 byte;
+
+	if (!len)
+		return -EOPNOTSUPP;
 
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG,
 			XLR_I2C_CFG_NOADDR | priv->cfg->cfg_extra);
-	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
 
 	timeout = msecs_to_jiffies(XLR_I2C_TIMEOUT);
@@ -167,14 +174,11 @@ retry:
 		checktime = jiffies;
 		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
 		if (i2c_status & XLR_I2C_RXRDY) {
-			if (nbytes > len)
+			if (nbytes >= len)
 				return -EIO;	/* should not happen */
 
-			/* we need to do a dummy datain when nbytes == len */
-			byte = xlr_i2c_rdreg(priv->iobase, XLR_I2C_DATAIN);
-			if (nbytes < len)
-				buf[nbytes] = byte;
-			nbytes++;
+			buf[nbytes++] =
+				xlr_i2c_rdreg(priv->iobase, XLR_I2C_DATAIN);
 
 			/* reset timeout on successful read */
 			stoptime = jiffies + timeout;
@@ -228,7 +232,7 @@ static int xlr_i2c_xfer(struct i2c_adapter *adap,
 static u32 xlr_func(struct i2c_adapter *adap)
 {
 	/* Emulate SMBUS over I2C */
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
+	return (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) | I2C_FUNC_I2C;
 }
 
 static struct i2c_algorithm xlr_i2c_algo = {
-- 
2.6.3
