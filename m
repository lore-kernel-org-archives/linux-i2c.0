From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v5 6/7] i2c: designware: enable SLAVE in platform module
Date: Wed, 28 Dec 2016 14:43:25 +0000
Message-ID: <ea8b611c3b7c2af8088e2dbc16554af5c8aed368.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:49210 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbcL1Orh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Dec 2016 09:47:37 -0500
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

- Slave mode selected in platform module (devicetree support only)
- Check for ACPI - not supported in SLAVE mode:
  - Changed the ifndef style to the use of ACPI_HANDLE that returns NULL
    if the device was not enumerated from ACPI namespace.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V4->V5: (Andy Shevchenko, Rob Herring, Mark Rutland)
- This is the patch that actually enable SLAVE mode in the platform 
  module by probing the DT nodes (Rob suggestion).
- Changed my device tree. Now I'm using: <reg | I2C_OWN_SLAVE_ADDRESS>
  to identify a Slave.
- I have a new way of checking if ACPI is not enabled using the 
  ACPI_HANDLE and not ifdef.

 drivers/i2c/busses/i2c-designware-platdrv.c | 70 +++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 5cf4df63dbe8..ef75031f8a62 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -21,6 +21,7 @@
  * ----------------------------------------------------------------------------
  *
  */
+#include <dt-bindings/i2c/i2c.h>
 #include <linux/acpi.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
@@ -143,11 +144,15 @@ static void i2c_dw_configure_master(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
+	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
+
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
 
 	dev_dbg(&pdev->dev, "I am registed as a I2C Master!\n");
 
+	dev->mode = DW_IC_MASTER;
+
 	switch (dev->clk_freq) {
 	case 100000:
 		dev->master_cfg |= DW_IC_CON_SPEED_STD;
@@ -160,6 +165,32 @@ static void i2c_dw_configure_master(struct platform_device *pdev)
 	}
 }
 
+static void i2c_dw_configure_slave(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+
+	dev->functionality = I2C_FUNC_SLAVE | DW_IC_DEFAULT_FUNCTIONALITY;
+
+	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
+			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED |
+			 DW_IC_CON_SPEED_FAST;
+
+	dev_dbg(&pdev->dev, "I am registed as a I2C Slave!\n");
+
+	dev->mode = DW_IC_SLAVE;
+
+	switch (dev->clk_freq) {
+	case 100000:
+		dev->slave_cfg |= DW_IC_CON_SPEED_STD;
+		break;
+	case 3400000:
+		dev->slave_cfg |= DW_IC_CON_SPEED_HIGH;
+		break;
+	default:
+		dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
+	}
+}
+
 static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
 {
 	if (IS_ERR(i_dev->clk))
@@ -200,9 +231,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct i2c_adapter *adap;
 	struct dw_i2c_dev *dev;
+	struct fwnode_handle *child;
 	u32 acpi_speed, ht = 0;
 	struct resource *mem;
 	int irq, r;
+	u32 reg;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -264,9 +297,16 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
-
-	i2c_dw_configure_master(pdev);
+	if (ACPI_HANDLE(&pdev->dev) == NULL) {
+		device_for_each_child_node(&pdev->dev, child) {
+			fwnode_property_read_u32(child, "reg", &reg);
+			if (reg & I2C_OWN_SLAVE_ADDRESS)
+				i2c_dw_configure_slave(pdev);
+			else
+				i2c_dw_configure_master(pdev);
+		}
+	} else
+		i2c_dw_configure_master(pdev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
@@ -295,7 +335,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
-	r = i2c_dw_probe(dev);
+	if (dev->mode == DW_IC_SLAVE)
+		r = i2c_dw_probe_slave(dev);
+	else
+		r = i2c_dw_probe(dev);
+
 	if (r && !dev->pm_runtime_disabled)
 		pm_runtime_disable(&pdev->dev);
 
@@ -310,7 +354,10 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&dev->adapter);
 
-	i2c_dw_disable(dev);
+	if (dev->mode == DW_IC_SLAVE)
+		i2c_dw_disable_slave(dev);
+	else
+		i2c_dw_disable(dev);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
@@ -350,7 +397,10 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
-	i2c_dw_disable(i_dev);
+	if (i_dev->mode == DW_IC_SLAVE)
+		i2c_dw_disable_slave(i_dev);
+	else
+		i2c_dw_disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
 
 	return 0;
@@ -363,8 +413,12 @@ static int dw_i2c_plat_resume(struct device *dev)
 
 	i2c_dw_plat_prepare_clk(i_dev, true);
 
-	if (!i_dev->pm_runtime_disabled)
-		i2c_dw_init(i_dev);
+	if (!i_dev->pm_runtime_disabled) {
+		if (i_dev->mode == DW_IC_SLAVE)
+			i2c_dw_init_slave(i_dev);
+		else
+			i2c_dw_init(i_dev);
+	}
 
 	return 0;
 }
-- 
2.11.0
