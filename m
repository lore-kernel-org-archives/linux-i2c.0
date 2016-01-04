From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 02/10] i2c-mux: move select and deselect ops to i2c_mux_core
Date: Mon,  4 Jan 2016 16:10:07 +0100
Message-ID: <1451920215-29167-3-git-send-email-peda@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

The mux select and deselect ops are common to the mux most of the time,
so store the ops in the mux core.

Change the select and deselect op to work in terms of the mux core instead
of the child adapter. No driver uses the child adapter anyway, and if it
is needed in a future mux driver it can be worked out from the channel id.

i2c-arb-gpio-challenge is special in that it needs the mux device pointer
in the select op, so store that device pointer in the mux core as well.
This pointer is going to get further use in later commits.

i2c-mux-pca954x is special since it does not add its deselect op to all
its child adapters, handle this by adding a mask that makes the deselect
op a no-operation for child adapters not wishing to deselect the mux.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c                      | 31 ++++++++++--------------------
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 18 ++++++++---------
 drivers/i2c/muxes/i2c-mux-gpio.c           | 19 +++++++++---------
 drivers/i2c/muxes/i2c-mux-pca9541.c        | 18 +++++++++--------
 drivers/i2c/muxes/i2c-mux-pca954x.c        | 30 +++++++++++++++++------------
 drivers/i2c/muxes/i2c-mux-pinctrl.c        | 20 ++++++++-----------
 drivers/i2c/muxes/i2c-mux-reg.c            | 21 +++++++++-----------
 include/linux/i2c-mux.h                    | 15 ++++++++-------
 8 files changed, 81 insertions(+), 91 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 99fd9106abc6..00ffbdba2cf8 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -32,13 +32,8 @@ struct i2c_mux_priv {
 	struct i2c_adapter adap;
 	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
-
 	struct device *mux_dev;
-	void *mux_priv;
 	u32 chan_id;
-
-	int (*select)(struct i2c_adapter *, void *mux_priv, u32 chan_id);
-	int (*deselect)(struct i2c_adapter *, void *mux_priv, u32 chan_id);
 };
 
 static int i2c_mux_master_xfer(struct i2c_adapter *adap,
@@ -51,11 +46,11 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = priv->select(parent, priv->mux_priv, priv->chan_id);
+	ret = muxc->select(muxc, priv->chan_id);
 	if (ret >= 0)
 		ret = __i2c_transfer(parent, msgs, num);
-	if (priv->deselect)
-		priv->deselect(parent, priv->mux_priv, priv->chan_id);
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
 
 	return ret;
 }
@@ -72,12 +67,12 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = priv->select(parent, priv->mux_priv, priv->chan_id);
+	ret = muxc->select(muxc, priv->chan_id);
 	if (ret >= 0)
 		ret = parent->algo->smbus_xfer(parent, addr, flags,
 					read_write, command, size, data);
-	if (priv->deselect)
-		priv->deselect(parent, priv->mux_priv, priv->chan_id);
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
 
 	return ret;
 }
@@ -116,6 +111,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct device *dev, int sizeof_priv)
 		if (!muxc->priv)
 			goto fail;
 	}
+	muxc->dev = dev;
 	return muxc;
 
 fail:
