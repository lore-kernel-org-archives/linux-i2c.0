From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 01/10] i2c-mux: add common core data for every mux instance
Date: Mon,  4 Jan 2016 16:10:06 +0100
Message-ID: <1451920215-29167-2-git-send-email-peda@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

The initial core mux structure starts off small with only the parent
adapter pointer, which all muxes have, and a priv pointer for mux
driver private data.

Add i2c_mux_alloc function to unify the creation of a mux.

Where appropriate, pass around the mux core structure instead of the
parent adapter or the driver private data.

Remove the parent adapter pointer from the driver private data for all
mux drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c                      | 35 ++++++++++++++++++++++++-----
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 24 +++++++++++---------
 drivers/i2c/muxes/i2c-mux-gpio.c           | 20 +++++++++--------
 drivers/i2c/muxes/i2c-mux-pca9541.c        | 36 ++++++++++++++++--------------
 drivers/i2c/muxes/i2c-mux-pca954x.c        | 22 +++++++++++++-----
 drivers/i2c/muxes/i2c-mux-pinctrl.c        | 24 +++++++++++---------
 drivers/i2c/muxes/i2c-mux-reg.c            | 25 ++++++++++++---------
 include/linux/i2c-mux.h                    | 14 +++++++++++-
 8 files changed, 129 insertions(+), 71 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 00fc5b1c7b66..99fd9106abc6 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -31,8 +31,8 @@
 struct i2c_mux_priv {
 	struct i2c_adapter adap;
 	struct i2c_algorithm algo;
+	struct i2c_mux_core *muxc;
 
-	struct i2c_adapter *parent;
 	struct device *mux_dev;
 	void *mux_priv;
 	u32 chan_id;
@@ -45,7 +45,8 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 			       struct i2c_msg msgs[], int num)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
-	struct i2c_adapter *parent = priv->parent;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
 	int ret;
 
 	/* Switch to the right mux port and perform the transfer. */
@@ -65,7 +66,8 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 			      int size, union i2c_smbus_data *data)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
-	struct i2c_adapter *parent = priv->parent;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
 	int ret;
 
 	/* Select the right mux port and perform the transfer. */
@@ -84,7 +86,7 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 static u32 i2c_mux_functionality(struct i2c_adapter *adap)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
-	struct i2c_adapter *parent = priv->parent;
+	struct i2c_adapter *parent = priv->muxc->parent;
 
 	return parent->algo->functionality(parent);
 }
@@ -102,7 +104,27 @@ static unsigned int i2c_mux_parent_classes(struct i2c_adapter *parent)
 	return class;
 }
 
-struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+struct i2c_mux_core *i2c_mux_alloc(struct device *dev, int sizeof_priv)
+{
+	struct i2c_mux_core *muxc;
+
+	muxc = devm_kzalloc(dev, sizeof(*muxc), GFP_KERNEL);
+	if (!muxc)
+		return NULL;
+	if (sizeof_priv) {
+		muxc->priv = devm_kzalloc(dev, sizeof_priv, GFP_KERNEL);
+		if (!muxc->priv)
+			goto fail;
+	}
+	return muxc;
+
+fail:
+	devm_kfree(dev, muxc);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(i2c_mux_alloc);
+
+struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 				struct device *mux_dev,
 				void *mux_priv, u32 force_nr, u32 chan_id,
 				unsigned int class,
@@ -111,6 +133,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 				int (*deselect) (struct i2c_adapter *,
 						 void *, u32))
 {
+	struct i2c_adapter *parent = muxc->parent;
 	struct i2c_mux_priv *priv;
 	char symlink_name[20];
 	int ret;
@@ -120,7 +143,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 		return NULL;
 
 	/* Set up private adapter data */
-	priv->parent = parent;
+	priv->muxc = muxc;
 	priv->mux_dev = mux_dev;
 	priv->mux_priv = mux_priv;
 	priv->chan_id = chan_id;
diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 402e3a6c671a..dd616c0280ad 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -42,7 +42,6 @@
  */
 
 struct i2c_arbitrator_data {
-	struct i2c_adapter *parent;
 	struct i2c_adapter *child;
 	int our_gpio;
 	int our_gpio_release;
@@ -119,6 +118,7 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *parent_np;
+	struct i2c_mux_core *muxc;
 	struct i2c_arbitrator_data *arb;
 	enum of_gpio_flags gpio_flags;
 	unsigned long out_init;
@@ -134,13 +134,14 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	arb = devm_kzalloc(dev, sizeof(*arb), GFP_KERNEL);
-	if (!arb) {
-		dev_err(dev, "Cannot allocate i2c_arbitrator_data\n");
+	muxc = i2c_mux_alloc(dev, sizeof(*arb));
+	if (!muxc) {
+		dev_err(dev, "Cannot allocate i2c_mux_core structure\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, arb);
+	arb = i2c_mux_priv(muxc);
 
+	platform_set_drvdata(pdev, muxc);
 	/* Request GPIOs */
 	ret = of_get_named_gpio_flags(np, "our-claim-gpio", 0, &gpio_flags);
 	if (!gpio_is_valid(ret)) {
@@ -196,21 +197,21 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return -EINVAL;
 	}
-	arb->parent = of_get_i2c_adapter_by_node(parent_np);
+	muxc->parent = of_find_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
-	if (!arb->parent) {
+	if (!muxc->parent) {
 		dev_err(dev, "Cannot find parent bus\n");
 		return -EPROBE_DEFER;
 	}
 
 	/* Actually add the mux adapter */
-	arb->child = i2c_add_mux_adapter(arb->parent, dev, arb, 0, 0, 0,
+	arb->child = i2c_add_mux_adapter(muxc, dev, arb, 0, 0, 0,
 					 i2c_arbitrator_select,
 					 i2c_arbitrator_deselect);
 	if (!arb->child) {
 		dev_err(dev, "Failed to add adapter\n");
 		ret = -ENODEV;
-		i2c_put_adapter(arb->parent);
+		i2c_put_adapter(muxc->parent);
 	}
 
 	return ret;
@@ -218,10 +219,11 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 
 static int i2c_arbitrator_remove(struct platform_device *pdev)
 {
-	struct i2c_arbitrator_data *arb = platform_get_drvdata(pdev);
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct i2c_arbitrator_data *arb = i2c_mux_priv(muxc);
 
 	i2c_del_mux_adapter(arb->child);
-	i2c_put_adapter(arb->parent);
+	i2c_put_adapter(muxc->parent);
 
 	return 0;
 }
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index b8e11c16d98c..3de6dc79c1db 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -18,7 +18,6 @@
 #include <linux/of_gpio.h>
 
 struct gpiomux {
-	struct i2c_adapter *parent;
 	struct i2c_adapter **adap; /* child busses */
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
@@ -136,19 +135,21 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 
 static int i2c_mux_gpio_probe(struct platform_device *pdev)
 {
+	struct i2c_mux_core *muxc;
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
 	int (*deselect) (struct i2c_adapter *, void *, u32);
 	unsigned initial_state, gpio_base;
 	int i, ret;
 
-	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
-	if (!mux) {
-		dev_err(&pdev->dev, "Cannot allocate gpiomux structure");
+	muxc = i2c_mux_alloc(&pdev->dev, sizeof(*mux));
+	if (!muxc) {
+		dev_err(&pdev->dev, "Cannot allocate i2c_mux_core structure\n");
 		return -ENOMEM;
 	}
+	mux = i2c_mux_priv(muxc);
 
-	platform_set_drvdata(pdev, mux);
+	platform_set_drvdata(pdev, muxc);
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		ret = i2c_mux_gpio_probe_dt(mux, pdev);
@@ -180,7 +181,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	if (!parent)
 		return -EPROBE_DEFER;
 
-	mux->parent = parent;
+	muxc->parent = parent;
 	mux->gpio_base = gpio_base;
 
 	mux->adap = devm_kzalloc(&pdev->dev,
@@ -223,7 +224,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		u32 nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
+		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev, mux, nr,
 						   mux->data.values[i], class,
 						   i2c_mux_gpio_select, deselect);
 		if (!mux->adap[i]) {
@@ -253,7 +254,8 @@ alloc_failed:
 
 static int i2c_mux_gpio_remove(struct platform_device *pdev)
 {
-	struct gpiomux *mux = platform_get_drvdata(pdev);
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct gpiomux *mux = i2c_mux_priv(muxc);
 	int i;
 
 	for (i = 0; i < mux->data.n_values; i++)
@@ -262,7 +264,7 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
 	for (i = 0; i < mux->data.n_gpios; i++)
 		gpio_free(mux->gpio_base + mux->data.gpios[i]);
 
-	i2c_put_adapter(mux->parent);
+	i2c_put_adapter(muxc->parent);
 
 	return 0;
 }
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index d0ba424adebc..b2525a772d3b 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -73,6 +73,7 @@
 #define SELECT_DELAY_LONG	1000
 
 struct pca9541 {
+	struct i2c_client *client;
 	struct i2c_adapter *mux_adap;
 	unsigned long select_timeout;
 	unsigned long arb_timeout;
@@ -217,7 +218,8 @@ static const u8 pca9541_control[16] = {
  */
 static int pca9541_arbitrate(struct i2c_client *client)
 {
-	struct pca9541 *data = i2c_get_clientdata(client);
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca9541 *data = i2c_mux_priv(muxc);
 	int reg;
 
 	reg = pca9541_reg_read(client, PCA9541_CONTROL);
@@ -324,20 +326,25 @@ static int pca9541_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
 	int force;
-	int ret = -ENODEV;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto err;
+		return -ENODEV;
 
-	data = kzalloc(sizeof(struct pca9541), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto err;
+	muxc = i2c_mux_alloc(&client->dev, sizeof(*data));
+	if (!muxc) {
+		dev_err(&client->dev,
+			"Cannot allocate i2c_mux_core structure\n");
+		return -ENOMEM;
 	}
+	data = i2c_mux_priv(muxc);
+
+	i2c_set_clientdata(client, muxc);
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
+	muxc->parent = adap;
 
 	/*
 	 * I2C accesses are unprotected here.
@@ -352,34 +359,29 @@ static int pca9541_probe(struct i2c_client *client,
 	force = 0;
 	if (pdata)
 		force = pdata->modes[0].adap_id;
-	data->mux_adap = i2c_add_mux_adapter(adap, &client->dev, client,
+	data->mux_adap = i2c_add_mux_adapter(muxc, &client->dev, client,
 					     force, 0, 0,
 					     pca9541_select_chan,
 					     pca9541_release_chan);
 
 	if (data->mux_adap == NULL) {
 		dev_err(&client->dev, "failed to register master selector\n");
-		goto exit_free;
+		return -ENODEV;
 	}
 
 	dev_info(&client->dev, "registered master selector for I2C %s\n",
 		 client->name);
 
 	return 0;
-
-exit_free:
-	kfree(data);
-err:
-	return ret;
 }
 
 static int pca9541_remove(struct i2c_client *client)
 {
-	struct pca9541 *data = i2c_get_clientdata(client);
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca9541 *data = i2c_mux_priv(muxc);
 
 	i2c_del_mux_adapter(data->mux_adap);
 
-	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index acfcef3d4068..00eda06a667e 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -63,6 +63,7 @@ struct pca954x {
 	struct i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
 
 	u8 last_chan;		/* last register value */
+	struct i2c_client *client;
 };
 
 struct chip_desc {
@@ -191,17 +192,23 @@ static int pca954x_probe(struct i2c_client *client,
 	bool idle_disconnect_dt;
 	struct gpio_desc *gpio;
 	int num, force, class;
+	struct i2c_mux_core *muxc;
 	struct pca954x *data;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
 		return -ENODEV;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct pca954x), GFP_KERNEL);
-	if (!data)
+	muxc = i2c_mux_alloc(&client->dev, sizeof(*data));
+	if (!muxc) {
+		dev_err(&client->dev,
+			"Cannot allocate i2c_mux_core structure\n");
 		return -ENOMEM;
+	}
+	data = i2c_mux_priv(muxc);
 
-	i2c_set_clientdata(client, data);
+	i2c_set_clientdata(client, muxc);
+	data->client = client;
 
 	/* Get the mux out of reset if a reset GPIO is specified. */
 	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
@@ -217,6 +224,7 @@ static int pca954x_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	muxc->parent = adap;
 	data->type = id->driver_data;
 	data->last_chan = 0;		   /* force the first selection */
 
@@ -241,7 +249,7 @@ static int pca954x_probe(struct i2c_client *client,
 		}
 
 		data->virt_adaps[num] =
-			i2c_add_mux_adapter(adap, &client->dev, client,
+			i2c_add_mux_adapter(muxc, &client->dev, client,
 				force, num, class, pca954x_select_chan,
 				(idle_disconnect_pd || idle_disconnect_dt)
 					? pca954x_deselect_mux : NULL);
@@ -270,7 +278,8 @@ virt_reg_failed:
 
 static int pca954x_remove(struct i2c_client *client)
 {
-	struct pca954x *data = i2c_get_clientdata(client);
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca954x *data = i2c_mux_priv(muxc);
 	const struct chip_desc *chip = &chips[data->type];
 	int i;
 
@@ -287,7 +296,8 @@ static int pca954x_remove(struct i2c_client *client)
 static int pca954x_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct pca954x *data = i2c_get_clientdata(client);
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca954x *data = i2c_mux_priv(muxc);
 
 	data->last_chan = 0;
 	return i2c_smbus_write_byte(client, 0);
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index b5a982ba8898..cd3b73e208ce 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -31,7 +31,6 @@ struct i2c_mux_pinctrl {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state **states;
 	struct pinctrl_state *state_idle;
-	struct i2c_adapter *parent;
 	struct i2c_adapter **busses;
 };
 
@@ -131,17 +130,19 @@ static inline int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 
 static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 {
+	struct i2c_mux_core *muxc;
 	struct i2c_mux_pinctrl *mux;
 	int (*deselect)(struct i2c_adapter *, void *, u32);
 	int i, ret;
 
-	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
-	if (!mux) {
-		dev_err(&pdev->dev, "Cannot allocate i2c_mux_pinctrl\n");
+	muxc = i2c_mux_alloc(&pdev->dev, sizeof(*mux));
+	if (!muxc) {
+		dev_err(&pdev->dev, "Cannot allocate i2c_mux_core structure\n");
 		ret = -ENOMEM;
 		goto err;
 	}
-	platform_set_drvdata(pdev, mux);
+	mux = i2c_mux_priv(muxc);
+	platform_set_drvdata(pdev, muxc);
 
 	mux->dev = &pdev->dev;
 
@@ -208,8 +209,8 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		deselect = NULL;
 	}
 
-	mux->parent = i2c_get_adapter(mux->pdata->parent_bus_num);
-	if (!mux->parent) {
+	muxc->parent = i2c_get_adapter(mux->pdata->parent_bus_num);
+	if (!muxc->parent) {
 		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
 			mux->pdata->parent_bus_num);
 		ret = -EPROBE_DEFER;
@@ -220,7 +221,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		u32 bus = mux->pdata->base_bus_num ?
 				(mux->pdata->base_bus_num + i) : 0;
 
-		mux->busses[i] = i2c_add_mux_adapter(mux->parent, &pdev->dev,
+		mux->busses[i] = i2c_add_mux_adapter(muxc, &pdev->dev,
 						     mux, bus, i, 0,
 						     i2c_mux_pinctrl_select,
 						     deselect);
@@ -236,20 +237,21 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 err_del_adapter:
 	for (; i > 0; i--)
 		i2c_del_mux_adapter(mux->busses[i - 1]);
-	i2c_put_adapter(mux->parent);
+	i2c_put_adapter(muxc->parent);
 err:
 	return ret;
 }
 
 static int i2c_mux_pinctrl_remove(struct platform_device *pdev)
 {
-	struct i2c_mux_pinctrl *mux = platform_get_drvdata(pdev);
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct i2c_mux_pinctrl *mux = i2c_mux_priv(muxc);
 	int i;
 
 	for (i = 0; i < mux->pdata->bus_count; i++)
 		i2c_del_mux_adapter(mux->busses[i]);
 
-	i2c_put_adapter(mux->parent);
+	i2c_put_adapter(muxc->parent);
 
 	return 0;
 }
diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 5fbd5bd0878f..76244aca154e 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 
 struct regmux {
-	struct i2c_adapter *parent;
 	struct i2c_adapter **adap; /* child busses */
 	struct i2c_mux_reg_platform_data data;
 };
@@ -87,6 +86,7 @@ static int i2c_mux_reg_deselect(struct i2c_adapter *adap, void *data,
 static int i2c_mux_reg_probe_dt(struct regmux *mux,
 					struct platform_device *pdev)
 {
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *adapter_np, *child;
 	struct i2c_adapter *adapter;
@@ -107,7 +107,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 	if (!adapter)
 		return -EPROBE_DEFER;
 
-	mux->parent = adapter;
+	muxc->parent = adapter;
 	mux->data.parent = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
 
@@ -169,6 +169,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 
 static int i2c_mux_reg_probe(struct platform_device *pdev)
 {
+	struct i2c_mux_core *muxc;
 	struct regmux *mux;
 	struct i2c_adapter *parent;
 	struct resource *res;
@@ -176,11 +177,14 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 	unsigned int class;
 	int i, ret, nr;
 
-	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
-	if (!mux)
+	muxc = i2c_mux_alloc(&pdev->dev, sizeof(*mux));
+	if (!muxc) {
+		dev_err(&pdev->dev, "Cannot allocate i2c_mux_core structure\n");
 		return -ENOMEM;
+	}
+	mux = i2c_mux_priv(muxc);
 
-	platform_set_drvdata(pdev, mux);
+	platform_set_drvdata(pdev, muxc);
 
 	if (dev_get_platdata(&pdev->dev)) {
 		memcpy(&mux->data, dev_get_platdata(&pdev->dev),
@@ -190,7 +194,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		if (!parent)
 			return -EPROBE_DEFER;
 
-		mux->parent = parent;
+		muxc->parent = parent;
 	} else {
 		ret = i2c_mux_reg_probe_dt(mux, pdev);
 		if (ret < 0) {
@@ -232,7 +236,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(mux->parent, &pdev->dev, mux,
+		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev, mux,
 						   nr, mux->data.values[i],
 						   class, i2c_mux_reg_select,
 						   deselect);
@@ -244,7 +248,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "%d port mux on %s adapter\n",
-		 mux->data.n_values, mux->parent->name);
+		 mux->data.n_values, muxc->parent->name);
 
 	return 0;
 
@@ -257,13 +261,14 @@ add_adapter_failed:
 
 static int i2c_mux_reg_remove(struct platform_device *pdev)
 {
-	struct regmux *mux = platform_get_drvdata(pdev);
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct regmux *mux = i2c_mux_priv(muxc);
 	int i;
 
 	for (i = 0; i < mux->data.n_values; i++)
 		i2c_del_mux_adapter(mux->adap[i]);
 
-	i2c_put_adapter(mux->parent);
+	i2c_put_adapter(muxc->parent);
 
 	return 0;
 }
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index b5f9a007a3ab..3ca1783b86ac 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -27,13 +27,25 @@
 
 #ifdef __KERNEL__
 
+struct i2c_mux_core {
+	struct i2c_adapter *parent;
+	void *priv;
+};
+
+struct i2c_mux_core *i2c_mux_alloc(struct device *dev, int sizeof_priv);
+
+static inline void *i2c_mux_priv(struct i2c_mux_core *muxc)
+{
+	return muxc->priv;
+}
+
 /*
  * Called to create a i2c bus on a multiplexed bus segment.
  * The mux_dev and chan_id parameters are passed to the select
  * and deselect callback functions to perform hardware-specific
  * mux control.
  */
-struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 				struct device *mux_dev,
 				void *mux_priv, u32 force_nr, u32 chan_id,
 				unsigned int class,
-- 
2.1.4
