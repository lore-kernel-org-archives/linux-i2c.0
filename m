From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Thu, 18 Sep 2014 12:26:07 +0300
Message-ID: <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411032367-20274-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add support for AMD version of the DW I2C host controller. The device is
enumerated from ACPI namespace with ACPI ID AMD0010. Because the core
driver needs an input source clock, and this is not an Intel LPSS device
where clocks are provided through drivers/acpi/acpi_lpss.c, we register the
clock ourselves if the clock rate is given in ->driver_data.

Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/Kconfig                  |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2ac87fa3058d..9384498ef3c1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -422,6 +422,7 @@ config I2C_DESIGNWARE_CORE
 
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
+	depends on COMMON_CLK
 	select I2C_DESIGNWARE_CORE
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 7087b6ee97e2..ecd0215d93c2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/err.h>
@@ -80,6 +81,7 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	bool fs_mode = dev->master_cfg & DW_IC_CON_SPEED_FAST;
+	const struct acpi_device_id *id;
 
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
@@ -94,9 +96,29 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
 			   fs_mode ? &dev->sda_hold_time : NULL);
 
+	/*
+	 * Provide a way for Designware I2C host controllers that are not
+	 * based on Intel LPSS to specify their input clock frequency via
+	 * ->driver_data.
+	 */
+	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	if (id && id->driver_data)
+		clk_register_fixed_rate(&pdev->dev, dev_name(&pdev->dev), NULL,
+					CLK_IS_ROOT, id->driver_data);
+
 	return 0;
 }
 
+static void dw_i2c_acpi_unconfigure(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	if (id && id->driver_data)
+		clk_unregister(dev->clk);
+}
+
 static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT33C2", 0 },
 	{ "INT33C3", 0 },
@@ -104,6 +126,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3433", 0 },
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
+	{ "AMD0010", 133 * 1000 * 1000 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
@@ -112,6 +135,7 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	return -ENODEV;
 }
+static inline void dw_i2c_acpi_unconfigure(struct platform_device *pdev) { }
 #endif
 
 static int dw_i2c_probe(struct platform_device *pdev)
@@ -235,6 +259,9 @@ static int dw_i2c_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (ACPI_COMPANION(&pdev->dev))
+		dw_i2c_acpi_unconfigure(pdev);
+
 	return 0;
 }
 
-- 
2.1.0
