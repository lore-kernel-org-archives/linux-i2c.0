From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] i2c: mux: reg: put away the parent i2c adapter on probe failure
Date: Sun, 7 May 2017 08:16:28 +0200
Message-ID: <1494137789-32395-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

It is only prudent to let go of resources that are not used.

Fixes: b3fdd32799d8 ("i2c: mux: Add register-based mux i2c-mux-reg")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index c6a90b4a9c62..91b10afc8c34 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -196,20 +196,25 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		mux->data.reg_size = resource_size(res);
 		mux->data.reg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mux->data.reg))
-			return PTR_ERR(mux->data.reg);
+		if (IS_ERR(mux->data.reg)) {
+			ret = PTR_ERR(mux->data.reg);
+			goto err_put_parent;
+		}
 	}
 
 	if (mux->data.reg_size != 4 && mux->data.reg_size != 2 &&
 	    mux->data.reg_size != 1) {
 		dev_err(&pdev->dev, "Invalid register size\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_parent;
 	}
 
 	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values, 0, 0,
 			     i2c_mux_reg_select, NULL);
-	if (!muxc)
-		return -ENOMEM;
+	if (!muxc) {
+		ret = -ENOMEM;
+		goto err_put_parent;
+	}
 	muxc->priv = mux;
 
 	platform_set_drvdata(pdev, muxc);
@@ -235,6 +240,8 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 
 add_adapter_failed:
 	i2c_mux_del_adapters(muxc);
+err_put_parent:
+	i2c_put_adapter(parent);
 
 	return ret;
 }
-- 
2.1.4
