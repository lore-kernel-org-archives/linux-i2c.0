From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c-mux-gpio: Rename platform data structure
Date: Sat, 28 Apr 2012 15:35:51 +0200
Message-ID: <20120428153551.64d4d200@endymion.delvare>
References: <20120428153206.00c1e226@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120428153206.00c1e226-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Align the name of i2c-mux-gpio's data structure on the new driver name.
Also change one define and adjust function names, even if they aren't
part of the public interface, for consistency.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
I made this a separate patch for easier testing/review/bisection.
Wolfram, feel free to merge into the first patch if you prefer a
single patch.

 drivers/i2c/muxes/i2c-mux-gpio.c |   33 +++++++++++++++++----------------
 include/linux/i2c-mux-gpio.h     |    6 +++---
 2 files changed, 20 insertions(+), 19 deletions(-)

--- linux-3.4-rc3.orig/drivers/i2c/muxes/i2c-mux-gpio.c	2012-04-27 16:23:49.000000000 +0200
+++ linux-3.4-rc3/drivers/i2c/muxes/i2c-mux-gpio.c	2012-04-27 16:33:48.511263516 +0200
@@ -20,10 +20,10 @@
 struct gpiomux {
 	struct i2c_adapter *parent;
 	struct i2c_adapter **adap; /* child busses */
-	struct gpio_i2cmux_platform_data data;
+	struct i2c_mux_gpio_platform_data data;
 };
 
-static void gpiomux_set(const struct gpiomux *mux, unsigned val)
+static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
 	int i;
 
@@ -31,28 +31,28 @@ static void gpiomux_set(const struct gpi
 		gpio_set_value(mux->data.gpios[i], val & (1 << i));
 }
 
-static int gpiomux_select(struct i2c_adapter *adap, void *data, u32 chan)
+static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
 {
 	struct gpiomux *mux = data;
 
-	gpiomux_set(mux, mux->data.values[chan]);
+	i2c_mux_gpio_set(mux, mux->data.values[chan]);
 
 	return 0;
 }
 
-static int gpiomux_deselect(struct i2c_adapter *adap, void *data, u32 chan)
+static int i2c_mux_gpio_deselect(struct i2c_adapter *adap, void *data, u32 chan)
 {
 	struct gpiomux *mux = data;
 
-	gpiomux_set(mux, mux->data.idle);
+	i2c_mux_gpio_set(mux, mux->data.idle);
 
 	return 0;
 }
 
-static int __devinit gpiomux_probe(struct platform_device *pdev)
+static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct gpiomux *mux;
-	struct gpio_i2cmux_platform_data *pdata;
+	struct i2c_mux_gpio_platform_data *pdata;
 	struct i2c_adapter *parent;
 	int (*deselect) (struct i2c_adapter *, void *, u32);
 	unsigned initial_state;
@@ -86,9 +86,9 @@ static int __devinit gpiomux_probe(struc
 		goto alloc_failed2;
 	}
 
-	if (pdata->idle != GPIO_I2CMUX_NO_IDLE) {
+	if (pdata->idle != I2C_MUX_GPIO_NO_IDLE) {
 		initial_state = pdata->idle;
-		deselect = gpiomux_deselect;
+		deselect = i2c_mux_gpio_deselect;
 	} else {
 		initial_state = pdata->values[0];
 		deselect = NULL;
@@ -106,7 +106,8 @@ static int __devinit gpiomux_probe(struc
 		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
 
 		mux->adap[i] = i2c_add_mux_adapter(parent, mux, nr, i,
-						   gpiomux_select, deselect);
+						   i2c_mux_gpio_select,
+						   deselect);
 		if (!mux->adap[i]) {
 			ret = -ENODEV;
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
@@ -137,7 +138,7 @@ alloc_failed:
 	return ret;
 }
 
-static int __devexit gpiomux_remove(struct platform_device *pdev)
+static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
 {
 	struct gpiomux *mux = platform_get_drvdata(pdev);
 	int i;
@@ -156,16 +157,16 @@ static int __devexit gpiomux_remove(stru
 	return 0;
 }
 
-static struct platform_driver gpiomux_driver = {
-	.probe	= gpiomux_probe,
-	.remove	= __devexit_p(gpiomux_remove),
+static struct platform_driver i2c_mux_gpio_driver = {
+	.probe	= i2c_mux_gpio_probe,
+	.remove	= __devexit_p(i2c_mux_gpio_remove),
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-mux-gpio",
 	},
 };
 
-module_platform_driver(gpiomux_driver);
+module_platform_driver(i2c_mux_gpio_driver);
 
 MODULE_DESCRIPTION("GPIO-based I2C multiplexer driver");
 MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
--- linux-3.4-rc3.orig/include/linux/i2c-mux-gpio.h	2012-04-27 16:24:39.000000000 +0200
+++ linux-3.4-rc3/include/linux/i2c-mux-gpio.h	2012-04-27 16:29:40.649551160 +0200
@@ -12,10 +12,10 @@
 #define _LINUX_I2C_MUX_GPIO_H
 
 /* MUX has no specific idle mode */
-#define GPIO_I2CMUX_NO_IDLE	((unsigned)-1)
+#define I2C_MUX_GPIO_NO_IDLE	((unsigned)-1)
 
 /**
- * struct gpio_i2cmux_platform_data - Platform-dependent data for i2c-mux-gpio
+ * struct i2c_mux_gpio_platform_data - Platform-dependent data for i2c-mux-gpio
  * @parent: Parent I2C bus adapter number
  * @base_nr: Base I2C bus number to number adapters from or zero for dynamic
  * @values: Array of bitmasks of GPIO settings (low/high) for each
@@ -25,7 +25,7 @@
  * @n_gpios: Number of GPIOs used to control MUX
  * @idle: Bitmask to write to MUX when idle or GPIO_I2CMUX_NO_IDLE if not used
  */
-struct gpio_i2cmux_platform_data {
+struct i2c_mux_gpio_platform_data {
 	int parent;
 	int base_nr;
 	const unsigned *values;

-- 
Jean Delvare
