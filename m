From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [PATCH 1/3] Prepare to extend pca9539 to support more chips -
 rename files
Date: Thu, 31 Jan 2008 23:06:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801312303270.3704@axis700.grange>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
	<200801311301.23117.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200801311301.23117.david-b@pacbell.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, video4linux-list@redhat.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

First stage of the extension, letting pca9539 also support
pca9536, pca9537, and pca9538. Split to make review easier.
Here only rename the files and modify the Makefile.
    
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>

---

On Thu, 31 Jan 2008, David Brownell wrote:

> On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> > This is a git-style rename patch. If desired, I can produce a complete GNU 
> > patch instead.
> 
> Yes, please.  This goes through Andrew's tree, using Quilt.

Below.

Are you expecting your gpiolib, and, respectively, this patch to be pushed 
to Linus for 2.6.25 or more likely later?

Thanks
Guennadi


diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 470ecd6..16dda77 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -5,5 +5,5 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o
 
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
-obj-$(CONFIG_GPIO_PCA9539)	+= pca9539.o
+obj-$(CONFIG_GPIO_PCA9539)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
diff --git a/drivers/gpio/pca9539.c b/drivers/gpio/pca9539.c
deleted file mode 100644
index 3e85c92..0000000
--- a/drivers/gpio/pca9539.c
+++ /dev/null
@@ -1,271 +0,0 @@
-/*
- *  pca9539.c - 16-bit I/O port with interrupt and reset
- *
- *  Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
- *  Copyright (C) 2007 Marvell International Ltd.
- *
- *  Derived from drivers/i2c/chips/pca9539.c
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/i2c/pca9539.h>
-
-#include <asm/gpio.h>
-
-
-#define NR_PCA9539_GPIOS	16
-
-#define PCA9539_INPUT		0
-#define PCA9539_OUTPUT		2
-#define PCA9539_INVERT		4
-#define PCA9539_DIRECTION	6
-
-struct pca9539_chip {
-	unsigned gpio_start;
-	uint16_t reg_output;
-	uint16_t reg_direction;
-
-	struct i2c_client *client;
-	struct gpio_chip gpio_chip;
-};
-
-/* NOTE:  we can't currently rely on fault codes to come from SMBus
- * calls, so we map all errors to EIO here and return zero otherwise.
- */
-static int pca9539_write_reg(struct pca9539_chip *chip, int reg, uint16_t val)
-{
-	if (i2c_smbus_write_word_data(chip->client, reg, val) < 0)
-		return -EIO;
-	else
-		return 0;
-}
-
-static int pca9539_read_reg(struct pca9539_chip *chip, int reg, uint16_t *val)
-{
-	int ret;
-
-	ret = i2c_smbus_read_word_data(chip->client, reg);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "failed reading register\n");
-		return -EIO;
-	}
-
-	*val = (uint16_t)ret;
-	return 0;
-}
-
-static int pca9539_gpio_direction_input(struct gpio_chip *gc, unsigned off)
-{
-	struct pca9539_chip *chip;
-	uint16_t reg_val;
-	int ret;
-
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
-
-	reg_val = chip->reg_direction | (1u << off);
-	ret = pca9539_write_reg(chip, PCA9539_DIRECTION, reg_val);
-	if (ret)
-		return ret;
-
-	chip->reg_direction = reg_val;
-	return 0;
-}
-
-static int pca9539_gpio_direction_output(struct gpio_chip *gc,
-		unsigned off, int val)
-{
-	struct pca9539_chip *chip;
-	uint16_t reg_val;
-	int ret;
-
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
-
-	/* set output level */
-	if (val)
-		reg_val = chip->reg_output | (1u << off);
-	else
-		reg_val = chip->reg_output & ~(1u << off);
-
-	ret = pca9539_write_reg(chip, PCA9539_OUTPUT, reg_val);
-	if (ret)
-		return ret;
-
-	chip->reg_output = reg_val;
-
-	/* then direction */
-	reg_val = chip->reg_direction & ~(1u << off);
-	ret = pca9539_write_reg(chip, PCA9539_DIRECTION, reg_val);
-	if (ret)
-		return ret;
-
-	chip->reg_direction = reg_val;
-	return 0;
-}
-
-static int pca9539_gpio_get_value(struct gpio_chip *gc, unsigned off)
-{
-	struct pca9539_chip *chip;
-	uint16_t reg_val;
-	int ret;
-
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
-
-	ret = pca9539_read_reg(chip, PCA9539_INPUT, &reg_val);
-	if (ret < 0) {
-		/* NOTE:  diagnostic already emitted; that's all we should
-		 * do unless gpio_*_value_cansleep() calls become different
-		 * from their nonsleeping siblings (and report faults).
-		 */
-		return 0;
-	}
-
-	return (reg_val & (1u << off)) ? 1 : 0;
-}
-
-static void pca9539_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
-{
-	struct pca9539_chip *chip;
-	uint16_t reg_val;
-	int ret;
-
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
-
-	if (val)
-		reg_val = chip->reg_output | (1u << off);
-	else
-		reg_val = chip->reg_output & ~(1u << off);
-
-	ret = pca9539_write_reg(chip, PCA9539_OUTPUT, reg_val);
-	if (ret)
-		return;
-
-	chip->reg_output = reg_val;
-}
-
-static int pca9539_init_gpio(struct pca9539_chip *chip)
-{
-	struct gpio_chip *gc;
-
-	gc = &chip->gpio_chip;
-
-	gc->direction_input  = pca9539_gpio_direction_input;
-	gc->direction_output = pca9539_gpio_direction_output;
-	gc->get = pca9539_gpio_get_value;
-	gc->set = pca9539_gpio_set_value;
-
-	gc->base = chip->gpio_start;
-	gc->ngpio = NR_PCA9539_GPIOS;
-	gc->label = "pca9539";
-
-	return gpiochip_add(gc);
-}
-
-static int __devinit pca9539_probe(struct i2c_client *client)
-{
-	struct pca9539_platform_data *pdata;
-	struct pca9539_chip *chip;
-	int ret;
-
-	pdata = client->dev.platform_data;
-	if (pdata == NULL)
-		return -ENODEV;
-
-	chip = kzalloc(sizeof(struct pca9539_chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-
-	chip->client = client;
-
-	chip->gpio_start = pdata->gpio_base;
-
-	/* initialize cached registers from their original values.
-	 * we can't share this chip with another i2c master.
-	 */
-	ret = pca9539_read_reg(chip, PCA9539_OUTPUT, &chip->reg_output);
-	if (ret)
-		goto out_failed;
-
-	ret = pca9539_read_reg(chip, PCA9539_DIRECTION, &chip->reg_direction);
-	if (ret)
-		goto out_failed;
-
-	/* set platform specific polarity inversion */
-	ret = pca9539_write_reg(chip, PCA9539_INVERT, pdata->invert);
-	if (ret)
-		goto out_failed;
-
-	ret = pca9539_init_gpio(chip);
-	if (ret)
-		goto out_failed;
-
-	if (pdata->setup) {
-		ret = pdata->setup(client, chip->gpio_chip.base,
-				chip->gpio_chip.ngpio, pdata->context);
-		if (ret < 0)
-			dev_warn(&client->dev, "setup failed, %d\n", ret);
-	}
-
-	i2c_set_clientdata(client, chip);
-	return 0;
-
-out_failed:
-	kfree(chip);
-	return ret;
-}
-
-static int pca9539_remove(struct i2c_client *client)
-{
-	struct pca9539_platform_data *pdata = client->dev.platform_data;
-	struct pca9539_chip *chip = i2c_get_clientdata(client);
-	int ret = 0;
-
-	if (pdata->teardown) {
-		ret = pdata->teardown(client, chip->gpio_chip.base,
-				chip->gpio_chip.ngpio, pdata->context);
-		if (ret < 0) {
-			dev_err(&client->dev, "%s failed, %d\n",
-					"teardown", ret);
-			return ret;
-		}
-	}
-
-	ret = gpiochip_remove(&chip->gpio_chip);
-	if (ret) {
-		dev_err(&client->dev, "%s failed, %d\n",
-				"gpiochip_remove()", ret);
-		return ret;
-	}
-
-	kfree(chip);
-	return 0;
-}
-
-static struct i2c_driver pca9539_driver = {
-	.driver = {
-		.name	= "pca9539",
-	},
-	.probe		= pca9539_probe,
-	.remove		= pca9539_remove,
-};
-
-static int __init pca9539_init(void)
-{
-	return i2c_add_driver(&pca9539_driver);
-}
-module_init(pca9539_init);
-
-static void __exit pca9539_exit(void)
-{
-	i2c_del_driver(&pca9539_driver);
-}
-module_exit(pca9539_exit);
-
-MODULE_AUTHOR("eric miao <eric.miao@marvell.com>");
-MODULE_DESCRIPTION("GPIO expander driver for PCA9539");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
new file mode 100644
index 0000000..7fae4e5
--- /dev/null
+++ b/drivers/gpio/pca953x.c
@@ -0,0 +1,271 @@
+/*
+ *  pca9539.c - 16-bit I/O port with interrupt and reset
+ *
+ *  Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
+ *  Copyright (C) 2007 Marvell International Ltd.
+ *
+ *  Derived from drivers/i2c/chips/pca9539.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c/pca953x.h>
+
+#include <asm/gpio.h>
+
+
+#define NR_PCA9539_GPIOS	16
+
+#define PCA9539_INPUT		0
+#define PCA9539_OUTPUT		2
+#define PCA9539_INVERT		4
+#define PCA9539_DIRECTION	6
+
+struct pca9539_chip {
+	unsigned gpio_start;
+	uint16_t reg_output;
+	uint16_t reg_direction;
+
+	struct i2c_client *client;
+	struct gpio_chip gpio_chip;
+};
+
+/* NOTE:  we can't currently rely on fault codes to come from SMBus
+ * calls, so we map all errors to EIO here and return zero otherwise.
+ */
+static int pca9539_write_reg(struct pca9539_chip *chip, int reg, uint16_t val)
+{
+	if (i2c_smbus_write_word_data(chip->client, reg, val) < 0)
+		return -EIO;
+	else
+		return 0;
+}
+
+static int pca9539_read_reg(struct pca9539_chip *chip, int reg, uint16_t *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(chip->client, reg);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "failed reading register\n");
+		return -EIO;
+	}
+
+	*val = (uint16_t)ret;
+	return 0;
+}
+
+static int pca9539_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	struct pca9539_chip *chip;
+	uint16_t reg_val;
+	int ret;
+
+	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+
+	reg_val = chip->reg_direction | (1u << off);
+	ret = pca9539_write_reg(chip, PCA9539_DIRECTION, reg_val);
+	if (ret)
+		return ret;
+
+	chip->reg_direction = reg_val;
+	return 0;
+}
+
+static int pca9539_gpio_direction_output(struct gpio_chip *gc,
+		unsigned off, int val)
+{
+	struct pca9539_chip *chip;
+	uint16_t reg_val;
+	int ret;
+
+	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+
+	/* set output level */
+	if (val)
+		reg_val = chip->reg_output | (1u << off);
+	else
+		reg_val = chip->reg_output & ~(1u << off);
+
+	ret = pca9539_write_reg(chip, PCA9539_OUTPUT, reg_val);
+	if (ret)
+		return ret;
+
+	chip->reg_output = reg_val;
+
+	/* then direction */
+	reg_val = chip->reg_direction & ~(1u << off);
+	ret = pca9539_write_reg(chip, PCA9539_DIRECTION, reg_val);
+	if (ret)
+		return ret;
+
+	chip->reg_direction = reg_val;
+	return 0;
+}
+
+static int pca9539_gpio_get_value(struct gpio_chip *gc, unsigned off)
+{
+	struct pca9539_chip *chip;
+	uint16_t reg_val;
+	int ret;
+
+	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+
+	ret = pca9539_read_reg(chip, PCA9539_INPUT, &reg_val);
+	if (ret < 0) {
+		/* NOTE:  diagnostic already emitted; that's all we should
+		 * do unless gpio_*_value_cansleep() calls become different
+		 * from their nonsleeping siblings (and report faults).
+		 */
+		return 0;
+	}
+
+	return (reg_val & (1u << off)) ? 1 : 0;
+}
+
+static void pca9539_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
+{
+	struct pca9539_chip *chip;
+	uint16_t reg_val;
+	int ret;
+
+	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+
+	if (val)
+		reg_val = chip->reg_output | (1u << off);
+	else
+		reg_val = chip->reg_output & ~(1u << off);
+
+	ret = pca9539_write_reg(chip, PCA9539_OUTPUT, reg_val);
+	if (ret)
+		return;
+
+	chip->reg_output = reg_val;
+}
+
+static int pca9539_init_gpio(struct pca9539_chip *chip)
+{
+	struct gpio_chip *gc;
+
+	gc = &chip->gpio_chip;
+
+	gc->direction_input  = pca9539_gpio_direction_input;
+	gc->direction_output = pca9539_gpio_direction_output;
+	gc->get = pca9539_gpio_get_value;
+	gc->set = pca9539_gpio_set_value;
+
+	gc->base = chip->gpio_start;
+	gc->ngpio = NR_PCA9539_GPIOS;
+	gc->label = "pca9539";
+
+	return gpiochip_add(gc);
+}
+
+static int __devinit pca9539_probe(struct i2c_client *client)
+{
+	struct pca9539_platform_data *pdata;
+	struct pca9539_chip *chip;
+	int ret;
+
+	pdata = client->dev.platform_data;
+	if (pdata == NULL)
+		return -ENODEV;
+
+	chip = kzalloc(sizeof(struct pca9539_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	chip->client = client;
+
+	chip->gpio_start = pdata->gpio_base;
+
+	/* initialize cached registers from their original values.
+	 * we can't share this chip with another i2c master.
+	 */
+	ret = pca9539_read_reg(chip, PCA9539_OUTPUT, &chip->reg_output);
+	if (ret)
+		goto out_failed;
+
+	ret = pca9539_read_reg(chip, PCA9539_DIRECTION, &chip->reg_direction);
+	if (ret)
+		goto out_failed;
+
+	/* set platform specific polarity inversion */
+	ret = pca9539_write_reg(chip, PCA9539_INVERT, pdata->invert);
+	if (ret)
+		goto out_failed;
+
+	ret = pca9539_init_gpio(chip);
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
+static int pca9539_remove(struct i2c_client *client)
+{
+	struct pca9539_platform_data *pdata = client->dev.platform_data;
+	struct pca9539_chip *chip = i2c_get_clientdata(client);
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
+static struct i2c_driver pca9539_driver = {
+	.driver = {
+		.name	= "pca9539",
+	},
+	.probe		= pca9539_probe,
+	.remove		= pca9539_remove,
+};
+
+static int __init pca9539_init(void)
+{
+	return i2c_add_driver(&pca9539_driver);
+}
+module_init(pca9539_init);
+
+static void __exit pca9539_exit(void)
+{
+	i2c_del_driver(&pca9539_driver);
+}
+module_exit(pca9539_exit);
+
+MODULE_AUTHOR("eric miao <eric.miao@marvell.com>");
+MODULE_DESCRIPTION("GPIO expander driver for PCA9539");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/pca9539.h b/include/linux/i2c/pca9539.h
deleted file mode 100644
index 611d84a..0000000
--- a/include/linux/i2c/pca9539.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* platform data for the PCA9539 16-bit I/O expander driver */
-
-struct pca9539_platform_data {
-	/* number of the first GPIO */
-	unsigned	gpio_base;
-
-	/* initial polarity inversion setting */
-	uint16_t	invert;
-
-	void		*context;	/* param to setup/teardown */
-
-	int		(*setup)(struct i2c_client *client,
-				unsigned gpio, unsigned ngpio,
-				void *context);
-	int		(*teardown)(struct i2c_client *client,
-				unsigned gpio, unsigned ngpio,
-				void *context);
-};
diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
new file mode 100644
index 0000000..611d84a
--- /dev/null
+++ b/include/linux/i2c/pca953x.h
@@ -0,0 +1,18 @@
+/* platform data for the PCA9539 16-bit I/O expander driver */
+
+struct pca9539_platform_data {
+	/* number of the first GPIO */
+	unsigned	gpio_base;
+
+	/* initial polarity inversion setting */
+	uint16_t	invert;
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

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
