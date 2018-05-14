From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 10/21] i2c: hix5hd2: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:19 +0200
Message-ID: <20180514145330.4857-11-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index bb68957d3da5..399b64c4c620 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -73,7 +73,6 @@
 #define I2C_OVER_INTR		BIT(0)
 
 #define HIX5I2C_MAX_FREQ	400000		/* 400k */
-#define HIX5I2C_READ_OPERATION	0x01
 
 enum hix5hd2_i2c_state {
 	HIX5I2C_STAT_RW_ERR = -1,
@@ -311,12 +310,8 @@ static void hix5hd2_i2c_message_start(struct hix5hd2_i2c_priv *priv, int stop)
 	hix5hd2_i2c_clr_all_irq(priv);
 	hix5hd2_i2c_enable_irq(priv);
 
-	if (priv->msg->flags & I2C_M_RD)
-		writel_relaxed((priv->msg->addr << 1) | HIX5I2C_READ_OPERATION,
-			       priv->regs + HIX5I2C_TXR);
-	else
-		writel_relaxed(priv->msg->addr << 1,
-			       priv->regs + HIX5I2C_TXR);
+	writel_relaxed(i2c_8bit_addr_from_msg(priv->msg),
+		       priv->regs + HIX5I2C_TXR);
 
 	writel_relaxed(I2C_WRITE | I2C_START, priv->regs + HIX5I2C_COM);
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
2.11.0
