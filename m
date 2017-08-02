From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] i2c: mux: pinctrl: drop the idle_state member
Date: Wed,  2 Aug 2017 09:27:28 +0200
Message-ID: <20170802072728.24586-3-peda@axentia.se>
References: <20170802072728.24586-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802072728.24586-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The information is available elsewhere.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index aa4a3bf9507f..20b90a7a1e61 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -28,7 +28,6 @@
 struct i2c_mux_pinctrl {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state **states;
-	struct pinctrl_state *state_idle;
 };
 
 static int i2c_mux_pinctrl_select(struct i2c_mux_core *muxc, u32 chan)
@@ -40,9 +39,7 @@ static int i2c_mux_pinctrl_select(struct i2c_mux_core *muxc, u32 chan)
 
 static int i2c_mux_pinctrl_deselect(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct i2c_mux_pinctrl *mux = i2c_mux_priv(muxc);
-
-	return pinctrl_select_state(mux->pinctrl, mux->state_idle);
+	return i2c_mux_pinctrl_select(muxc, muxc->num_adapters);
 }
 
 static struct i2c_adapter *i2c_mux_pinctrl_root_adapter(
@@ -149,7 +146,6 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_put_parent;
 		}
-		mux->state_idle = mux->states[i];
 		muxc->deselect = i2c_mux_pinctrl_deselect;
 	}
 
@@ -166,7 +162,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		dev_info(dev, "mux-locked i2c mux\n");
 
 	/* Do not add any adapter for the idle state (if it's there at all). */
-	for (i = 0; i < num_names - !!mux->state_idle; i++) {
+	for (i = 0; i < num_names - !!muxc->deselect; i++) {
 		ret = i2c_mux_add_adapter(muxc, 0, i, 0);
 		if (ret)
 			goto err_del_adapter;
-- 
2.11.0
