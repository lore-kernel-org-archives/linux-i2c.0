From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/3] i2c: xlr: fix extra read/write at end of rx transfer
Date: Mon,  2 Nov 2015 02:03:37 +0000
Message-ID: <1446429818-24155-2-git-send-email-mans@mansr.com>
References: <1446429818-24155-1-git-send-email-mans@mansr.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:39746 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbbKBCD5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 1 Nov 2015 21:03:57 -0500
In-Reply-To: <1446429818-24155-1-git-send-email-mans@mansr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

The BYTECNT register holds the transfer size minus one.  Setting it
to the correct value requires a dummy read/write only for zero-length
transfers as it is impossible to request one from the hardware.  If a
zero-length transfer is requested, changing the length to 1 and setting
"buf" to a dummy location allows making the main loops less convoluted.

In other words, this patch makes the driver transfer the number of bytes
requested unless this is zero, which is not supported by the hardware,
in which case one byte is transferred instead.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/i2c/busses/i2c-xlr.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 10fb916..c1afc3e 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -90,37 +90,45 @@ static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 	u32 i2c_status;
 	int pos, timedout;
 	u8 offset, byte;
+	u32 xfer;
+
+	if (!len) {
+		byte = 0;
+		buf = &byte;
+		len = 1;
+	}
 
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
@@ -151,9 +159,15 @@ static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
 	int nbytes, timedout;
 	u8 byte;
 
+	if (!len) {
+		byte = 0;
+		buf = &byte;
+		len = 1;
+	}
+
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG,
 			XLR_I2C_CFG_NOADDR | priv->cfg->cfg_extra);
-	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
 
 	timeout = msecs_to_jiffies(XLR_I2C_TIMEOUT);
@@ -167,14 +181,11 @@ retry:
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
-- 
2.6.2
