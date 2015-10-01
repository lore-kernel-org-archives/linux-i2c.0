From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/8] mfd: intel_quark_i2c_gpio: load gpio driver first
Date: Thu,  1 Oct 2015 14:20:25 +0300
Message-ID: <1443698430-74415-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4121 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755701AbbJALUf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 1 Oct 2015 07:20:35 -0400
In-Reply-To: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Intel Galileo boards the GPIO expander is connected to i2c bus. Moreover it
is able to generate interrupt, but interrupt line is connected to GPIO. That's
why we have to have GPIO driver in place when we will probe i2c host with
device connected to it.

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
2.5.1
