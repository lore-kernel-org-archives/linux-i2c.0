From: Balaji Venkatachalam <balaji.v-VY1X38MsZ4VWk0Htik3J/w@public.gmane.org>
Subject: [Patch]PCA9698-Add driver for PCA9698 GPIO Expander Chip on I2C Bus
Date: Wed, 23 Feb 2011 11:24:36 +0530
Message-ID: <AANLkTi=N2P2z1GzUmesYDXqWw6zct+MD-_X0TsZg0vOa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lakshmi Mohan <mohan-VY1X38MsZ4VWk0Htik3J/w@public.gmane.org>, Sriram Subramanian <sriram-VY1X38MsZ4VWk0Htik3J/w@public.gmane.org>, "vbalaji.acs" <vbalaji.acs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Balaji Venkatachalam <balaji.v-VY1X38MsZ4VWk0Htik3J/w@public.gmane.org>

Patch [V1.24] for NXP's PCA9698 GPIO Expander controlled via I2C (@ 100KHz).
I tested it on my custom board with ARM9 (Freescale i.MX233) with
Kernel 2.6.31.14.

Todo List:
1. Test enabling the CONFIG_OF_GPIO
2. Arrive at strategy to implement GPIO All Call Command via sys interface


Any comments are welcome.

Signed-off-by: Balaji Venkatachalam <balaji.v-VY1X38MsZ4VWk0Htik3J/w@public.gmane.org>
---
diff -uprN -X a/Documentation/dontdiff a/drivers/gpio/Kconfig
b/drivers/gpio/Kconfig
--- a/drivers/gpio/Kconfig	2010-07-05 22:41:43.000000000 +0530
+++ b/drivers/gpio/Kconfig	2011-02-20 20:07:09.000000000 +0530
@@ -124,6 +124,18 @@ config GPIO_PCA953X
 	  This driver can also be built as a module.  If so, the module
 	  will be called pca953x.

+config GPIO_PCA9698
+	tristate "PCA9698 I/O ports"
+	depends on I2C
+	help
+	  Say yes here to provide access to several register of PCA9698
+
+	  40 bits:	pca9698
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pca9698.
+
+
 config GPIO_PCF857X
 	tristate "PCF857x, PCA{85,96}7x, and MAX732[89] I2C GPIO expanders"
 	depends on I2C
diff -uprN -X a/Documentation/dontdiff a/drivers/gpio/Makefile
b/drivers/gpio/Makefile
--- a/drivers/gpio/Makefile	2010-07-05 22:41:43.000000000 +0530
+++ b/drivers/gpio/Makefile	2011-02-20 20:07:42.000000000 +0530
@@ -8,6 +8,7 @@ obj-$(CONFIG_GPIO_MAX7301)	+= max7301.o
 obj-$(CONFIG_GPIO_MAX732X)	+= max732x.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
+obj-$(CONFIG_GPIO_PCA9698)	+= pca9698.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
 obj-$(CONFIG_GPIO_PL061)	+= pl061.o
 obj-$(CONFIG_GPIO_TWL4030)	+= twl4030-gpio.o
