From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/8] mfd: intel_quark_i2c_gpio: support devices behind i2c bus
Date: Thu,  1 Oct 2015 14:20:26 +0300
Message-ID: <1443698430-74415-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38744 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756489AbbJALVG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 1 Oct 2015 07:21:06 -0400
In-Reply-To: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Intel Galileo Gen2 the GPIO expanders are connected to the i2c bus. For
those devices the ACPI table has specific parameters that refer to an actual
i2c host controller. Since MFD now copes with that specific configuration we
have to provide a necessary information how to distinguish devices in ACPI
namespace. Here the _ADR values are provided.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 958c134..0421374 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -31,6 +31,10 @@
 #define MFD_I2C_BAR		0
 #define MFD_GPIO_BAR		1
 
+/* ACPI _ADR value to match the child node */
+#define MFD_ACPI_MATCH_GPIO	0ULL
+#define MFD_ACPI_MATCH_I2C	1ULL
+
 /* The base GPIO number under GPIOLIB framework */
 #define INTEL_QUARK_MFD_GPIO_BASE	8
 
@@ -82,16 +86,25 @@ static struct resource intel_quark_i2c_res[] = {
 	},
 };
 
+static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
+	.adr = MFD_ACPI_MATCH_I2C,
+};
+
 static struct resource intel_quark_gpio_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
 };
 
+static struct mfd_cell_acpi_match intel_quark_acpi_match_gpio = {
+	.adr = MFD_ACPI_MATCH_GPIO,
+};
+
 static struct mfd_cell intel_quark_mfd_cells[] = {
 	{
 		.id = MFD_GPIO_BAR,
 		.name = "gpio-dwapb",
+		.acpi_match = &intel_quark_acpi_match_gpio,
 		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
 		.resources = intel_quark_gpio_res,
 		.ignore_resource_conflicts = true,
@@ -99,6 +112,7 @@ static struct mfd_cell intel_quark_mfd_cells[] = {
 	{
 		.id = MFD_I2C_BAR,
 		.name = "i2c_designware",
+		.acpi_match = &intel_quark_acpi_match_i2c,
 		.num_resources = ARRAY_SIZE(intel_quark_i2c_res),
 		.resources = intel_quark_i2c_res,
 		.ignore_resource_conflicts = true,
-- 
2.5.1
