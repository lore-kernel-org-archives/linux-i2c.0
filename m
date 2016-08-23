From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: mux: demux-pinctrl: run properly with multiple instances
Date: Tue, 23 Aug 2016 17:28:03 +0200
Message-ID: <20160823152803.2051-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

We can't use a static property for all the changesets, so we now create
dynamic ones for each changeset.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: 50a5ba87690814 ("i2c: mux: demux-pinctrl: add driver")
---

Finally fixed this one!

Simon: I think you can retest your demuxer-dts-series now.

Pantelis: What happened to your series with the changeset helpers? It would
have fixed this bug, too, and would still make this code easier to read, so a
welcome addition. Also, I still haven't fully understood when it is safe to use
a static property? It would be helpful to document this. I spent quite some
time on this one because randomly broken pointers are hard to debug.

 drivers/i2c/muxes/i2c-demux-pinctrl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 215ac87f606d2d..e999125ce37d77 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -37,8 +37,6 @@ struct i2c_demux_pinctrl_priv {
 	struct i2c_demux_pinctrl_chan chan[];
 };
 
-static struct property status_okay = { .name = "status", .length = 3, .value = "ok" };
-
 static int i2c_demux_master_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct i2c_demux_pinctrl_priv *priv = adap->algo_data;
@@ -192,6 +190,7 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct i2c_demux_pinctrl_priv *priv;
+	struct property *props;
 	int num_chan, i, j, err;
 
 	num_chan = of_count_phandle_with_args(np, "i2c-parent", NULL);
@@ -202,7 +201,10 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv)
 			   + num_chan * sizeof(struct i2c_demux_pinctrl_chan), GFP_KERNEL);
-	if (!priv)
+
+	props = devm_kcalloc(&pdev->dev, num_chan, sizeof(*props), GFP_KERNEL);
+
+	if (!priv || !props)
 		return -ENOMEM;
 
 	err = of_property_read_string(np, "i2c-bus-name", &priv->bus_name);
@@ -220,8 +222,12 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 		}
 		priv->chan[i].parent_np = adap_np;
 
+		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
+		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		props[i].length = 3;
+
 		of_changeset_init(&priv->chan[i].chgset);
-		of_changeset_update_property(&priv->chan[i].chgset, adap_np, &status_okay);
+		of_changeset_update_property(&priv->chan[i].chgset, adap_np, &props[i]);
 	}
 
 	priv->num_chan = num_chan;
-- 
2.9.3
