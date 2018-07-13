From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH/RFT 5/6] i2c: imx: set SDA as output for recovery
Date: Fri, 13 Jul 2018 23:09:17 +0200
Message-ID: <20180713210920.3648-6-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This allows for sending STOP when generating pulses which is much more
robust because it will bring clients into a default state.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 3e23ee26c55c..a3881e270106 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1009,7 +1009,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 			PINCTRL_STATE_DEFAULT);
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
 			"gpio");
-	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
+	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_OUT_HIGH_OPEN_DRAIN);
 	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
 
 	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
-- 
2.11.0
