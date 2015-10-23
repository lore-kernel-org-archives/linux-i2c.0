From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 5/5] pwm-pca9685: enable ACPI device found on Galileo Gen2
Date: Fri, 23 Oct 2015 12:16:45 +0300
Message-ID: <1445591805-28886-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org

There is a chip connected to i2c bus on Intel Galileo Gen2 board. Enable it via
ACPI ID INT3492.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/Kconfig       |  2 +-
 drivers/pwm/pwm-pca9685.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 062630a..bb114ef 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -242,7 +242,7 @@ config PWM_MXS
 
 config PWM_PCA9685
 	tristate "NXP PCA9685 PWM driver"
-	depends on OF && I2C
+	depends on I2C
 	select REGMAP_I2C
 	help
 	  Generic PWM framework driver for NXP PCA9685 LED controller.
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 70448a6..117fccf 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -19,9 +19,11 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -297,7 +299,6 @@ static const struct regmap_config pca9685_regmap_i2c_config = {
 static int pca9685_pwm_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
-	struct device_node *np = client->dev.of_node;
 	struct pca9685 *pca;
 	int ret;
 	int mode2;
@@ -320,12 +321,12 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
 
-	if (of_property_read_bool(np, "invert"))
+	if (device_property_read_bool(&client->dev, "invert"))
 		mode2 |= MODE2_INVRT;
 	else
 		mode2 &= ~MODE2_INVRT;
 
-	if (of_property_read_bool(np, "open-drain"))
+	if (device_property_read_bool(&client->dev, "open-drain"))
 		mode2 &= ~MODE2_OUTDRV;
 	else
 		mode2 |= MODE2_OUTDRV;
@@ -363,16 +364,27 @@ static const struct i2c_device_id pca9685_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pca9685_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pca9685_acpi_ids[] = {
+	{ "INT3492", 0 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
+#endif
+
+#ifdef CONFIG_OF
 static const struct of_device_id pca9685_dt_ids[] = {
 	{ .compatible = "nxp,pca9685-pwm", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
+#endif
 
 static struct i2c_driver pca9685_i2c_driver = {
 	.driver = {
 		.name = "pca9685-pwm",
-		.of_match_table = pca9685_dt_ids,
+		.acpi_match_table = ACPI_PTR(pca9685_acpi_ids),
+		.of_match_table = of_match_ptr(pca9685_dt_ids),
 	},
 	.probe = pca9685_pwm_probe,
 	.remove = pca9685_pwm_remove,
-- 
2.6.1
