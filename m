From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: imx: make bitrate unsigned int
Date: Sun,  8 Jul 2012 13:24:47 +0200
Message-ID: <1341746687-1448-1-git-send-email-wolfram@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

sparse found this assignment of u32 to an int. Fix it:

drivers/i2c/busses/i2c-imx.c:540:56: warning: incorrect type in argument 3 (different signedness)

Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a93e846..3f5dfe8 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -471,8 +471,8 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
 	struct pinctrl *pinctrl;
 	void __iomem *base;
-	int irq, bitrate;
-	int ret;
+	int irq, ret;
+	u32 bitrate;
 
 	dev_dbg(&pdev->dev, "<%s>\n", __func__);
 
-- 
1.7.10
