From: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Subject: AW: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Tue, 20 Jun 2017 10:20:42 +0200
Message-ID: <681500CE65202E47A192754B01DAB4671B1674818F@SDE12.beckipc.net>
References: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
 <20170619144601.vhswaa27f5mcxcxs@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx.beck-ipc.com ([195.243.140.130]:60131 "EHLO mx.beck-ipc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdFTIUq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 20 Jun 2017 04:20:46 -0400
In-Reply-To: <20170619144601.vhswaa27f5mcxcxs@ninjato>
Content-Language: de-DE
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>


The i2c-imx driver incorrectly uses readb()/writeb() to read and 
write to the appropriate registers when performing a repeated start. 
The appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions 
should be used instead. Performing a repeated start results in 
a kernel panic. The platform is imx.

Signed-off-by: Michail G Etairidis <m.etairidis@beck-ipc.com>

---

I am resubmitting this patch to add the required Signed-off-by 
information.

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c index 95ed171..54a47b4 100644
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
