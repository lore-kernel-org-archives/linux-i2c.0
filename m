From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: [PATCH 3/3] Add support for PCA953[4-8] I2C GPIO extenders to the
 pca953x driver
Date: Thu, 31 Jan 2008 15:04:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801311500240.8478@axis700.grange>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: video4linux-list@redhat.com, i2c@lm-sensors.org
Cc: David Brownell <david-b@pacbell.net>, Jean Delvare <khali@linux-fr.org>
List-Id: linux-i2c@vger.kernel.org

Last stage in adding more chips to the pca953x gpio driver. As long as
we don't implement their interrupt and reset functionality, they are
identical except for the numbers of GPIOs and register size.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>

---

 drivers/gpio/pca953x.c |  114 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 84 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 51adbaa..a7d3ae2 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -1,5 +1,5 @@
 /*
- *  pca953x.c - 16-bit I/O port with interrupt and reset
+ *  pca953x.c - I/O ports with interrupt and reset
  *
  *  Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
  *  Copyright (C) 2007 Marvell International Ltd.
@@ -18,16 +18,43 @@
 
 #include <asm/gpio.h>
 
+#define PCA953X_INPUT          0
+#define PCA953X_OUTPUT         1
+#define PCA953X_INVERT         2
+#define PCA953X_DIRECTION      3
 
-#define NR_PCA953X_GPIOS	16
+/* This is only temporary - should go with 2.6.26. Only introduced now
+ * to avoid a sequence of strcmp() calls and just compare in a loop */
+struct pca953x_desc {
+	unsigned int	gpios;
+	char		*name;
+};
 
