From: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4] i2c: designware: Add support for AMD i2c controller
Date: Wed, 17 Sep 2014 13:14:45 +0800
Message-ID: <1410930885-1379-1-git-send-email-carlpeng008@gmail.com>
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
 drivers/i2c/busses/i2c-designware-platdrv.c | 53 +++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index bc87733..20015e6 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -43,14 +43,18 @@
 #include <linux/acpi.h>
 #include "i2c-designware-core.h"
 
+struct dw_i2c_config {
+	u32 clk_rate_khz;
+};
+
 static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
 	.functionality	= i2c_dw_func,
 };
-static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
-{
-	return clk_get_rate(dev->clk)/1000;
-}
+
+static struct dw_i2c_config amd_i2c_config = {
+	.clk_rate_khz = 133 * 1000,
+};
 
 #ifdef CONFIG_ACPI
 static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
@@ -107,7 +111,8 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3433", 0 },
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
-	{ }
+	{ "AMD0010", (unsigned long)&amd_i2c_config },
+	{},
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
 #else
@@ -117,12 +122,35 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 }
 #endif
 
+static const struct dw_i2c_config *i2c_dw_get_config(
+					struct dw_i2c_dev *dev)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dw_i2c_acpi_match, dev->dev);
+	if (id)
+		return (const struct dw_i2c_config *)id->driver_data;
+
+	return NULL;
+}
+
+static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
+{
+	const struct dw_i2c_config *conf = i2c_dw_get_config(dev);
+
+	if (conf)
+		return conf->clk_rate_khz;
+
+	return clk_get_rate(dev->clk)/1000;
+}
+
 static int dw_i2c_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem;
 	int irq, r;
+	const struct dw_i2c_config *conf;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -145,12 +173,17 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
+	conf = i2c_dw_get_config(dev);
+
+	if (!conf) {
+		dev->clk = devm_clk_get(&pdev->dev, NULL);
 
-	if (IS_ERR(dev->clk))
-		return PTR_ERR(dev->clk);
-	clk_prepare_enable(dev->clk);
+		if (IS_ERR(dev->clk))
+			return PTR_ERR(dev->clk);
+		clk_prepare_enable(dev->clk);
+	}
+
+	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 
 	if (pdev->dev.of_node) {
 		u32 ht = 0;
-- 
1.9.1
