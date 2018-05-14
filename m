From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 12/21] i2c: imx: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:21 +0200
Message-ID: <20180514145330.4857-13-peda@axentia.se>
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
i2c_imx_dma_write and i2c_imx_write are always called with a
write in msgs->flags, and i2c_imx_read with a read.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d7267dd9c7bf..bcb41fc75043 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -630,7 +630,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 * Write slave address.
 	 * The first byte must be transmitted by the CPU.
 	 */
-	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
@@ -760,10 +760,10 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 	int i, result;
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
-		__func__, msgs->addr << 1);
+		__func__, i2c_8bit_addr_from_msg(msgs));
 
 	/* write slave address */
-	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	result = i2c_imx_trx_complete(i2c_imx);
 	if (result)
 		return result;
@@ -796,10 +796,10 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
-		__func__, (msgs->addr << 1) | 0x01);
+		__func__, i2c_8bit_addr_from_msg(msgs));
 
 	/* write slave address */
-	imx_i2c_write_reg((msgs->addr << 1) | 0x01, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	result = i2c_imx_trx_complete(i2c_imx);
 	if (result)
 		return result;
-- 
2.11.0
