From: Luka Perkov <luka-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] i2c: imx: retry on NAK
Date: Wed, 11 Sep 2013 01:58:10 +0200
Message-ID: <1378857490-30968-1-git-send-email-luka@openwrt.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Luka Perkov <luka-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>

In case of busy i2c try again to get ACK.

Signed-off-by: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Tested-by: Luka Perkov <luka-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf4665..c64afe6 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -62,6 +62,7 @@
 
 /* Default value */
 #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
+#define IMX_I2C_MAX_RETRIES	3	/* number of retries to attempt */
 
 /* IMX I2C registers:
  * the I2C register offset is different between SoCs,
@@ -298,7 +299,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
 {
 	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
-		return -EIO;  /* No ACK */
+		return -EAGAIN; /* try again */
 	}
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> ACK received\n", __func__);
@@ -633,6 +634,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
 	i2c_imx->adapter.nr 		= pdev->id;
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
+	i2c_imx->adapter.retries	= IMX_I2C_MAX_RETRIES;
 	i2c_imx->base			= base;
 
 	/* Get I2C clock */
-- 
1.8.4
