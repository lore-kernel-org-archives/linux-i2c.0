From: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] i2c: imx: add retries for i2c-0 on Ventana boards
Date: Thu,  7 Jul 2016 07:03:49 -0700
Message-ID: <1467900229-5262-1-git-send-email-tharvey@gateworks.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36639 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbcGGN6M (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Jul 2016 09:58:12 -0400
Received: by mail-pf0-f180.google.com with SMTP id t190so6457537pfb.3
        for <linux-i2c@vger.kernel.org>; Thu, 07 Jul 2016 06:58:12 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Gateworks Ventana IMX6 based boards have a Gateworks System Controller [1]
(gsc) device that can NAK i2c transactions when its busy in an ADC loop. As
this is always on i2c-0 we will add retries for that bus for any Ventana
board.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/i2c/busses/i2c-imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1844bc9..aec71c3 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -460,6 +460,8 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
 {
 	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
+		if (i2c_imx->adapter.retries)
+			return -EAGAIN;
 		return -ENXIO;  /* No ACK */
 	}
 
@@ -1068,6 +1070,16 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
 	i2c_imx->base			= base;
 
+	/*
+	 * The Gateworks Ventana has an i2c based system controller on i2c-0
+	 * which emulates several standard i2c devices with existing drivers.
+	 * That device can NAK when its in an ADC loop. Add bus retries.
+	 */
+	if (of_machine_is_compatible("gw,ventana") && phy_addr == 0x021a0000) {
+		dev_info(&pdev->dev, "Adding retries for Ventana GSC\n");
+		i2c_imx->adapter.retries = 3;
+	}
+
 	/* Get I2C clock */
 	i2c_imx->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_imx->clk)) {
-- 
1.9.1
