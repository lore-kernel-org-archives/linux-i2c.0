From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/8] mfd: intel_quark_i2c_gpio: support devices behind i2c bus
Date: Tue, 22 Sep 2015 13:10:15 +0300
Message-ID: <1442916619-140607-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Intel Galileo Gen2 the GPIO expanders are connected to the i2c bus. For
those devices the ACPI table has specific parameters that refer to an actual
i2c host controller. Since MFD now copes with that specific configuration we
have to provide a necessary information how to distinguish devices in ACPI
namespace. Here the _ADR values are provided.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 89bd4bf..e9fd33b 100644
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
 
@@ -82,9 +86,14 @@ static struct resource intel_quark_i2c_res[] = {
 	},
 };
 
+static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
+	.adr = MFD_ACPI_MATCH_I2C,
+};
+
 static struct mfd_cell intel_quark_mfd_i2c_cell = {
 	.id = MFD_I2C_BAR,
 	.name = "i2c_designware",
+	.acpi_match = &intel_quark_acpi_match_i2c,
 	.num_resources = ARRAY_SIZE(intel_quark_i2c_res),
 	.resources = intel_quark_i2c_res,
 	.ignore_resource_conflicts = true,
@@ -96,9 +105,14 @@ static struct resource intel_quark_gpio_res[] = {
 	},
 };
 
+static struct mfd_cell_acpi_match intel_quark_acpi_match_gpio = {
+	.adr = MFD_ACPI_MATCH_GPIO,
+};
+
 static struct mfd_cell intel_quark_mfd_gpio_cell = {
 	.id = MFD_GPIO_BAR,
 	.name = "gpio-dwapb",
+	.acpi_match = &intel_quark_acpi_match_gpio,
 	.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
 	.resources = intel_quark_gpio_res,
 	.ignore_resource_conflicts = true,
-- 
2.5.1