@@ -125,13 +121,9 @@ fail:
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
 
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
-				struct device *mux_dev,
-				void *mux_priv, u32 force_nr, u32 chan_id,
-				unsigned int class,
-				int (*select) (struct i2c_adapter *,
-					       void *, u32),
-				int (*deselect) (struct i2c_adapter *,
-						 void *, u32))
+					struct device *mux_dev,
+					u32 force_nr, u32 chan_id,
+					unsigned int class)
 {
 	struct i2c_adapter *parent = muxc->parent;
 	struct i2c_mux_priv *priv;
@@ -145,10 +137,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 	/* Set up private adapter data */
 	priv->muxc = muxc;
 	priv->mux_dev = mux_dev;
-	priv->mux_priv = mux_priv;
 	priv->chan_id = chan_id;
-	priv->select = select;
-	priv->deselect = deselect;
 
 	/* Need to do algo dynamically because we don't know ahead
 	 * of time what sort of physical adapter we'll be dealing with.
diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index dd616c0280ad..1c4741cf290f 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -58,9 +58,9 @@ struct i2c_arbitrator_data {
  *
  * Use the GPIO-based signalling protocol; return -EBUSY if we fail.
  */
-static int i2c_arbitrator_select(struct i2c_adapter *adap, void *data, u32 chan)
+static int i2c_arbitrator_select(struct i2c_mux_core *muxc, u32 chan)
 {
-	const struct i2c_arbitrator_data *arb = data;
+	const struct i2c_arbitrator_data *arb = i2c_mux_priv(muxc);
 	unsigned long stop_retry, stop_time;
 
 	/* Start a round of trying to claim the bus */
@@ -92,7 +92,7 @@ static int i2c_arbitrator_select(struct i2c_adapter *adap, void *data, u32 chan)
 	/* Give up, release our claim */
 	gpio_set_value(arb->our_gpio, arb->our_gpio_release);
 	udelay(arb->slew_delay_us);
-	dev_err(&adap->dev, "Could not claim bus, timeout\n");
+	dev_err(muxc->dev, "Could not claim bus, timeout\n");
 	return -EBUSY;
 }
 
@@ -101,10 +101,9 @@ static int i2c_arbitrator_select(struct i2c_adapter *adap, void *data, u32 chan)
  *
  * Release the I2C bus using the GPIO-based signalling protocol.
  */
-static int i2c_arbitrator_deselect(struct i2c_adapter *adap, void *data,
-				   u32 chan)
+static int i2c_arbitrator_deselect(struct i2c_mux_core *muxc, u32 chan)
 {
-	const struct i2c_arbitrator_data *arb = data;
+	const struct i2c_arbitrator_data *arb = i2c_mux_priv(muxc);
 
 	/* Release the bus and wait for the other master to notice */
 	gpio_set_value(arb->our_gpio, arb->our_gpio_release);
@@ -142,6 +141,9 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 	arb = i2c_mux_priv(muxc);
 
 	platform_set_drvdata(pdev, muxc);
+
+	muxc->select = i2c_arbitrator_select,
+	muxc->deselect = i2c_arbitrator_deselect;
 	/* Request GPIOs */
 	ret = of_get_named_gpio_flags(np, "our-claim-gpio", 0, &gpio_flags);
 	if (!gpio_is_valid(ret)) {
@@ -205,9 +207,7 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 	}
 
 	/* Actually add the mux adapter */
-	arb->child = i2c_add_mux_adapter(muxc, dev, arb, 0, 0, 0,
-					 i2c_arbitrator_select,
-					 i2c_arbitrator_deselect);
+	arb->child = i2c_add_mux_adapter(muxc, dev, 0, 0, 0);
 	if (!arb->child) {
 		dev_err(dev, "Failed to add adapter\n");
 		ret = -ENODEV;
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 3de6dc79c1db..bd000406e160 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -32,18 +32,18 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 					val & (1 << i));
 }
 
-static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
+static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct gpiomux *mux = data;
+	struct gpiomux *mux = i2c_mux_priv(muxc);
 
 	i2c_mux_gpio_set(mux, chan);
 
 	return 0;
 }
 
-static int i2c_mux_gpio_deselect(struct i2c_adapter *adap, void *data, u32 chan)
+static int i2c_mux_gpio_deselect(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct gpiomux *mux = data;
+	struct gpiomux *mux = i2c_mux_priv(muxc);
 
 	i2c_mux_gpio_set(mux, mux->data.idle);
 
@@ -138,7 +138,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	struct i2c_mux_core *muxc;
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
-	int (*deselect) (struct i2c_adapter *, void *, u32);
 	unsigned initial_state, gpio_base;
 	int i, ret;
 
@@ -182,6 +181,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 
 	muxc->parent = parent;
+	muxc->select = i2c_mux_gpio_select;
 	mux->gpio_base = gpio_base;
 
 	mux->adap = devm_kzalloc(&pdev->dev,
@@ -195,10 +195,10 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
 		initial_state = mux->data.idle;
-		deselect = i2c_mux_gpio_deselect;
+		muxc->deselect = i2c_mux_gpio_deselect;
 	} else {
 		initial_state = mux->data.values[0];
-		deselect = NULL;
+		muxc->deselect = NULL;
 	}
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
@@ -224,9 +224,8 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		u32 nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev, mux, nr,
-						   mux->data.values[i], class,
-						   i2c_mux_gpio_select, deselect);
+		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev, nr,
+						   mux->data.values[i], class);
 		if (!mux->adap[i]) {
 			ret = -ENODEV;
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index b2525a772d3b..178c22981636 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -287,9 +287,10 @@ static int pca9541_arbitrate(struct i2c_client *client)
 	return 0;
 }
 
-static int pca9541_select_chan(struct i2c_adapter *adap, void *client, u32 chan)
+static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct pca9541 *data = i2c_get_clientdata(client);
+	struct pca9541 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
 	int ret;
 	unsigned long timeout = jiffies + ARB2_TIMEOUT;
 		/* give up after this time */
