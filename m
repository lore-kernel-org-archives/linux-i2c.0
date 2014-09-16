From: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3] i2c: designware: Add support for AMD i2c controller
Date: Tue, 16 Sep 2014 14:20:58 +0800
Message-ID: <1410848458-1455-1-git-send-email-carlpeng008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

AMD i2c bus controller is ACPI device, its ACPI ID
is "AMD0010". This patch is used to add support for
AMD i2c bus controller in the Designware platform
driver.

Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 46 +++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index d66b6cb..c67d4ac 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -105,6 +105,7 @@ struct dw_i2c_dev {
 	u16			ss_lcnt;
 	u16			fs_hcnt;
 	u16			fs_lcnt;
+	struct	dw_i2c_pdata	*pdata;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index bc87733..8a96e69 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -43,15 +43,31 @@
 #include <linux/acpi.h>
 #include "i2c-designware-core.h"
 
+#define AMD_CLK_KHZ		(133 * 1000)
+
+struct dw_i2c_pdata {
+	u32 clk_rate_khz;
+};
+
 static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
 	.functionality	= i2c_dw_func,
 };
+
+static struct dw_i2c_pdata amd_i2c_config = {
+	.clk_rate_khz = AMD_CLK_KHZ,
+};
+
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 {
 	return clk_get_rate(dev->clk)/1000;
 }
 
+static u32 amd_i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
+{
+	return dev->pdata->clk_rate_khz;
+}
+
 #ifdef CONFIG_ACPI
 static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
 			       u16 *hcnt, u16 *lcnt, u32 *sda_hold)
@@ -107,7 +123,8 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3433", 0 },
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
-	{ }
+	{ "AMD0010", (unsigned long)&amd_i2c_config },
+	{},
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
 #else
@@ -116,6 +133,17 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 	return -ENODEV;
 }
 #endif
+struct dw_i2c_pdata *get_amd_i2c_driver_data(
+					struct platform_device *pdev)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dw_i2c_acpi_match, &pdev->dev);
+	if (id)
+		return (struct dw_i2c_pdata *)id->driver_data;
+
+	return NULL;
+}
 
 static int dw_i2c_probe(struct platform_device *pdev)
 {
@@ -145,12 +173,18 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
+	dev->pdata = get_amd_i2c_driver_data(pdev);
+
+	if (!dev->pdata) {
+		dev->clk = devm_clk_get(&pdev->dev, NULL);
+		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
+
+		if (IS_ERR(dev->clk))
+			return PTR_ERR(dev->clk);
+		clk_prepare_enable(dev->clk);
+	} else
+		dev->get_clk_rate_khz = amd_i2c_dw_get_clk_rate_khz;
 
-	if (IS_ERR(dev->clk))
-		return PTR_ERR(dev->clk);
-	clk_prepare_enable(dev->clk);
 
 	if (pdev->dev.of_node) {
 		u32 ht = 0;
-- 
1.9.1
