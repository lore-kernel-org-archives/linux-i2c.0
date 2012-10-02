From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c-i801: Let i2c-mux-gpio find the GPIO chip
Date: Tue, 2 Oct 2012 22:54:00 +0200
Message-ID: <20121002225400.12267d00@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Now that i2c-mux-gpio is able to find the GPIO chip by itself, we can
delegate this task. The great thing here is that i2c-mux-gpio can
defer device probing until the gpio chip is available, so we no longer
depend on the module loading order.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

--- linux-3.6-rc5.orig/drivers/i2c/busses/i2c-i801.c	2012-09-13 18:18:02.884008189 +0200
+++ linux-3.6-rc5/drivers/i2c/busses/i2c-i801.c	2012-09-13 18:18:12.031009849 +0200
@@ -194,7 +194,6 @@ struct i801_priv {
 
 #if defined CONFIG_I2C_MUX || defined CONFIG_I2C_MUX_MODULE
 	const struct i801_mux_config *mux_drvdata;
-	unsigned mux_priv[2];
 	struct platform_device *mux_pdev;
 #endif
 };
@@ -1008,60 +1007,32 @@ static struct dmi_system_id __devinitdat
 	{ }
 };
 
-static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
-					      void *data)
-{
-	return !strcmp(chip->label, data);
-}
-
 /* Setup multiplexing if needed */
 static int __devinit i801_add_mux(struct i801_priv *priv)
 {
 	struct device *dev = &priv->adapter.dev;
 	const struct i801_mux_config *mux_config;
-	struct gpio_chip *gpio;
 	struct i2c_mux_gpio_platform_data gpio_data;
-	int i, err;
+	int err;
 
 	if (!priv->mux_drvdata)
 		return 0;
 	mux_config = priv->mux_drvdata;
 
-	/* Find GPIO chip */
-	gpio = gpiochip_find(mux_config->gpio_chip, match_gpio_chip_by_label);
-	if (gpio) {
-		dev_info(dev,
-			 "GPIO chip %s found, SMBus multiplexing enabled\n",
-			 mux_config->gpio_chip);
-	} else {
-		dev_err(dev,
-			"GPIO chip %s not found, SMBus multiplexing disabled\n",
-			mux_config->gpio_chip);
-		return -ENODEV;
-	}
-
-	/* Find absolute GPIO pin numbers */
-	if (ARRAY_SIZE(priv->mux_priv) < mux_config->n_gpios) {
-		dev_err(dev, "i801_priv.mux_priv too small (%zu, need %d)\n",
-			ARRAY_SIZE(priv->mux_priv), mux_config->n_gpios);
-		return -ENODEV;
-	}
-	for (i = 0; i < mux_config->n_gpios; i++)
-		priv->mux_priv[i] = gpio->base + mux_config->gpios[i];
-
 	/* Prepare the platform data */
 	memset(&gpio_data, 0, sizeof(struct i2c_mux_gpio_platform_data));
 	gpio_data.parent = priv->adapter.nr;
 	gpio_data.values = mux_config->values;
 	gpio_data.n_values = mux_config->n_values;
 	gpio_data.classes = mux_config->classes;
-	gpio_data.gpios = priv->mux_priv;
+	gpio_data.gpio_chip = mux_config->gpio_chip;
+	gpio_data.gpios = mux_config->gpios;
 	gpio_data.n_gpios = mux_config->n_gpios;
 	gpio_data.idle = I2C_MUX_GPIO_NO_IDLE;
 
 	/* Register the mux device */
 	priv->mux_pdev = platform_device_register_data(dev, "i2c-mux-gpio",
-				priv->mux_priv[0], &gpio_data,
+				PLATFORM_DEVID_AUTO, &gpio_data,
 				sizeof(struct i2c_mux_gpio_platform_data));
 	if (IS_ERR(priv->mux_pdev)) {
 		err = PTR_ERR(priv->mux_pdev);


-- 
Jean Delvare
