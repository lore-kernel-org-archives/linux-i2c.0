From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 13/13] i2c: designware: Convert to use unified device property API
Date: Tue, 24 Nov 2015 12:22:59 +0200
Message-ID: <1448360579-79260-14-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

With ACPI _DSD (introduced in ACPI v5.1) it is now possible to pass device
configuration information from ACPI in addition to DT. In order to support
this, convert the driver to use the unified device property accessors
instead of DT specific.

Change to ordering a bit so that we first try platform data and if that's
not available look from device properties. ACPI *CNT methods are then used
as last resort to override everything else.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 48 +++++++++++++----------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 809579e..e9062be 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -36,6 +36,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -156,33 +157,28 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	/* fast mode by default because of legacy reasons */
 	clk_freq = 400000;
 
-	if (has_acpi_companion(&pdev->dev)) {
-		dw_i2c_acpi_configure(pdev);
-	} else if (pdev->dev.of_node) {
-		of_property_read_u32(pdev->dev.of_node,
-					"i2c-sda-hold-time-ns", &ht);
-
-		of_property_read_u32(pdev->dev.of_node,
-				     "i2c-sda-falling-time-ns",
-				     &dev->sda_falling_time);
-		of_property_read_u32(pdev->dev.of_node,
-				     "i2c-scl-falling-time-ns",
-				     &dev->scl_falling_time);
-
-		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				     &clk_freq);
-
-		/* Only standard mode at 100kHz and fast mode at 400kHz
-		 * are supported.
-		 */
-		if (clk_freq != 100000 && clk_freq != 400000) {
-			dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
-			return -EINVAL;
-		}
+	if ((pdata = dev_get_platdata(&pdev->dev))) {
+		clk_freq = pdata->i2c_scl_freq;
 	} else {
-		pdata = dev_get_platdata(&pdev->dev);
-		if (pdata)
-			clk_freq = pdata->i2c_scl_freq;
+		device_property_read_u32(&pdev->dev, "i2c-sda-hold-time-ns",
+					 &ht);
+		device_property_read_u32(&pdev->dev, "i2c-sda-falling-time-ns",
+					 &dev->sda_falling_time);
+		device_property_read_u32(&pdev->dev, "i2c-scl-falling-time-ns",
+					 &dev->scl_falling_time);
+		device_property_read_u32(&pdev->dev, "clock-frequency",
+					 &clk_freq);
+	}
+
+	if (has_acpi_companion(&pdev->dev))
+		dw_i2c_acpi_configure(pdev);
+
+	/* Only standard mode at 100kHz and fast mode at 400kHz
+	 * are supported.
+	 */
+	if (clk_freq != 100000 && clk_freq != 400000) {
+		dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
+		return -EINVAL;
 	}
 
 	r = i2c_dw_eval_lock_support(dev);
-- 
2.6.2
