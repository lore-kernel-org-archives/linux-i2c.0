From: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/3] Second stage extending the pca953x GPIO driver -
 change Kconfig, "sed" files
Date: Thu, 31 Jan 2008 15:04:25 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801311456280.8478@axis700.grange>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801311453470.8478-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

All affected files have been passed through sed, except for a couple
of obvious exception places. Also extended Kconfig help.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---

 drivers/gpio/Kconfig        |   11 ++--
 drivers/gpio/Makefile       |    2 +-
 drivers/gpio/pca953x.c      |  110 +++++++++++++++++++++---------------------
 include/linux/i2c/pca953x.h |    2 +-
 4 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 74fac0f..a122d85 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -27,15 +27,16 @@ config DEBUG_GPIO
 
 comment "I2C GPIO expanders:"
 
-config GPIO_PCA9539
-	tristate "PCA9539 16-bit I/O port"
+config GPIO_PCA953X
+	tristate "PCA953X I/O ports"
 	depends on I2C
 	help
-	  Say yes here to support the PCA9539 16-bit I/O port. These
-	  parts are made by NXP and TI.
+	  Say yes here to support the PCA9534 (8-bit), PCA9535 (16-bit),
+	  PCA9536 (4-bit), PCA9537 (4-bit), PCA9538 (8-bit), and PCA9539
+	  (16-bit) I/O ports. These parts are made by NXP and TI.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called pca9539.
+	  will be called pca953x.
 
 config GPIO_PCF857X
 	tristate "PCF857x, PCA857x, and PCA967x I2C GPIO expanders"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 16dda77..fdde992 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -5,5 +5,5 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o
 
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
-obj-$(CONFIG_GPIO_PCA9539)	+= pca953x.o
+obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 7fae4e5..51adbaa 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -1,5 +1,5 @@
 /*
- *  pca9539.c - 16-bit I/O port with interrupt and reset
+ *  pca953x.c - 16-bit I/O port with interrupt and reset
  *
  *  Copyright (C) 2005 Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
  *  Copyright (C) 2007 Marvell International Ltd.
@@ -19,14 +19,14 @@
 #include <asm/gpio.h>
 
 
-#define NR_PCA9539_GPIOS	16
+#define NR_PCA953X_GPIOS	16
 
-#define PCA9539_INPUT		0
-#define PCA9539_OUTPUT		2
-#define PCA9539_INVERT		4
-#define PCA9539_DIRECTION	6
+#define PCA953X_INPUT		0
+#define PCA953X_OUTPUT		2
+#define PCA953X_INVERT		4
+#define PCA953X_DIRECTION	6
 
-struct pca9539_chip {
+struct pca953x_chip {
 	unsigned gpio_start;
 	uint16_t reg_output;
 	uint16_t reg_direction;
@@ -38,7 +38,7 @@ struct pca9539_chip {
 /* NOTE:  we can't currently rely on fault codes to come from SMBus
  * calls, so we map all errors to EIO here and return zero otherwise.
  */
-static int pca9539_write_reg(struct pca9539_chip *chip, int reg, uint16_t val)
+static int pca953x_write_reg(struct pca953x_chip *chip, int reg, uint16_t val)
 {
 	if (i2c_smbus_write_word_data(chip->client, reg, val) < 0)
 		return -EIO;
@@ -46,7 +46,7 @@ static int pca9539_write_reg(struct pca9539_chip *chip, int reg, uint16_t val)
 		return 0;
 }
 
-static int pca9539_read_reg(struct pca9539_chip *chip, int reg, uint16_t *val)
+static int pca953x_read_reg(struct pca953x_chip *chip, int reg, uint16_t *val)
 {
 	int ret;
 
@@ -60,16 +60,16 @@ static int pca9539_read_reg(struct pca9539_chip *chip, int reg, uint16_t *val)
 	return 0;
 }
 
