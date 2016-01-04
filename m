From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 04/10] i2c-mux: remove the mux dev pointer from the mux per channel data
Date: Mon,  4 Jan 2016 16:10:09 +0100
Message-ID: <1451920215-29167-5-git-send-email-peda@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

The dev pointer is readily available in the mux core struct, no point in
keeping multiple copies around.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c                      | 24 ++++++++++++------------
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c |  2 +-
 drivers/i2c/muxes/i2c-mux-gpio.c           |  3 +--
 drivers/i2c/muxes/i2c-mux-pca9541.c        |  2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c        |  3 +--
 drivers/i2c/muxes/i2c-mux-pinctrl.c        |  3 +--
 drivers/i2c/muxes/i2c-mux-reg.c            |  3 +--
 include/linux/i2c-mux.h                    |  1 -
 8 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 84169a1c9c1b..b507a799f222 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -32,7 +32,6 @@ struct i2c_mux_priv {
 	struct i2c_adapter adap;
 	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
-	struct device *mux_dev;
 	u32 chan_id;
 };
 
@@ -144,7 +143,6 @@ fail:
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
 
 int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
-			struct device *mux_dev,
 			u32 force_nr, u32 chan_id,
 			unsigned int class)
 {
@@ -169,7 +167,6 @@ int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 
 	/* Set up private adapter data */
 	priv->muxc = muxc;
-	priv->mux_dev = mux_dev;
 	priv->chan_id = chan_id;
 
 	/* Need to do algo dynamically because we don't know ahead
@@ -204,11 +201,11 @@ int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 	 * Try to populate the mux adapter's of_node, expands to
 	 * nothing if !CONFIG_OF.
 	 */
-	if (mux_dev->of_node) {
+	if (muxc->dev->of_node) {
 		struct device_node *child;
 		u32 reg;
 
-		for_each_child_of_node(mux_dev->of_node, child) {
+		for_each_child_of_node(muxc->dev->of_node, child) {
 			ret = of_property_read_u32(child, "reg", &reg);
 			if (ret)
 				continue;
@@ -222,8 +219,9 @@ int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 	/*
 	 * Associate the mux channel with an ACPI node.
 	 */
-	if (has_acpi_companion(mux_dev))
-		acpi_preset_companion(&priv->adap.dev, ACPI_COMPANION(mux_dev),
+	if (has_acpi_companion(muxc->dev))
+		acpi_preset_companion(&priv->adap.dev,
+				      ACPI_COMPANION(muxc->dev),
 				      chan_id);
 
 	if (force_nr) {
@@ -240,12 +238,14 @@ int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 		return ret;
 	}
 
-	WARN(sysfs_create_link(&priv->adap.dev.kobj, &mux_dev->kobj, "mux_device"),
-			       "can't create symlink to mux device\n");
+	WARN(sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
+			       "mux_device"),
+	     "can't create symlink to mux device\n");
 
 	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", chan_id);
-	WARN(sysfs_create_link(&mux_dev->kobj, &priv->adap.dev.kobj, symlink_name),
-			       "can't create symlink for channel %u\n", chan_id);
+	WARN(sysfs_create_link(&muxc->dev->kobj, &priv->adap.dev.kobj,
+			       symlink_name),
+	     "can't create symlink for channel %u\n", chan_id);
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
@@ -266,7 +266,7 @@ void i2c_del_mux_adapters(struct i2c_mux_core *muxc)
 
 		snprintf(symlink_name, sizeof(symlink_name),
 			 "channel-%u", priv->chan_id);
-		sysfs_remove_link(&priv->mux_dev->kobj, symlink_name);
+		sysfs_remove_link(&muxc->dev->kobj, symlink_name);
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 49aca5f26ebb..13379762d91a 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -206,7 +206,7 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 	}
 
 	/* Actually add the mux adapter */
-	ret = i2c_add_mux_adapter(muxc, dev, 0, 0, 0);
+	ret = i2c_add_mux_adapter(muxc, 0, 0, 0);
 	if (ret) {
 		dev_err(dev, "Failed to add adapter\n");
 		i2c_put_adapter(muxc->parent);
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 49b8d83fbc22..4641ea0da516 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -220,8 +220,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		u32 nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		ret = i2c_add_mux_adapter(muxc, &pdev->dev, nr,
-					  mux->data.values[i], class);
+		ret = i2c_add_mux_adapter(muxc, nr, mux->data.values[i], class);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
 			goto add_adapter_failed;
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 791efe1d3dbc..9ee0d8b70283 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -364,7 +364,7 @@ static int pca9541_probe(struct i2c_client *client,
 	force = 0;
 	if (pdata)
 		force = pdata->modes[0].adap_id;
-	ret = i2c_add_mux_adapter(muxc, &client->dev, force, 0, 0);
+	ret = i2c_add_mux_adapter(muxc, force, 0, 0);
 	if (ret) {
 		dev_err(&client->dev, "failed to register master selector\n");
 		return ret;
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index e3219ba9307c..bd89da42b417 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -262,8 +262,7 @@ static int pca954x_probe(struct i2c_client *client,
 					   || idle_disconnect_dt) << num;
 		}
 
-		ret = i2c_add_mux_adapter(muxc, &client->dev,
-					  force, num, class);
+		ret = i2c_add_mux_adapter(muxc, force, num, class);
 
 		if (ret) {
 			dev_err(&client->dev,
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 23792a1b2b3c..24c8f218760f 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -215,8 +215,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		u32 bus = mux->pdata->base_bus_num ?
 				(mux->pdata->base_bus_num + i) : 0;
 
-		ret = i2c_add_mux_adapter(muxc, &pdev->dev,
-					  bus, i, 0);
+		ret = i2c_add_mux_adapter(muxc, bus, i, 0);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
 			goto err_del_adapter;
diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 73de562b7731..3624635f70ff 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -231,8 +231,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		ret = i2c_add_mux_adapter(muxc, &pdev->dev, nr,
-					  mux->data.values[i], class);
+		ret = i2c_add_mux_adapter(muxc, nr, mux->data.values[i], class);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
 			goto add_adapter_failed;
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index bfcdcc46f2a6..d88e0a3b6768 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -56,7 +56,6 @@ int i2c_mux_reserve_adapters(struct i2c_mux_core *muxc, int adapters);
  * mux control.
  */
 int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
-			struct device *mux_dev,
 			u32 force_nr, u32 chan_id,
 			unsigned int class);
 
-- 
2.1.4
