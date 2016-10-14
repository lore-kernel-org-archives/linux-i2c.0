From: Luis.Oliveira@synopsys.com
Subject: [PATCH v2 1/4] Factor out _master() parts of code and identify as much as possible all related with MASTER mode
Date: Fri, 14 Oct 2016 17:52:48 +0100
Message-ID: <923d41c5a11538963fe5b49d181cfa8d1fec5756.1476462204.git.lolivei@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:32978 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbcJNQxh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Oct 2016 12:53:37 -0400
In-Reply-To: <cover.1476462204.git.lolivei@synopsys.com>
In-Reply-To: <cover.1476462204.git.lolivei@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, CARLOS.PALMINHA@synopsys.com, Ramiro.Oliveira@synopsys.com

From: Luis Oliveira <lolivei@synopsys.com>

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
 drivers/i2c/busses/i2c-designware-core.c    | 71 +++++++++++++++++++----------
 drivers/i2c/busses/i2c-designware-platdrv.c | 37 +++++++++------
 2 files changed, 71 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 1fe93c4..cc38329 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -87,13 +87,15 @@
 #define DW_IC_INTR_GEN_CALL	0x800
 
 #define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
-					 DW_IC_INTR_TX_EMPTY | \
 					 DW_IC_INTR_TX_ABRT | \
 					 DW_IC_INTR_STOP_DET)
+ 
+#define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
+					 DW_IC_INTR_TX_EMPTY)
 
 #define DW_IC_STATUS_ACTIVITY		0x1
 #define DW_IC_STATUS_TFE		BIT(2)
-#define DW_IC_STATUS_MST_ACTIVITY	BIT(5)
+#define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
@@ -201,6 +203,17 @@ static void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 	}
 }
 
+static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
+{
+		/* Configure Tx/Rx FIFO threshold levels */
+		dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
+		dw_writel(dev, 0, DW_IC_RX_TL);
+
+		/* configure the i2c master */
+		dw_writel(dev, dev->master_cfg , DW_IC_CON);
+		dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);
+}
+
 static u32
 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
@@ -317,10 +330,10 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
 }
 
 /**
- * i2c_dw_init() - initialize the designware i2c master hardware
+ * i2c_dw_init() - initialize the designware i2c hardware
  * @dev: device private data
  *
- * This functions configures and enables the I2C master.
+ * This functions configures and enables the I2C.
  * This function is called during I2C init function, and in case of timeout at
  * run time.
  */
@@ -431,12 +444,9 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 			"Hardware too old to adjust SDA hold time.\n");
 	}
 
-	/* Configure Tx/Rx FIFO threshold levels */
-	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
-	dw_writel(dev, 0, DW_IC_RX_TL);
-
-	/* configure the i2c master */
-	dw_writel(dev, dev->master_cfg , DW_IC_CON);
+	if ((dev->master_cfg & DW_IC_CON_MASTER) &&
+		(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) 
+		i2c_dw_configure_fifo_master(dev);
 
 	i2c_dw_release_lock(dev);
 
@@ -480,7 +490,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		 */
 		ic_status = dw_readl(dev, DW_IC_STATUS);
 		if (!dev->dynamic_tar_update_enabled ||
-		    (ic_status & DW_IC_STATUS_MST_ACTIVITY) ||
+		    (ic_status & DW_IC_STATUS_MASTER_ACTIVITY) ||
 		    !(ic_status & DW_IC_STATUS_TFE)) {
 			__i2c_dw_enable_and_wait(dev, false);
 			enabled = false;
@@ -520,7 +530,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
-	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
+	dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);
 }
 
 /*
@@ -540,7 +550,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
 
-	intr_mask = DW_IC_INTR_DEFAULT_MASK;
+	intr_mask = DW_IC_INTR_MASTER_MASK;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/*
@@ -839,19 +849,13 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
  * Interrupt service routine. This gets called whenever an I2C interrupt
  * occurs.
  */
-static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
-{
-	struct dw_i2c_dev *dev = dev_id;
-	u32 stat, enabled;
-
-	enabled = dw_readl(dev, DW_IC_ENABLE);
-	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
-	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__, enabled, stat);
-	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
-		return IRQ_NONE;
 
+static bool i2c_dw_irq_handler_master(struct dw_i2c_dev *dev )
+{
+	u32 stat;
+	
 	stat = i2c_dw_read_clear_intrbits(dev);
-
+	
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
@@ -895,7 +899,26 @@ tx_aborted:
 		i2c_dw_disable_int(dev);
 		dw_writel(dev, stat, DW_IC_INTR_MASK);
 	}
+	return true;
+}
+
+static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
+{
+	struct dw_i2c_dev *dev = dev_id;
+	u32 stat, enabled, mode;
+
+	enabled = dw_readl(dev, DW_IC_ENABLE);
+	mode = dw_readl(dev, DW_IC_CON);
+	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+
+	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__, enabled, stat);
+	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
+		return IRQ_NONE;
 
+	if(i2c_dw_irq_handler_master(dev))
+		return IRQ_HANDLED;
+			
+	complete(&dev->cmd_complete);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12..d5986c2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -138,6 +138,29 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 }
 #endif
 
+static void i2c_dw_configure_master(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	
+	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+			  DW_IC_CON_RESTART_EN;
+			  
+	dev->functionality |= I2C_FUNC_10BIT_ADDR;
+	dev_info(&pdev->dev, "I am registed as a I2C Master!\n");
+	
+	switch (dev->clk_freq) {
+	case 100000:
+		dev->master_cfg |= DW_IC_CON_SPEED_STD;
+		break;
+	case 3400000:
+		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
+		break;
+	default:
+		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+	}
+	
+}
+
 static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
 {
 	if (IS_ERR(i_dev->clk))
@@ -222,19 +245,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
 
-	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-			  DW_IC_CON_RESTART_EN;
-
-	switch (dev->clk_freq) {
-	case 100000:
-		dev->master_cfg |= DW_IC_CON_SPEED_STD;
-		break;
-	case 3400000:
-		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
-		break;
-	default:
-		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
-	}
+	i2c_dw_configure_master(pdev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
-- 
2.10.1
