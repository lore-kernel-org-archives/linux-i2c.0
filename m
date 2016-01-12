From: <ying.zhang22455@nxp.com>
Subject: [PATCH] drivers : i2c: Allow i2c devices share an interrupt
Date: Tue, 12 Jan 2016 16:01:47 +0800
Message-ID: <1452585707-20294-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0087.outbound.protection.outlook.com ([65.55.169.87]:60698
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753119AbcALIm2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Jan 2016 03:42:28 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: X.Xie@freescale.com, Ying Zhang <b40530@freescale.com>, Ying Zhang <ying.zhang22455@nxp.com>

From: Ying Zhang <b40530@freescale.com>

The I2C devices on I2C1, I2C2, I2C3, I2C4 share interrupts,
but the flag is not set when requesting IRQ.

This patch set the flag to IRQF_SHARED.

Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d4d8536..611b269 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1094,7 +1094,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	}
 
 	/* Request IRQ */
-	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, IRQF_SHARED,
 				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
-- 
2.1.0.27.g96db324
