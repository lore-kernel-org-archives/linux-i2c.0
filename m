From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: mux: demux-pinctrl: properly roll back when adding adapter fails
Date: Fri, 12 Aug 2016 18:40:23 +0200
Message-ID: <1471020023-2263-1-git-send-email-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54600 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbcHLQkl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Aug 2016 12:40:41 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

We also need to revert the dynamic OF change, so we get a consistent
state again. Otherwise, we might have two devices enabled e.g. after
pinctrl setup fails.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 8de073aed00148..215ac87f606d2d 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -68,7 +68,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	adap = of_find_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
 	if (!adap) {
 		ret = -ENODEV;
-		goto err;
+		goto err_with_revert;
 	}
 
 	p = devm_pinctrl_get_select(adap->dev.parent, priv->bus_name);
@@ -103,6 +103,8 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 
  err_with_put:
 	i2c_put_adapter(adap);
+ err_with_revert:
+	of_changeset_revert(&priv->chan[new_chan].chgset);
  err:
 	dev_err(priv->dev, "failed to setup demux-adapter %d (%d)\n", new_chan, ret);
 	return ret;
-- 
2.8.1
