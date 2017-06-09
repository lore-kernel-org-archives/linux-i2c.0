From: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Subject: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Fri, 9 Jun 2017 15:28:12 +0200
Message-ID: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx.beck-ipc.com ([195.243.140.130]:39223 "EHLO mx.beck-ipc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdFIN2T (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 9 Jun 2017 09:28:19 -0400
Content-Language: de-DE
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>

The i2c-imx driver incorrectly uses readb()/writeb() to read and write to the appropriate registers when performing a repeated start. The appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions should be used instead. Performing a repeated start results in a kernel panic.

I am resubmitting this patch as the previous one was erroneous. This patch is based on the current upstream kernel code.

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 95ed171..54a47b4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -734,9 +734,9 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		 * the first read operation, otherwise the first read cost
 		 * one extra clock cycle.
 		 */
-		temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 		temp |= I2CR_MTX;
-		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	}
 	msgs->buf[msgs->len-1] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
 
@@ -857,9 +857,9 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 				 * the first read operation, otherwise the first read cost
 				 * one extra clock cycle.
 				 */
-				temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 				temp |= I2CR_MTX;
-				writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 			}
 		} else if (i == (msgs->len - 2)) {
 			dev_dbg(&i2c_imx->adapter.dev,
