From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 03/10] i2c-mux: move the slave side adapter management to i2c_mux_core
Date: Mon,  4 Jan 2016 16:10:08 +0100
Message-ID: <1451920215-29167-4-git-send-email-peda@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

All muxes have slave side adapters, many have some arbitrary number of
them. Handle this in the mux core, so that drivers are simplified.

Add i2c_mux_reserve_adapter that can be used when it is known in advance
how many child adapters that is to be added. This avoids reallocating
memory.

Drop i2c_del_mux_adapter and replace it with i2c_del_mux_adapters, since
no mux driver is dynamically deleting individual child adapters anyway.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c                      | 71 +++++++++++++++++++++++-------
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 10 ++---
 drivers/i2c/muxes/i2c-mux-gpio.c           | 23 ++++------
 drivers/i2c/muxes/i2c-mux-pca9541.c        | 13 +++---
 drivers/i2c/muxes/i2c-mux-pca954x.c        | 29 +++++-------
 drivers/i2c/muxes/i2c-mux-pinctrl.c        | 27 ++++--------
 drivers/i2c/muxes/i2c-mux-reg.c            | 26 ++++-------
 include/linux/i2c-mux.h                    | 15 ++++---
 8 files changed, 110 insertions(+), 104 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 00ffbdba2cf8..84169a1c9c1b 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -99,6 +99,29 @@ static unsigned int i2c_mux_parent_classes(struct i2c_adapter *parent)
 	return class;
 }
 
+int i2c_mux_reserve_adapters(struct i2c_mux_core *muxc, int adapters)
+{
+	struct i2c_adapter **adapter;
+
+	if (adapters <= muxc->max_adapters)
+		return 0;
+
+	adapter = devm_kmalloc_array(muxc->dev,
+				     adapters, sizeof(*adapter),
+				     GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+
+	memcpy(adapter, muxc->adapter,
+	       muxc->max_adapters * sizeof(*adapter));
+
+	devm_kfree(muxc->dev, muxc->adapter);
+	muxc->adapter = adapter;
+	muxc->max_adapters = adapters;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_mux_reserve_adapters);
+
 struct i2c_mux_core *i2c_mux_alloc(struct device *dev, int sizeof_priv)
 {
 	struct i2c_mux_core *muxc;
@@ -120,19 +143,29 @@ fail:
 }
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
 
-struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
-					struct device *mux_dev,
-					u32 force_nr, u32 chan_id,
-					unsigned int class)
+int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
+			struct device *mux_dev,
+			u32 force_nr, u32 chan_id,
+			unsigned int class)
 {
 	struct i2c_adapter *parent = muxc->parent;
 	struct i2c_mux_priv *priv;
 	char symlink_name[20];
 	int ret;
 
+	if (muxc->adapters >= muxc->max_adapters) {
+		int new_max = 2 * muxc->max_adapters;
+
+		if (!new_max)
+			new_max = 1;
+		ret = i2c_mux_reserve_adapters(muxc, new_max);
+		if (ret)
+			return ret;
+	}
+
 	priv = kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
 	if (!priv)
-		return NULL;
+		return -ENOMEM;
 
 	/* Set up private adapter data */
 	priv->muxc = muxc;
@@ -204,7 +237,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 			"failed to add mux-adapter (error=%d)\n",
 			ret);
 		kfree(priv);
