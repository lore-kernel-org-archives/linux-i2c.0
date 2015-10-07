From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/6] mfd: intel_quark_i2c_gpio: load gpio driver first
Date: Wed,  7 Oct 2015 13:18:46 +0300
Message-ID: <1444213129-29793-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Intel Galileo boards the GPIO expander is connected to i2c bus. Moreover it
is able to generate interrupt, but interrupt line is connected to GPIO. That's
why we have to have GPIO driver in place when we will probe i2c host with
device connected to it.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 1ce1603..958c134 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -90,19 +90,19 @@ static struct resource intel_quark_gpio_res[] = {
 
 static struct mfd_cell intel_quark_mfd_cells[] = {
 	{
-		.id = MFD_I2C_BAR,
-		.name = "i2c_designware",
-		.num_resources = ARRAY_SIZE(intel_quark_i2c_res),
-		.resources = intel_quark_i2c_res,
-		.ignore_resource_conflicts = true,
-	},
-	{
 		.id = MFD_GPIO_BAR,
 		.name = "gpio-dwapb",
 		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
 		.resources = intel_quark_gpio_res,
 		.ignore_resource_conflicts = true,
 	},
+	{
+		.id = MFD_I2C_BAR,
+		.name = "i2c_designware",
+		.num_resources = ARRAY_SIZE(intel_quark_i2c_res),
+		.resources = intel_quark_i2c_res,
+		.ignore_resource_conflicts = true,
+	},
 };
 
 static const struct pci_device_id intel_quark_mfd_ids[] = {
@@ -248,12 +248,11 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 
 	dev_set_drvdata(&pdev->dev, quark_mfd);
 
-	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_BAR]);
+	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[1]);
 	if (ret)
 		return ret;
 
-	ret = intel_quark_gpio_setup(pdev,
-				     &intel_quark_mfd_cells[MFD_GPIO_BAR]);
+	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[0]);
 	if (ret)
 		return ret;
 
-- 
2.5.3