@@ -311,9 +312,11 @@ static int pca9541_select_chan(struct i2c_adapter *adap, void *client, u32 chan)
 	return -ETIMEDOUT;
 }
 
-static int pca9541_release_chan(struct i2c_adapter *adap,
-				void *client, u32 chan)
+static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
 {
+	struct pca9541 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+
 	pca9541_release_bus(client);
 	return 0;
 }
@@ -345,6 +348,8 @@ static int pca9541_probe(struct i2c_client *client,
 
 	data->client = client;
 	muxc->parent = adap;
+	muxc->select = pca9541_select_chan;
+	muxc->deselect = pca9541_release_chan;
 
 	/*
 	 * I2C accesses are unprotected here.
@@ -359,10 +364,7 @@ static int pca9541_probe(struct i2c_client *client,
 	force = 0;
 	if (pdata)
 		force = pdata->modes[0].adap_id;
-	data->mux_adap = i2c_add_mux_adapter(muxc, &client->dev, client,
-					     force, 0, 0,
-					     pca9541_select_chan,
-					     pca9541_release_chan);
+	data->mux_adap = i2c_add_mux_adapter(muxc, &client->dev, force, 0, 0);
 
 	if (data->mux_adap == NULL) {
 		dev_err(&client->dev, "failed to register master selector\n");
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 00eda06a667e..edc6693ffea9 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -63,6 +63,7 @@ struct pca954x {
 	struct i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
 
 	u8 last_chan;		/* last register value */
+	u8 deselect;
 	struct i2c_client *client;
 };
 
@@ -147,10 +148,10 @@ static int pca954x_reg_write(struct i2c_adapter *adap,
 	return ret;
 }
 
-static int pca954x_select_chan(struct i2c_adapter *adap,
-			       void *client, u32 chan)
+static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct pca954x *data = i2c_get_clientdata(client);
+	struct pca954x *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
 	const struct chip_desc *chip = &chips[data->type];
 	u8 regval;
 	int ret = 0;
@@ -163,21 +164,24 @@ static int pca954x_select_chan(struct i2c_adapter *adap,
 
 	/* Only select the channel if its different from the last channel */
 	if (data->last_chan != regval) {
-		ret = pca954x_reg_write(adap, client, regval);
+		ret = pca954x_reg_write(muxc->parent, client, regval);
 		data->last_chan = regval;
 	}
 
 	return ret;
 }
 
-static int pca954x_deselect_mux(struct i2c_adapter *adap,
-				void *client, u32 chan)
+static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct pca954x *data = i2c_get_clientdata(client);
+	struct pca954x *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+
+	if (!(data->deselect & (1 << chan)))
+		return 0;
 
 	/* Deselect active channel */
 	data->last_chan = 0;
-	return pca954x_reg_write(adap, client, data->last_chan);
+	return pca954x_reg_write(muxc->parent, client, data->last_chan);
 }
 
 /*
@@ -225,6 +229,8 @@ static int pca954x_probe(struct i2c_client *client,
 	}
 
 	muxc->parent = adap;
+	muxc->select = pca954x_select_chan;
+	muxc->deselect = pca954x_deselect_mux;
 	data->type = id->driver_data;
 	data->last_chan = 0;		   /* force the first selection */
 
@@ -246,13 +252,13 @@ static int pca954x_probe(struct i2c_client *client,
 				/* discard unconfigured channels */
 				break;
 			idle_disconnect_pd = pdata->modes[num].deselect_on_exit;
+			data->deselect |= (idle_disconnect_pd
+					   || idle_disconnect_dt) << num;
 		}
 
 		data->virt_adaps[num] =
-			i2c_add_mux_adapter(muxc, &client->dev, client,
-				force, num, class, pca954x_select_chan,
-				(idle_disconnect_pd || idle_disconnect_dt)
-					? pca954x_deselect_mux : NULL);
+			i2c_add_mux_adapter(muxc, &client->dev,
+					    force, num, class);
 
 		if (data->virt_adaps[num] == NULL) {
 			ret = -ENODEV;
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index cd3b73e208ce..79bd1ea75444 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -34,18 +34,16 @@ struct i2c_mux_pinctrl {
 	struct i2c_adapter **busses;
 };
 
-static int i2c_mux_pinctrl_select(struct i2c_adapter *adap, void *data,
-				  u32 chan)
+static int i2c_mux_pinctrl_select(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct i2c_mux_pinctrl *mux = data;
+	struct i2c_mux_pinctrl *mux = i2c_mux_priv(muxc);
 
 	return pinctrl_select_state(mux->pinctrl, mux->states[chan]);
 }
 
-static int i2c_mux_pinctrl_deselect(struct i2c_adapter *adap, void *data,
-				    u32 chan)
+static int i2c_mux_pinctrl_deselect(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct i2c_mux_pinctrl *mux = data;
+	struct i2c_mux_pinctrl *mux = i2c_mux_priv(muxc);
 
 	return pinctrl_select_state(mux->pinctrl, mux->state_idle);
 }
@@ -132,7 +130,6 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc;
 	struct i2c_mux_pinctrl *mux;
-	int (*deselect)(struct i2c_adapter *, void *, u32);
 	int i, ret;
 
 	muxc = i2c_mux_alloc(&pdev->dev, sizeof(*mux));
@@ -204,10 +201,11 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 			goto err;
 		}
 
