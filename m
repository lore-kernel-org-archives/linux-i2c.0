From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 14/14] i2c: mux: demux-pinctrl: make drivers with no pinctrl work again
Date: Sun,  6 Nov 2016 21:20:32 +0100
Message-ID: <20161106202032.5227-15-wsa+renesas@sang-engineering.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Some drivers like i2c-gpio do not have dedicated pinctrl states. They
broke when error checking for pinctrl was added. Detect them now, and in
their case, simply skip over pinctrl configuration.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index b3893f6282ba5b..3e6fe1760d82fc 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -69,10 +69,28 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 		goto err_with_revert;
 	}
 
-	p = devm_pinctrl_get_select(adap->dev.parent, priv->bus_name);
+	/*
+	 * Check if there are pinctrl states at all. Note: we cant' use
+	 * devm_pinctrl_get_select() because we need to distinguish between
+	 * the -ENODEV from devm_pinctrl_get() and pinctrl_lookup_state().
+	 */
+	p = devm_pinctrl_get(adap->dev.parent);
 	if (IS_ERR(p)) {
 		ret = PTR_ERR(p);
-		goto err_with_put;
+		/* continue if just no pinctrl states (e.g. i2c-gpio), otherwise exit */
+		if (ret != -ENODEV)
+			goto err_with_put;
+	} else {
+		/* there are states. check and use them */
+		struct pinctrl_state *s = pinctrl_lookup_state(p, priv->bus_name);
+
+		if (IS_ERR(s)) {
+			ret = PTR_ERR(s);
+			goto err_with_put;
+		}
+		ret = pinctrl_select_state(p, s);
+		if (ret < 0)
+			goto err_with_put;
 	}
 
 	priv->chan[new_chan].parent_adap = adap;
-- 
2.9.3
