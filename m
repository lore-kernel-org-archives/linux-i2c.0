From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
Date: Mon,  9 Jul 2018 11:43:03 +0200
Message-ID: <20180709094304.8814-4-esben.haabendal@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709094304.8814-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Esben Haabendal <eha@deif.com>, Philipp Zabel <p.zabel@pengutronix.de>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Always update the stopped state when busy status have been checked.
This is identical to what was done before, with the exception of error
handling.
Without this change, some errors cause the stopped state to be left in
incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
i2c_imx_xfer().

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/i2c/busses/i2c-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d86f152176a4..1db8e6790afc 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 			return -EAGAIN;
 		}
 
-		if (for_busy && (temp & I2SR_IBB))
+		if (for_busy && (temp & I2SR_IBB)) {
+			i2c_imx->stopped = 0;
 			break;
-		if (!for_busy && !(temp & I2SR_IBB))
+		}
+		if (!for_busy && !(temp & I2SR_IBB)) {
+			i2c_imx->stopped = 1;
 			break;
+		}
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
@@ -538,7 +542,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	result = i2c_imx_bus_busy(i2c_imx, 1);
 	if (result)
 		return result;
-	i2c_imx->stopped = 0;
 
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	temp &= ~I2CR_DMAEN;
@@ -569,7 +572,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 
 	if (!i2c_imx->stopped) {
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	}
 
 	/* Disable I2C controller */
@@ -724,7 +726,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		temp &= ~(I2CR_MSTA | I2CR_MTX);
 		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	} else {
 		/*
 		 * For i2c master receiver repeat restart operation like:
@@ -852,7 +853,6 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 				temp &= ~(I2CR_MSTA | I2CR_MTX);
 				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 				i2c_imx_bus_busy(i2c_imx, 0);
-				i2c_imx->stopped = 1;
 			} else {
 				/*
 				 * For i2c master receiver repeat restart operation like:
-- 
2.18.0
