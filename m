From: Gao Pan <b54642@freescale.com>
Subject: [Patch V1] i2c: imx: init bus recovery info before adding i2c adapter
Date: Fri, 4 Dec 2015 17:33:14 +0800
Message-ID: <1449221594-29603-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:24650
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755471AbbLDJeO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 4 Dec 2015 04:34:14 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, b54642@freescale.com, kernel@pengutronix.de

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
 drivers/i2c/busses/i2c-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 6dcfff5..0f41408 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1139,6 +1139,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 			i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
 
+	i2c_imx_init_recovery_info(i2c_imx, pdev);
+
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0) {
@@ -1146,8 +1148,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		goto rpm_disable;
 	}
 
-	i2c_imx_init_recovery_info(i2c_imx, pdev);
-
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-- 
1.9.1