-#define PCA953X_INPUT		0
-#define PCA953X_OUTPUT		2
-#define PCA953X_INVERT		4
-#define PCA953X_DIRECTION	6
+static const struct pca953x_desc pca953x_descs[] = {
+	{
+		.gpios	= 8,
+		.name	= "pca9534",
+	}, {
+		.gpios	= 16,
+		.name	= "pca9535",
+	}, {
+		.gpios	= 4,
+		.name	= "pca9536",
+	}, {
+		.gpios	= 4,
+		.name	= "pca9537",
+	}, {
+		.gpios	= 8,
+		.name	= "pca9538",
+	}, {
+		.gpios	= 16,
+		.name	= "pca9539",
+	},
+};
 
 struct pca953x_chip {
 	unsigned gpio_start;
+	unsigned reg_shift;
 	uint16_t reg_output;
 	uint16_t reg_direction;
 
@@ -40,17 +67,30 @@ struct pca953x_chip {
  */
 static int pca953x_write_reg(struct pca953x_chip *chip, int reg, uint16_t val)
 {
-	if (i2c_smbus_write_word_data(chip->client, reg, val) < 0)
-		return -EIO;
+	int ret;
+
+	if (chip->gpio_chip.ngpio <= 8)
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
 
 static int pca953x_read_reg(struct pca953x_chip *chip, int reg, uint16_t *val)
 {
 	int ret;
 
-	ret = i2c_smbus_read_word_data(chip->client, reg);
+	if (chip->gpio_chip.ngpio <= 8)
+		ret = i2c_smbus_read_byte_data(chip->client, reg);
+	else
+		ret = i2c_smbus_read_word_data(chip->client, reg);
+
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "failed reading register\n");
 		return -EIO;
@@ -64,12 +104,13 @@ static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 {
 	struct pca953x_chip *chip;
 	uint16_t reg_val;
-	int ret;
+	int ret, reg;
 
 	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
 	reg_val = chip->reg_direction | (1u << off);
-	ret = pca953x_write_reg(chip, PCA953X_DIRECTION, reg_val);
+	reg = PCA953X_DIRECTION << chip->reg_shift;
+	ret = pca953x_write_reg(chip, reg, reg_val);
 	if (ret)
 		return ret;
 
@@ -82,7 +123,7 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 {
 	struct pca953x_chip *chip;
 	uint16_t reg_val;
-	int ret;
+	int ret, reg;
 
 	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
@@ -92,7 +133,8 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 	else
 		reg_val = chip->reg_output & ~(1u << off);
 
-	ret = pca953x_write_reg(chip, PCA953X_OUTPUT, reg_val);
+	reg = PCA953X_OUTPUT << chip->reg_shift;
+	ret = pca953x_write_reg(chip, reg, reg_val);
 	if (ret)
 		return ret;
 
@@ -100,7 +142,8 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 
 	/* then direction */
 	reg_val = chip->reg_direction & ~(1u << off);
-	ret = pca953x_write_reg(chip, PCA953X_DIRECTION, reg_val);
+	reg = PCA953X_DIRECTION << chip->reg_shift;
+	ret = pca953x_write_reg(chip, reg, reg_val);
 	if (ret)
 		return ret;
 
@@ -112,11 +155,12 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 {
 	struct pca953x_chip *chip;
 	uint16_t reg_val;
-	int ret;
+	int ret, reg;
 
 	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
-	ret = pca953x_read_reg(chip, PCA953X_INPUT, &reg_val);
+	reg = PCA953X_INPUT << chip->reg_shift;
+	ret = pca953x_read_reg(chip, reg, &reg_val);
 	if (ret < 0) {
 		/* NOTE:  diagnostic already emitted; that's all we should
 		 * do unless gpio_*_value_cansleep() calls become different
@@ -132,7 +176,7 @@ static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 {
 	struct pca953x_chip *chip;
 	uint16_t reg_val;
-	int ret;
+	int ret, reg;
 
 	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
@@ -141,14 +185,15 @@ static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 	else
 		reg_val = chip->reg_output & ~(1u << off);
 
-	ret = pca953x_write_reg(chip, PCA953X_OUTPUT, reg_val);
+	reg = PCA953X_OUTPUT << chip->reg_shift;
+	ret = pca953x_write_reg(chip, reg, reg_val);
 	if (ret)
 		return;
 
 	chip->reg_output = reg_val;
 }
 
-static int pca953x_init_gpio(struct pca953x_chip *chip)
+static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
 	struct gpio_chip *gc;
 
@@ -160,22 +205,26 @@ static int pca953x_init_gpio(struct pca953x_chip *chip)
 	gc->set = pca953x_gpio_set_value;
 
 	gc->base = chip->gpio_start;
-	gc->ngpio = NR_PCA953X_GPIOS;
-	gc->label = "pca953x";
-
-	return gpiochip_add(gc);
+	gc->ngpio = gpios;
+	gc->label = chip->client->name;
 }
 
 static int __devinit pca953x_probe(struct i2c_client *client)
 {
 	struct pca953x_platform_data *pdata;
 	struct pca953x_chip *chip;
-	int ret;
+	int ret, i;
 
 	pdata = client->dev.platform_data;
 	if (pdata == NULL)
 		return -ENODEV;
 
+	for (i = 0; i < ARRAY_SIZE(pca953x_descs); i++)
+		if (!strcmp(pca953x_descs[i].name, client->name))
+			break;
+	if (i == ARRAY_SIZE(pca953x_descs))
+		return -ENODEV;
+
 	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
@@ -187,20 +236,25 @@ static int __devinit pca953x_probe(struct i2c_client *client)
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
-	ret = pca953x_read_reg(chip, PCA953X_OUTPUT, &chip->reg_output);
+	chip->reg_shift = (pca953x_descs[i].gpios - 1) >> 3;
+
+	pca953x_setup_gpio(chip, pca953x_descs[i].gpios);
+
+	ret = pca953x_read_reg(chip, PCA953X_OUTPUT << chip->reg_shift, &chip->reg_output);
 	if (ret)
 		goto out_failed;
 
-	ret = pca953x_read_reg(chip, PCA953X_DIRECTION, &chip->reg_direction);
+	ret = pca953x_read_reg(chip, PCA953X_DIRECTION << chip->reg_shift, &chip->reg_direction);
 	if (ret)
 		goto out_failed;
 
 	/* set platform specific polarity inversion */
-	ret = pca953x_write_reg(chip, PCA953X_INVERT, pdata->invert);
+	ret = pca953x_write_reg(chip, PCA953X_INVERT << chip->reg_shift, pdata->invert);
 	if (ret)
 		goto out_failed;
 
-	ret = pca953x_init_gpio(chip);
+
+	ret = gpiochip_add(&chip->gpio_chip);
 	if (ret)
 		goto out_failed;
 
@@ -267,5 +321,5 @@ static void __exit pca953x_exit(void)
 module_exit(pca953x_exit);
 
 MODULE_AUTHOR("eric miao <eric.miao@marvell.com>");
-MODULE_DESCRIPTION("GPIO expander driver for PCA9536...PCA9539");
+MODULE_DESCRIPTION("GPIO expander driver for PCA953X");
 MODULE_LICENSE("GPL");
-- 
1.5.3.4

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
