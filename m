From: Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH 1/1] i2c: designware: reverts "i2c: designware: Add support
 for AMD I2C controller"
Date: Fri, 23 Oct 2015 13:28:47 +0800
Message-ID: <1445578127.2977.23.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0073.outbound.protection.outlook.com ([157.56.110.73]:36256
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751191AbbJWFdl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 01:33:41 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: mika.westerberg@linux.intel.com
Cc: baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

The patch reverts commit a445900c9060 (i2c: designware: Add support for
AMD I2C controller)

Since kernel starts to support APD(drivers/acpi/acpi_apd.c), there is
no need to get freq from id->driver_data for AMD0010. clkdev is supposed
to be already registered in APD.

So, revert old design and make AMD0010 looks like other ones.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 472b882..4bf5fc1 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -97,7 +97,6 @@ static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
 static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
-	const struct acpi_device_id *id;
 
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
@@ -111,29 +110,9 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
 			   &dev->sda_hold_time);
 
-	/*
-	 * Provide a way for Designware I2C host controllers that are not
-	 * based on Intel LPSS to specify their input clock frequency via
-	 * id->driver_data.
-	 */
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (id && id->driver_data)
-		clk_register_fixed_rate(&pdev->dev, dev_name(&pdev->dev), NULL,
-					CLK_IS_ROOT, id->driver_data);
-
 	return 0;
 }
 
-static void dw_i2c_acpi_unconfigure(struct platform_device *pdev)
-{
-	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (id && id->driver_data)
-		clk_unregister(dev->clk);
-}
-
 static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT33C2", 0 },
 	{ "INT33C3", 0 },
@@ -141,7 +120,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3433", 0 },
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
-	{ "AMD0010", 133 * 1000 * 1000 },
+	{ "AMD0010", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
@@ -150,7 +129,6 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	return -ENODEV;
 }
-static inline void dw_i2c_acpi_unconfigure(struct platform_device *pdev) { }
 #endif
 
 static int dw_i2c_probe(struct platform_device *pdev)
@@ -306,9 +284,6 @@ static int dw_i2c_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (has_acpi_companion(&pdev->dev))
-		dw_i2c_acpi_unconfigure(pdev);
-
 	return 0;
 }
 
-- 
1.9.1