diff -uprN -X a/Documentation/dontdiff a/drivers/gpio/pca9698.c
b/drivers/gpio/pca9698.c
--- a/drivers/gpio/pca9698.c	1970-01-01 05:30:00.000000000 +0530
+++ b/drivers/gpio/pca9698.c	2011-02-20 21:33:45.000000000 +0530
@@ -0,0 +1,401 @@
+/*
+ *  NXP pca9698.c - 40 bit I/O Expander on I2C bus
+ *
+ * Copyright (C) 2011 Thotaka Technologies Pvt Ltd
+ * Author: Balaji Venkatachalam <balaji.v-VY1X38MsZ4VWk0Htik3J/w@public.gmane.org>
+ * based on pca953x.c written by eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c/pca9698.h>
+
+#ifdef CONFIG_OF_GPIO
+/*TODO: Not Tested. As it is adopted from PCA959x.c*/
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#endif
+
+#include <linux/gpio.h>
+
+#define DRV_NAME "pca9698"
+
+#define PCA9698_INPUT			0
+#define PCA9698_OUTPUT			1
+#define PCA9698_INVERT			2
+#define PCA9698_DIRECTION		3
+
+
+
+static const struct i2c_device_id pca9698_id[] = {
+		{ "pca9698", 40, },
+		{ }
+};
+MODULE_DEVICE_TABLE(i2c, pca9698_id);
+
+struct pca9698_chip {
+	unsigned gpio_start;
+	uint8_t reg_output[PCA9698_MAX_BANKS];
+	uint8_t reg_direction[PCA9698_MAX_BANKS];
+	struct i2c_client *client;
+	struct pca9698_platform_data *dyn_pdata;
+	struct gpio_chip gpio_chip;
+	char **names;
+};
+uint8_t i2cdataaddr[5] = {0, 0, 0, 0, 0};
+
+static int pca9698_write_reg(struct pca9698_chip *chip, int reg, uint8_t *val)
+{
+	int ret;
+	ret = i2c_smbus_write_i2c_block_data(chip->client,
+			((reg << 3)|0x80), 5, val);
+
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "failed writing register\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int pca9698_read_reg(struct pca9698_chip *chip, int reg, uint8_t *val)
+{
+	int ret;
+	ret = i2c_smbus_read_i2c_block_data(chip->client,
+			((reg << 3)|0x80), 5, val);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "failed reading register\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int pca9698_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	struct pca9698_chip *chip;
+	int ret, bankid;
+
+	chip = container_of(gc, struct pca9698_chip, gpio_chip);
+	bankid = 0;
+	do {
+		i2cdataaddr[bankid] = chip->reg_direction[bankid] | (1u << off);
+	} while (++bankid <= PCA9698_MAX_BANKS);
+	ret = pca9698_write_reg(chip, PCA9698_DIRECTION, i2cdataaddr);
+	if (ret)
+		return ret;
+	bankid = 0;
+	do {
+		chip->reg_direction[bankid] = i2cdataaddr[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+
+	return 0;
+}
+
+static int pca9698_gpio_direction_output(struct gpio_chip *gc,
+		unsigned off, int val)
+{
+	struct pca9698_chip *chip;
+	int ret, bankid = 0;
+	unsigned int port = 0;
+	chip = container_of(gc, struct pca9698_chip, gpio_chip);
+
+	port = off/8;
+	off = off%8;
+	bankid = 0;
+	do {
+		if (bankid == port) {
+			if (val)
+				i2cdataaddr[bankid] =
+					chip->reg_output[bankid] | (1u << off);
+			else
+				i2cdataaddr[bankid] =
+					chip->reg_output[bankid] & ~(1u << off);
+		} else
+			i2cdataaddr[bankid] = chip->reg_output[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+	ret = pca9698_write_reg(chip, PCA9698_OUTPUT, i2cdataaddr);
+	if (ret)
+		return ret;
+	bankid = 0;
+	do {
+		chip->reg_output[bankid] = i2cdataaddr[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+	bankid = 0;
+	do {
+		if (bankid == port)
+			i2cdataaddr[bankid] =
+				chip->reg_direction[bankid] & ~(1u << off);
+		else
+			i2cdataaddr[bankid] = chip->reg_direction[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+	ret = pca9698_write_reg(chip, PCA9698_DIRECTION, i2cdataaddr);
+	if (ret)
+		return ret;
+	bankid = 0;
+	do {
+		chip->reg_direction[bankid] = i2cdataaddr[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+	return 0;
+}
+
+static int pca9698_gpio_get_value(struct gpio_chip *gc, unsigned off)
+{
+	struct pca9698_chip *chip;
+	int ret;
+	unsigned int port = 0;
+	chip = container_of(gc, struct pca9698_chip, gpio_chip);
+
+	ret = pca9698_read_reg(chip, PCA9698_INPUT, i2cdataaddr);
+	if (ret < 0) {
+		/* NOTE:  diagnostic already emitted; that's all we should
+		 * do unless gpio_*_value_cansleep() calls become different
+		 * from their nonsleeping siblings (and report faults).
+		 */
+		return 0;
+	}
+	port = off/8;
+	off = off%8;
+	return (i2cdataaddr[port] & (1u << off)) ? 1 : 0;
+}
+
+static void pca9698_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
+{
+	struct pca9698_chip *chip;
+	int ret, bankid = 0;
+	unsigned int port = 0;
+	chip = container_of(gc, struct pca9698_chip, gpio_chip);
+	port = off/8;
+	off = off%8;
+	bankid = 0;
+	do {
+		if (bankid == port) {
+			if (val)
+				i2cdataaddr[bankid] =
+					chip->reg_output[bankid] | (1u << off);
+			else
+				i2cdataaddr[bankid] =
+					chip->reg_output[bankid] & ~(1u << off);
+		} else {
+			i2cdataaddr[bankid] = chip->reg_output[bankid];
+		}
+	} while (++bankid <= PCA9698_MAX_BANKS);
+	ret = pca9698_write_reg(chip, PCA9698_OUTPUT, i2cdataaddr);
+	if (ret)
+		return;
+	bankid = 0;
+	do {
+		chip->reg_output[bankid] = i2cdataaddr[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+}
+
+static void pca9698_setup_gpio(struct pca9698_chip *chip, int gpios)
+{
+	struct gpio_chip *gc;
+	gc = &chip->gpio_chip;
+
+	gc->direction_input  = pca9698_gpio_direction_input;
+	gc->direction_output = pca9698_gpio_direction_output;
+	gc->get = pca9698_gpio_get_value;
+	gc->set = pca9698_gpio_set_value;
+	gc->can_sleep = 1;
+
+	gc->base = chip->gpio_start;
+	gc->ngpio = gpios;
+	gc->label = chip->client->name;
+	gc->dev = &chip->client->dev;
+	gc->owner = THIS_MODULE;
+	gc->names = chip->names;
+}
+
+/*
+ * Handlers for alternative sources of platform_data
+ */
+#ifdef CONFIG_OF_GPIO
+/*
+ * TODO: To be tested. As it is adopted from PCA953x.c
+ */
+ */
+/*
+ * Translate OpenFirmware node properties into platform_data
+ */
+static struct pca9698_platform_data *
+pca9698_get_alt_pdata(struct i2c_client *client)
+{
+	struct pca9698_platform_data *pdata;
+	struct device_node *node;
+	const uint16_t *val;
+	node = dev_archdata_get_node(&client->dev.archdata);
+	if (node == NULL)
+		return NULL;
+
+	pdata = kzalloc(sizeof(struct pca9698_platform_data), GFP_KERNEL);
+	if (pdata == NULL) {
+		dev_err(&client->dev, "Unable to allocate platform_data\n");
+		return NULL;
+	}
+
+	pdata->gpio_base = -1;
+	val = of_get_property(node, "linux,gpio-base", NULL);
+	if (val) {
+		if (*val < 0)
+			dev_warn(&client->dev,
+					"invalid gpio-base in device tree\n");
+		else
+			pdata->gpio_base = *val;
+	}
+
+	val = of_get_property(node, "polarity", NULL);
+	if (val)
+		pdata->invert = *val;
+
+	return pdata;
+}
+#else
+static struct pca9698_platform_data *
+pca9698_get_alt_pdata(struct i2c_client *client)
+{
+	return NULL;
+}
+#endif
+
+static int __devinit pca9698_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct pca9698_platform_data *pdata;
+
+	struct pca9698_chip *chip;
+	int ret, bankid = 0;
+	chip = kzalloc(sizeof(struct pca9698_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	pdata = client->dev.platform_data;
+
+	if (pdata == NULL) {
+		pdata = pca9698_get_alt_pdata(client);
+		/*
+		 * Unlike normal platform_data, this is allocated
+		 * dynamically and must be freed in the driver
+		 */
+		chip->dyn_pdata = pdata;
+	}
+	if (pdata == NULL) {
+		dev_dbg(&client->dev, "no platform data\n");
+		ret = -EINVAL;
+		goto out_failed;
+	}
+	chip->client = client;
+	chip->gpio_start = pdata->gpio_base;
+	chip->names = pdata->names;
+	/* initialize cached registers from their original values.
+	 * we can't share this chip with another i2c master.
+	 */
+	pca9698_setup_gpio(chip, id->driver_data);
+	ret = pca9698_read_reg(chip, PCA9698_OUTPUT, i2cdataaddr);
+
+	if (ret)
+		goto out_failed;
+
+	bankid = 0;
+	do {
+		chip->reg_output[bankid] = i2cdataaddr[0];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+
+	ret = pca9698_read_reg(chip, PCA9698_DIRECTION, i2cdataaddr);
+
+	if (ret)
+		goto out_failed;
+
+	bankid = 0;
+	do {
+		chip->reg_direction[bankid] = i2cdataaddr[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+
+	bankid = 0;
+	do {
+		i2cdataaddr[bankid] = pdata->invert[bankid];
+	} while (++bankid <= PCA9698_MAX_BANKS);
+	/* set platform specific polarity inversion */
+	ret = pca9698_write_reg(chip, PCA9698_INVERT, i2cdataaddr);
+	if (ret)
+		goto out_failed;
+
+	ret = gpiochip_add(&chip->gpio_chip);
+	if (ret)
+		goto out_failed;
+	if (pdata->setup) {
+		ret = pdata->setup(client, chip->gpio_chip.base,
+				chip->gpio_chip.ngpio, pdata->context);
+		if (ret < 0)
+			dev_warn(&client->dev, "setup failed, %d\n", ret);
+	}
+	i2c_set_clientdata(client, chip);
+	dev_info(&client->dev, DRV_NAME " driver registered\n");
+	return 0;
+
+out_failed:
+	kfree(chip->dyn_pdata);
+	kfree(chip);
+	return ret;
+}
+
+static int pca9698_remove(struct i2c_client *client)
+{
+	struct pca9698_platform_data *pdata = client->dev.platform_data;
+	struct pca9698_chip *chip = i2c_get_clientdata(client);
+	int ret = 0;
+	if (pdata->teardown) {
+		ret = pdata->teardown(client, chip->gpio_chip.base,
+				chip->gpio_chip.ngpio, pdata->context);
+		if (ret < 0) {
+			dev_err(&client->dev, "%s failed, %d\n",
+					"teardown", ret);
+			return ret;
+		}
+	}
+
+	ret = gpiochip_remove(&chip->gpio_chip);
+	if (ret) {
+		dev_err(&client->dev, "%s failed, %d\n",
+				"gpiochip_remove()", ret);
+		return ret;
+	}
+
+	kfree(chip->dyn_pdata);
+	kfree(chip);
+	return 0;
+}
+
+static struct i2c_driver pca9698_driver = {
+		.driver = {
+				.name	= DRV_NAME,
+		},
+		.probe		= pca9698_probe,
+		.remove		= pca9698_remove,
+		.id_table	= pca9698_id,
+};
+
+static int __init pca9698_init(void)
+{
+	return i2c_add_driver(&pca9698_driver);
+}
+/* register after i2c postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(pca9698_init);
+
+static void __exit pca9698_exit(void)
+{
+	i2c_del_driver(&pca9698_driver);
+}
+module_exit(pca9698_exit);
+
+MODULE_AUTHOR("Balaji Venkatachalam <balaji.v@thotakaa>");
+MODULE_DESCRIPTION("GPIO expander driver for PCA9698");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("i2c:" DRV_NAME);
diff -uprN -X a/Documentation/dontdiff a/include/linux/i2c/pca9698.h
b/include/linux/i2c/pca9698.h
--- a/include/linux/i2c/pca9698.h	1970-01-01 05:30:00.000000000 +0530
+++ b/include/linux/i2c/pca9698.h	2011-02-20 19:10:38.000000000 +0530
@@ -0,0 +1,19 @@
+/* platform data for the PCA9698 16-bit I/O expander driver */
+#define PCA9698_MAX_BANKS		5
+struct pca9698_platform_data {
+	/* number of the first GPIO */
+	unsigned	gpio_base;
+
+	/* initial polarity inversion setting */
+	uint8_t	invert[PCA9698_MAX_BANKS];
+
+	void		*context;	/* param to setup/teardown */
+
+	int		(*setup)(struct i2c_client *client,
+				unsigned gpio, unsigned ngpio,
+				void *context);
+	int		(*teardown)(struct i2c_client *client,
+				unsigned gpio, unsigned ngpio,
+				void *context);
+	char		**names;
+};
