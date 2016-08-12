From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/8] i2c: designware: Move clk_freq into struct dw_i2c_dev
Date: Fri, 12 Aug 2016 17:02:47 +0300
Message-ID: <1471010574-28598-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcHLODG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Aug 2016 10:03:06 -0400
In-Reply-To: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Weifeng Voon <weifeng.voon@intel.com>

I2c designware controller operate speed is configured in the register
IC_CON. Previously the operate speed is determined by a local variable
clk_freq. This patch will move the local variable clk_freq into struct
dw_i2c_dev. This change will ease the set and get of the clk_freq.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h    |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 38493a7142ad..63f6d4acee39 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -57,6 +57,7 @@
  * @tx_fifo_depth: depth of the hardware tx fifo
  * @rx_fifo_depth: depth of the hardware rx fifo
  * @rx_outstanding: current master-rx elements in tx fifo
+ * @clk_freq: bus clock frequency
  * @ss_hcnt: standard speed HCNT value
  * @ss_lcnt: standard speed LCNT value
  * @fs_hcnt: fast speed HCNT value
@@ -96,6 +97,7 @@ struct dw_i2c_dev {
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 	int			rx_outstanding;
+	u32			clk_freq;
 	u32			sda_hold_time;
 	u32			sda_falling_time;
 	u32			scl_falling_time;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d656657b805c..1608cf4d3263 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -155,7 +155,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *mem;
 	int irq, r;
-	u32 clk_freq, ht = 0;
+	u32 ht = 0;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -175,10 +175,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 
 	/* fast mode by default because of legacy reasons */
-	clk_freq = 400000;
+	dev->clk_freq = 400000;
 
 	if (pdata) {
-		clk_freq = pdata->i2c_scl_freq;
+		dev->clk_freq = pdata->i2c_scl_freq;
 	} else {
 		device_property_read_u32(&pdev->dev, "i2c-sda-hold-time-ns",
 					 &ht);
@@ -187,7 +187,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		device_property_read_u32(&pdev->dev, "i2c-scl-falling-time-ns",
 					 &dev->scl_falling_time);
 		device_property_read_u32(&pdev->dev, "clock-frequency",
-					 &clk_freq);
+					 &dev->clk_freq);
 	}
 
 	if (has_acpi_companion(&pdev->dev))
@@ -196,7 +196,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	/*
 	 * Only standard mode at 100kHz and fast mode at 400kHz are supported.
 	 */
-	if (clk_freq != 100000 && clk_freq != 400000) {
+	if (dev->clk_freq != 100000 && dev->clk_freq != 400000) {
 		dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
 		return -EINVAL;
 	}
@@ -212,7 +212,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
-	if (clk_freq == 100000)
+	if (dev->clk_freq == 100000)
 		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_STD;
 	else
-- 
2.8.1