-		deselect = i2c_mux_pinctrl_deselect;
+		muxc->deselect = i2c_mux_pinctrl_deselect;
 	} else {
-		deselect = NULL;
+		muxc->deselect = NULL;
 	}
+	muxc->select = i2c_mux_pinctrl_select;
 
 	muxc->parent = i2c_get_adapter(mux->pdata->parent_bus_num);
 	if (!muxc->parent) {
@@ -222,9 +220,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 				(mux->pdata->base_bus_num + i) : 0;
 
 		mux->busses[i] = i2c_add_mux_adapter(muxc, &pdev->dev,
-						     mux, bus, i, 0,
-						     i2c_mux_pinctrl_select,
-						     deselect);
+						     bus, i, 0);
 		if (!mux->busses[i]) {
 			ret = -ENODEV;
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 76244aca154e..d85879c46d90 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -63,18 +63,16 @@ static int i2c_mux_reg_set(const struct regmux *mux, unsigned int chan_id)
 	return 0;
 }
 
-static int i2c_mux_reg_select(struct i2c_adapter *adap, void *data,
-			      unsigned int chan)
+static int i2c_mux_reg_select(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct regmux *mux = data;
+	struct regmux *mux = i2c_mux_priv(muxc);
 
 	return i2c_mux_reg_set(mux, chan);
 }
 
-static int i2c_mux_reg_deselect(struct i2c_adapter *adap, void *data,
-				unsigned int chan)
+static int i2c_mux_reg_deselect(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct regmux *mux = data;
+	struct regmux *mux = i2c_mux_priv(muxc);
 
 	if (mux->data.idle_in_use)
 		return i2c_mux_reg_set(mux, mux->data.idle);
@@ -173,7 +171,6 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 	struct regmux *mux;
 	struct i2c_adapter *parent;
 	struct resource *res;
-	int (*deselect)(struct i2c_adapter *, void *, u32);
 	unsigned int class;
 	int i, ret, nr;
 
@@ -227,19 +224,19 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	muxc->select = i2c_mux_reg_select;
 	if (mux->data.idle_in_use)
-		deselect = i2c_mux_reg_deselect;
+		muxc->deselect = i2c_mux_reg_deselect;
 	else
-		deselect = NULL;
+		muxc->deselect = NULL;
 
 	for (i = 0; i < mux->data.n_values; i++) {
 		nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
 		class = mux->data.classes ? mux->data.classes[i] : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev, mux,
+		mux->adap[i] = i2c_add_mux_adapter(muxc, &pdev->dev,
 						   nr, mux->data.values[i],
-						   class, i2c_mux_reg_select,
-						   deselect);
+						   class);
 		if (!mux->adap[i]) {
 			ret = -ENODEV;
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index 3ca1783b86ac..5cd6e1e664e0 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -29,7 +29,12 @@
 
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
+	struct device *dev;
+
 	void *priv;
+
+	int (*select)(struct i2c_mux_core *, u32 chan_id);
+	int (*deselect)(struct i2c_mux_core *, u32 chan_id);
 };
 
 struct i2c_mux_core *i2c_mux_alloc(struct device *dev, int sizeof_priv);
@@ -46,13 +51,9 @@ static inline void *i2c_mux_priv(struct i2c_mux_core *muxc)
  * mux control.
  */
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
-				struct device *mux_dev,
-				void *mux_priv, u32 force_nr, u32 chan_id,
-				unsigned int class,
-				int (*select) (struct i2c_adapter *,
-					       void *mux_dev, u32 chan_id),
-				int (*deselect) (struct i2c_adapter *,
-						 void *mux_dev, u32 chan_id));
+					struct device *mux_dev,
+					u32 force_nr, u32 chan_id,
+					unsigned int class);
 
 void i2c_del_mux_adapter(struct i2c_adapter *adap);
 
-- 
2.1.4
