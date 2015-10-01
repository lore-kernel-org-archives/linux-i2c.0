From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/8] gpio: pca953x: store driver_data for future use
Date: Thu,  1 Oct 2015 14:20:27 +0300
Message-ID: <1443698430-74415-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Instead of using id->driver_data directly we copied it to the internal
structure. This will help to adapt driver for ACPI use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 50caeb1..242e244 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -42,6 +42,9 @@
 #define PCA_INT			0x0100
 #define PCA953X_TYPE		0x1000
 #define PCA957X_TYPE		0x2000
+#define PCA_TYPE_MASK		0xF000
+
+#define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
 
 static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9505", 40 | PCA953X_TYPE | PCA_INT, },
@@ -95,6 +98,7 @@ struct pca953x_chip {
 	struct gpio_chip gpio_chip;
 	const char *const *names;
 	int	chip_type;
+	unsigned long driver_data;
 };
 
 static inline struct pca953x_chip *to_pca(struct gpio_chip *gc)
@@ -517,14 +521,13 @@ static irqreturn_t pca953x_irq_handler(int irq, void *devid)
 }
 
 static int pca953x_irq_setup(struct pca953x_chip *chip,
-			     const struct i2c_device_id *id,
 			     int irq_base)
 {
 	struct i2c_client *client = chip->client;
 	int ret, i, offset = 0;
 
 	if (client->irq && irq_base != -1
-			&& (id->driver_data & PCA_INT)) {
+			&& (chip->driver_data & PCA_INT)) {
 
 		switch (chip->chip_type) {
 		case PCA953X_TYPE:
@@ -581,12 +584,11 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 
 #else /* CONFIG_GPIO_PCA953X_IRQ */
 static int pca953x_irq_setup(struct pca953x_chip *chip,
-			     const struct i2c_device_id *id,
 			     int irq_base)
 {
 	struct i2c_client *client = chip->client;
 
-	if (irq_base != -1 && (id->driver_data & PCA_INT))
+	if (irq_base != -1 && (chip->driver_data & PCA_INT))
 		dev_warn(&client->dev, "interrupt support not compiled in\n");
 
 	return 0;
@@ -673,14 +675,15 @@ static int pca953x_probe(struct i2c_client *client,
 
 	chip->client = client;
 
-	chip->chip_type = id->driver_data & (PCA953X_TYPE | PCA957X_TYPE);
+	chip->driver_data = id->driver_data;
+	chip->chip_type = PCA_CHIP_TYPE(chip->driver_data);
 
 	mutex_init(&chip->i2c_lock);
 
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
-	pca953x_setup_gpio(chip, id->driver_data & PCA_GPIO_MASK);
+	pca953x_setup_gpio(chip, chip->driver_data & PCA_GPIO_MASK);
 
 	if (chip->chip_type == PCA953X_TYPE)
 		ret = device_pca953x_init(chip, invert);
@@ -693,7 +696,7 @@ static int pca953x_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = pca953x_irq_setup(chip, id, irq_base);
+	ret = pca953x_irq_setup(chip, irq_base);
 	if (ret)
 		return ret;
 
-- 
2.5.1
