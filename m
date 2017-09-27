From: Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH 3/3] i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags
Date: Wed, 27 Sep 2017 20:22:23 +0530
Message-ID: <1506523943-8632-4-git-send-email-kamlakant.patel@cavium.com>
References: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:21856
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbdI0Owg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 27 Sep 2017 10:52:36 -0400
In-Reply-To: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Kamlakant Patel <kamlakant.patel@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jayachandran C <jnair@caviumnetworks.com>

The driver needs to handle the flag I2C_M_RECV_LEN during receive to
support SMBus emulation.

Update receive logic to handle the case where the length is received
as the first byte of a transaction.

Also update the code to handle I2C_CLIENT_PEC, which is set when the
client sends a packet error checking code byte.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index f0bef2d..91c0369 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -82,6 +82,8 @@ struct xlp9xx_i2c_dev {
 	struct completion msg_complete;
 	int irq;
 	bool msg_read;
+	bool len_recv;
+	bool client_pec;
 	u32 __iomem *base;
 	u32 msg_buf_remaining;
 	u32 msg_len;
@@ -143,10 +145,25 @@ static void xlp9xx_i2c_fill_tx_fifo(struct xlp9xx_i2c_dev *priv)
 static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 {
 	u32 len, i;
-	u8 *buf = priv->msg_buf;
+	u8 rlen, *buf = priv->msg_buf;
 
 	len = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_FIFOWCNT) &
 				  XLP9XX_I2C_FIFO_WCNT_MASK;
+	if (!len)
+		return;
+	if (priv->len_recv) {
+		/* read length byte */
+		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+		*buf++ = rlen;
+		len--;
+		if (priv->client_pec)
+			++rlen;
+		/* update remaining bytes and message length */
+		priv->msg_buf_remaining = rlen;
+		priv->msg_len = rlen + 1;
+		priv->len_recv = false;
+	}
+
 	len = min(priv->msg_buf_remaining, len);
 	for (i = 0; i < len; i++, buf++)
 		*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
@@ -230,7 +247,7 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 			       int last_msg)
 {
 	unsigned long timeleft;
-	u32 intr_mask, cmd, val;
+	u32 intr_mask, cmd, val, len;
 
 	priv->msg_buf = msg->buf;
 	priv->msg_buf_remaining = priv->msg_len = msg->len;
@@ -263,9 +280,13 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 	else
 		val &= ~XLP9XX_I2C_CTRL_ADDMODE;
 
+	priv->len_recv = (msg->flags & I2C_M_RECV_LEN);
+	len = priv->len_recv ? XLP9XX_I2C_FIFO_SIZE : msg->len;
+	priv->client_pec = (msg->flags & I2C_CLIENT_PEC);
+
 	/* set data length to be transferred */
 	val = (val & ~XLP9XX_I2C_CTRL_MCTLEN_MASK) |
-	      (msg->len << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
+	      (len << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
 	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, val);
 
 	/* fill fifo during tx */
@@ -312,6 +333,9 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 		return -ETIMEDOUT;
 	}
 
+	/* update msg->len with actual received length */
+	if (msg->flags & I2C_M_RECV_LEN)
+		msg->len = priv->msg_len;
 	return 0;
 }
 
-- 
2.7.4
