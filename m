From: Gao Pan <b54642@freescale.com>
Subject: [Patch V1] i2c: imx: improve code readability
Date: Mon, 2 Nov 2015 17:05:30 +0800
Message-ID: <1446455130-4704-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0135.outbound.protection.outlook.com ([65.55.169.135]:43184
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751368AbbKBJig (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 04:38:36 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, b54642@freescale.com

Replace of_get_named_gpio_flags with of_get_named_gpio because
the latter has less parameters, which improves code readability.

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Gao Pan <b54642@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1e4d99d..b0fe090 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -996,10 +996,8 @@ static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 			PINCTRL_STATE_DEFAULT);
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
 			"gpio");
-	rinfo->sda_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
-			"sda-gpios", 0, NULL);
-	rinfo->scl_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
-			"scl-gpios", 0, NULL);
+	rinfo->sda_gpio = of_get_named_gpio(pdev->dev.of_node, "sda-gpios", 0);
+	rinfo->scl_gpio = of_get_named_gpio(pdev->dev.of_node, "scl-gpios", 0);
 
 	if (!gpio_is_valid(rinfo->sda_gpio) ||
 	    !gpio_is_valid(rinfo->scl_gpio) ||
-- 
1.9.1
