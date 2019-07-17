From: Anson.Huang@nxp.com
Subject: [PATCH 2/2] i2c: imx-lpi2c: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 17 Jul 2019 16:40:17 +0800
Message-ID: <20190717084017.30987-2-Anson.Huang@nxp.com>
References: <20190717084017.30987-1-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717084017.30987-1-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-i2c@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index dc00fab..c92b564 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -545,7 +545,6 @@ MODULE_DEVICE_TABLE(of, lpi2c_imx_of_match);
 static int lpi2c_imx_probe(struct platform_device *pdev)
 {
 	struct lpi2c_imx_struct *lpi2c_imx;
-	struct resource *res;
 	unsigned int temp;
 	int irq, ret;
 
@@ -553,8 +552,7 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	if (!lpi2c_imx)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	lpi2c_imx->base = devm_ioremap_resource(&pdev->dev, res);
+	lpi2c_imx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpi2c_imx->base))
 		return PTR_ERR(lpi2c_imx->base);
 
-- 
2.7.4
