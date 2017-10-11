From: Wei Jinhua <wei.jinhua1@zte.com.cn>
Subject: [PATCH] i2c:imx: use IRQF_SHARED mode to request IRQ
Date: Wed, 11 Oct 2017 15:57:20 +0800
Message-ID: <1507708640-11622-1-git-send-email-wei.jinhua1@zte.com.cn>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:59438 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756643AbdJKH75 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 11 Oct 2017 03:59:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, jochen@scram.de, jiang.biao2@zte.com.cn, wei.jinhua1@zte.com.cn, zhong.weidong@zte.com.cn

Some SoC share one irq number between I2C controllers. 
For example, on the LS2088 board, I2C 1 and I2C 2 share 
one irq number. In this case, only one I2C controller 
can register successfully, and others will fail.

Signed-off-by: Wei Jinhua <wei.jinhua1@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 54a47b4..e5c8b3d 100644
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
2.1.0.GIT
