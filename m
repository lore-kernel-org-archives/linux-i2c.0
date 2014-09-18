From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] i2c: designware: Rework probe() to get clock a bit later
Date: Thu, 18 Sep 2014 12:26:06 +0300
Message-ID: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In order to be able to create missing clock for AMD (and in future possibly
others) we move getting clock for the device a bit later. Also make ACPI/DT
configuration in the same place depending on from where the device was
enumerated from.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 54 ++++++++++++++---------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index bc8773333155..7087b6ee97e2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -81,9 +81,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	bool fs_mode = dev->master_cfg & DW_IC_CON_SPEED_FAST;
 
-	if (!ACPI_HANDLE(&pdev->dev))
-		return -ENODEV;
-
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
 	dev->rx_fifo_depth = 32;
@@ -123,6 +120,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *mem;
 	int irq, r;
+	u32 ht = 0;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -145,6 +143,29 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
+	dev->functionality =
+		I2C_FUNC_I2C |
+		I2C_FUNC_10BIT_ADDR |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK;
+	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
+
+	if (ACPI_COMPANION(&pdev->dev)) {
+		dw_i2c_acpi_configure(pdev);
+	} else if (pdev->dev.of_node) {
+		of_property_read_u32(pdev->dev.of_node,
+				     "i2c-sda-hold-time-ns", &ht);
+		of_property_read_u32(pdev->dev.of_node,
+				     "i2c-sda-falling-time-ns",
+				     &dev->sda_falling_time);
+		of_property_read_u32(pdev->dev.of_node,
+				     "i2c-scl-falling-time-ns",
+				     &dev->scl_falling_time);
+	}
+
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 
@@ -152,36 +173,13 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(dev->clk);
 	clk_prepare_enable(dev->clk);
 
-	if (pdev->dev.of_node) {
-		u32 ht = 0;
+	if (!dev->sda_hold_time && ht) {
 		u32 ic_clk = dev->get_clk_rate_khz(dev);
-
-		of_property_read_u32(pdev->dev.of_node,
-					"i2c-sda-hold-time-ns", &ht);
 		dev->sda_hold_time = div_u64((u64)ic_clk * ht + 500000,
 					     1000000);
-
-		of_property_read_u32(pdev->dev.of_node,
-				     "i2c-sda-falling-time-ns",
-				     &dev->sda_falling_time);
-		of_property_read_u32(pdev->dev.of_node,
-				     "i2c-scl-falling-time-ns",
-				     &dev->scl_falling_time);
 	}
 
-	dev->functionality =
-		I2C_FUNC_I2C |
-		I2C_FUNC_10BIT_ADDR |
-		I2C_FUNC_SMBUS_BYTE |
-		I2C_FUNC_SMBUS_BYTE_DATA |
-		I2C_FUNC_SMBUS_WORD_DATA |
-		I2C_FUNC_SMBUS_I2C_BLOCK;
-	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-
-	/* Try first if we can configure the device from ACPI */
-	r = dw_i2c_acpi_configure(pdev);
-	if (r) {
+	if (!dev->tx_fifo_depth) {
 		u32 param1 = i2c_dw_read_comp_param(dev);
 
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
-- 
2.1.0
