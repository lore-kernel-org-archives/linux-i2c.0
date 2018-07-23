From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH] i2c: xlp9xx: Fix case where SSIF read transaction completes early
Date: Sun, 22 Jul 2018 22:18:39 -0700
Message-ID: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jglauber@cavium.com, george.cherian@cavium.com, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

During ipmi stress tests we see occasional failure of transactions
at the boot time. This happens in the case of a I2C_M_RECV_LEN
transactions, when the read transfer completes (with the initial
read length of 34) before the driver gets a chance to handle interrupts.

The current driver code expects at least 2 interrupts for I2C_M_RECV_LEN
transactions. The length is updated during the first interrupt, and  the
buffer contents are only copied during subsequent interrupts. In case of
just one interrupt, we will complete the transaction without copying
out the bytes from RX fifo.

Update the code to drain the RX fifo after the length update,
so that the transaction completes correctly in all cases.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 1f41a4f..01fa04d 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -191,28 +191,30 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 	if (priv->len_recv) {
 		/* read length byte */
 		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+		len--;
 		if (rlen > I2C_SMBUS_BLOCK_MAX || rlen == 0) {
 			rlen = 0;	/*abort transfer */
 			priv->msg_buf_remaining = 0;
 			priv->msg_len = 0;
-		} else {
-			*buf++ = rlen;
-			if (priv->client_pec)
-				++rlen; /* account for error check byte */
-			/* update remaining bytes and message length */
-			priv->msg_buf_remaining = rlen;
-			priv->msg_len = rlen + 1;
+			xlp9xx_i2c_update_rlen(priv);
+			return;
 		}
+
+		*buf++ = rlen;
+		if (priv->client_pec)
+			++rlen; /* account for error check byte */
+		/* update remaining bytes and message length */
+		priv->msg_buf_remaining = rlen;
+		priv->msg_len = rlen + 1;
 		xlp9xx_i2c_update_rlen(priv);
 		priv->len_recv = false;
-	} else {
-		len = min(priv->msg_buf_remaining, len);
-		for (i = 0; i < len; i++, buf++)
-			*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
-
-		priv->msg_buf_remaining -= len;
 	}
 
+	len = min(priv->msg_buf_remaining, len);
+	for (i = 0; i < len; i++, buf++)
+		*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+
+	priv->msg_buf_remaining -= len;
 	priv->msg_buf = buf;
 
 	if (priv->msg_buf_remaining)
-- 
1.8.3.1
