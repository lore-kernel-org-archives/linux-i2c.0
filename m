From: Gao Pan <pandy.gao@nxp.com>
Subject: [Patch V1] i2c: fsl-lpi2c: read lpi2c fifo size in probe()
Date: Fri, 2 Dec 2016 11:38:16 +0800
Message-ID: <1480649896-5222-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:45136
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752102AbcLBDjr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Dec 2016 22:39:47 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, wsa-dev@sang-engineering.com, cmo@melexis.com, robh@kernel.org, vz@mleia.com
Cc: linux-i2c@vger.kernel.org, pandy.gao@nxp.com, frank.li@nxp.com, fugang.duan@nxp.com

The lpi2c fifo size is a read only parameter resides Parameter
Register. It's better to read lpi2c tx/rx fifo size in probe()
other than just define a macro for it.

Signed-off-by: Gao Pan <pandy.gao@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 9794ff6..c62b7cd 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -83,9 +83,6 @@
 #define I2C_CLK_RATIO	2
 #define CHUNK_DATA	256
 
-#define LPI2C_RX_FIFOSIZE	4
-#define LPI2C_TX_FIFOSIZE	4
-
 #define LPI2C_DEFAULT_RATE	100000
 #define STARDARD_MAX_BITRATE	400000
 #define FAST_MAX_BITRATE	1000000
@@ -118,6 +115,8 @@ struct lpi2c_imx_struct {
 	unsigned int		delivered;
 	unsigned int		block_data;
 	unsigned int		bitrate;
+	unsigned int		txfifosize;
+	unsigned int		rxfifosize;
 	enum lpi2c_imx_mode	mode;
 };
 
@@ -346,7 +345,7 @@ static int lpi2c_imx_txfifo_empty(struct lpi2c_imx_struct *lpi2c_imx)
 
 static void lpi2c_imx_set_tx_watermark(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	writel(LPI2C_TX_FIFOSIZE >> 1, lpi2c_imx->base + LPI2C_MFCR);
+	writel(lpi2c_imx->txfifosize >> 1, lpi2c_imx->base + LPI2C_MFCR);
 }
 
 static void lpi2c_imx_set_rx_watermark(struct lpi2c_imx_struct *lpi2c_imx)
@@ -355,8 +354,8 @@ static void lpi2c_imx_set_rx_watermark(struct lpi2c_imx_struct *lpi2c_imx)
 
 	remaining = lpi2c_imx->msglen - lpi2c_imx->delivered;
 
-	if (remaining > (LPI2C_RX_FIFOSIZE >> 1))
-		temp = LPI2C_RX_FIFOSIZE >> 1;
+	if (remaining > (lpi2c_imx->rxfifosize >> 1))
+		temp = lpi2c_imx->rxfifosize >> 1;
 	else
 		temp = 0;
 
@@ -369,7 +368,7 @@ static void lpi2c_imx_write_txfifo(struct lpi2c_imx_struct *lpi2c_imx)
 
 	txcnt = readl(lpi2c_imx->base + LPI2C_MFSR) & 0xff;
 
-	while (txcnt < LPI2C_TX_FIFOSIZE) {
+	while (txcnt < lpi2c_imx->txfifosize) {
 		if (lpi2c_imx->delivered == lpi2c_imx->msglen)
 			break;
 
@@ -554,6 +553,7 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 {
 	struct lpi2c_imx_struct *lpi2c_imx;
 	struct resource *res;
+	unsigned int temp;
 	int irq, ret;
 
 	lpi2c_imx = devm_kzalloc(&pdev->dev, sizeof(*lpi2c_imx), GFP_KERNEL);
@@ -599,12 +599,18 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&lpi2c_imx->adapter, lpi2c_imx);
 	platform_set_drvdata(pdev, lpi2c_imx);
 
-	ret = clk_prepare(lpi2c_imx->clk);
+	ret = clk_prepare_enable(lpi2c_imx->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "clk prepare failed %d\n", ret);
+		dev_err(&pdev->dev, "clk enable failed %d\n", ret);
 		return ret;
 	}
 
+	temp = readl(lpi2c_imx->base + LPI2C_PARAM);
+	lpi2c_imx->txfifosize = 1 << (temp & 0x0f);
+	lpi2c_imx->rxfifosize = 1 << ((temp >> 8) & 0x0f);
+
+	clk_disable(lpi2c_imx->clk);
+
 	ret = i2c_add_adapter(&lpi2c_imx->adapter);
 	if (ret)
 		goto clk_unprepare;
-- 
1.9.1
