From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Fix false warning from i2c_dw_clk_rate()
Date: Thu, 11 May 2017 15:49:49 +0300
Message-ID: <20170511124949.26650-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:6162 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932866AbdEKMv5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 11 May 2017 08:51:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Commit bd698d24b1b5 ("i2c: designware: Get selected speed mode
sda-hold-time via ACPI") causes a false warning from i2c_dw_clk_rate()
in case platform doesn't provide explicit input clock but provides valid
SCL timing parameters via ACPI.

After above commit timing parameters only for the selected speed is get
but code in i2c_dw_init() tries to calculate missing parameters using
the input clock which leads to a warning when there is no input clock
defined.

Fix this by reordering the code such a way that timing parameters
validation/calculation and setting is done for the selected speed only.
While at it do the calculation only once during the first call.

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 148 +++++++++++++++++++------------
 1 file changed, 89 insertions(+), 59 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c453717b753b..315c2b4365d3 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -317,48 +317,9 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
 		dev->release_lock(dev);
 }
 
-/**
- * i2c_dw_init() - initialize the designware i2c master hardware
- * @dev: device private data
- *
- * This functions configures and enables the I2C master.
- * This function is called during I2C init function, and in case of timeout at
- * run time.
- */
-int i2c_dw_init(struct dw_i2c_dev *dev)
+static void i2c_dw_set_timings_sm(struct dw_i2c_dev *dev)
 {
 	u32 hcnt, lcnt;
-	u32 reg, comp_param1;
-	u32 sda_falling_time, scl_falling_time;
-	int ret;
-
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
-
-	reg = dw_readl(dev, DW_IC_COMP_TYPE);
-	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
-		/* Configure register endianess access */
-		dev->flags |= ACCESS_SWAP;
-	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
-		/* Configure register access mode 16bit */
-		dev->flags |= ACCESS_16BIT;
-	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
-		dev_err(dev->dev, "Unknown Synopsys component type: "
-			"0x%08x\n", reg);
-		i2c_dw_release_lock(dev);
-		return -ENODEV;
-	}
-
-	comp_param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
-
-	/* Disable the adapter */
-	__i2c_dw_enable_and_wait(dev, false);
-
-	/* set standard and fast speed deviders for high/low periods */
-
-	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
-	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
 
 	/* Set SCL timing parameters for standard-mode */
 	if (dev->ss_hcnt && dev->ss_lcnt) {
@@ -367,17 +328,24 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	} else {
 		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
 					4000,	/* tHD;STA = tHIGH = 4.0 us */
-					sda_falling_time,
+					dev->sda_falling_time,
 					0,	/* 0: DW default, 1: Ideal */
 					0);	/* No offset */
 		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
 					4700,	/* tLOW = 4.7 us */
-					scl_falling_time,
+					dev->scl_falling_time,
 					0);	/* No offset */
+		dev->ss_hcnt = hcnt;
+		dev->ss_lcnt = lcnt;
 	}
 	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
 	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
 	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
+}
+
+static void i2c_dw_set_timings_fm(struct dw_i2c_dev *dev)
+{
+	u32 hcnt, lcnt;
 
 	/* Set SCL timing parameters for fast-mode or fast-mode plus */
 	if ((dev->clk_freq == 1000000) && dev->fp_hcnt && dev->fp_lcnt) {
@@ -389,33 +357,58 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	} else {
 		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
 					600,	/* tHD;STA = tHIGH = 0.6 us */
-					sda_falling_time,
+					dev->sda_falling_time,
 					0,	/* 0: DW default, 1: Ideal */
 					0);	/* No offset */
 		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
 					1300,	/* tLOW = 1.3 us */
-					scl_falling_time,
+					dev->scl_falling_time,
 					0);	/* No offset */
+		dev->fs_hcnt = hcnt;
+		dev->fs_lcnt = lcnt;
 	}
 	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
 	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
 	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
+}
 
-	if ((dev->master_cfg & DW_IC_CON_SPEED_MASK) ==
-		DW_IC_CON_SPEED_HIGH) {
-		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
-			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
-			dev_err(dev->dev, "High Speed not supported!\n");
-			dev->master_cfg &= ~DW_IC_CON_SPEED_MASK;
-			dev->master_cfg |= DW_IC_CON_SPEED_FAST;
-		} else if (dev->hs_hcnt && dev->hs_lcnt) {
-			hcnt = dev->hs_hcnt;
-			lcnt = dev->hs_lcnt;
-			dw_writel(dev, hcnt, DW_IC_HS_SCL_HCNT);
-			dw_writel(dev, lcnt, DW_IC_HS_SCL_LCNT);
-			dev_dbg(dev->dev, "HighSpeed-mode HCNT:LCNT = %d:%d\n",
-				hcnt, lcnt);
-		}
+static void i2c_dw_set_timings_hsm(struct dw_i2c_dev *dev)
+{
+	u32 comp_param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
+
+	if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
+	    != DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
+		dev_err(dev->dev, "High Speed not supported!\n");
+		/* revert to fast-mode */
+		dev->master_cfg &= ~DW_IC_CON_SPEED_MASK;
+		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+		i2c_dw_set_timings_fm(dev);
+	} else if (dev->hs_hcnt && dev->hs_lcnt) {
+		dw_writel(dev, dev->hs_hcnt, DW_IC_HS_SCL_HCNT);
+		dw_writel(dev, dev->hs_lcnt, DW_IC_HS_SCL_LCNT);
+		dev_dbg(dev->dev, "HighSpeed-mode HCNT:LCNT = %d:%d\n",
+			dev->hs_hcnt, dev->hs_lcnt);
+	}
+}
+
+static void i2c_dw_set_timings(struct dw_i2c_dev *dev)
+{
+	u32 reg;
+
+	/* set standard and fast speed deviders for high/low periods */
+	dev->sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
+	dev->scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
+
+	switch (dev->master_cfg & DW_IC_CON_SPEED_MASK) {
+	case DW_IC_CON_SPEED_STD:
+		i2c_dw_set_timings_sm(dev);
+		break;
+	case DW_IC_CON_SPEED_FAST:
+		i2c_dw_set_timings_fm(dev);
+		break;
+	case DW_IC_CON_SPEED_HIGH:
+		i2c_dw_set_timings_hsm(dev);
+		break;
 	}
 
 	/* Configure SDA Hold Time if required */
@@ -439,6 +432,43 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		dev_warn(dev->dev,
 			"Hardware too old to adjust SDA hold time.\n");
 	}
+}
+
+/**
+ * i2c_dw_init() - initialize the designware i2c master hardware
+ * @dev: device private data
+ *
+ * This functions configures and enables the I2C master.
+ * This function is called during I2C init function, and in case of timeout at
+ * run time.
+ */
+int i2c_dw_init(struct dw_i2c_dev *dev)
+{
+	u32 reg;
+	int ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	reg = dw_readl(dev, DW_IC_COMP_TYPE);
+	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
+		/* Configure register endianess access */
+		dev->flags |= ACCESS_SWAP;
+	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
+		/* Configure register access mode 16bit */
+		dev->flags |= ACCESS_16BIT;
+	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
+		dev_err(dev->dev, "Unknown Synopsys component type: "
+			"0x%08x\n", reg);
+		i2c_dw_release_lock(dev);
+		return -ENODEV;
+	}
+
+	/* Disable the adapter */
+	__i2c_dw_enable_and_wait(dev, false);
+
+	i2c_dw_set_timings(dev);
 
 	/* Configure Tx/Rx FIFO threshold levels */
 	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
-- 
2.11.0
