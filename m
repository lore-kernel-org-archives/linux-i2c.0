From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/4] i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
Date: Thu,  6 Dec 2018 12:55:26 +0900
Message-ID: <1544068528-27657-3-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

 - For a repeated START condition, this controller starts data transfer
   immediately after the slave address is written to the TX-FIFO.

 - Once the TX-FIFO empty interrupt is asserted, the controller makes
   a pause even if additional data are written to the TX-FIFO.

Given those circumstances, the data after a repeated START may not be
transferred if the interrupt is asserted while the TX-FIFO is being
filled up. A more reliable way is to append TX data only in the
interrupt handler.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index fad2b00..d8a5db14 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -269,7 +269,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr)
+static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr,
+				  bool repeat)
 {
 	priv->enabled_irqs |= UNIPHIER_FI2C_INT_TE;
 	uniphier_fi2c_set_irqs(priv);
@@ -279,8 +280,12 @@ static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr)
 	/* set slave address */
 	writel(UNIPHIER_FI2C_DTTX_CMD | addr << 1,
 	       priv->membase + UNIPHIER_FI2C_DTTX);
-	/* first chunk of data */
-	uniphier_fi2c_fill_txfifo(priv, true);
+	/*
+	 * First chunk of data. For a repeated START condition, do not write
+	 * data to the TX fifo here to avoid the timing issue.
+	 */
+	if (!repeat)
+		uniphier_fi2c_fill_txfifo(priv, true);
 }
 
 static void uniphier_fi2c_rx_init(struct uniphier_fi2c_priv *priv, u16 addr)
@@ -361,7 +366,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	if (is_read)
 		uniphier_fi2c_rx_init(priv, msg->addr);
 	else
-		uniphier_fi2c_tx_init(priv, msg->addr);
+		uniphier_fi2c_tx_init(priv, msg->addr, repeat);
 
 	dev_dbg(&adap->dev, "start condition\n");
 	/*
-- 
2.7.4
