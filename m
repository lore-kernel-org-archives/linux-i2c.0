From: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/8] i2c: imx: enable clk before write to registers
Date: Wed, 7 Aug 2013 17:05:37 +0800
Message-ID: <1375866343-2074-2-git-send-email-b35083@freescale.com>
References: <1375866343-2074-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375866343-2074-1-git-send-email-b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The module clk should be enabled before write to
its register in probe(), and the clk can be disabled
after.

Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 9167d43..7adb351 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -543,6 +543,11 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_imx->clk);
 	}
 
+	ret = clk_prepare_enable(i2c_imx->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "can't enable I2C clock\n");
+		return ret;
+	}
 	/* Request IRQ */
 	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
 				pdev->name, i2c_imx);
@@ -580,6 +585,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 
 	/* Set up platform driver data */
 	platform_set_drvdata(pdev, i2c_imx);
+	clk_disable_unprepare(i2c_imx->clk);
 
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
-- 
1.8.0
