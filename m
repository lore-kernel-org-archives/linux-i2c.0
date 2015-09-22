From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/8] mfd: intel_quark_i2c_gpio: load gpio driver first
Date: Tue, 22 Sep 2015 13:10:14 +0300
Message-ID: <1442916619-140607-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Intel Galileo boards the GPIO expander is connected to i2c bus. Moreover it
is able to generate interrupt, but interrupt line is connected to GPIO. That's
why we have to have GPIO driver in place when we will probe i2c host with
device connected to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 48 +++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 1ce1603..89bd4bf 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -82,27 +82,26 @@ static struct resource intel_quark_i2c_res[] = {
 	},
 };
 
+static struct mfd_cell intel_quark_mfd_i2c_cell = {
+	.id = MFD_I2C_BAR,
+	.name = "i2c_designware",
+	.num_resources = ARRAY_SIZE(intel_quark_i2c_res),
+	.resources = intel_quark_i2c_res,
+	.ignore_resource_conflicts = true,
+};
+
 static struct resource intel_quark_gpio_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
 };
 
-static struct mfd_cell intel_quark_mfd_cells[] = {
-	{
-		.id = MFD_I2C_BAR,
-		.name = "i2c_designware",
-		.num_resources = ARRAY_SIZE(intel_quark_i2c_res),
-		.resources = intel_quark_i2c_res,
-		.ignore_resource_conflicts = true,
-	},
-	{
-		.id = MFD_GPIO_BAR,
-		.name = "gpio-dwapb",
-		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
-		.resources = intel_quark_gpio_res,
-		.ignore_resource_conflicts = true,
-	},
+static struct mfd_cell intel_quark_mfd_gpio_cell = {
+	.id = MFD_GPIO_BAR,
+	.name = "gpio-dwapb",
+	.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
+	.resources = intel_quark_gpio_res,
+	.ignore_resource_conflicts = true,
 };
 
 static const struct pci_device_id intel_quark_mfd_ids[] = {
@@ -248,18 +247,25 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 
 	dev_set_drvdata(&pdev->dev, quark_mfd);
 
-	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_BAR]);
+	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_i2c_cell);
 	if (ret)
 		return ret;
 
-	ret = intel_quark_gpio_setup(pdev,
-				     &intel_quark_mfd_cells[MFD_GPIO_BAR]);
+	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_gpio_cell);
 	if (ret)
 		return ret;
 
-	return mfd_add_devices(&pdev->dev, 0, intel_quark_mfd_cells,
-			       ARRAY_SIZE(intel_quark_mfd_cells), NULL, 0,
-			       NULL);
+	ret = mfd_add_devices(&pdev->dev, 0, &intel_quark_mfd_gpio_cell, 1,
+			      NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	ret = mfd_add_devices(&pdev->dev, 0, &intel_quark_mfd_i2c_cell, 1,
+			      NULL, 0, NULL);
+	if (ret)
+		mfd_remove_devices(&pdev->dev);
+
+	return ret;
 }
 
 static void intel_quark_mfd_remove(struct pci_dev *pdev)
-- 
2.5.1
