From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: mux: demux-pinctrl: invalidate properly when switching fails
Date: Mon, 22 Aug 2016 16:52:21 +0200
Message-ID: <20160822145221.4033-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Make sure the index to the active channel is invalidated when switching
fails.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 215ac87f606d2d..b6b9d2582fac56 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -107,6 +107,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	of_changeset_revert(&priv->chan[new_chan].chgset);
  err:
 	dev_err(priv->dev, "failed to setup demux-adapter %d (%d)\n", new_chan, ret);
+	priv->cur_chan = -EINVAL;
 	return ret;
 }
 
-- 
2.9.3
