From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: i2c-mux-pinctrl: use deferred probe when adapter not found
Date: Thu, 10 Oct 2013 10:28:56 +0200
Message-ID: <1381393747-17662-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If it is not there yet, it might appear later.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 69a9173..68a3715 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -113,7 +113,7 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
 	if (!adapter) {
 		dev_err(mux->dev, "Cannot find parent bus\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 	mux->pdata->parent_bus_num = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
@@ -211,7 +211,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 	if (!mux->parent) {
 		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
 			mux->pdata->parent_bus_num);
-		ret = -ENODEV;
+		ret = -EPROBE_DEFER;
 		goto err;
 	}
 
-- 
1.8.4.rc3
