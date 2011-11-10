From: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] i2c: imx: convert clk_prepare/clk_unprepare
Date: Thu, 10 Nov 2011 13:04:19 +0800
Message-ID: <1320901459-13208-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 58832e5..aad623b 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -196,6 +196,7 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
+	clk_prepare(i2c_imx->clk);
 	clk_enable(i2c_imx->clk);
 	writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
 	/* Enable I2C controller */
@@ -246,6 +247,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 	/* Disable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
 	clk_disable(i2c_imx->clk);
+	clk_unprepare(i2c_imx->clk);
 }
 
 static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
-- 
1.7.5.4
