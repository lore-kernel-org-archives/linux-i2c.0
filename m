From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH/RFT 2/6] i2c: imx: use open drain for recovery GPIO
Date: Fri, 13 Jul 2018 23:09:14 +0200
Message-ID: <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I2C is open drain, so set up the GPIO accordingly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 0207e194f84b..3e23ee26c55c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1010,7 +1010,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
 			"gpio");
 	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
-	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH);
+	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
 
 	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
 	    PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER) {
-- 
2.11.0
