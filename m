From: Gao Pan <b54642@freescale.com>
Subject: [Patch V2] i2c: imx: init bus recovery info before adding i2c adapter
Date: Wed, 9 Dec 2015 11:08:22 +0800
Message-ID: <1449630502-14835-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bon0114.outbound.protection.outlook.com ([157.56.111.114]:53460
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751070AbbLIDJT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 8 Dec 2015 22:09:19 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, b54642@freescale.com, kernel@pengutronix.de, r49496@freescale.com

During driver probe, i2c_imx_init_recovery_info() must come before
i2c_add_numbered_adapter(), because the get/set_scl() functions
are assigned in i2c_register_adapter() under the conditon that bus
recover_info are initialized. Otherwise, get/set_scl() function
pointers never get assigned.

In such case, when i2c_generic_gpio_recovery() is used for bus recovery,
there will be kernel crash because bri->set_scl is NULL.

The solution to this bug is moving i2c_imx_init_recovery_info() before
i2c_register_adapter().

Signed-off-by: Gao Pan <b54642@freescale.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
V2:
 -base on the latest commit id(856ed208dd69d03c00670db5c235d253af443440)

 drivers/i2c/busses/i2c-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 9bb0b05..d4d8536 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1119,6 +1119,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 			i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
 
+	i2c_imx_init_recovery_info(i2c_imx, pdev);
+
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0) {
@@ -1126,8 +1128,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	i2c_imx_init_recovery_info(i2c_imx, pdev);
-
 	/* Set up platform driver data */
 	platform_set_drvdata(pdev, i2c_imx);
 	clk_disable_unprepare(i2c_imx->clk);
-- 
1.9.1
