From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH RESEND 4/5] i2c: imx: adopt pinctrl support
Date: Mon,  7 May 2012 08:53:59 +0800
Message-ID: <1336352040-28447-5-git-send-email-shawn.guo@linaro.org>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336352040-28447-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index dfb84b7..56bce9a 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -51,6 +51,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_i2c.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <mach/irqs.h>
 #include <mach/hardware.h>
@@ -470,6 +471,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imx_i2c_struct *i2c_imx;
 	struct resource *res;
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
+	struct pinctrl *pinctrl;
 	void __iomem *base;
 	resource_size_t res_size;
 	int irq, bitrate;
@@ -520,6 +522,12 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->base			= base;
 	i2c_imx->res			= res;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto fail3;
+	}
+
 	/* Get I2C clock */
 	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
 	if (IS_ERR(i2c_imx->clk)) {
-- 
1.7.5.4
