From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] i2c: mux: pinctrl: remove platform_data
Date: Wed,  2 Aug 2017 09:27:27 +0200
Message-ID: <20170802072728.24586-2-peda@axentia.se>
References: <20170802072728.24586-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802072728.24586-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

No platform (at least no upstreamed platform) has ever used this
platform_data. Just drop it and simplify the code.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/Kconfig           |   1 +
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 219 ++++++++++++------------------------
 include/linux/i2c-mux-pinctrl.h     |  41 -------
 3 files changed, 72 insertions(+), 189 deletions(-)
 delete mode 100644 include/linux/i2c-mux-pinctrl.h

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 2c64d0e0740f..1bba95ecc7c0 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -76,6 +76,7 @@ config I2C_MUX_PCA954x
 config I2C_MUX_PINCTRL
 	tristate "pinctrl-based I2C multiplexer"
 	depends on PINCTRL
+	depends on OF || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for an I2C
 	  multiplexer that uses the pinctrl subsystem, i.e. pin multiplexing.
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 7c0c264b07bc..aa4a3bf9507f 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -20,14 +20,12 @@
 #include <linux/i2c-mux.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/i2c-mux-pinctrl.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include "../../pinctrl/core.h"
 
 struct i2c_mux_pinctrl {
-	struct i2c_mux_pinctrl_platform_data *pdata;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state **states;
 	struct pinctrl_state *state_idle;
@@ -47,80 +45,6 @@ static int i2c_mux_pinctrl_deselect(struct i2c_mux_core *muxc, u32 chan)
 	return pinctrl_select_state(mux->pinctrl, mux->state_idle);
 }
 
