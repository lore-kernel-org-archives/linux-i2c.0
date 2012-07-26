From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-mux-gpio: Add support for dynamically allocated GPIO
 pins
Date: Thu, 26 Jul 2012 21:52:47 +0200
Message-ID: <20120726215247.678b0456@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-mux-gpio: Add support for dynamically allocated GPIO pins

The code instantiating an i2c-mux-gpio platform device doesn't
necessarily know in advance the GPIO pin numbers it wants to use. If
pins are on a GPIO device which gets its base GPIO number assigned
dynamically at run-time, the values can't be hard-coded.

In that case, let the caller tell i2c-mux-gpio the name of the GPIO
chip and the (relative) GPIO pin numbers to use. At probe time, the
i2c-mux-gpio driver will look for the chip and apply the proper offset
to turn relative GPIO pin numbers to absolute GPIO pin numbers.

The same could be done on the caller's end directly, however doing it
in i2c-mux-gpio has two benefits:
* It avoids duplicating the code on every caller's side (about 30
  lines of code.)
* It allows for deferred probing for the muxed part of the I2C bus
  only. If finding the GPIO chip is the caller's responsibility, then
  deferred probing (if the GPIO chip isn't there yet) will not only
  affect the mux and the I2C bus segments behind it, but also the I2C
  bus trunk.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
---
Unfortunately this is not compatible with my idea of letting the
caller set the platform device ID based on one GPIO pin numbers, as
these numbers are no longer known in advance :(

 drivers/i2c/muxes/i2c-mux-gpio.c |   38 ++++++++++++++++++++++++++++++++------
 include/linux/i2c-mux-gpio.h     |    3 +++
 2 files changed, 35 insertions(+), 6 deletions(-)

--- linux-3.5.orig/drivers/i2c/muxes/i2c-mux-gpio.c	2012-07-26 21:29:52.290209307 +0200
+++ linux-3.5/drivers/i2c/muxes/i2c-mux-gpio.c	2012-07-26 21:31:08.865648994 +0200
@@ -21,6 +21,7 @@ struct gpiomux {
 	struct i2c_adapter *parent;
 	struct i2c_adapter **adap; /* child busses */
 	struct i2c_mux_gpio_platform_data data;
+	unsigned gpio_base;
 };
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
@@ -28,7 +29,8 @@ static void i2c_mux_gpio_set(const struc
 	int i;
 
 	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_set_value(mux->data.gpios[i], val & (1 << i));
+		gpio_set_value(mux->gpio_base + mux->data.gpios[i],
+			       val & (1 << i));
 }
 
 static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
@@ -49,13 +51,19 @@ static int i2c_mux_gpio_deselect(struct
 	return 0;
 }
 
+static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
+					      void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
 static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct gpiomux *mux;
 	struct i2c_mux_gpio_platform_data *pdata;
 	struct i2c_adapter *parent;
 	int (*deselect) (struct i2c_adapter *, void *, u32);
-	unsigned initial_state;
+	unsigned initial_state, gpio_base;
 	int i, ret;
 
 	pdata = pdev->dev.platform_data;
@@ -64,6 +72,23 @@ static int __devinit i2c_mux_gpio_probe(
 		return -ENODEV;
 	}
 
+	/*
+	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
+	 * relative to its base GPIO number. Otherwise they are absolute.
+	 */
+	if (pdata->gpio_chip) {
+		struct gpio_chip *gpio;
+
+		gpio = gpiochip_find(pdata->gpio_chip,
+				     match_gpio_chip_by_label);
+		if (!gpio)
+			return -EPROBE_DEFER;
+
+		gpio_base = gpio->base;
+	} else {
+		gpio_base = 0;
+	}
+
 	parent = i2c_get_adapter(pdata->parent);
 	if (!parent) {
 		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
@@ -79,6 +104,7 @@ static int __devinit i2c_mux_gpio_probe(
 
 	mux->parent = parent;
 	mux->data = *pdata;
+	mux->gpio_base = gpio_base;
 	mux->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->n_values,
 			    GFP_KERNEL);
 	if (!mux->adap) {
@@ -95,10 +121,10 @@ static int __devinit i2c_mux_gpio_probe(
 	}
 
 	for (i = 0; i < pdata->n_gpios; i++) {
-		ret = gpio_request(pdata->gpios[i], "i2c-mux-gpio");
+		ret = gpio_request(gpio_base + pdata->gpios[i], "i2c-mux-gpio");
 		if (ret)
 			goto err_request_gpio;
-		gpio_direction_output(pdata->gpios[i],
+		gpio_direction_output(gpio_base + pdata->gpios[i],
 				      initial_state & (1 << i));
 	}
 
@@ -129,7 +155,7 @@ add_adapter_failed:
 	i = pdata->n_gpios;
 err_request_gpio:
 	for (; i > 0; i--)
-		gpio_free(pdata->gpios[i - 1]);
+		gpio_free(gpio_base + pdata->gpios[i - 1]);
 	kfree(mux->adap);
 alloc_failed2:
 	kfree(mux);
@@ -148,7 +174,7 @@ static int __devexit i2c_mux_gpio_remove
 		i2c_del_mux_adapter(mux->adap[i]);
 
 	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_free(mux->data.gpios[i]);
+		gpio_free(mux->gpio_base + mux->data.gpios[i]);
 
 	platform_set_drvdata(pdev, NULL);
 	i2c_put_adapter(mux->parent);
--- linux-3.5.orig/include/linux/i2c-mux-gpio.h	2012-07-26 21:29:52.291209307 +0200
+++ linux-3.5/include/linux/i2c-mux-gpio.h	2012-07-26 21:31:08.866648994 +0200
@@ -22,6 +22,8 @@
  *	position
  * @n_values: Number of multiplexer positions (busses to instantiate)
  * @classes: Optional I2C auto-detection classes
+ * @gpio_chip: Optional GPIO chip name; if set, GPIO pin numbers are given
+ *	relative to the base GPIO number of that chip
  * @gpios: Array of GPIO numbers used to control MUX
  * @n_gpios: Number of GPIOs used to control MUX
  * @idle: Bitmask to write to MUX when idle or GPIO_I2CMUX_NO_IDLE if not used
@@ -32,6 +34,7 @@ struct i2c_mux_gpio_platform_data {
 	const unsigned *values;
 	int n_values;
 	const unsigned *classes;
+	char *gpio_chip;
 	const unsigned *gpios;
 	int n_gpios;
 	unsigned idle;


-- 
Jean Delvare
