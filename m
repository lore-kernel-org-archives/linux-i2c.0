From: <ying.zhang22455@nxp.com>
Subject: [PATCH v2] i2c: imx: allow i2c devices share an interrupt
Date: Mon, 11 Sep 2017 16:34:16 +0800
Message-ID: <20170911083416.2895-1-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0060.outbound.protection.outlook.com ([104.47.34.60]:51840
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751065AbdIKIva (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 11 Sep 2017 04:51:30 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Zhang Ying-22455 <ying.zhang22455@nxp.com>

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Allow the I2C device on the same bus can’t claim irq.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
[change from v1]
----update the commit message.

 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 54a47b40546f..e5c8b3d5df77 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1100,7 +1100,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	}
 
 	/* Request IRQ */
-	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, IRQF_SHARED,
 				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
-- 
2.14.1
