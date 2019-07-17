From: Anson.Huang@nxp.com
Subject: [PATCH 1/2] i2c: mxs: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 17 Jul 2019 16:40:16 +0800
Message-ID: <20190717084017.30987-1-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
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
 drivers/i2c/busses/i2c-mxs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 7d79317..8922491 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -802,7 +802,6 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
-	struct resource *res;
 	int err, irq;
 
 	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
@@ -814,8 +813,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 		i2c->dev_type = device_id->driver_data;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	i2c->regs = devm_ioremap_resource(&pdev->dev, res);
+	i2c->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(i2c->regs))
 		return PTR_ERR(i2c->regs);
 
-- 
2.7.4
