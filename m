From: Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] i2c: imx: Defer probing if EDMA not available
Date: Wed, 27 Nov 2019 07:12:09 +0000
Message-ID: <20191127071136.5240-1-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux@rempel-privat.de" <linux@rempel-privat.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc: "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peng Ma <peng.ma@nxp.com>
List-Id: linux-i2c@vger.kernel.org

EDMA may be not available or defered due to dependencies on
other modules, If these scenarios is encountered, we should
defer probing.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 40111a3..c2b0693 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -369,8 +369,8 @@ static void i2c_imx_reset_regs(struct imx_i2c_struct *i=
2c_imx)
 }
=20
 /* Functions for DMA support */
-static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
-						dma_addr_t phy_addr)
+static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
+			       dma_addr_t phy_addr)
 {
 	struct imx_i2c_dma *dma;
 	struct dma_slave_config dma_sconfig;
@@ -379,7 +379,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *=
i2c_imx,
=20
 	dma =3D devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
 	if (!dma)
-		return;
+		return -ENOMEM;
=20
 	dma->chan_tx =3D dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
@@ -424,7 +424,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *=
i2c_imx,
 	dev_info(dev, "using %s (tx) and %s (rx) for DMA transfers\n",
 		dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
=20
-	return;
+	return 0;
=20
 fail_rx:
 	dma_release_channel(dma->chan_rx);
@@ -432,6 +432,8 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *=
i2c_imx,
 	dma_release_channel(dma->chan_tx);
 fail_al:
 	devm_kfree(dev, dma);
+
+	return ret;
 }
=20
 static void i2c_imx_dma_callback(void *arg)
@@ -1605,10 +1607,14 @@ static int i2c_imx_probe(struct platform_device *pd=
ev)
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
=20
 	/* Init DMA config if supported */
-	i2c_imx_dma_request(i2c_imx, phy_addr);
+	ret =3D i2c_imx_dma_request(i2c_imx, phy_addr);
+	if (ret =3D=3D -EPROBE_DEFER)
+		goto i2c_adapter_remove;
=20
 	return 0;   /* Return OK */
=20
+i2c_adapter_remove:
+	i2c_del_adapter(&i2c_imx->adapter);
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
 rpm_disable:
--=20
2.9.5
