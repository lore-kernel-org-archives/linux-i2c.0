From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/8] gpio: pca953x: support ACPI devices found on Galileo Gen2
Date: Tue, 22 Sep 2015 13:10:17 +0300
Message-ID: <1442916619-140607-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

This patch adds a support of the expandes found on Intel Galileo Gen2 board.
The platform information comes from ACPI.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 242e244..0220b38 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -21,6 +21,7 @@
 #ifdef CONFIG_OF_GPIO
 #include <linux/of_platform.h>
 #endif
+#include <linux/acpi.h>
 
 #define PCA953X_INPUT		0
 #define PCA953X_OUTPUT		1
@@ -75,6 +76,12 @@ static const struct i2c_device_id pca953x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pca953x_id);
 
+static const struct acpi_device_id pca953x_acpi_ids[] = {
+	{ "INT3491", 16 | PCA953X_TYPE | PCA_INT, },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
+
 #define MAX_BANK 5
 #define BANK_SZ 8
 
@@ -675,7 +682,18 @@ static int pca953x_probe(struct i2c_client *client,
 
 	chip->client = client;
 
-	chip->driver_data = id->driver_data;
+	if (id) {
+		chip->driver_data = id->driver_data;
+	} else {
+		const struct acpi_device_id *id;
+
+		id = acpi_match_device(pca953x_acpi_ids, &client->dev);
+		if (!id)
+			return -ENODEV;
+
+		chip->driver_data = id->driver_data;
+	}
+
 	chip->chip_type = PCA_CHIP_TYPE(chip->driver_data);
 
 	mutex_init(&chip->i2c_lock);
@@ -768,6 +786,7 @@ static struct i2c_driver pca953x_driver = {
 	.driver = {
 		.name	= "pca953x",
 		.of_match_table = pca953x_dt_ids,
+		.acpi_match_table = ACPI_PTR(pca953x_acpi_ids),
 	},
 	.probe		= pca953x_probe,
 	.remove		= pca953x_remove,
-- 
2.5.1
