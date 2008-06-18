From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: [PATCH v2] Driver for NS LP3944 FunLight Chip
Date: Wed, 18 Jun 2008 09:46:45 +0200
Message-ID: <20080618094645.1a7c8c26.ospite@studenti.unina.it>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

here's a driver for the National Semiconductor LP3944 FunLight Chip,
I wrote it for the OpenEZX project (http://www.openezx.org).

Can you please give some feedback about its status?

I2C driver for National Semiconductor LP3944 Funlight Chip
http://www.national.com/pf/LP/LP3944.html

This helper chip can drive up to 8 leds, with two programmable dim modes;
it could even be used as a gpio expander but this driver assumes it is used
as a led controller.

The dim modes are used to set _blink_ patterns for leds, the pattern is
specified supplying two parameters:
  - period: from 0s to 1.6s
  - duty cycle: percentage of the period the led is on, from 0 to 100

LP3944 can be found on Motorola A910 smartphone, where it drives the rgb
leds, the camera flash light and the displays backlights.

Signed-off-by: Antonio Ospite <ao2-WB6LKoYH/xlAfugRpC6u6w@public.gmane.org>

Index: linux-2.6.26-rc6/drivers/i2c/chips/lp3944.c
===================================================================
--- /dev/null
+++ linux-2.6.26-rc6/drivers/i2c/chips/lp3944.c
@@ -0,0 +1,436 @@
+/*
+ * lp3944.c - driver for National Semiconductor LP3944 Funlight Chip
+ *
+ * Copyright (C) 2008 Antonio Ospite <ao2-WB6LKoYH/xlAfugRpC6u6w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/*
+ * I2C driver for National Semiconductor LP3944 Funlight Chip
+ * http://www.national.com/pf/LP/LP3944.html
+ *
+ * This helper chip can drive up to 8 leds, with two programmable DIM modes;
+ * it could even be used as a gpio expander but this driver assumes it is used
+ * as a led controller.
+ *
+ * The DIM modes are used to set _blink_ patterns for leds, the pattern is
+ * specified supplying two parameters:
+ *   - period: from 0s to 1.6s
+ *   - duty cycle: percentage of the period the led is on, from 0 to 100
+ *
+ * LP3944 can be found on Motorola A910 smartphone, where it drives the rgb
+ * leds, the camera flash light and the displays backlights.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c/lp3944.h>
+
+#define LP3944_REG_INPUT1	0x00	/* LEDs 0-7 InputRegister (Read Only) */
+#define LP3944_REG_REGISTER1	0x01	/* None (Read Only) */
+#define LP3944_REG_PSC0		0x02	/* Frequency Prescaler 0 (R/W) */
+#define LP3944_REG_PWM0		0x03	/* PWM Register 0 (R/W) */
+#define LP3944_REG_PSC1		0x04	/* Frequency Prescaler 1 (R/W) */
+#define LP3944_REG_PWM1		0x05	/* PWM Register 1 (R/W) */
+#define LP3944_REG_LS0		0x06	/* LEDs 0-3 Selector (R/W) */
+#define LP3944_REG_LS1		0x07	/* LEDs 4-7 Selector (R/W) */
+#define LP3944_REG_REGISTER8	0x08	/* None (R/W) */
+#define LP3944_REG_REGISTER9	0x09	/* None (R/W) */
+
+#define LP3944_LED_STATUS_MASK	0x03
+
+/* Saved data */
+struct lp3944_data {
+	struct i2c_client *client;
+	struct mutex lock;
+
+	/* Only regs from 2 to 9 are R/W */
+	u8 LP3944_REGS[8];
+};
+
+static struct lp3944_data *lp3944;
+
+static int lp3944_reg_read(struct i2c_client *client, unsigned reg,
+			   unsigned *value);
+static int lp3944_reg_write(struct i2c_client *client, unsigned reg,
+			    unsigned value);
+
+/*
+ * Set the period in DIM status
+ *
+ * @dim: LP3944_DIM0 | LP3944_DIM1
+ * @period: period of a blink, that is a on/off cycle, in 1/10 sec
+ */
+int lp3944_dim_set_period(unsigned dim, unsigned period)
+{
+	unsigned psc_reg;
+	unsigned psc_value;
+	int err;
+
+	if (dim == LP3944_DIM0)
+		psc_reg = LP3944_REG_PSC0;
+	else if (dim == LP3944_DIM1)
+		psc_reg = LP3944_REG_PSC1;
+	else
+		return -EINVAL;
+
+	/* Convert period to Prescaler value */
+	if (period > LP3944_PERIOD_MAX)
+		return -EINVAL;
+
+	if (period == LP3944_PERIOD_MIN)
+		psc_value = 0;
+	else
+		psc_value = (period * LP3944_PERIOD_MAX) - 1;
+
+	mutex_lock(&lp3944->lock);
+	err = lp3944_reg_write(lp3944->client, psc_reg, psc_value);
+	mutex_unlock(&lp3944->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(lp3944_dim_set_period);
+
+/*
+ * Set the duty cycle in DIM status
+ *
+ * @dim: LP3944_DIM0 | LP3944_DIM1
+ * @duty_cycle: percentage of a period in which a led is ON
+ */
+int lp3944_dim_set_dutycycle(unsigned dim, unsigned duty_cycle)
+{
+	unsigned pwm_reg;
+	unsigned pwm_value;
+	int err;
+
+	if (dim == LP3944_DIM0)
+		pwm_reg = LP3944_REG_PWM0;
+	else if (dim == LP3944_DIM1)
+		pwm_reg = LP3944_REG_PWM1;
+	else
+		return -EINVAL;
+
+	/* Convert duty cycle to PWM value */
+	if (duty_cycle > LP3944_DUTY_CYCLE_MAX)
+		return -EINVAL;
+
+	if (duty_cycle == LP3944_DUTY_CYCLE_MAX)
+		pwm_value = 255;
+	else
+		pwm_value = (duty_cycle * 256) / 100;
+
+	mutex_lock(&lp3944->lock);
+	err = lp3944_reg_write(lp3944->client, pwm_reg, pwm_value);
+	mutex_unlock(&lp3944->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(lp3944_dim_set_dutycycle);
+
+/*
+ * Set the led status
+ *
+ * @led: LP3944_LED0-LP3944_LED7
+ * @status: off, on, dim0, dim1
+ */
+int lp3944_led_set(unsigned led, unsigned status)
+{
+	unsigned reg;
+	unsigned val;
+	int err;
+
+	switch (led) {
+	case LP3944_LED0:
+	case LP3944_LED1:
+	case LP3944_LED2:
+	case LP3944_LED3:
+		reg = LP3944_REG_LS0;
+		break;
+	case LP3944_LED4:
+	case LP3944_LED5:
+	case LP3944_LED6:
+	case LP3944_LED7:
+		led -= LP3944_LED4;
+		reg = LP3944_REG_LS1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (status > LP3944_LED_STATUS_DIM1)
+		return -EINVAL;
+
+	mutex_lock(&lp3944->lock);
+	lp3944_reg_read(lp3944->client, reg, &val);
+
+	val &= ~(LP3944_LED_STATUS_MASK << (led << 1));
+	val |= (status << (led << 1));
+
+	pr_debug("%s: led %d, status %d, val: 0x%02x\n",
+		 __func__, led, status, val);
+
+	/* set led status */
+	err = lp3944_reg_write(lp3944->client, reg, val);
+	mutex_unlock(&lp3944->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(lp3944_led_set);
+
+/* low-level sysfs interface */
+static ssize_t lp3944_get_reg(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned reg;
+	unsigned val;
+	int ret = 0;
+
+	/* line length = strlen("0x00 0x00\n") */
+	const int l = 10;
+
+	for (reg = 0; reg <= LP3944_REG_REGISTER9; reg++) {
+		/*
+		 * we could even use lp3944 auto-increment feature here, but
+		 * that's not very important.
+		 */
+		lp3944_reg_read(client, reg, &val);
+		ret += sprintf(buf + l * reg, "0x%02x 0x%02x\n", reg, val);
+	}
+
+	return ret;
+}
+
+static ssize_t lp3944_set_reg(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned reg;
+	unsigned val;
+
+	if (sscanf(buf, "0x%2x 0x%2x", &reg, &val) != 2)
+		return -EINVAL;
+
+	if (reg > LP3944_REG_REGISTER9)
+		return -EINVAL;
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	lp3944_reg_write(client, reg, val);
+
+	return count;
+}
+
+static DEVICE_ATTR(reg, S_IWUSR | S_IRUGO, lp3944_get_reg, lp3944_set_reg);
+
+static struct attribute *lp3944_attributes[] = {
+	&dev_attr_reg.attr,
+	NULL
+};
+
+static const struct attribute_group lp3944_attr_group = {
+	.attrs = lp3944_attributes,
+};
+
+/* private stuff */
+
+static int lp3944_reg_read(struct i2c_client *client, unsigned reg,
+			   unsigned *value)
+{
+	int tmp;
+
+	tmp = i2c_smbus_read_byte_data(client, reg);
+	if (tmp < 0)
+		return -EINVAL;
+
+	*value = (unsigned) tmp;
+	pr_debug("%s: reg: 0x%02x value: 0x%02x\n", __func__, reg, *value);
+
+	return 0;
+}
+
+static int lp3944_reg_write(struct i2c_client *client, unsigned reg,
+			    unsigned value)
+{
+	unsigned tmp;
+	int ret;
+
+	tmp = i2c_smbus_read_byte_data(client, reg);
+	pr_debug("%s: before write reg: 0x%02x value: 0x%02x\n",
+		 __func__, reg, tmp);
+
+	ret = i2c_smbus_write_byte_data(client, reg, value);
+
+	tmp = i2c_smbus_read_byte_data(client, reg);
+	pr_debug("%s: after write reg: 0x%02x value: 0x%02x\n",
+		 __func__, reg, tmp);
+
+	return ret;
+}
+
+static int lp3944_init_client(struct i2c_client *client)
+{
+	struct lp3944_data *data = i2c_get_clientdata(client);
+	int tmp;
+
+	/* Try to read a byte, if it fails, return an error */
+	tmp = i2c_smbus_read_byte_data(client, LP3944_REG_INPUT1);
+	if (tmp < 0)
+		return -ENODEV;
+
+	/* Default values, taken from official datasheet */
+	lp3944_reg_write(client, LP3944_REG_PSC0, 0x00);
+	lp3944_reg_write(client, LP3944_REG_PWM0, 0x80);
+	lp3944_reg_write(client, LP3944_REG_PSC1, 0x00);
+	lp3944_reg_write(client, LP3944_REG_PWM1, 0x80);
+	lp3944_reg_write(client, LP3944_REG_LS0, 0x00);
+	lp3944_reg_write(client, LP3944_REG_LS1, 0x00);
+
+	data->LP3944_REGS[0] = 0x00;
+	data->LP3944_REGS[1] = 0x80;
+	data->LP3944_REGS[2] = 0x00;
+	data->LP3944_REGS[3] = 0x80;
+	data->LP3944_REGS[4] = 0x00;
+	data->LP3944_REGS[5] = 0x00;
+
+	return 0;
+}
+
+static int __devinit lp3944_probe(struct i2c_client *client)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct lp3944_data *data;
+	int err;
+
+	dev_dbg(&client->dev, "adapter %s!\n", adapter->name);
+
+	if (lp3944) {
+		dev_dbg(&client->dev, "only one lp3944 chip allowed.\n");
+		return -ENODEV;
+	}
+
+	/* Let's see whether this adapter can support what we need. */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		printk(KERN_ERR "%s: insufficient functionality!\n", __func__);
+		err = -EIO;
+		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct lp3944_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	mutex_init(&data->lock);
+
+	/* Initialize the lp3944 chip */
+	err = lp3944_init_client(client);
+	if (err)
+		goto exit_kfree;
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &lp3944_attr_group);
+	if (err)
+		goto exit_kfree;
+
+	lp3944 = data;
+	dev_info(&client->dev, "lp3944 enabled\n");
+
+	return 0;
+
+exit_kfree:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int __devexit lp3944_remove(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &lp3944_attr_group);
+
+	lp3944_reg_write(client, LP3944_REG_LS0, 0x00);
+	lp3944_reg_write(client, LP3944_REG_LS1, 0x00);
+
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int lp3944_suspend(struct i2c_client *client, pm_message_t state)
+{
+	struct lp3944_data *data = i2c_get_clientdata(client);
+	int i;
+
+	dev_dbg(&client->dev, "lp3944_suspend\n");
+
+	for (i = 2; i < LP3944_REG_REGISTER9; i++)
+		data->LP3944_REGS[i - 2] = i2c_smbus_read_byte_data(client, i);
+
+	return 0;
+}
+
+static int lp3944_resume(struct i2c_client *client)
+{
+	struct lp3944_data *data = i2c_get_clientdata(client);
+	int i;
+
+	dev_dbg(&client->dev, "lp3944_resume\n");
+
+	for (i = 2; i < LP3944_REG_REGISTER9; i++)
+		i2c_smbus_write_byte_data(client, i, data->LP3944_REGS[i - 2]);
+
+	return 0;
+}
+#else
+
+#define lp3944_suspend NULL
+#define lp3944_resume NULL
+
+#endif /* CONFIG_PM */
+
+/* lp3944 i2c driver struct */
+static struct i2c_driver lp3944_driver = {
+	.driver = {
+		   .name  = "lp3944",
+		   .owner = THIS_MODULE,
+		   },
+	.probe   = lp3944_probe,
+	.remove  = lp3944_remove,
+	.suspend = lp3944_suspend,
+	.resume  = lp3944_resume,
+};
+
+static int __init lp3944_module_init(void)
+{
+	int err;
+
+	err = i2c_add_driver(&lp3944_driver);
+	if (err)
+		printk(KERN_ERR "%s: can't add i2c driver\n", __func__);
+
+	return err;
+}
+
+static void __exit lp3944_module_exit(void)
+{
+	i2c_del_driver(&lp3944_driver);
+}
+
+module_init(lp3944_module_init);
+module_exit(lp3944_module_exit);
+
+/* Module information */
+MODULE_AUTHOR("Antonio Ospite <ao2-WB6LKoYH/xlAfugRpC6u6w@public.gmane.org>");
+MODULE_DESCRIPTION("LP3944 Fun Light Chip");
+MODULE_LICENSE("GPL");
Index: linux-2.6.26-rc6/drivers/i2c/chips/Kconfig
===================================================================
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/Kconfig
+++ linux-2.6.26-rc6/drivers/i2c/chips/Kconfig
@@ -129,6 +129,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called tsl2550.
 
+config LP3944
+	tristate "National Semiconductor LP3944 Fun Light Chip"
+	depends on EXPERIMENTAL
+	help
+	  If you say yes here you get support for the National Semiconductor LP3944
+	  Lighting Management Unit (LMU) also known as a Fun Light Chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lp3944.
+
 config MENELAUS
 	bool "TWL92330/Menelaus PM chip"
 	depends on I2C=y && ARCH_OMAP24XX
Index: linux-2.6.26-rc6/drivers/i2c/chips/Makefile
===================================================================
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/Makefile
+++ linux-2.6.26-rc6/drivers/i2c/chips/Makefile
@@ -20,6 +20,7 @@
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
+obj-$(CONFIG_LP3944)		+= lp3944.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
Index: linux-2.6.26-rc6/include/linux/i2c/lp3944.h
===================================================================
--- /dev/null
+++ linux-2.6.26-rc6/include/linux/i2c/lp3944.h
@@ -0,0 +1,45 @@
+/*
+ * lp3944.h - public interface for National Semiconductor LP3944 Funlight Chip
+ *
+ * Copyright (C) 2008 Antonio Ospite <ao2-WB6LKoYH/xlAfugRpC6u6w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __LINUX_I2C_LP3944_H
+#define __LINUX_I2C_LP3944_H
+
+#define LP3944_LED0 0
+#define LP3944_LED1 1
+#define LP3944_LED2 2
+#define LP3944_LED3 3
+#define LP3944_LED4 4
+#define LP3944_LED5 5
+#define LP3944_LED6 6
+#define LP3944_LED7 7
+
+#define LP3944_DIM0 0
+#define LP3944_DIM1 1
+
+/* period in 1/10 sec */
+#define LP3944_PERIOD_MIN 0
+#define LP3944_PERIOD_MAX 16
+
+/* duty cycle is a percentage */
+#define LP3944_DUTY_CYCLE_MIN 0
+#define LP3944_DUTY_CYCLE_MAX 100
+
+/* led statuses */
+#define LP3944_LED_STATUS_OFF	0x0
+#define LP3944_LED_STATUS_ON	0x1
+#define LP3944_LED_STATUS_DIM0	0x2
+#define LP3944_LED_STATUS_DIM1	0x3
+
+extern int lp3944_dim_set_period(unsigned dim, unsigned period);
+extern int lp3944_dim_set_dutycycle(unsigned int dim, unsigned duty_cycle);
+extern int lp3944_led_set(unsigned led, unsigned status);
+
+#endif /* __LINUX_I2C_LP3944_H */
Index: linux-2.6.26-rc6/Documentation/i2c/chips/lp3944
===================================================================
--- /dev/null
+++ linux-2.6.26-rc6/Documentation/i2c/chips/lp3944
@@ -0,0 +1,101 @@
+Kernel driver lp3944
+====================
+
+  * National Semiconductor LP3944 Fun-light Chip
+    Prefix: 'lp3944'
+    Addresses scanned: None (see the Notes section below)
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LP/LP3944.html
+
+Authors:
+        Antonio Ospite <ao2-WB6LKoYH/xlAfugRpC6u6w@public.gmane.org>
+
+
+Description
+-----------
+The LP3944 is a helper chip that can drive up to 8 leds, with two programmable
+DIM modes; it could even be used as a gpio expander but this driver assumes it
+is used as a led controller.
+
+The DIM modes are used to set _blink_ patterns for leds, the pattern is
+specified supplying two parameters:
+  - period: from 0s to 1.6s
+  - duty cycle: percentage of the period the led is on, from 0 to 100
+
+Setting a led in DIM0 or DIM1 mode makes it blink according to the pattern.
+
+See the datasheet for details.
+
+LP3944 can be found on Motorola A910 smartphone, where it drives the rgb
+leds, the camera flash light and the displays backlights.
+
+
+Notes
+-----
+The chip is used mainly in embedded contextes, so this driver expects it is
+registered using the i2c_board_info mechanism.
+
+To register the chip at address 0x60 on adapter 0, set the info:
+
+	static struct i2c_board_info __initdata a910_i2c_board_info[] = {
+		{
+			I2C_BOARD_INFO("lp3944", 0x60),
+			.type = "lp3944",
+		},
+	};
+
+and register it in the platform init function
+
+	i2c_register_board_info(0, a910_i2c_board_info,
+			ARRAY_SIZE(a910_i2c_board_info));
+
+
+Accessing LP3944 via exported interface
+---------------------------------------
+The driver exposes a friendly interface to abstract the chip functionalities
+for other drivers to use.
+
+Including include/linux/i2c/lp3944.h one can use these calls:
+
+extern int lp3944_dim_set_period(unsigned dim, unsigned period);
+extern int lp3944_dim_set_dutycycle(unsigned int dim, unsigned duty_cycle);
+extern int lp3944_led_set(unsigned led, unsigned status);
+
+in a leds-class driver.
+
+
+Accessing LP3944 via /sys interface
+-----------------------------------
+Standard i2c sysfs interface can be found at
+/sys/bus/i2c/devices/<0>-<1>/
+or
+/sys/bus/i2c/drivers/lp3944/<0>-<1>/
+
+where <0> is the bus the chip was registered to (e. g. i2c-0)
+and <1> the chip address.
+
+Additionally, there is a R/W 'reg' file which can be used to dump and set
+register values.
+  $ cat reg
+  0x00 0xd7
+  0x01 0x00
+  0x02 0x4f
+  0x03 0x0c
+  0x04 0x9f
+  0x05 0x80
+  0x06 0x40
+  0x07 0x00
+  0x08 0x00
+  0x09 0x00
+
+Set period and duty_cycle for DIM0 mode:
+  $ echo 0x02 0x4f > reg
+  $ echo 0x03 0x0c > reg
+
+Set LED0 mode to DIM0
+  $ echo 0x06 0x02 > reg
+
+Registers 0x08 and 0x09 are not used for led control but are still valid to
+store arbitrary bytes :)
+  $ echo 0x08 0xde > reg
+  $ echo 0x09 0xad > reg

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