-		return NULL;
+		return ret;
 	}
 
 	WARN(sysfs_create_link(&priv->adap.dev.kobj, &mux_dev->kobj, "mux_device"),
@@ -216,23 +249,31 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
-	return &priv->adap;
+	muxc->adapter[muxc->adapters++] = &priv->adap;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
 
-void i2c_del_mux_adapter(struct i2c_adapter *adap)
+void i2c_del_mux_adapters(struct i2c_mux_core *muxc)
 {
-	struct i2c_mux_priv *priv = adap->algo_data;
 	char symlink_name[20];
 
-	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", priv->chan_id);
-	sysfs_remove_link(&priv->mux_dev->kobj, symlink_name);
+	while (muxc->adapters) {
+		struct i2c_adapter *adap = muxc->adapter[--muxc->adapters];
+		struct i2c_mux_priv *priv = adap->algo_data;
 
-	sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
-	i2c_del_adapter(adap);
-	kfree(priv);
+		muxc->adapter[muxc->adapters] = NULL;
+
+		snprintf(symlink_name, sizeof(symlink_name),
+			 "channel-%u", priv->chan_id);
+		sysfs_remove_link(&priv->mux_dev->kobj, symlink_name);
+
+		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
+		i2c_del_adapter(adap);
+		kfree(priv);
+	}
 }
-EXPORT_SYMBOL_GPL(i2c_del_mux_adapter);
+EXPORT_SYMBOL_GPL(i2c_del_mux_adapters);
 
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("I2C driver for multiplexed I2C busses");
diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 1c4741cf290f..49aca5f26ebb 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -42,7 +42,6 @@
  */
 
 struct i2c_arbitrator_data {
-	struct i2c_adapter *child;
 	int our_gpio;
 	int our_gpio_release;
 	int their_gpio;
@@ -207,10 +206,9 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 	}
 
 	/* Actually add the mux adapter */
-	arb->child = i2c_add_mux_adapter(muxc, dev, 0, 0, 0);
-	if (!arb->child) {
+	ret = i2c_add_mux_adapter(muxc, dev, 0, 0, 0);
+	if (ret) {
 		dev_err(dev, "Failed to add adapter\n");
-		ret = -ENODEV;
 		i2c_put_adapter(muxc->parent);
 	}
 
@@ -220,11 +218,9 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 static int i2c_arbitrator_remove(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
-	struct i2c_arbitrator_data *arb = i2c_mux_priv(muxc);
 
-	i2c_del_mux_adapter(arb->child);
+	i2c_del_mux_adapters(muxc);
 	i2c_put_adapter(muxc->parent);
-
 	return 0;
 }
 
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index bd000406e160..49b8d83fbc22 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -18,7 +18,6 @@
 #include <linux/of_gpio.h>
 
 struct gpiomux {
-	struct i2c_adapter **adap; /* child busses */
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
 };
@@ -184,12 +183,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	muxc->select = i2c_mux_gpio_select;
 	mux->gpio_base = gpio_base;
 
-	mux->adap = devm_kzalloc(&pdev->dev,
-				 sizeof(*mux->adap) * mux->data.n_values,
-				 GFP_KERNEL);
-	if (!mux->adap) {
-		dev_err(&pdev->dev, "Cannot allocate i2c_adapter structure");
-		ret = -ENOMEM;
+	ret = i2c_mux_reserve_adapters(muxc, mux->data.n_values);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot allocate i2c_adapter structures\n");
 		goto alloc_failed;
 	}
 
@@ -224,10 +220,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		u32 nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev, nr,
-						   mux->data.values[i], class);
-		if (!mux->adap[i]) {
-			ret = -ENODEV;
+		ret = i2c_add_mux_adapter(muxc, &pdev->dev, nr,
+					  mux->data.values[i], class);
+		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
 			goto add_adapter_failed;
 		}
@@ -239,8 +234,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	return 0;
 
 add_adapter_failed:
-	for (; i > 0; i--)
-		i2c_del_mux_adapter(mux->adap[i - 1]);
+	i2c_del_mux_adapters(muxc);
 	i = mux->data.n_gpios;
 err_request_gpio:
 	for (; i > 0; i--)
@@ -257,8 +251,7 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
 	struct gpiomux *mux = i2c_mux_priv(muxc);
 	int i;
 
-	for (i = 0; i < mux->data.n_values; i++)
-		i2c_del_mux_adapter(mux->adap[i]);
+	i2c_del_mux_adapters(muxc);
 
 	for (i = 0; i < mux->data.n_gpios; i++)
 		gpio_free(mux->gpio_base + mux->data.gpios[i]);
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 178c22981636..791efe1d3dbc 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -74,7 +74,6 @@
 
 struct pca9541 {
 	struct i2c_client *client;
-	struct i2c_adapter *mux_adap;
 	unsigned long select_timeout;
 	unsigned long arb_timeout;
 };
@@ -332,6 +331,7 @@ static int pca9541_probe(struct i2c_client *client,
 	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
 	int force;
+	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -364,11 +364,10 @@ static int pca9541_probe(struct i2c_client *client,
 	force = 0;
 	if (pdata)
 		force = pdata->modes[0].adap_id;
-	data->mux_adap = i2c_add_mux_adapter(muxc, &client->dev, force, 0, 0);
-
-	if (data->mux_adap == NULL) {
+	ret = i2c_add_mux_adapter(muxc, &client->dev, force, 0, 0);
+	if (ret) {
 		dev_err(&client->dev, "failed to register master selector\n");
-		return -ENODEV;
+		return ret;
 	}
 
 	dev_info(&client->dev, "registered master selector for I2C %s\n",
@@ -380,10 +379,8 @@ static int pca9541_probe(struct i2c_client *client,
 static int pca9541_remove(struct i2c_client *client)
 {
 	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
-	struct pca9541 *data = i2c_mux_priv(muxc);
-
-	i2c_del_mux_adapter(data->mux_adap);
 
+	i2c_del_mux_adapters(muxc);
 	return 0;
 }
 
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index edc6693ffea9..e3219ba9307c 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -60,7 +60,6 @@ enum pca_type {
 
 struct pca954x {
 	enum pca_type type;
-	struct i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
 
 	u8 last_chan;		/* last register value */
 	u8 deselect;
@@ -234,6 +233,13 @@ static int pca954x_probe(struct i2c_client *client,
 	data->type = id->driver_data;
 	data->last_chan = 0;		   /* force the first selection */
 
+	ret = i2c_mux_reserve_adapters(muxc, chips[data->type].nchans);
+	if (ret) {
+		dev_err(&client->dev,
+			"Cannot allocate i2c_adapter structures\n");
+		return ret;
+	}
+
 	idle_disconnect_dt = of_node &&
 		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
 
@@ -256,12 +262,10 @@ static int pca954x_probe(struct i2c_client *client,
 					   || idle_disconnect_dt) << num;
 		}
 
-		data->virt_adaps[num] =
-			i2c_add_mux_adapter(muxc, &client->dev,
-					    force, num, class);
+		ret = i2c_add_mux_adapter(muxc, &client->dev,
+					  force, num, class);
 
-		if (data->virt_adaps[num] == NULL) {
-			ret = -ENODEV;
+		if (ret) {
 			dev_err(&client->dev,
 				"failed to register multiplexed adapter"
 				" %d as bus %d\n", num, force);
@@ -277,24 +281,15 @@ static int pca954x_probe(struct i2c_client *client,
 	return 0;
 
 virt_reg_failed:
-	for (num--; num >= 0; num--)
-		i2c_del_mux_adapter(data->virt_adaps[num]);
+	i2c_del_mux_adapters(muxc);
 	return ret;
 }
 
 static int pca954x_remove(struct i2c_client *client)
 {
 	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
-	struct pca954x *data = i2c_mux_priv(muxc);
-	const struct chip_desc *chip = &chips[data->type];
-	int i;
-
-	for (i = 0; i < chip->nchans; ++i)
-		if (data->virt_adaps[i]) {
-			i2c_del_mux_adapter(data->virt_adaps[i]);
-			data->virt_adaps[i] = NULL;
-		}
 
+	i2c_del_mux_adapters(muxc);
 	return 0;
 }
 
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 79bd1ea75444..23792a1b2b3c 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -31,7 +31,6 @@ struct i2c_mux_pinctrl {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state **states;
 	struct pinctrl_state *state_idle;
-	struct i2c_adapter **busses;
 };
 
 static int i2c_mux_pinctrl_select(struct i2c_mux_core *muxc, u32 chan)
@@ -164,12 +163,9 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	mux->busses = devm_kzalloc(&pdev->dev,
-				   sizeof(*mux->busses) * mux->pdata->bus_count,
-				   GFP_KERNEL);
-	if (!mux->busses) {
-		dev_err(&pdev->dev, "Cannot allocate busses\n");
-		ret = -ENOMEM;
+	ret = i2c_mux_reserve_adapters(muxc, mux->pdata->bus_count);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot reserve adapters\n");
 		goto err;
 	}
 
@@ -219,10 +215,9 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		u32 bus = mux->pdata->base_bus_num ?
 				(mux->pdata->base_bus_num + i) : 0;
 
-		mux->busses[i] = i2c_add_mux_adapter(muxc, &pdev->dev,
-						     bus, i, 0);
-		if (!mux->busses[i]) {
-			ret = -ENODEV;
+		ret = i2c_add_mux_adapter(muxc, &pdev->dev,
+					  bus, i, 0);
+		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
 			goto err_del_adapter;
 		}
@@ -231,8 +226,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_adapter:
-	for (; i > 0; i--)
-		i2c_del_mux_adapter(mux->busses[i - 1]);
+	i2c_del_mux_adapters(muxc);
 	i2c_put_adapter(muxc->parent);
 err:
 	return ret;
@@ -241,14 +235,9 @@ err:
 static int i2c_mux_pinctrl_remove(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
-	struct i2c_mux_pinctrl *mux = i2c_mux_priv(muxc);
-	int i;
-
-	for (i = 0; i < mux->pdata->bus_count; i++)
-		i2c_del_mux_adapter(mux->busses[i]);
 
+	i2c_del_mux_adapters(muxc);
 	i2c_put_adapter(muxc->parent);
-
 	return 0;
 }
 
diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index d85879c46d90..73de562b7731 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 
 struct regmux {
-	struct i2c_adapter **adap; /* child busses */
 	struct i2c_mux_reg_platform_data data;
 };
 
@@ -216,11 +215,9 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	mux->adap = devm_kzalloc(&pdev->dev,
-				 sizeof(*mux->adap) * mux->data.n_values,
-				 GFP_KERNEL);
-	if (!mux->adap) {
-		dev_err(&pdev->dev, "Cannot allocate i2c_adapter structure");
+	ret = i2c_mux_reserve_adapters(muxc, mux->data.n_values);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot allocate i2c_adapter structures\n");
 		return -ENOMEM;
 	}
 
@@ -234,11 +231,9 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev,
-						   nr, mux->data.values[i],
-						   class);
-		if (!mux->adap[i]) {
-			ret = -ENODEV;
+		ret = i2c_add_mux_adapter(muxc, &pdev->dev, nr,
+					  mux->data.values[i], class);
+		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
 			goto add_adapter_failed;
 		}
@@ -250,8 +245,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 	return 0;
 
 add_adapter_failed:
-	for (; i > 0; i--)
-		i2c_del_mux_adapter(mux->adap[i - 1]);
+	i2c_del_mux_adapters(muxc);
 
 	return ret;
 }
@@ -259,12 +253,8 @@ add_adapter_failed:
 static int i2c_mux_reg_remove(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
-	struct regmux *mux = i2c_mux_priv(muxc);
-	int i;
-
-	for (i = 0; i < mux->data.n_values; i++)
-		i2c_del_mux_adapter(mux->adap[i]);
 
+	i2c_del_mux_adapters(muxc);
 	i2c_put_adapter(muxc->parent);
 
 	return 0;
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index 5cd6e1e664e0..bfcdcc46f2a6 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -29,6 +29,9 @@
 
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
+	struct i2c_adapter **adapter;
+	int adapters;
+	int max_adapters;
 	struct device *dev;
 
 	void *priv;
@@ -44,18 +47,20 @@ static inline void *i2c_mux_priv(struct i2c_mux_core *muxc)
 	return muxc->priv;
 }
 
+int i2c_mux_reserve_adapters(struct i2c_mux_core *muxc, int adapters);
+
 /*
  * Called to create a i2c bus on a multiplexed bus segment.
  * The mux_dev and chan_id parameters are passed to the select
  * and deselect callback functions to perform hardware-specific
  * mux control.
  */
-struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
-					struct device *mux_dev,
-					u32 force_nr, u32 chan_id,
-					unsigned int class);
+int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
+			struct device *mux_dev,
+			u32 force_nr, u32 chan_id,
+			unsigned int class);
 
-void i2c_del_mux_adapter(struct i2c_adapter *adap);
+void i2c_del_mux_adapters(struct i2c_mux_core *muxc);
 
 #endif /* __KERNEL__ */
 
-- 
2.1.4
