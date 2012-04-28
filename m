From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] i2c: Rename last mux driver to standard pattern
Date: Sat, 28 Apr 2012 15:32:06 +0200
Message-ID: <20120428153206.00c1e226@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Update the MAINTAINERS entry and all other references accordingly.

Based on an original patch by Wolfram Sang.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Peter, I assumed your ack still applied, please yell if not.

Changes since v1:
* Renamed header file and documentation file too.
* Updated MAINTAINERS.
* Updated references.

 Documentation/i2c/muxes/gpio-i2cmux  |   65 ------------
 Documentation/i2c/muxes/i2c-mux-gpio |   65 ++++++++++++
 MAINTAINERS                          |    6 -
 drivers/i2c/muxes/Kconfig            |    2 
 drivers/i2c/muxes/Makefile           |    2 
 drivers/i2c/muxes/gpio-i2cmux.c      |  173 ----------------------------------
 drivers/i2c/muxes/i2c-mux-gpio.c     |  173 ++++++++++++++++++++++++++++++++++
 include/linux/gpio-i2cmux.h          |   38 -------
 include/linux/i2c-mux-gpio.h         |   38 +++++++
 9 files changed, 281 insertions(+), 281 deletions(-)

--- linux-3.4-rc3.orig/drivers/i2c/muxes/Kconfig	2012-04-27 16:23:40.000000000 +0200
+++ linux-3.4-rc3/drivers/i2c/muxes/Kconfig	2012-04-27 16:23:49.202679506 +0200
@@ -15,7 +15,7 @@ config I2C_MUX_GPIO
 	  through GPIO pins.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called gpio-i2cmux.
+	  will be called i2c-mux-gpio.
 
 config I2C_MUX_PCA9541
 	tristate "NXP PCA9541 I2C Master Selector"
--- linux-3.4-rc3.orig/drivers/i2c/muxes/Makefile	2012-04-27 16:23:40.000000000 +0200
+++ linux-3.4-rc3/drivers/i2c/muxes/Makefile	2012-04-27 16:23:49.203679506 +0200
@@ -1,7 +1,7 @@
 #
 # Makefile for multiplexer I2C chip drivers.
 
-obj-$(CONFIG_I2C_MUX_GPIO)	+= gpio-i2cmux.o
+obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
 obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
 
