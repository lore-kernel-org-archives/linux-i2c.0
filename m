From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 2/4] i2c: xlp9xx: Handle transactions with I2C_M_RECV_LEN properly
Date: Thu, 18 Jan 2018 05:39:22 +0000
Message-ID: <1516253964-4615-2-git-send-email-george.cherian@cavium.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:53632
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753433AbeARFj6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 00:39:58 -0500
In-Reply-To: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>

In case of transaction with I2C_M_RECV_LEN set, make sure the driver reads
the first byte and then updates the RX fifo with the expected length. Set
threshold to 1 byte so that driver gets an interrupt on receiving the first byte.
After which the transfer length is updated depending on the received length.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 6d78cdc..b5b224e 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -125,7 +125,16 @@ static void xlp9xx_i2c_update_rx_fifo_thres(struct xlp9xx_i2c_dev *priv)
 {
 	u32 thres;
 
-	thres = min(priv->msg_buf_remaining, XLP9XX_I2C_FIFO_SIZE);
+	if (priv->len_recv)
+		/* interrupt after the first read to examine
+		 * the length byte before proceeding further
+		 */
+		thres = 1;
+	else if (priv->msg_buf_remaining > XLP9XX_I2C_FIFO_SIZE)
+		thres = XLP9XX_I2C_FIFO_SIZE;
+	else
+		thres = priv->msg_buf_remaining;
+
 	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MFIFOCTRL,
 			     thres << XLP9XX_I2C_MFIFOCTRL_HITH_SHIFT);
 }
@@ -144,7 +153,7 @@ static void xlp9xx_i2c_fill_tx_fifo(struct xlp9xx_i2c_dev *priv)
 
 static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 {
-	u32 len, i;
+	u32 len, i, val;
 	u8 rlen, *buf = priv->msg_buf;
 
 	len = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_FIFOWCNT) &
@@ -156,19 +165,27 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
 		*buf++ = rlen;
 		len--;
+
 		if (priv->client_pec)
 			++rlen;
 		/* update remaining bytes and message length */
 		priv->msg_buf_remaining = rlen;
 		priv->msg_len = rlen + 1;
 		priv->len_recv = false;
-	}
 
-	len = min(priv->msg_buf_remaining, len);
-	for (i = 0; i < len; i++, buf++)
-		*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+		/* Update transfer length to read only actual data */
+		val = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_CTRL);
+		val = (val & ~XLP9XX_I2C_CTRL_MCTLEN_MASK) |
+			((rlen + 1) << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
+		xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, val);
+	} else {
+		len = min(priv->msg_buf_remaining, len);
+		for (i = 0; i < len; i++, buf++)
+			*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+
+		priv->msg_buf_remaining -= len;
+	}
 
-	priv->msg_buf_remaining -= len;
 	priv->msg_buf = buf;
 
 	if (priv->msg_buf_remaining)
-- 
2.1.4
