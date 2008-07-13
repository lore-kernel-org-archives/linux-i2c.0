From: "eric miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
	MAX7320-7327 I2C Port Expanders
Date: Sun, 13 Jul 2008 14:04:28 +0800
Message-ID: <f17812d70807122304o533d8af9k1384db653b264912@mail.gmail.com>
References: <4875A893.3090402@gmail.com>
	<200807111425.00961.david-b@pacbell.net>
	<20080712091610.4ec242c3@hyperion.delvare>
	<200807120046.29389.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200807120046.29389.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>From 562e78eec627092610db817e28c4ff9be6af13e1 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 10 Jul 2008 13:37:59 +0800
Subject: [PATCH] gpio: max732x: add support for MAX7319, MAX7320-7327
I2C Port Expanders

Signed-off-by: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---

Updated as below. i2c_new_dummy() is called _only_ when necessary
(there's 8-bit IO expander). mutex is used to protect the update to
chip->reg_out[].

Actually, I don't quite like the idea of i2c_new_dummy(), which creates
several i2c_client for one device. Due to:

1. i2c_client should really be 1:1 with the device
2. a dummy i2c_client just wastes another several bytes
3. for chips like max732x, actually, the range of 0x50 - 0x5F will be
monitored by the I2C chips at startup to decide the connections of
AD2/AD0 pins to GND/VCC/SCL/SDA, so actually, even if the chip
is finally decided at, say 0x56, no sane hardware designers will put
another chip whose address falls between 0x50-0x5F together with
such a max732x chip, ugly, but true.

One i2c_client requesting a group of address could somehow be
more reasonable, and requested address can be changed at
run-time.

Anyway, here's the one for i2c_new_dummy().

 drivers/gpio/Kconfig        |   22 +++
 drivers/gpio/Makefile       |    1 +
 drivers/gpio/max732x.c      |  380 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/max732x.h |   19 ++
 4 files changed, 422 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/max732x.c
 create mode 100644 include/linux/i2c/max732x.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bbd2834..b8a60fb 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -27,6 +27,28 @@ config DEBUG_GPIO

 comment "I2C GPIO expanders:"

+config GPIO_MAX732X
+	tristate "MAX7319, MAX7320-7327 8/16-bit I2C Port Expanders"
+	depends on I2C
+	help
+	  Say yes here to support the MAX7319, MAX7320-7327 series of I2C
+	  Port Expanders. Each IO port on these chips has a fixed role of
+	  Input (designated by 'I'), Push-Pull Output ('O'), or Open-Drain
+	  Input and Output (designed by 'P'). The combinations are listed
+	  below:
+
+	    MAX7319 (8I), MAX7320 (8O), MAX7321 (8P), MAX7322 (4I4O),
+	    MAX7323 (4P4O), MAX7324 (8I8O), MAX7325 (8P8O)
+	    MAX7326 (4I12O), MAX7327 (4P12O)
+
+	  The board code has to specify the model to use, and the start
+	  number for these GPIOs. Model specific information is calculated
+	  automatically. Due to the fixed role of each port, configuration
+	  of the port direction will be ignored and a warning be issued if
+	  the corresponding port isn't applicable. And gpio_get_value() to
+	  those output only ports will return the configured output status
+	  instead of a real input.
+
 config GPIO_PCA953X
 	tristate "PCA953x I/O ports"
 	depends on I2C
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fdde992..421a11b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -4,6 +4,7 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG

 obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o

+obj-$(CONFIG_GPIO_MAX732X)	+= max732x.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
diff --git a/drivers/gpio/max732x.c b/drivers/gpio/max732x.c
new file mode 100644
index 0000000..187511e
--- /dev/null
+++ b/drivers/gpio/max732x.c
@@ -0,0 +1,380 @@
+/*
+ *  max732x.c - I2C Port Expander with 8/16 I/O
+ *
+ *  Copyright (C) 2007 Marvell International Ltd.
+ *  Copyright (C) 2008 Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ *  Copyright (C) 2008 Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ *
+ *  Derived from drivers/gpio/pca953x.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/gpio.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c/max732x.h>
+
+/* Each port of MAX732x (including MAX7319) falls into one of the
+ * following three types:
+ *
+ *   - Push Pull Output
+ *   - Input
+ *   - Open Drain I/O
+ *
+ * designated by 'O', 'I' and 'P' individually according to MAXIM's
+ * datasheets.
+ *
+ * There are two groups of I/O ports, each group usually includes
+ * up to 8 I/O ports, and is accessed by a specific I2C address:
+ *
+ *   - Group A : by I2C address 0b'110xxxx
+ *   - Group B : by I2C address 0b'101xxxx
+ *
+ * where 'xxxx' is decided by the connections of pin AD2/AD0.
+ *
+ * Within each group of ports, there are five known combinations of
+ * I/O ports: 4I4O, 4P4O, 8I, 8P, 8O, see the definitions below for
+ * the detailed organization of these ports.
+ *
+ * GPIO numbers start from 'gpio_base + 0' to 'gpio_base + 8/16',
+ * and GPIOs from GROUP_A are numbered before those from GROUP_B
+ * (if there are two groups).
+ *
+ * NOTE: MAX7328/MAX7329, however, resembles much closer to PCF8574,
+ * they are not supported by this driver.
+ */
+
+#define PORT_NONE	0x0	/* '/' No Port */
+#define PORT_OUTPUT	0x1	/* 'O' Push-Pull, Output Only */
+#define PORT_INPUT	0x2	/* 'I' Input Only */
+#define PORT_OPENDRAIN	0x3	/* 'P' Open-Drain, I/O */
+
+#define IO_4I4O		0x5AA5	/* O7 O6 I5 I4 I3 I2 O1 O0 */
+#define IO_4P4O		0x5FF5	/* O7 O6 P5 P4 P3 P2 O1 O0 */
+#define IO_8I		0xAAAA	/* I7 I6 I5 I4 I3 I2 I1 I0 */
+#define IO_8P		0xFFFF	/* P7 P6 P5 P4 P3 P2 P1 P0 */
+#define IO_8O		0x5555	/* O7 O6 O5 O4 O3 O2 O1 O0 */
+
+#define GROUP_A(x)	((x) & 0xffff)	/* I2C Addr: 0b'110xxxx */
+#define GROUP_B(x)	((x) << 16)	/* I2C Addr: 0b'101xxxx */
+
+static const struct i2c_device_id max732x_id[] = {
+	{ "max7319", GROUP_A(IO_8I) },
+	{ "max7320", GROUP_B(IO_8O) },
+	{ "max7321", GROUP_A(IO_8P) },
+	{ "max7322", GROUP_A(IO_4I4O) },
+	{ "max7323", GROUP_A(IO_4P4O) },
+	{ "max7324", GROUP_A(IO_8I) | GROUP_B(IO_8O) },
+	{ "max7325", GROUP_A(IO_8P) | GROUP_B(IO_8O) },
+	{ "max7326", GROUP_A(IO_4I4O) | GROUP_B(IO_8O) },
+	{ "max7327", GROUP_A(IO_4P4O) | GROUP_B(IO_8O) },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, max732x_id);
+
+struct max732x_chip {
+	struct gpio_chip gpio_chip;
+
+	struct i2c_client *client_dummy;
+	struct i2c_client *client_group_a;
+	struct i2c_client *client_group_b;
+
+	unsigned int	mask_group_a;
+	unsigned int	dir_input;
+	unsigned int	dir_output;
+
+	struct mutex	lock;
+	uint8_t		reg_out[2];
+};
+
+static int max732x_write(struct max732x_chip *chip, int group_a, uint8_t val)
+{
+	struct i2c_client *client;
+	int ret;
+
+	client = group_a ? chip->client_group_a : chip->client_group_b;
+
+	BUG_ON(client == NULL);
+
+	ret = i2c_smbus_write_byte(client, val);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed writing\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max732x_read(struct max732x_chip *chip, int group_a, uint8_t *val)
+{
+	struct i2c_client *client;
+	int ret;
+
+	client = group_a ? chip->client_group_a : chip->client_group_b;
+
+	BUG_ON(client == NULL);
+
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed reading\n");
+		return ret;
+	}
+
+	*val = (uint8_t)ret;
+	return 0;
+}
+
+static inline int is_group_a(struct max732x_chip *chip, unsigned off)
+{
+	return (1u << off) & chip->mask_group_a;
+}
+
+static int max732x_gpio_get_value(struct gpio_chip *gc, unsigned off)
+{
+	struct max732x_chip *chip;
+	uint8_t reg_val;
+	int ret;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	ret = max732x_read(chip, is_group_a(chip, off), &reg_val);
+	if (ret < 0)
+		return 0;
+
+	return reg_val & (1u << (off & 0x7));
+}
+
+static void max732x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
+{
+	struct max732x_chip *chip;
+	uint8_t reg_out, mask = 1u << (off & 0x7);
+	int ret;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	mutex_lock(&chip->lock);
+
+	reg_out = (off > 7) ? chip->reg_out[1] : chip->reg_out[0];
+	reg_out = (val) ? reg_out | mask : reg_out & ~mask;
+
+	ret = max732x_write(chip, is_group_a(chip, off), reg_out);
+	if (ret < 0)
+		goto out;
+
+	/* update the shadow register then */
+	if (off > 7)
+		chip->reg_out[1] = reg_out;
+	else
+		chip->reg_out[0] = reg_out;
+out:
+	mutex_unlock(&chip->lock);
+}
+
+static int max732x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	struct max732x_chip *chip;
+	unsigned int mask = 1u << off;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	if ((mask & chip->dir_input) == 0) {
+		pr_warning("%s: port %d is output only\n", __func__, off);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+static int max732x_gpio_direction_output(struct gpio_chip *gc,
+		unsigned off, int val)
+{
+	struct max732x_chip *chip;
+	unsigned int mask = 1u << off;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	if ((mask & chip->dir_output) == 0) {
+		pr_warning("%s: port %d is input only\n", __func__, off);
+		return -EACCES;
+	}
+
+	max732x_gpio_set_value(gc, off, val);
+	return 0;
+}
+
+static int __devinit max732x_setup_gpio(struct max732x_chip *chip,
+					const struct i2c_device_id *id,
+					unsigned gpio_start)
+{
+	struct gpio_chip *gc = &chip->gpio_chip;
+	uint32_t id_data = id->driver_data;
+	int i, port = 0;
+
+	for (i = 0; i < 16; i++, id_data >>= 2) {
+		unsigned int mask = 1 << port;
+
+		switch (id_data & 0x3) {
+		case PORT_OUTPUT:
+			chip->dir_output |= mask;
+			break;
+		case PORT_INPUT:
+			chip->dir_input |= mask;
+			break;
+		case PORT_OPENDRAIN:
+			chip->dir_output |= mask;
+			chip->dir_input |= mask;
+			break;
+		default:
+			continue;
+		}
+
+		if (i < 8)
+			chip->mask_group_a |= mask;
+		port++;
+	}
+
+	gc->direction_input  = max732x_gpio_direction_input;
+	gc->direction_output = max732x_gpio_direction_output;
+	gc->get = max732x_gpio_get_value;
+	gc->set = max732x_gpio_set_value;
+	gc->can_sleep = 1;
+
+	gc->base = gpio_start;
+	gc->ngpio = port;
+	gc->label = "max732x";
+	gc->owner = THIS_MODULE;
+
+	return port;
+}
+
+static int __devinit max732x_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct max732x_platform_data *pdata;
+	struct max732x_chip *chip;
+	struct i2c_client *c;
+	uint16_t addr_a, addr_b;
+	int ret, nr_port;
+
+	pdata = client->dev.platform_data;
+	if (pdata == NULL)
+		return -ENODEV;
+
+	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	nr_port = max732x_setup_gpio(chip, id, pdata->gpio_base);
+
+	addr_a = (client->addr & 0x0f) | 0x60;
+	addr_b = (client->addr & 0x0f) | 0x50;
+
+	switch (client->addr & 0x70) {
+	case 0x60:
+		chip->client_group_a = client;
+		if (nr_port > 7) {
+			c = i2c_new_dummy(client->adapter, addr_b);
+			chip->client_group_b = chip->client_dummy = c;
+		}
+		break;
+	case 0x50:
+		chip->client_group_b = client;
+		if (nr_port > 7) {
+			c = i2c_new_dummy(client->adapter, addr_a);
+			chip->client_group_a = chip->client_dummy = c;
+		}
+		break;
+	default:
+		dev_err(&client->dev, "invalid I2C address specified %02x\n",
+				client->addr);
+		return -EINVAL;
+	}
+
+	mutex_init(&chip->lock);
+
+	max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
+	if (nr_port > 7)
+		max732x_read(chip, is_group_a(chip, 8), &chip->reg_out[1]);
+
+	ret = gpiochip_add(&chip->gpio_chip);
+	if (ret)
+		goto out_failed;
+
+	if (pdata->setup) {
+		ret = pdata->setup(client, chip->gpio_chip.base,
+				chip->gpio_chip.ngpio, pdata->context);
+		if (ret < 0)
+			dev_warn(&client->dev, "setup failed, %d\n", ret);
+	}
+
+	i2c_set_clientdata(client, chip);
+	return 0;
+
+out_failed:
+	kfree(chip);
+	return ret;
+}
+
+static int __devexit max732x_remove(struct i2c_client *client)
+{
+	struct max732x_platform_data *pdata = client->dev.platform_data;
+	struct max732x_chip *chip = i2c_get_clientdata(client);
+	int ret;
+
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
+	/* unregister the dummy i2c_client */
+	if (chip->client_dummy)
+		i2c_unregister_device(chip->client_dummy);
+
+	kfree(chip);
+	return 0;
+}
+
+static struct i2c_driver max732x_driver = {
+	.driver = {
+		.name	= "max732x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max732x_probe,
+	.remove		= __devexit_p(max732x_remove),
+	.id_table	= max732x_id,
+};
+
+static int __init max732x_init(void)
+{
+	return i2c_add_driver(&max732x_driver);
+}
+module_init(max732x_init);
+
+static void __exit max732x_exit(void)
+{
+	i2c_del_driver(&max732x_driver);
+}
+module_exit(max732x_exit);
+
+MODULE_AUTHOR("Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("GPIO expander driver for MAX732X");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/max732x.h b/include/linux/i2c/max732x.h
new file mode 100644
index 0000000..e103366
--- /dev/null
+++ b/include/linux/i2c/max732x.h
@@ -0,0 +1,19 @@
+#ifndef __LINUX_I2C_MAX732X_H
+#define __LINUX_I2C_MAX732X_H
+
+/* platform data for the MAX732x 8/16-bit I/O expander driver */
+
+struct max732x_platform_data {
+	/* number of the first GPIO */
+	unsigned	gpio_base;
+
+	void		*context;	/* param to setup/teardown */
+
+	int		(*setup)(struct i2c_client *client,
+				unsigned gpio, unsigned ngpio,
+				void *context);
+	int		(*teardown)(struct i2c_client *client,
+				unsigned gpio, unsigned ngpio,
+				void *context);
+};
+#endif /* __LINUX_I2C_MAX732X_H */
-- 
1.5.4.3

>From 562e78eec627092610db817e28c4ff9be6af13e1 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 10 Jul 2008 13:37:59 +0800
Subject: [PATCH] gpio: max732x: add support for MAX7319, MAX7320-7327
I2C Port Expanders

Signed-off-by: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/gpio/Kconfig        |   22 +++
 drivers/gpio/Makefile       |    1 +
 drivers/gpio/max732x.c      |  380 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/max732x.h |   19 ++
 4 files changed, 422 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/max732x.c
 create mode 100644 include/linux/i2c/max732x.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bbd2834..b8a60fb 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -27,6 +27,28 @@ config DEBUG_GPIO

 comment "I2C GPIO expanders:"

+config GPIO_MAX732X
+	tristate "MAX7319, MAX7320-7327 8/16-bit I2C Port Expanders"
+	depends on I2C
+	help
+	  Say yes here to support the MAX7319, MAX7320-7327 series of I2C
+	  Port Expanders. Each IO port on these chips has a fixed role of
+	  Input (designated by 'I'), Push-Pull Output ('O'), or Open-Drain
+	  Input and Output (designed by 'P'). The combinations are listed
+	  below:
+
+	    MAX7319 (8I), MAX7320 (8O), MAX7321 (8P), MAX7322 (4I4O),
+	    MAX7323 (4P4O), MAX7324 (8I8O), MAX7325 (8P8O)
+	    MAX7326 (4I12O), MAX7327 (4P12O)
+
+	  The board code has to specify the model to use, and the start
+	  number for these GPIOs. Model specific information is calculated
+	  automatically. Due to the fixed role of each port, configuration
+	  of the port direction will be ignored and a warning be issued if
+	  the corresponding port isn't applicable. And gpio_get_value() to
+	  those output only ports will return the configured output status
+	  instead of a real input.
+
 config GPIO_PCA953X
 	tristate "PCA953x I/O ports"
 	depends on I2C
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fdde992..421a11b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -4,6 +4,7 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG

 obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o

+obj-$(CONFIG_GPIO_MAX732X)	+= max732x.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
diff --git a/drivers/gpio/max732x.c b/drivers/gpio/max732x.c
new file mode 100644
index 0000000..187511e
--- /dev/null
+++ b/drivers/gpio/max732x.c
@@ -0,0 +1,380 @@
+/*
+ *  max732x.c - I2C Port Expander with 8/16 I/O
+ *
+ *  Copyright (C) 2007 Marvell International Ltd.
+ *  Copyright (C) 2008 Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ *  Copyright (C) 2008 Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ *
+ *  Derived from drivers/gpio/pca953x.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/gpio.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c/max732x.h>
+
+/* Each port of MAX732x (including MAX7319) falls into one of the
+ * following three types:
+ *
+ *   - Push Pull Output
+ *   - Input
+ *   - Open Drain I/O
+ *
+ * designated by 'O', 'I' and 'P' individually according to MAXIM's
+ * datasheets.
+ *
+ * There are two groups of I/O ports, each group usually includes
+ * up to 8 I/O ports, and is accessed by a specific I2C address:
+ *
+ *   - Group A : by I2C address 0b'110xxxx
+ *   - Group B : by I2C address 0b'101xxxx
+ *
+ * where 'xxxx' is decided by the connections of pin AD2/AD0.
+ *
+ * Within each group of ports, there are five known combinations of
+ * I/O ports: 4I4O, 4P4O, 8I, 8P, 8O, see the definitions below for
+ * the detailed organization of these ports.
+ *
+ * GPIO numbers start from 'gpio_base + 0' to 'gpio_base + 8/16',
+ * and GPIOs from GROUP_A are numbered before those from GROUP_B
+ * (if there are two groups).
+ *
+ * NOTE: MAX7328/MAX7329, however, resembles much closer to PCF8574,
+ * they are not supported by this driver.
+ */
+
+#define PORT_NONE	0x0	/* '/' No Port */
+#define PORT_OUTPUT	0x1	/* 'O' Push-Pull, Output Only */
+#define PORT_INPUT	0x2	/* 'I' Input Only */
+#define PORT_OPENDRAIN	0x3	/* 'P' Open-Drain, I/O */
+
+#define IO_4I4O		0x5AA5	/* O7 O6 I5 I4 I3 I2 O1 O0 */
+#define IO_4P4O		0x5FF5	/* O7 O6 P5 P4 P3 P2 O1 O0 */
+#define IO_8I		0xAAAA	/* I7 I6 I5 I4 I3 I2 I1 I0 */
+#define IO_8P		0xFFFF	/* P7 P6 P5 P4 P3 P2 P1 P0 */
+#define IO_8O		0x5555	/* O7 O6 O5 O4 O3 O2 O1 O0 */
+
+#define GROUP_A(x)	((x) & 0xffff)	/* I2C Addr: 0b'110xxxx */
+#define GROUP_B(x)	((x) << 16)	/* I2C Addr: 0b'101xxxx */
+
+static const struct i2c_device_id max732x_id[] = {
+	{ "max7319", GROUP_A(IO_8I) },
+	{ "max7320", GROUP_B(IO_8O) },
+	{ "max7321", GROUP_A(IO_8P) },
+	{ "max7322", GROUP_A(IO_4I4O) },
+	{ "max7323", GROUP_A(IO_4P4O) },
+	{ "max7324", GROUP_A(IO_8I) | GROUP_B(IO_8O) },
+	{ "max7325", GROUP_A(IO_8P) | GROUP_B(IO_8O) },
+	{ "max7326", GROUP_A(IO_4I4O) | GROUP_B(IO_8O) },
+	{ "max7327", GROUP_A(IO_4P4O) | GROUP_B(IO_8O) },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, max732x_id);
+
+struct max732x_chip {
+	struct gpio_chip gpio_chip;
+
+	struct i2c_client *client_dummy;
+	struct i2c_client *client_group_a;
+	struct i2c_client *client_group_b;
+
+	unsigned int	mask_group_a;
+	unsigned int	dir_input;
+	unsigned int	dir_output;
+
+	struct mutex	lock;
+	uint8_t		reg_out[2];
+};
+
+static int max732x_write(struct max732x_chip *chip, int group_a, uint8_t val)
+{
+	struct i2c_client *client;
+	int ret;
+
+	client = group_a ? chip->client_group_a : chip->client_group_b;
+
+	BUG_ON(client == NULL);
+
+	ret = i2c_smbus_write_byte(client, val);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed writing\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max732x_read(struct max732x_chip *chip, int group_a, uint8_t *val)
+{
+	struct i2c_client *client;
+	int ret;
+
+	client = group_a ? chip->client_group_a : chip->client_group_b;
+
+	BUG_ON(client == NULL);
+
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed reading\n");
+		return ret;
+	}
+
+	*val = (uint8_t)ret;
+	return 0;
+}
+
+static inline int is_group_a(struct max732x_chip *chip, unsigned off)
+{
+	return (1u << off) & chip->mask_group_a;
+}
+
+static int max732x_gpio_get_value(struct gpio_chip *gc, unsigned off)
+{
+	struct max732x_chip *chip;
+	uint8_t reg_val;
+	int ret;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	ret = max732x_read(chip, is_group_a(chip, off), &reg_val);
+	if (ret < 0)
+		return 0;
+
+	return reg_val & (1u << (off & 0x7));
+}
+
+static void max732x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
+{
+	struct max732x_chip *chip;
+	uint8_t reg_out, mask = 1u << (off & 0x7);
+	int ret;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	mutex_lock(&chip->lock);
+
+	reg_out = (off > 7) ? chip->reg_out[1] : chip->reg_out[0];
+	reg_out = (val) ? reg_out | mask : reg_out & ~mask;
+
+	ret = max732x_write(chip, is_group_a(chip, off), reg_out);
+	if (ret < 0)
+		goto out;
+
+	/* update the shadow register then */
+	if (off > 7)
+		chip->reg_out[1] = reg_out;
+	else
+		chip->reg_out[0] = reg_out;
+out:
+	mutex_unlock(&chip->lock);
+}
+
+static int max732x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	struct max732x_chip *chip;
+	unsigned int mask = 1u << off;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	if ((mask & chip->dir_input) == 0) {
+		pr_warning("%s: port %d is output only\n", __func__, off);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+static int max732x_gpio_direction_output(struct gpio_chip *gc,
+		unsigned off, int val)
+{
+	struct max732x_chip *chip;
+	unsigned int mask = 1u << off;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	if ((mask & chip->dir_output) == 0) {
+		pr_warning("%s: port %d is input only\n", __func__, off);
+		return -EACCES;
+	}
+
+	max732x_gpio_set_value(gc, off, val);
+	return 0;
+}
+
+static int __devinit max732x_setup_gpio(struct max732x_chip *chip,
+					const struct i2c_device_id *id,
+					unsigned gpio_start)
+{
+	struct gpio_chip *gc = &chip->gpio_chip;
+	uint32_t id_data = id->driver_data;
+	int i, port = 0;
+
+	for (i = 0; i < 16; i++, id_data >>= 2) {
+		unsigned int mask = 1 << port;
+
+		switch (id_data & 0x3) {
+		case PORT_OUTPUT:
+			chip->dir_output |= mask;
+			break;
+		case PORT_INPUT:
+			chip->dir_input |= mask;
+			break;
+		case PORT_OPENDRAIN:
+			chip->dir_output |= mask;
+			chip->dir_input |= mask;
+			break;
+		default:
+			continue;
+		}
+
+		if (i < 8)
+			chip->mask_group_a |= mask;
+		port++;
+	}
+
+	gc->direction_input  = max732x_gpio_direction_input;
+	gc->direction_output = max732x_gpio_direction_output;
+	gc->get = max732x_gpio_get_value;
+	gc->set = max732x_gpio_set_value;
+	gc->can_sleep = 1;
+
+	gc->base = gpio_start;
+	gc->ngpio = port;
+	gc->label = "max732x";
+	gc->owner = THIS_MODULE;
+
+	return port;
+}
+
+static int __devinit max732x_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct max732x_platform_data *pdata;
+	struct max732x_chip *chip;
+	struct i2c_client *c;
+	uint16_t addr_a, addr_b;
+	int ret, nr_port;
+
+	pdata = client->dev.platform_data;
+	if (pdata == NULL)
+		return -ENODEV;
+
+	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	nr_port = max732x_setup_gpio(chip, id, pdata->gpio_base);
+
+	addr_a = (client->addr & 0x0f) | 0x60;
+	addr_b = (client->addr & 0x0f) | 0x50;
+
+	switch (client->addr & 0x70) {
+	case 0x60:
+		chip->client_group_a = client;
+		if (nr_port > 7) {
+			c = i2c_new_dummy(client->adapter, addr_b);
+			chip->client_group_b = chip->client_dummy = c;
+		}
+		break;
+	case 0x50:
+		chip->client_group_b = client;
+		if (nr_port > 7) {
+			c = i2c_new_dummy(client->adapter, addr_a);
+			chip->client_group_a = chip->client_dummy = c;
+		}
+		break;
+	default:
+		dev_err(&client->dev, "invalid I2C address specified %02x\n",
+				client->addr);
+		return -EINVAL;
+	}
+
+	mutex_init(&chip->lock);
+
+	max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
+	if (nr_port > 7)
+		max732x_read(chip, is_group_a(chip, 8), &chip->reg_out[1]);
+
+	ret = gpiochip_add(&chip->gpio_chip);
+	if (ret)
+		goto out_failed;
+
+	if (pdata->setup) {
+		ret = pdata->setup(client, chip->gpio_chip.base,
+				chip->gpio_chip.ngpio, pdata->context);
+		if (ret < 0)
+			dev_warn(&client->dev, "setup failed, %d\n", ret);
+	}
+
+	i2c_set_clientdata(client, chip);
+	return 0;
+
+out_failed:
+	kfree(chip);
+	return ret;
+}
+
+static int __devexit max732x_remove(struct i2c_client *client)
+{
+	struct max732x_platform_data *pdata = client->dev.platform_data;
+	struct max732x_chip *chip = i2c_get_clientdata(client);
+	int ret;
+
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
+	/* unregister the dummy i2c_client */
+	if (chip->client_dummy)
+		i2c_unregister_device(chip->client_dummy);
+
+	kfree(chip);
+	return 0;
+}
+
+static struct i2c_driver max732x_driver = {
+	.driver = {
+		.name	= "max732x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max732x_probe,
+	.remove		= __devexit_p(max732x_remove),
+	.id_table	= max732x_id,
+};
+
+static int __init max732x_init(void)
+{
+	return i2c_add_driver(&max732x_driver);
+}
+module_init(max732x_init);
+
+static void __exit max732x_exit(void)
+{
+	i2c_del_driver(&max732x_driver);
+}
+module_exit(max732x_exit);
+
+MODULE_AUTHOR("Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("GPIO expander driver for MAX732X");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/max732x.h b/include/linux/i2c/max732x.h
new file mode 100644
index 0000000..e103366
--- /dev/null
+++ b/include/linux/i2c/max732x.h
@@ -0,0 +1,19 @@
+#ifndef __LINUX_I2C_MAX732X_H
+#define __LINUX_I2C_MAX732X_H
+
+/* platform data for the MAX732x 8/16-bit I/O expander driver */
+
+struct max732x_platform_data {
+	/* number of the first GPIO */
+	unsigned	gpio_base;
+
+	void		*context;	/* param to setup/teardown */
+
+	int		(*setup)(struct i2c_client *client,
+				unsigned gpio, unsigned ngpio,
+				void *context);
+	int		(*teardown)(struct i2c_client *client,
+				unsigned gpio, unsigned ngpio,
+				void *context);
+};
+#endif /* __LINUX_I2C_MAX732X_H */
-- 
1.5.4.3

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
