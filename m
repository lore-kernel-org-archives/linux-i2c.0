From: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Subject: [PATCH] Remove extra spaces.
Date: Mon, 25 Jan 2016 15:48:32 +0300
Message-ID: <1453726112-7049-1-git-send-email-dbaranov@dev.rtsoft.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:44439 "EHLO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbcAYNVr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jan 2016 08:21:47 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitriy Baranov <dbaranov@dev.rtsoft.ru>

Signed-off-by: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
---
 drivers/i2c/busses/i2c-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a2b132c..1ca7ef2 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -212,7 +212,7 @@ struct imx_i2c_struct {
 	struct imx_i2c_dma	*dma;
 };
 
-static const struct imx_i2c_hwdata imx1_i2c_hwdata  = {
+static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
 	.devtype		= IMX1_I2C,
 	.regshift		= IMX_I2C_REGSHIFT,
 	.clk_div		= imx_i2c_clk_div,
@@ -222,7 +222,7 @@ static const struct imx_i2c_hwdata imx1_i2c_hwdata  = {
 
 };
 
-static const struct imx_i2c_hwdata imx21_i2c_hwdata  = {
+static const struct imx_i2c_hwdata imx21_i2c_hwdata = {
 	.devtype		= IMX21_I2C,
 	.regshift		= IMX_I2C_REGSHIFT,
 	.clk_div		= imx_i2c_clk_div,
@@ -871,7 +871,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 		if ((!i) && block_data)
 			msgs->buf[0] = len;
 		else
-			msgs->buf[i] =  imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+			msgs->buf[i] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
 		dev_dbg(&i2c_imx->adapter.dev,
 			"<%s> read byte: B%d=0x%X\n",
 			__func__, i, msgs->buf[i]);
@@ -916,7 +916,7 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 			temp |= I2CR_RSTA;
 			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-			result =  i2c_imx_bus_busy(i2c_imx, 1);
+			result = i2c_imx_bus_busy(i2c_imx, 1);
 			if (result)
 				goto fail0;
 		}
@@ -1192,7 +1192,7 @@ static int i2c_imx_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int i2c_imx_runtime_suspend(struct device *dev)
 {
-	struct imx_i2c_struct *i2c_imx  = dev_get_drvdata(dev);
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(i2c_imx->clk);
 
@@ -1201,7 +1201,7 @@ static int i2c_imx_runtime_suspend(struct device *dev)
 
 static int i2c_imx_runtime_resume(struct device *dev)
 {
-	struct imx_i2c_struct *i2c_imx  = dev_get_drvdata(dev);
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_prepare_enable(i2c_imx->clk);
-- 
2.5.0
