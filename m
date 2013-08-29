From: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH v4 1/1] i2c: rcar: modify I2C driver
Date: Thu, 29 Aug 2013 18:36:35 +0900
Message-ID: <1377768995-13880-2-git-send-email-nv-dung@jinso.co.jp>
References: <1377768995-13880-1-git-send-email-nv-dung@jinso.co.jp>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377768995-13880-1-git-send-email-nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch modify I2C driver of rcar-H1 to usable on both rcar-H1 and rcar-H2.

Signed-off-by: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 drivers/i2c/busses/i2c-rcar.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 0fc5858..32ec693 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -101,6 +101,11 @@ enum {
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
 
+enum rcar_i2c_type {
+	I2C_RCAR_H1,
+	I2C_RCAR_H2,
+};
+
 struct rcar_i2c_priv {
 	void __iomem *io;
 	struct i2c_adapter adap;
@@ -113,6 +118,7 @@ struct rcar_i2c_priv {
 	int irq;
 	u32 icccr;
 	u32 flags;
+	enum rcar_i2c_type	devtype;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -224,12 +230,25 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	u32 scgd, cdf;
 	u32 round, ick;
 	u32 scl;
+	u32 cdf_width;
 
 	if (!clkp) {
 		dev_err(dev, "there is no peripheral_clk\n");
 		return -EIO;
 	}
 
+	switch (priv->devtype) {
+	case I2C_RCAR_H1:
+		cdf_width = 2;
+		break;
+	case I2C_RCAR_H2:
+		cdf_width = 3;
+		break;
+	default:
+		dev_err(dev, "device type error\n");
+		return -EIO;
+	}
+
 	/*
 	 * calculate SCL clock
 	 * see
@@ -245,7 +264,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	 * clkp : peripheral_clk
 	 * F[]  : integer up-valuation
 	 */
-	for (cdf = 0; cdf < 4; cdf++) {
+	for (cdf = 0; cdf < (1 << cdf_width); cdf++) {
 		ick = clk_get_rate(clkp) / (1 + cdf);
 		if (ick < 20000000)
 			goto ick_find;
@@ -287,7 +306,7 @@ scgd_find:
 	/*
 	 * keep icccr value
 	 */
-	priv->icccr = (scgd << 2 | cdf);
+	priv->icccr = (scgd << (cdf_width) | cdf);
 
 	return 0;
 }
@@ -632,6 +651,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	bus_speed = 100000; /* default 100 kHz */
 	if (pdata && pdata->bus_speed)
 		bus_speed = pdata->bus_speed;
+
+	priv->devtype = platform_get_device_id(pdev)->driver_data;
+
 	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
 	if (ret < 0)
 		return ret;
@@ -686,6 +708,14 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_device_id rcar_i2c_id_table[] = {
+	{ "i2c-rcar",		I2C_RCAR_H1 },
+	{ "i2c-rcar_h1",	I2C_RCAR_H1 },
+	{ "i2c-rcar_h2",	I2C_RCAR_H2 },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, rcar_i2c_id_table);
+
 static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
@@ -693,6 +723,7 @@ static struct platform_driver rcar_i2c_driver = {
 	},
 	.probe		= rcar_i2c_probe,
 	.remove		= rcar_i2c_remove,
+	.id_table	= rcar_i2c_id_table,
 };
 
 module_platform_driver(rcar_i2c_driver);
-- 
1.7.9.5
