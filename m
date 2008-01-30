From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [i2c] [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
 support to the pca9539 GPIO driver
Date: Wed, 30 Jan 2008 17:48:44 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801301732550.6547@axis700.grange>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<Pine.LNX.4.64.0801231820060.4932@axis700.grange>
	<20080127224559.4eed7cea@hyperion.delvare>
	<200801272218.04137.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200801272218.04137.david-b@pacbell.net>
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

PCA9539 and PCA9536 have identical register layout, and differ only in the 
number of GPIOs and, respectively, register size. Extend the pca9539 
driver to also support PCA9536. The driver can further be extended in the 
future to also support PCA953[4578] chips.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>

---

On Sun, 27 Jan 2008, David Brownell wrote:

> On Sunday 27 January 2008, Jean Delvare wrote:
> > 
> > There is a new GPIO subsystem (under driver/gpio), that's where you
> > should add this driver.
> 
> That should merge soonish into kernel GIT -- Linus is merging up a
> storm before LCA starts, but Andrew's not sent it yet -- but it's
> easy to grab from current MM.

Hope it does, as now my video patches depend on those.

> There's a pca9539 driver there, and ISTR the 9536 is very similar
> except it has no IRQ support and only has 8-bit registers.  You
> should be able to reuse its platform_data structure.  It has a
> registration callback that should let you establish the linkage to
> the camera(s) you want to control.

I didn't need anything like that. I just used the platform knowledge of 
the GPIO number. This way the camera driver just obtains the GPIO, 
requests and uses it.

> I suspect you'll come across one other issue... one potential fix
> being to add a mechanism matching a NOTE in the gpiolib sources.

You mean gpio numbers? See above - platform code knows, that it's GPIO 1 
on the extender, that the cameras need.

> I think you should consider making one driver that can handle three
> chips: the 4-bit pca9536 (8 pins) and pca9537 (10 pins -- add irq and
> reset), plus their 8-bit pca9538 sibling (16 pins -- four more GPIOs,
> and two address bits).  Their register model is *identical* ... all
> that would mean is understanding that for some chips the high nibble
> is actually valid.  (And eventually, maybe, that some chips support
> input-changed IRQs that can help avoid synchronous register reads.
> If the i2c_client doesn't list an IRQ that's of course not an issue.)

I think, there are more than 3. But I'd prefer staying with the two at the 
moment - others can be added later. And I haven't found in the driver 
support for IRQ and reset pins, so, no differentiation is made for those 
either.

Note, the patch below uses git-specific "renamed from/to" tags, so, it 
won't work with GNU patch. But it is easier to review it this way.

Thanks
Guennadi


diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 74fac0f..713c0fe 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -27,15 +27,15 @@ config DEBUG_GPIO
 
 comment "I2C GPIO expanders:"
 
-config GPIO_PCA9539
-	tristate "PCA9539 16-bit I/O port"
+config GPIO_PCA953X
+	tristate "PCA953X I/O port"
 	depends on I2C
 	help
-	  Say yes here to support the PCA9539 16-bit I/O port. These
-	  parts are made by NXP and TI.
+	  Say yes here to support PCA9539 16-bit and PCA9536 4-bit I/O ports.
+	  These parts are made by NXP and TI.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called pca9539.
+	  will be called pca953x.
 
 config GPIO_PCF857X
 	tristate "PCF857x, PCA857x, and PCA967x I2C GPIO expanders"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 470ecd6..fdde992 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -5,5 +5,5 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o
 
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
-obj-$(CONFIG_GPIO_PCA9539)	+= pca9539.o
+obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
diff --git a/drivers/gpio/pca9539.c b/drivers/gpio/pca953x.c
similarity index 67%
rename from drivers/gpio/pca9539.c
rename to drivers/gpio/pca953x.c
index 3e85c92..3e9d650 100644
@@ -1,5 +1,5 @@
 /*
- *  pca9539.c - 16-bit I/O port with interrupt and reset
+ *  pca953x.c - I/O port with interrupt and reset
  *
  *  Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
  *  Copyright (C) 2007 Marvell International Ltd.
@@ -14,19 +14,42 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pca9539.h>
+#include <linux/i2c/pca953x.h>
 
 #include <asm/gpio.h>
 
+enum {
+	PCA9536,
+	PCA9539,
+};
 
-#define NR_PCA9539_GPIOS	16
+struct pca953x_desc {
+	unsigned int gpios;
+	unsigned int input;
+	unsigned int output;
+	unsigned int invert;
+	unsigned int direction;
+};
 
-#define PCA9539_INPUT		0
-#define PCA9539_OUTPUT		2
-#define PCA9539_INVERT		4
-#define PCA9539_DIRECTION	6
+static const struct pca953x_desc pca953x_descs[] = {
+	[PCA9536] = {
+		.gpios		= 4,
+		.input		= 0,
+		.output		= 1,
+		.invert		= 2,
+		.direction	= 3,
+	},
+	[PCA9539] = {
+		.gpios		= 16,
+		.input		= 0,
+		.output		= 2,
+		.invert		= 4,
+		.direction	= 6,
+	},
+};
 
-struct pca9539_chip {
+struct pca953x_chip {
+	struct pca953x_desc const *desc;
 	unsigned gpio_start;
 	uint16_t reg_output;
 	uint16_t reg_direction;
@@ -38,19 +61,32 @@ struct pca9539_chip {
 /* NOTE:  we can't currently rely on fault codes to come from SMBus
  * calls, so we map all errors to EIO here and return zero otherwise.
  */
-static int pca9539_write_reg(struct pca9539_chip *chip, int reg, uint16_t val)
+static int pca953x_write_reg(struct pca953x_chip *chip, int reg, uint16_t val)
 {
-	if (i2c_smbus_write_word_data(chip->client, reg, val) < 0)
-		return -EIO;
+	int ret;
+
+	if (chip->desc->gpios <= 8)
+		ret = i2c_smbus_write_byte_data(chip->client, reg, val);
 	else
-		return 0;
+		ret = i2c_smbus_write_word_data(chip->client, reg, val);
+
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "failed writing register\n");
+		return -EIO;
+	}
+
+	return 0;
 }
 