--- linux-3.4-rc3.orig/drivers/i2c/muxes/gpio-i2cmux.c	2012-04-27 16:23:40.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,173 +0,0 @@
-/*
- * I2C multiplexer using GPIO API
- *
- * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/i2c.h>
-#include <linux/i2c-mux.h>
-#include <linux/gpio-i2cmux.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/gpio.h>
-
-struct gpiomux {
-	struct i2c_adapter *parent;
-	struct i2c_adapter **adap; /* child busses */
-	struct gpio_i2cmux_platform_data data;
-};
-
-static void gpiomux_set(const struct gpiomux *mux, unsigned val)
-{
-	int i;
-
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_set_value(mux->data.gpios[i], val & (1 << i));
-}
-
-static int gpiomux_select(struct i2c_adapter *adap, void *data, u32 chan)
-{
-	struct gpiomux *mux = data;
-
-	gpiomux_set(mux, mux->data.values[chan]);
-
-	return 0;
-}
-
-static int gpiomux_deselect(struct i2c_adapter *adap, void *data, u32 chan)
-{
-	struct gpiomux *mux = data;
-
-	gpiomux_set(mux, mux->data.idle);
-
-	return 0;
-}
-
-static int __devinit gpiomux_probe(struct platform_device *pdev)
-{
-	struct gpiomux *mux;
-	struct gpio_i2cmux_platform_data *pdata;
-	struct i2c_adapter *parent;
-	int (*deselect) (struct i2c_adapter *, void *, u32);
-	unsigned initial_state;
-	int i, ret;
-
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "Missing platform data\n");
-		return -ENODEV;
-	}
-
-	parent = i2c_get_adapter(pdata->parent);
-	if (!parent) {
-		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
-			pdata->parent);
-		return -ENODEV;
-	}
-
-	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
-	if (!mux) {
-		ret = -ENOMEM;
-		goto alloc_failed;
-	}
-
-	mux->parent = parent;
-	mux->data = *pdata;
-	mux->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->n_values,
-			    GFP_KERNEL);
-	if (!mux->adap) {
-		ret = -ENOMEM;
-		goto alloc_failed2;
-	}
-
-	if (pdata->idle != GPIO_I2CMUX_NO_IDLE) {
-		initial_state = pdata->idle;
-		deselect = gpiomux_deselect;
-	} else {
-		initial_state = pdata->values[0];
-		deselect = NULL;
-	}
-
-	for (i = 0; i < pdata->n_gpios; i++) {
-		ret = gpio_request(pdata->gpios[i], "gpio-i2cmux");
-		if (ret)
-			goto err_request_gpio;
-		gpio_direction_output(pdata->gpios[i],
-				      initial_state & (1 << i));
-	}
-
-	for (i = 0; i < pdata->n_values; i++) {
-		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
-
-		mux->adap[i] = i2c_add_mux_adapter(parent, mux, nr, i,
-						   gpiomux_select, deselect);
-		if (!mux->adap[i]) {
-			ret = -ENODEV;
-			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
-			goto add_adapter_failed;
-		}
-	}
-
-	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
-		 pdata->n_values, parent->name);
-
-	platform_set_drvdata(pdev, mux);
-
-	return 0;
-
-add_adapter_failed:
-	for (; i > 0; i--)
-		i2c_del_mux_adapter(mux->adap[i - 1]);
-	i = pdata->n_gpios;
-err_request_gpio:
-	for (; i > 0; i--)
-		gpio_free(pdata->gpios[i - 1]);
-	kfree(mux->adap);
-alloc_failed2:
-	kfree(mux);
-alloc_failed:
-	i2c_put_adapter(parent);
-
-	return ret;
-}
-
-static int __devexit gpiomux_remove(struct platform_device *pdev)
-{
-	struct gpiomux *mux = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < mux->data.n_values; i++)
-		i2c_del_mux_adapter(mux->adap[i]);
-
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_free(mux->data.gpios[i]);
-
-	platform_set_drvdata(pdev, NULL);
-	i2c_put_adapter(mux->parent);
-	kfree(mux->adap);
-	kfree(mux);
-
-	return 0;
-}
-
-static struct platform_driver gpiomux_driver = {
-	.probe	= gpiomux_probe,
-	.remove	= __devexit_p(gpiomux_remove),
-	.driver	= {
-		.owner	= THIS_MODULE,
-		.name	= "gpio-i2cmux",
-	},
-};
-
-module_platform_driver(gpiomux_driver);
-
-MODULE_DESCRIPTION("GPIO-based I2C multiplexer driver");
-MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:gpio-i2cmux");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-3.4-rc3/drivers/i2c/muxes/i2c-mux-gpio.c	2012-04-27 16:23:49.222679507 +0200
@@ -0,0 +1,173 @@
+/*
+ * I2C multiplexer using GPIO API
+ *
+ * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/i2c-mux-gpio.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+
+struct gpiomux {
+	struct i2c_adapter *parent;
+	struct i2c_adapter **adap; /* child busses */
+	struct gpio_i2cmux_platform_data data;
+};
+
+static void gpiomux_set(const struct gpiomux *mux, unsigned val)
+{
+	int i;
+
+	for (i = 0; i < mux->data.n_gpios; i++)
+		gpio_set_value(mux->data.gpios[i], val & (1 << i));
+}
+
+static int gpiomux_select(struct i2c_adapter *adap, void *data, u32 chan)
+{
+	struct gpiomux *mux = data;
+
+	gpiomux_set(mux, mux->data.values[chan]);
+
+	return 0;
+}
+
+static int gpiomux_deselect(struct i2c_adapter *adap, void *data, u32 chan)
+{
+	struct gpiomux *mux = data;
+
+	gpiomux_set(mux, mux->data.idle);
+
+	return 0;
+}
+
+static int __devinit gpiomux_probe(struct platform_device *pdev)
+{
+	struct gpiomux *mux;
+	struct gpio_i2cmux_platform_data *pdata;
+	struct i2c_adapter *parent;
+	int (*deselect) (struct i2c_adapter *, void *, u32);
+	unsigned initial_state;
+	int i, ret;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "Missing platform data\n");
+		return -ENODEV;
+	}
+
+	parent = i2c_get_adapter(pdata->parent);
+	if (!parent) {
+		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
+			pdata->parent);
+		return -ENODEV;
+	}
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux) {
+		ret = -ENOMEM;
+		goto alloc_failed;
+	}
+
+	mux->parent = parent;
+	mux->data = *pdata;
+	mux->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->n_values,
+			    GFP_KERNEL);
+	if (!mux->adap) {
+		ret = -ENOMEM;
+		goto alloc_failed2;
+	}
+
+	if (pdata->idle != GPIO_I2CMUX_NO_IDLE) {
+		initial_state = pdata->idle;
+		deselect = gpiomux_deselect;
+	} else {
+		initial_state = pdata->values[0];
+		deselect = NULL;
+	}
+
+	for (i = 0; i < pdata->n_gpios; i++) {
+		ret = gpio_request(pdata->gpios[i], "i2c-mux-gpio");
+		if (ret)
+			goto err_request_gpio;
+		gpio_direction_output(pdata->gpios[i],
+				      initial_state & (1 << i));
+	}
+
+	for (i = 0; i < pdata->n_values; i++) {
+		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
+
+		mux->adap[i] = i2c_add_mux_adapter(parent, mux, nr, i,
+						   gpiomux_select, deselect);
+		if (!mux->adap[i]) {
+			ret = -ENODEV;
+			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
+			goto add_adapter_failed;
+		}
+	}
+
+	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
+		 pdata->n_values, parent->name);
+
+	platform_set_drvdata(pdev, mux);
+
+	return 0;
+
+add_adapter_failed:
+	for (; i > 0; i--)
+		i2c_del_mux_adapter(mux->adap[i - 1]);
+	i = pdata->n_gpios;
+err_request_gpio:
+	for (; i > 0; i--)
+		gpio_free(pdata->gpios[i - 1]);
+	kfree(mux->adap);
+alloc_failed2:
+	kfree(mux);
+alloc_failed:
+	i2c_put_adapter(parent);
+
+	return ret;
+}
+
+static int __devexit gpiomux_remove(struct platform_device *pdev)
+{
+	struct gpiomux *mux = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < mux->data.n_values; i++)
+		i2c_del_mux_adapter(mux->adap[i]);
+
+	for (i = 0; i < mux->data.n_gpios; i++)
+		gpio_free(mux->data.gpios[i]);
+
+	platform_set_drvdata(pdev, NULL);
+	i2c_put_adapter(mux->parent);
+	kfree(mux->adap);
+	kfree(mux);
+
+	return 0;
+}
+
+static struct platform_driver gpiomux_driver = {
+	.probe	= gpiomux_probe,
+	.remove	= __devexit_p(gpiomux_remove),
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "i2c-mux-gpio",
+	},
+};
+
+module_platform_driver(gpiomux_driver);
+
+MODULE_DESCRIPTION("GPIO-based I2C multiplexer driver");
+MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:i2c-mux-gpio");
--- linux-3.4-rc3.orig/include/linux/gpio-i2cmux.h	2012-04-27 16:23:40.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,38 +0,0 @@
-/*
- * gpio-i2cmux interface to platform code
- *
- * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _LINUX_GPIO_I2CMUX_H
-#define _LINUX_GPIO_I2CMUX_H
-
-/* MUX has no specific idle mode */
-#define GPIO_I2CMUX_NO_IDLE	((unsigned)-1)
-
-/**
- * struct gpio_i2cmux_platform_data - Platform-dependent data for gpio-i2cmux
- * @parent: Parent I2C bus adapter number
- * @base_nr: Base I2C bus number to number adapters from or zero for dynamic
- * @values: Array of bitmasks of GPIO settings (low/high) for each
- *	position
- * @n_values: Number of multiplexer positions (busses to instantiate)
- * @gpios: Array of GPIO numbers used to control MUX
- * @n_gpios: Number of GPIOs used to control MUX
- * @idle: Bitmask to write to MUX when idle or GPIO_I2CMUX_NO_IDLE if not used
- */
-struct gpio_i2cmux_platform_data {
-	int parent;
-	int base_nr;
-	const unsigned *values;
-	int n_values;
-	const unsigned *gpios;
-	int n_gpios;
-	unsigned idle;
-};
-
-#endif /* _LINUX_GPIO_I2CMUX_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-3.4-rc3/include/linux/i2c-mux-gpio.h	2012-04-27 16:24:39.183682038 +0200
@@ -0,0 +1,38 @@
+/*
+ * i2c-mux-gpio interface to platform code
+ *
+ * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_I2C_MUX_GPIO_H
+#define _LINUX_I2C_MUX_GPIO_H
+
+/* MUX has no specific idle mode */
+#define GPIO_I2CMUX_NO_IDLE	((unsigned)-1)
+
+/**
+ * struct gpio_i2cmux_platform_data - Platform-dependent data for i2c-mux-gpio
+ * @parent: Parent I2C bus adapter number
+ * @base_nr: Base I2C bus number to number adapters from or zero for dynamic
+ * @values: Array of bitmasks of GPIO settings (low/high) for each
+ *	position
+ * @n_values: Number of multiplexer positions (busses to instantiate)
+ * @gpios: Array of GPIO numbers used to control MUX
+ * @n_gpios: Number of GPIOs used to control MUX
+ * @idle: Bitmask to write to MUX when idle or GPIO_I2CMUX_NO_IDLE if not used
+ */
+struct gpio_i2cmux_platform_data {
+	int parent;
+	int base_nr;
+	const unsigned *values;
+	int n_values;
+	const unsigned *gpios;
+	int n_gpios;
+	unsigned idle;
+};
+
+#endif /* _LINUX_I2C_MUX_GPIO_H */
--- linux-3.4-rc3.orig/Documentation/i2c/muxes/gpio-i2cmux	2012-04-27 16:23:40.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,65 +0,0 @@
-Kernel driver gpio-i2cmux
-
-Author: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
-
-Description
------------
-
-gpio-i2cmux is an i2c mux driver providing access to I2C bus segments
-from a master I2C bus and a hardware MUX controlled through GPIO pins.
-
-E.G.:
-
-  ----------              ----------  Bus segment 1   - - - - -
- |          | SCL/SDA    |          |-------------- |           |
- |          |------------|          |
- |          |            |          | Bus segment 2 |           |
- |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
- |          |------------|          |               |           |
- |          |            |          | Bus segment M
- |          |            |          |---------------|           |
-  ----------              ----------                  - - - - -
-
-SCL/SDA of the master I2C bus is multiplexed to bus segment 1..M
-according to the settings of the GPIO pins 1..N.
-
-Usage
------
-
-gpio-i2cmux uses the platform bus, so you need to provide a struct
-platform_device with the platform_data pointing to a struct
-gpio_i2cmux_platform_data with the I2C adapter number of the master
-bus, the number of bus segments to create and the GPIO pins used
-to control it. See include/linux/gpio-i2cmux.h for details.
-
-E.G. something like this for a MUX providing 4 bus segments
-controlled through 3 GPIO pins:
-
-#include <linux/gpio-i2cmux.h>
-#include <linux/platform_device.h>
-
-static const unsigned myboard_gpiomux_gpios[] = {
-	AT91_PIN_PC26, AT91_PIN_PC25, AT91_PIN_PC24
-};
-
-static const unsigned myboard_gpiomux_values[] = {
-	0, 1, 2, 3
-};
-
-static struct gpio_i2cmux_platform_data myboard_i2cmux_data = {
-	.parent		= 1,
-	.base_nr	= 2, /* optional */
-	.values		= myboard_gpiomux_values,
-	.n_values	= ARRAY_SIZE(myboard_gpiomux_values),
-	.gpios		= myboard_gpiomux_gpios,
-	.n_gpios	= ARRAY_SIZE(myboard_gpiomux_gpios),
-	.idle		= 4, /* optional */
-};
-
-static struct platform_device myboard_i2cmux = {
-	.name		= "gpio-i2cmux",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &myboard_i2cmux_data,
-	},
-};
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-3.4-rc3/Documentation/i2c/muxes/i2c-mux-gpio	2012-04-27 16:23:49.229679507 +0200
@@ -0,0 +1,65 @@
+Kernel driver i2c-gpio-mux
+
+Author: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+
+Description
+-----------
+
+i2c-gpio-mux is an i2c mux driver providing access to I2C bus segments
+from a master I2C bus and a hardware MUX controlled through GPIO pins.
+
+E.G.:
+
+  ----------              ----------  Bus segment 1   - - - - -
+ |          | SCL/SDA    |          |-------------- |           |
+ |          |------------|          |
+ |          |            |          | Bus segment 2 |           |
+ |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
+ |          |------------|          |               |           |
+ |          |            |          | Bus segment M
+ |          |            |          |---------------|           |
+  ----------              ----------                  - - - - -
+
+SCL/SDA of the master I2C bus is multiplexed to bus segment 1..M
+according to the settings of the GPIO pins 1..N.
+
+Usage
+-----
+
+i2c-gpio-mux uses the platform bus, so you need to provide a struct
+platform_device with the platform_data pointing to a struct
+gpio_i2cmux_platform_data with the I2C adapter number of the master
+bus, the number of bus segments to create and the GPIO pins used
+to control it. See include/linux/i2c-gpio-mux.h for details.
+
+E.G. something like this for a MUX providing 4 bus segments
+controlled through 3 GPIO pins:
+
+#include <linux/i2c-gpio-mux.h>
+#include <linux/platform_device.h>
+
+static const unsigned myboard_gpiomux_gpios[] = {
+	AT91_PIN_PC26, AT91_PIN_PC25, AT91_PIN_PC24
+};
+
+static const unsigned myboard_gpiomux_values[] = {
+	0, 1, 2, 3
+};
+
+static struct gpio_i2cmux_platform_data myboard_i2cmux_data = {
+	.parent		= 1,
+	.base_nr	= 2, /* optional */
+	.values		= myboard_gpiomux_values,
+	.n_values	= ARRAY_SIZE(myboard_gpiomux_values),
+	.gpios		= myboard_gpiomux_gpios,
+	.n_gpios	= ARRAY_SIZE(myboard_gpiomux_gpios),
+	.idle		= 4, /* optional */
+};
+
+static struct platform_device myboard_i2cmux = {
+	.name		= "i2c-gpio-mux",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &myboard_i2cmux_data,
+	},
+};
--- linux-3.4-rc3.orig/MAINTAINERS	2012-04-27 16:23:40.000000000 +0200
+++ linux-3.4-rc3/MAINTAINERS	2012-04-27 16:23:49.231679508 +0200
@@ -2940,9 +2940,9 @@ GENERIC GPIO I2C MULTIPLEXER DRIVER
 M:	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Supported
-F:	drivers/i2c/muxes/gpio-i2cmux.c
-F:	include/linux/gpio-i2cmux.h
-F:	Documentation/i2c/muxes/gpio-i2cmux
+F:	drivers/i2c/muxes/i2c-mux-gpio.c
+F:	include/linux/i2c-mux-gpio.h
+F:	Documentation/i2c/muxes/i2c-mux-gpio
 
 GENERIC HDLC (WAN) DRIVERS
 M:	Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>


-- 
Jean Delvare
