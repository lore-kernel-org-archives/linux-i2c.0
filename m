From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] i2c: imx: defer probe if bus recovery GPIOs are not ready
Date: Mon, 26 Sep 2016 17:18:58 -0700
Message-ID: <20160927001858.11601-1-stefan@agner.ch>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:39617 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755769AbcI0ATL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Sep 2016 20:19:11 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: leoyang.li@nxp.com, linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>

Some SoC might load the GPIO driver after the I2C driver and
using the I2C bus recovery mechanism via GPIOs. In this case
it is crucial to defer probing if the GPIO request functions
do so, otherwise the I2C driver gets loaded without recovery
mechanisms enabled.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This is an actual issue on NXP Vybrid devices on which the GPIO
driver gets loaded rather later.

--
Stefan

 drivers/i2c/busses/i2c-imx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 592a8f2..47fc1f1 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1009,10 +1009,13 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 	rinfo->sda_gpio = of_get_named_gpio(pdev->dev.of_node, "sda-gpios", 0);
 	rinfo->scl_gpio = of_get_named_gpio(pdev->dev.of_node, "scl-gpios", 0);
 
-	if (!gpio_is_valid(rinfo->sda_gpio) ||
-	    !gpio_is_valid(rinfo->scl_gpio) ||
-	    IS_ERR(i2c_imx->pinctrl_pins_default) ||
-	    IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
+	if (rinfo->sda_gpio == -EPROBE_DEFER ||
+	    rinfo->scl_gpio == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!gpio_is_valid(rinfo->sda_gpio) ||
+		   !gpio_is_valid(rinfo->scl_gpio) ||
+		   IS_ERR(i2c_imx->pinctrl_pins_default) ||
+		   IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
 		dev_dbg(&pdev->dev, "recovery information incomplete\n");
 		return 0;
 	}
-- 
2.10.0
