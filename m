From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 05/10] i2c-mux: pinctrl: get rid of the driver private struct device pointer
Date: Mon,  4 Jan 2016 16:10:10 +0100
Message-ID: <1451920215-29167-6-git-send-email-peda@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

There is a copy of the device pointer in the mux core.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 24c8f218760f..e27f66bf5341 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -26,7 +26,6 @@
 #include <linux/of.h>
 
 struct i2c_mux_pinctrl {
-	struct device *dev;
 	struct i2c_mux_pinctrl_platform_data *pdata;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state **states;
@@ -51,6 +50,7 @@ static int i2c_mux_pinctrl_deselect(struct i2c_mux_core *muxc, u32 chan)
 static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 				struct platform_device *pdev)
 {
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
 	int num_names, i, ret;
 	struct device_node *adapter_np;
@@ -61,14 +61,14 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 
 	mux->pdata = devm_kzalloc(&pdev->dev, sizeof(*mux->pdata), GFP_KERNEL);
 	if (!mux->pdata) {
-		dev_err(mux->dev,
+		dev_err(muxc->dev,
 			"Cannot allocate i2c_mux_pinctrl_platform_data\n");
 		return -ENOMEM;
 	}
 
 	num_names = of_property_count_strings(np, "pinctrl-names");
 	if (num_names < 0) {
-		dev_err(mux->dev, "Cannot parse pinctrl-names: %d\n",
+		dev_err(muxc->dev, "Cannot parse pinctrl-names: %d\n",
 			num_names);
 		return num_names;
 	}
@@ -77,7 +77,7 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 		sizeof(*mux->pdata->pinctrl_states) * num_names,
 		GFP_KERNEL);
 	if (!mux->pdata->pinctrl_states) {
-		dev_err(mux->dev, "Cannot allocate pinctrl_states\n");
+		dev_err(muxc->dev, "Cannot allocate pinctrl_states\n");
 		return -ENOMEM;
 	}
 
@@ -85,14 +85,14 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 		ret = of_property_read_string_index(np, "pinctrl-names", i,
 			&mux->pdata->pinctrl_states[mux->pdata->bus_count]);
 		if (ret < 0) {
-			dev_err(mux->dev, "Cannot parse pinctrl-names: %d\n",
+			dev_err(muxc->dev, "Cannot parse pinctrl-names: %d\n",
 				ret);
 			return ret;
 		}
 		if (!strcmp(mux->pdata->pinctrl_states[mux->pdata->bus_count],
 			    "idle")) {
 			if (i != num_names - 1) {
-				dev_err(mux->dev, "idle state must be last\n");
+				dev_err(muxc->dev, "idle state must be last\n");
 				return -EINVAL;
 			}
 			mux->pdata->pinctrl_state_idle = "idle";
@@ -103,13 +103,13 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 
 	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
 	if (!adapter_np) {
-		dev_err(mux->dev, "Cannot parse i2c-parent\n");
+		dev_err(muxc->dev, "Cannot parse i2c-parent\n");
 		return -ENODEV;
 	}
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
 	of_node_put(adapter_np);
 	if (!adapter) {
-		dev_err(mux->dev, "Cannot find parent bus\n");
+		dev_err(muxc->dev, "Cannot find parent bus\n");
 		return -EPROBE_DEFER;
 	}
 	mux->pdata->parent_bus_num = i2c_adapter_id(adapter);
@@ -140,8 +140,6 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 	mux = i2c_mux_priv(muxc);
 	platform_set_drvdata(pdev, muxc);
 
-	mux->dev = &pdev->dev;
-
 	mux->pdata = dev_get_platdata(&pdev->dev);
 	if (!mux->pdata) {
 		ret = i2c_mux_pinctrl_parse_dt(mux, pdev);
-- 
2.1.4
