From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 09/21] i2c: emev2: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:18 +0200
Message-ID: <20180514145330.4857-10-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-emev2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index d2e84480fbe9..ba9b6ea48a31 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -149,7 +149,7 @@ static int __em_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 	em_clear_set_bit(priv, 0, I2C_BIT_STT0, I2C_OFS_IICC0);
 
 	/* Send slave address and R/W type */
-	writeb((msg->addr << 1) | read, priv->base + I2C_OFS_IIC0);
+	writeb(i2c_8bit_addr_from_msg(msg), priv->base + I2C_OFS_IIC0);
 
 	/* Wait for transaction */
 	status = em_i2c_wait_for_event(priv);
-- 
2.11.0
