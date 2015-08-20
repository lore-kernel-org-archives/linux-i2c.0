From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: mux: reg: simplify register size checking
Date: Thu, 20 Aug 2015 23:40:46 +0200
Message-ID: <1440106846-4484-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Checking was done at three different locations, just do it once and
properly at probing time.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---

York Sun: Can you test this patch? I can only build test.

 drivers/i2c/muxes/i2c-mux-reg.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 86d41d36a78340..da8926d816c8cc 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -59,9 +59,6 @@ static int i2c_mux_reg_set(const struct regmux *mux, unsigned int chan_id)
 		if (!mux->data.write_only)
 			ioread8(mux->data.reg);
 		break;
-	default:
-		pr_err("Invalid register size\n");
-		return -EINVAL;
 	}
 
 	return 0;
@@ -154,10 +151,6 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 	/* map address from "reg" if exists */
 	if (of_address_to_resource(np, 0, &res)) {
 		mux->data.reg_size = resource_size(&res);
-		if (mux->data.reg_size > 4) {
-			dev_err(&pdev->dev, "Invalid address size\n");
-			return -EINVAL;
-		}
 		mux->data.reg = devm_ioremap_resource(&pdev->dev, &res);
 		if (IS_ERR(mux->data.reg))
 			return PTR_ERR(mux->data.reg);
@@ -210,15 +203,17 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 			"Register not set, using platform resource\n");
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		mux->data.reg_size = resource_size(res);
-		if (mux->data.reg_size > 4) {
-			dev_err(&pdev->dev, "Invalid resource size\n");
-			return -EINVAL;
-		}
 		mux->data.reg = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(mux->data.reg))
 			return PTR_ERR(mux->data.reg);
 	}
 
+	if (mux->data.reg_size != 4 && mux->data.reg_size != 2 &&
+	    mux->data.reg_size != 1) {
+		dev_err(&pdev->dev, "Invalid register size\n");
+		return -EINVAL;
+	}
+
 	mux->adap = devm_kzalloc(&pdev->dev,
 				 sizeof(*mux->adap) * mux->data.n_values,
 				 GFP_KERNEL);
-- 
2.1.4
