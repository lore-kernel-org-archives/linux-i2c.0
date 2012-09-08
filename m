From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: mxs: correctly setup speed for non devicetree
Date: Sat,  8 Sep 2012 17:38:52 +0200
Message-ID: <1347118732-4896-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Commit cd4f2d4 (i2c: mxs: Set I2C timing registers for mxs-i2c) only
covered the case for devicetree and made platform_data based boards
bail out with -EINVAL. Correctly support the latter one, too.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 088c5c1..51f05b8 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -365,10 +365,6 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	struct device_node *node = dev->of_node;
 	int ret;
 
-	if (!node)
-		return -EINVAL;
-
-	i2c->speed = &mxs_i2c_95kHz_config;
 	ret = of_property_read_u32(node, "clock-frequency", &speed);
 	if (ret)
 		dev_warn(dev, "No I2C speed selected, using 100kHz\n");
@@ -419,10 +415,13 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 		return err;
 
 	i2c->dev = dev;
+	i2c->speed = &mxs_i2c_95kHz_config;
 
-	err = mxs_i2c_get_ofdata(i2c);
-	if (err)
-		return err;
+	if (dev->of_node) {
+		err = mxs_i2c_get_ofdata(i2c);
+		if (err)
+			return err;
+	}
 
 	platform_set_drvdata(pdev, i2c);
 
-- 
1.7.10.4
