From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 2/3] i2c: designware: Rework probe() to get clock a bit later
Date: Tue, 30 Sep 2014 13:04:54 +0300
Message-ID: <1412071495-15323-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1412071495-15323-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412071495-15323-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In order to be able to create missing clock for AMD (and in future possibly
others) we move getting clock for the device a bit later. Also make ACPI/DT
configuration in the same place depending on from where the device was
enumerated from.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 38 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 353adc4dc583..e59c63ae4d41 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -81,9 +81,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
-	if (!ACPI_HANDLE(&pdev->dev))
-		return -ENODEV;
-
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
 	dev->rx_fifo_depth = 32;
@@ -123,7 +120,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct dw_i2c_platform_data *pdata;
 	int irq, r;
-	u32 clk_freq;
+	u32 clk_freq, ht = 0;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -146,24 +143,14 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
-
-	if (IS_ERR(dev->clk))
-		return PTR_ERR(dev->clk);
-	clk_prepare_enable(dev->clk);
-
 	/* fast mode by default because of legacy reasons */
 	clk_freq = 400000;
 
-	if (pdev->dev.of_node) {
-		u32 ht = 0;
-		u32 ic_clk = dev->get_clk_rate_khz(dev);
-
+	if (ACPI_COMPANION(&pdev->dev)) {
+		dw_i2c_acpi_configure(pdev);
+	} else if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
 					"i2c-sda-hold-time-ns", &ht);
-		dev->sda_hold_time = div_u64((u64)ic_clk * ht + 500000,
-					     1000000);
 
 		of_property_read_u32(pdev->dev.of_node,
 				     "i2c-sda-falling-time-ns",
@@ -202,9 +189,20 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
-	/* Try first if we can configure the device from ACPI */
-	r = dw_i2c_acpi_configure(pdev);
-	if (r) {
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
+	clk_prepare_enable(dev->clk);
+
+	if (!dev->sda_hold_time && ht) {
+		u32 ic_clk = dev->get_clk_rate_khz(dev);
+
+		dev->sda_hold_time = div_u64((u64)ic_clk * ht + 500000,
+					     1000000);
+	}
+
+	if (!dev->tx_fifo_depth) {
 		u32 param1 = i2c_dw_read_comp_param(dev);
 
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
-- 
2.1.0
