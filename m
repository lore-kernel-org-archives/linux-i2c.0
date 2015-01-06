From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/3] i2c: imx: silence dma_request_slave_channel errors if dma not set up in device tree
Date: Tue,  6 Jan 2015 15:48:19 +0100
Message-ID: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If the i2c device tree nodes don't contain the dmas and dma-names property, an
error is displayed for each i2c device:

    of_dma_request_slave_channel: dma-names property of node '/soc/aips-bus@02100000/i2c@021a0000' missing or empty

This patch avoids calling dma_request_slave_channel if the dma-names property
does not exist in the device tree in the first place.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 7f3a9fe..f0d9904 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -288,6 +288,9 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	struct device *dev = &i2c_imx->adapter.dev;
 	int ret;
 
+	if (!of_get_property(dev->of_node, "dma-names", NULL))
+		return;
+
 	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
 	if (!dma)
 		return;
-- 
2.1.4