-#ifdef CONFIG_OF
-static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
-				    struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	int num_names, i, ret;
-	struct device_node *adapter_np;
-	struct i2c_adapter *adapter;
-
-	if (!np)
-		return 0;
-
-	mux->pdata = devm_kzalloc(&pdev->dev, sizeof(*mux->pdata), GFP_KERNEL);
-	if (!mux->pdata)
-		return -ENOMEM;
-
-	num_names = of_property_count_strings(np, "pinctrl-names");
-	if (num_names < 0) {
-		dev_err(&pdev->dev, "Cannot parse pinctrl-names: %d\n",
-			num_names);
-		return num_names;
-	}
-
-	mux->pdata->pinctrl_states = devm_kzalloc(&pdev->dev,
-		sizeof(*mux->pdata->pinctrl_states) * num_names,
-		GFP_KERNEL);
-	if (!mux->pdata->pinctrl_states)
-		return -ENOMEM;
-
-	for (i = 0; i < num_names; i++) {
-		ret = of_property_read_string_index(np, "pinctrl-names", i,
-			&mux->pdata->pinctrl_states[mux->pdata->bus_count]);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Cannot parse pinctrl-names: %d\n",
-				ret);
-			return ret;
-		}
-		if (!strcmp(mux->pdata->pinctrl_states[mux->pdata->bus_count],
-			    "idle")) {
-			if (i != num_names - 1) {
-				dev_err(&pdev->dev,
-					"idle state must be last\n");
-				return -EINVAL;
-			}
-			mux->pdata->pinctrl_state_idle = "idle";
-		} else {
-			mux->pdata->bus_count++;
-		}
-	}
-
-	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
-	if (!adapter_np) {
-		dev_err(&pdev->dev, "Cannot parse i2c-parent\n");
-		return -ENODEV;
-	}
-	adapter = of_find_i2c_adapter_by_node(adapter_np);
-	of_node_put(adapter_np);
-	if (!adapter) {
-		dev_err(&pdev->dev, "Cannot find parent bus\n");
-		return -EPROBE_DEFER;
-	}
-	mux->pdata->parent_bus_num = i2c_adapter_id(adapter);
-	put_device(&adapter->dev);
-
-	return 0;
-}
-#else
-static inline int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
-					   struct platform_device *pdev)
-{
-	return 0;
-}
-#endif
-
 static struct i2c_adapter *i2c_mux_pinctrl_root_adapter(
 	struct pinctrl_state *state)
 {
@@ -141,110 +65,109 @@ static struct i2c_adapter *i2c_mux_pinctrl_root_adapter(
 	return root;
 }
 
+static struct i2c_adapter *i2c_mux_pinctrl_parent_adapter(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *parent_np;
+	struct i2c_adapter *parent;
+
+	parent_np = of_parse_phandle(np, "i2c-parent", 0);
+	if (!parent_np) {
+		dev_err(dev, "Cannot parse i2c-parent\n");
+		return ERR_PTR(-ENODEV);
+	}
+	parent = of_find_i2c_adapter_by_node(parent_np);
+	of_node_put(parent_np);
+	if (!parent)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return parent;
+}
+
 static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct i2c_mux_core *muxc;
 	struct i2c_mux_pinctrl *mux;
+	struct i2c_adapter *parent;
 	struct i2c_adapter *root;
-	int i, ret;
-
-	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
-	if (!mux) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	int num_names, i, ret;
+	const char *name;
 
-	mux->pdata = dev_get_platdata(&pdev->dev);
-	if (!mux->pdata) {
-		ret = i2c_mux_pinctrl_parse_dt(mux, pdev);
-		if (ret < 0)
-			goto err;
-	}
-	if (!mux->pdata) {
-		dev_err(&pdev->dev, "Missing platform data\n");
-		ret = -ENODEV;
-		goto err;
+	num_names = of_property_count_strings(np, "pinctrl-names");
+	if (num_names < 0) {
+		dev_err(dev, "Cannot parse pinctrl-names: %d\n",
+			num_names);
+		return num_names;
 	}
 
-	mux->states = devm_kzalloc(&pdev->dev,
-				   sizeof(*mux->states) * mux->pdata->bus_count,
-				   GFP_KERNEL);
-	if (!mux->states) {
-		dev_err(&pdev->dev, "Cannot allocate states\n");
-		ret = -ENOMEM;
-		goto err;
-	}
+	parent = i2c_mux_pinctrl_parent_adapter(dev);
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
 
-	muxc = i2c_mux_alloc(NULL, &pdev->dev, mux->pdata->bus_count, 0, 0,
-			     i2c_mux_pinctrl_select, NULL);
+	muxc = i2c_mux_alloc(parent, dev, num_names,
+			     sizeof(*mux) + num_names * sizeof(*mux->states),
+			     0, i2c_mux_pinctrl_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
-		goto err;
+		goto err_put_parent;
 	}
-	muxc->priv = mux;
+	mux = i2c_mux_priv(muxc);
+	mux->states = (struct pinctrl_state **)(mux + 1);
 
 	platform_set_drvdata(pdev, muxc);
 
-	mux->pinctrl = devm_pinctrl_get(&pdev->dev);
+	mux->pinctrl = devm_pinctrl_get(dev);
 	if (IS_ERR(mux->pinctrl)) {
 		ret = PTR_ERR(mux->pinctrl);
-		dev_err(&pdev->dev, "Cannot get pinctrl: %d\n", ret);
-		goto err;
+		dev_err(dev, "Cannot get pinctrl: %d\n", ret);
+		goto err_put_parent;
 	}
-	for (i = 0; i < mux->pdata->bus_count; i++) {
-		mux->states[i] = pinctrl_lookup_state(mux->pinctrl,
-						mux->pdata->pinctrl_states[i]);
+
+	for (i = 0; i < num_names; i++) {
+		ret = of_property_read_string_index(np, "pinctrl-names", i,
+						    &name);
+		if (ret < 0) {
+			dev_err(dev, "Cannot parse pinctrl-names: %d\n", ret);
+			goto err_put_parent;
+		}
+
+		mux->states[i] = pinctrl_lookup_state(mux->pinctrl, name);
 		if (IS_ERR(mux->states[i])) {
 			ret = PTR_ERR(mux->states[i]);
-			dev_err(&pdev->dev,
-				"Cannot look up pinctrl state %s: %d\n",
-				mux->pdata->pinctrl_states[i], ret);
-			goto err;
-		}
-	}
-	if (mux->pdata->pinctrl_state_idle) {
-		mux->state_idle = pinctrl_lookup_state(mux->pinctrl,
-						mux->pdata->pinctrl_state_idle);
-		if (IS_ERR(mux->state_idle)) {
-			ret = PTR_ERR(mux->state_idle);
-			dev_err(&pdev->dev,
-				"Cannot look up pinctrl state %s: %d\n",
-				mux->pdata->pinctrl_state_idle, ret);
-			goto err;
+			dev_err(dev, "Cannot look up pinctrl state %s: %d\n",
+				name, ret);
+			goto err_put_parent;
 		}
 
-		muxc->deselect = i2c_mux_pinctrl_deselect;
-	}
+		if (strcmp(name, "idle"))
+			continue;
 
-	muxc->parent = i2c_get_adapter(mux->pdata->parent_bus_num);
-	if (!muxc->parent) {
-		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
-			mux->pdata->parent_bus_num);
-		ret = -EPROBE_DEFER;
-		goto err;
+		if (i != num_names - 1) {
+			dev_err(dev, "idle state must be last\n");
+			ret = -EINVAL;
+			goto err_put_parent;
+		}
+		mux->state_idle = mux->states[i];
+		muxc->deselect = i2c_mux_pinctrl_deselect;
 	}
 
 	root = i2c_root_adapter(&muxc->parent->dev);
 
 	muxc->mux_locked = true;
-	for (i = 0; i < mux->pdata->bus_count; i++) {
+	for (i = 0; i < num_names; i++) {
 		if (root != i2c_mux_pinctrl_root_adapter(mux->states[i])) {
 			muxc->mux_locked = false;
 			break;
 		}
 	}
-	if (muxc->mux_locked && mux->pdata->pinctrl_state_idle &&
-	    root != i2c_mux_pinctrl_root_adapter(mux->state_idle))
-		muxc->mux_locked = false;
-
 	if (muxc->mux_locked)
-		dev_info(&pdev->dev, "mux-locked i2c mux\n");
+		dev_info(dev, "mux-locked i2c mux\n");
 
-	for (i = 0; i < mux->pdata->bus_count; i++) {
-		u32 bus = mux->pdata->base_bus_num ?
-				(mux->pdata->base_bus_num + i) : 0;
-
-		ret = i2c_mux_add_adapter(muxc, bus, i, 0);
+	/* Do not add any adapter for the idle state (if it's there at all). */
+	for (i = 0; i < num_names - !!mux->state_idle; i++) {
+		ret = i2c_mux_add_adapter(muxc, 0, i, 0);
 		if (ret)
 			goto err_del_adapter;
 	}
@@ -253,8 +176,9 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 
 err_del_adapter:
 	i2c_mux_del_adapters(muxc);
+err_put_parent:
 	i2c_put_adapter(muxc->parent);
-err:
+
 	return ret;
 }
 
@@ -264,16 +188,15 @@ static int i2c_mux_pinctrl_remove(struct platform_device *pdev)
 
 	i2c_mux_del_adapters(muxc);
 	i2c_put_adapter(muxc->parent);
+
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id i2c_mux_pinctrl_of_match[] = {
 	{ .compatible = "i2c-mux-pinctrl", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, i2c_mux_pinctrl_of_match);
-#endif
 
 static struct platform_driver i2c_mux_pinctrl_driver = {
 	.driver	= {
diff --git a/include/linux/i2c-mux-pinctrl.h b/include/linux/i2c-mux-pinctrl.h
deleted file mode 100644
index a65c86429e84..000000000000
--- a/include/linux/i2c-mux-pinctrl.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * i2c-mux-pinctrl platform data
- *
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef _LINUX_I2C_MUX_PINCTRL_H
-#define _LINUX_I2C_MUX_PINCTRL_H
-
-/**
- * struct i2c_mux_pinctrl_platform_data - Platform data for i2c-mux-pinctrl
- * @parent_bus_num: Parent I2C bus number
- * @base_bus_num: Base I2C bus number for the child busses. 0 for dynamic.
- * @bus_count: Number of child busses. Also the number of elements in
- *	@pinctrl_states
- * @pinctrl_states: The names of the pinctrl state to select for each child bus
- * @pinctrl_state_idle: The pinctrl state to select when no child bus is being
- *	accessed. If NULL, the most recently used pinctrl state will be left
- *	selected.
- */
-struct i2c_mux_pinctrl_platform_data {
-	int parent_bus_num;
-	int base_bus_num;
-	int bus_count;
-	const char **pinctrl_states;
-	const char *pinctrl_state_idle;
-};
-
-#endif
-- 
2.11.0