-static int pca9539_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 {
-	struct pca9539_chip *chip;
+	struct pca953x_chip *chip;
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
 	reg_val = chip->reg_direction | (1u << off);
-	ret = pca9539_write_reg(chip, PCA9539_DIRECTION, reg_val);
+	ret = pca953x_write_reg(chip, PCA953X_DIRECTION, reg_val);
 	if (ret)
 		return ret;
 
@@ -77,14 +77,14 @@ static int pca9539_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 	return 0;
 }
 
-static int pca9539_gpio_direction_output(struct gpio_chip *gc,
+static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 		unsigned off, int val)
 {
-	struct pca9539_chip *chip;
+	struct pca953x_chip *chip;
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
 	/* set output level */
 	if (val)
@@ -92,7 +92,7 @@ static int pca9539_gpio_direction_output(struct gpio_chip *gc,
 	else
 		reg_val = chip->reg_output & ~(1u << off);
 
-	ret = pca9539_write_reg(chip, PCA9539_OUTPUT, reg_val);
+	ret = pca953x_write_reg(chip, PCA953X_OUTPUT, reg_val);
 	if (ret)
 		return ret;
 
@@ -100,7 +100,7 @@ static int pca9539_gpio_direction_output(struct gpio_chip *gc,
 
 	/* then direction */
 	reg_val = chip->reg_direction & ~(1u << off);
-	ret = pca9539_write_reg(chip, PCA9539_DIRECTION, reg_val);
+	ret = pca953x_write_reg(chip, PCA953X_DIRECTION, reg_val);
 	if (ret)
 		return ret;
 
@@ -108,15 +108,15 @@ static int pca9539_gpio_direction_output(struct gpio_chip *gc,
 	return 0;
 }
 
-static int pca9539_gpio_get_value(struct gpio_chip *gc, unsigned off)
+static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 {
-	struct pca9539_chip *chip;
+	struct pca953x_chip *chip;
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
-	ret = pca9539_read_reg(chip, PCA9539_INPUT, &reg_val);
+	ret = pca953x_read_reg(chip, PCA953X_INPUT, &reg_val);
 	if (ret < 0) {
 		/* NOTE:  diagnostic already emitted; that's all we should
 		 * do unless gpio_*_value_cansleep() calls become different
@@ -128,55 +128,55 @@ static int pca9539_gpio_get_value(struct gpio_chip *gc, unsigned off)
 	return (reg_val & (1u << off)) ? 1 : 0;
 }
 
-static void pca9539_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
+static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 {
-	struct pca9539_chip *chip;
+	struct pca953x_chip *chip;
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca9539_chip, gpio_chip);
+	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
 	if (val)
 		reg_val = chip->reg_output | (1u << off);
 	else
 		reg_val = chip->reg_output & ~(1u << off);
 
-	ret = pca9539_write_reg(chip, PCA9539_OUTPUT, reg_val);
+	ret = pca953x_write_reg(chip, PCA953X_OUTPUT, reg_val);
 	if (ret)
 		return;
 
 	chip->reg_output = reg_val;
 }
 
-static int pca9539_init_gpio(struct pca9539_chip *chip)
+static int pca953x_init_gpio(struct pca953x_chip *chip)
 {
 	struct gpio_chip *gc;
 
 	gc = &chip->gpio_chip;
 
-	gc->direction_input  = pca9539_gpio_direction_input;
-	gc->direction_output = pca9539_gpio_direction_output;
-	gc->get = pca9539_gpio_get_value;
-	gc->set = pca9539_gpio_set_value;
+	gc->direction_input  = pca953x_gpio_direction_input;
+	gc->direction_output = pca953x_gpio_direction_output;
+	gc->get = pca953x_gpio_get_value;
+	gc->set = pca953x_gpio_set_value;
 
 	gc->base = chip->gpio_start;
-	gc->ngpio = NR_PCA9539_GPIOS;
-	gc->label = "pca9539";
+	gc->ngpio = NR_PCA953X_GPIOS;
+	gc->label = "pca953x";
 
 	return gpiochip_add(gc);
 }
 
-static int __devinit pca9539_probe(struct i2c_client *client)
+static int __devinit pca953x_probe(struct i2c_client *client)
 {
-	struct pca9539_platform_data *pdata;
-	struct pca9539_chip *chip;
+	struct pca953x_platform_data *pdata;
+	struct pca953x_chip *chip;
 	int ret;
 
 	pdata = client->dev.platform_data;
 	if (pdata == NULL)
 		return -ENODEV;
 
-	chip = kzalloc(sizeof(struct pca9539_chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
@@ -187,20 +187,20 @@ static int __devinit pca9539_probe(struct i2c_client *client)
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
-	ret = pca9539_read_reg(chip, PCA9539_OUTPUT, &chip->reg_output);
+	ret = pca953x_read_reg(chip, PCA953X_OUTPUT, &chip->reg_output);
 	if (ret)
 		goto out_failed;
 
-	ret = pca9539_read_reg(chip, PCA9539_DIRECTION, &chip->reg_direction);
+	ret = pca953x_read_reg(chip, PCA953X_DIRECTION, &chip->reg_direction);
 	if (ret)
 		goto out_failed;
 
 	/* set platform specific polarity inversion */
-	ret = pca9539_write_reg(chip, PCA9539_INVERT, pdata->invert);
+	ret = pca953x_write_reg(chip, PCA953X_INVERT, pdata->invert);
 	if (ret)
 		goto out_failed;
 
-	ret = pca9539_init_gpio(chip);
+	ret = pca953x_init_gpio(chip);
 	if (ret)
 		goto out_failed;
 
@@ -219,10 +219,10 @@ out_failed:
 	return ret;
 }
 
-static int pca9539_remove(struct i2c_client *client)
+static int pca953x_remove(struct i2c_client *client)
 {
-	struct pca9539_platform_data *pdata = client->dev.platform_data;
-	struct pca9539_chip *chip = i2c_get_clientdata(client);
+	struct pca953x_platform_data *pdata = client->dev.platform_data;
+	struct pca953x_chip *chip = i2c_get_clientdata(client);
 	int ret = 0;
 
 	if (pdata->teardown) {
@@ -246,26 +246,26 @@ static int pca9539_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct i2c_driver pca9539_driver = {
+static struct i2c_driver pca953x_driver = {
 	.driver = {
-		.name	= "pca9539",
+		.name	= "pca953x",
 	},
-	.probe		= pca9539_probe,
-	.remove		= pca9539_remove,
+	.probe		= pca953x_probe,
+	.remove		= pca953x_remove,
 };
 
-static int __init pca9539_init(void)
+static int __init pca953x_init(void)
 {
-	return i2c_add_driver(&pca9539_driver);
+	return i2c_add_driver(&pca953x_driver);
 }
-module_init(pca9539_init);
+module_init(pca953x_init);
 
-static void __exit pca9539_exit(void)
+static void __exit pca953x_exit(void)
 {
-	i2c_del_driver(&pca9539_driver);
+	i2c_del_driver(&pca953x_driver);
 }
-module_exit(pca9539_exit);
+module_exit(pca953x_exit);
 
 MODULE_AUTHOR("eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
-MODULE_DESCRIPTION("GPIO expander driver for PCA9539");
+MODULE_DESCRIPTION("GPIO expander driver for PCA9536...PCA9539");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
index 611d84a..3c73612 100644
--- a/include/linux/i2c/pca953x.h
+++ b/include/linux/i2c/pca953x.h
@@ -1,6 +1,6 @@
 /* platform data for the PCA9539 16-bit I/O expander driver */
 
-struct pca9539_platform_data {
+struct pca953x_platform_data {
 	/* number of the first GPIO */
 	unsigned	gpio_base;
 
-- 
1.5.3.4

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
