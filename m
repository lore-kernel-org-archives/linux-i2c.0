From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Thu, 10 Jul 2008 14:13:39 +0800
Message-ID: <4875A893.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/gpio/Kconfig        |   22 +++
 drivers/gpio/Makefile       |    1 +
 drivers/gpio/max732x.c      |  342 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/max732x.h |   19 +++
 4 files changed, 384 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/max732x.c
 create mode 100644 include/linux/i2c/max732x.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bbd2834..9f8d030 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -61,6 +61,28 @@ config GPIO_PCF857X
 	  This driver provides an in-kernel interface to those GPIOs using
 	  platform-neutral GPIO calls.
 
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
 comment "SPI GPIO expanders:"
 
 config GPIO_MCP23S08
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fdde992..814698c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
+obj-$(CONFIG_GPIO_MAX732X)	+= max732x.o
diff --git a/drivers/gpio/max732x.c b/drivers/gpio/max732x.c
new file mode 100644
index 0000000..b1b9b62
--- /dev/null
+++ b/drivers/gpio/max732x.c
@@ -0,0 +1,342 @@
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
+#include <linux/i2c.h>
+#include <linux/i2c/max732x.h>
+
+#include <asm/gpio.h>
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
+ * up to 8 I/O ports, and is accessed by different I2C address:
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
+	struct i2c_client *client;
+	struct gpio_chip gpio_chip;
+
+	unsigned	gpio_start;
+	unsigned short	addr_group_a;
+	unsigned short	addr_group_b;
+
+	unsigned int	mask_group_a;
+	unsigned int	dir_input;
+	unsigned int	dir_output;
+	uint8_t		reg_out[2];
+};
+
+/* NOTE:  we can't currently rely on fault codes to come from SMBus
+ * calls, so we map all errors to EIO here and return zero otherwise.
+ */
+static int max732x_write(struct max732x_chip *chip, int group_a, uint8_t val)
+{
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	client->addr = group_a ? chip->addr_group_a : chip->addr_group_b;
+
+	ret = i2c_smbus_write_byte(client, val);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed writing\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int max732x_read(struct max732x_chip *chip, int group_a, uint8_t *val)
+{
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	client->addr = group_a ? chip->addr_group_a : chip->addr_group_b;
+
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed reading\n");
+		return -EIO;
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
+	return (reg_val & (1u << (off & 0x7))) ? 1 : 0;
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
+	reg_out = (off > 7) ? chip->reg_out[1] : chip->reg_out[0];
+	reg_out = (val) ? reg_out | mask : reg_out & ~mask;
+
+	ret = max732x_write(chip, is_group_a(chip, off), reg_out);
+	if (ret < 0)
+		return;
+
+	/* update the shadow register then */
+	if (off > 7)
+		chip->reg_out[1] = reg_out;
+	else
+		chip->reg_out[0] = reg_out;
+}
+
+static int max732x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	struct max732x_chip *chip;
+	unsigned int mask = 1u << off;
+
+	chip = container_of(gc, struct max732x_chip, gpio_chip);
+
+	if ((mask & chip->dir_input) == 0)
+		pr_warning("%s: port %d is output only\n", __func__, off);
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
+		return 0;
+	}
+
+	max732x_gpio_set_value(gc, off, val);
+	return 0;
+}
+
+static void max732x_setup_gpio(struct max732x_chip *chip, uint32_t id_data)
+{
+	struct gpio_chip *gc = &chip->gpio_chip;
+	int i, port = 0, nr_port;
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
+	nr_port = port;
+
+	if (nr_port > 7) {
+		max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
+		max732x_read(chip, is_group_a(chip, 8), &chip->reg_out[1]);
+	} else
+		max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
+
+	gc->direction_input  = max732x_gpio_direction_input;
+	gc->direction_output = max732x_gpio_direction_output;
+	gc->get = max732x_gpio_get_value;
+	gc->set = max732x_gpio_set_value;
+	gc->can_sleep = 1;
+
+	gc->base = chip->gpio_start;
+	gc->ngpio = port;
+	gc->label = chip->client->name;
+	gc->owner = THIS_MODULE;
+}
+
+static int __devinit max732x_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct max732x_platform_data *pdata;
+	struct max732x_chip *chip;
+	int ret;
+
+	pdata = client->dev.platform_data;
+	if (pdata == NULL)
+		return -ENODEV;
+
+	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	chip->client = client;
+
+	chip->gpio_start = pdata->gpio_base;
+	chip->addr_group_a = (client->addr & 0x0f) | 0x60;
+	chip->addr_group_b = (client->addr & 0x0f) | 0x50;
+
+	max732x_setup_gpio(chip, id->driver_data);
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
+static int max732x_remove(struct i2c_client *client)
+{
+	struct max732x_platform_data *pdata = client->dev.platform_data;
+	struct max732x_chip *chip = i2c_get_clientdata(client);
+	int ret = 0;
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
+	kfree(chip);
+	return 0;
+}
+
+static struct i2c_driver max732x_driver = {
+	.driver = {
+		.name	= "max732x",
+	},
+	.probe		= max732x_probe,
+	.remove		= max732x_remove,
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