-static int pca9539_read_reg(struct pca9539_chip *chip, int reg, uint16_t *val)
+static int pca953x_read_reg(struct pca953x_chip *chip, int reg, uint16_t *val)
 {
 	int ret;
 
-	ret = i2c_smbus_read_word_data(chip->client, reg);
+	if (chip->desc->gpios <= 8)
+		ret = i2c_smbus_read_byte_data(chip->client, reg);
+	else
+		ret = i2c_smbus_read_word_data(chip->client, reg);
+
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "failed reading register\n");
 		return -EIO;
@@ -60,16 +96,16 @@ static int pca9539_read_reg(struct pca9539_chip *chip, int reg, uint16_t *val)
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
+	ret = pca953x_write_reg(chip, chip->desc->direction, reg_val);
 	if (ret)
 		return ret;
 
@@ -77,14 +113,14 @@ static int pca9539_gpio_direction_input(struct gpio_chip *gc, unsigned off)
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
@@ -92,7 +128,7 @@ static int pca9539_gpio_direction_output(struct gpio_chip *gc,
 	else
 		reg_val = chip->reg_output & ~(1u << off);
 
-	ret = pca9539_write_reg(chip, PCA9539_OUTPUT, reg_val);
+	ret = pca953x_write_reg(chip, chip->desc->output, reg_val);
 	if (ret)
 		return ret;
 
@@ -100,7 +136,7 @@ static int pca9539_gpio_direction_output(struct gpio_chip *gc,
 
 	/* then direction */
 	reg_val = chip->reg_direction & ~(1u << off);
-	ret = pca9539_write_reg(chip, PCA9539_DIRECTION, reg_val);
+	ret = pca953x_write_reg(chip, chip->desc->direction, reg_val);
 	if (ret)
 		return ret;
 
@@ -108,15 +144,15 @@ static int pca9539_gpio_direction_output(struct gpio_chip *gc,
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
+	ret = pca953x_read_reg(chip, chip->desc->input, &reg_val);
 	if (ret < 0) {
 		/* NOTE:  diagnostic already emitted; that's all we should
 		 * do unless gpio_*_value_cansleep() calls become different
@@ -128,58 +164,67 @@ static int pca9539_gpio_get_value(struct gpio_chip *gc, unsigned off)
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
+	ret = pca953x_write_reg(chip, chip->desc->output, reg_val);
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
+	gc->ngpio = chip->desc->gpios;
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
+	int variant;
 
 	pdata = client->dev.platform_data;
 	if (pdata == NULL)
 		return -ENODEV;
 
-	chip = kzalloc(sizeof(struct pca9539_chip), GFP_KERNEL);
+	if (!strcmp("pca9539", pdata->name))
+		variant = PCA9539;
+	else if (!strcmp("pca9536", pdata->name))
+		variant = PCA9536;
+	else
+		return -ENODEV;
+
+	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
+	chip->desc = &pca953x_descs[variant];
 	chip->client = client;
 
 	chip->gpio_start = pdata->gpio_base;
@@ -187,20 +232,20 @@ static int __devinit pca9539_probe(struct i2c_client *client)
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
-	ret = pca9539_read_reg(chip, PCA9539_OUTPUT, &chip->reg_output);
+	ret = pca953x_read_reg(chip, chip->desc->output, &chip->reg_output);
 	if (ret)
 		goto out_failed;
 
-	ret = pca9539_read_reg(chip, PCA9539_DIRECTION, &chip->reg_direction);
+	ret = pca953x_read_reg(chip, chip->desc->direction, &chip->reg_direction);
 	if (ret)
 		goto out_failed;
 
 	/* set platform specific polarity inversion */
-	ret = pca9539_write_reg(chip, PCA9539_INVERT, pdata->invert);
+	ret = pca953x_write_reg(chip, chip->desc->invert, pdata->invert);
 	if (ret)
 		goto out_failed;
 
-	ret = pca9539_init_gpio(chip);
+	ret = pca953x_init_gpio(chip);
 	if (ret)
 		goto out_failed;
 
@@ -219,10 +264,10 @@ out_failed:
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
@@ -246,26 +291,26 @@ static int pca9539_remove(struct i2c_client *client)
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
 
 MODULE_AUTHOR("eric miao <eric.miao@marvell.com>");
-MODULE_DESCRIPTION("GPIO expander driver for PCA9539");
+MODULE_DESCRIPTION("GPIO expander driver for PCA953X");
 MODULE_LICENSE("GPL");
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index f29a502..806b86c 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -16,6 +16,10 @@
 #define ARCH_NR_GPIOS		256
 #endif
 
+#ifndef NO_GPIO
+#define NO_GPIO			((unsigned int)-1)
+#endif
+
 struct seq_file;
 
 /**
diff --git a/include/linux/i2c/pca9539.h b/include/linux/i2c/pca953x.h
similarity index 67%
rename from include/linux/i2c/pca9539.h
rename to include/linux/i2c/pca953x.h
index 611d84a..8977e57 100644
--- a/include/linux/i2c/pca9539.h
+++ b/include/linux/i2c/pca953x.h
@@ -1,9 +1,12 @@
-/* platform data for the PCA9539 16-bit I/O expander driver */
+/* platform data for the PCA953x I/O expander driver */
 
-struct pca9539_platform_data {
+struct pca953x_platform_data {
 	/* number of the first GPIO */
 	unsigned	gpio_base;
 
+	/* chip variant. Currently supported "pca9536" and "pca9539" */
+	const char	*name;
+
 	/* initial polarity inversion setting */
 	uint16_t	invert;

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
