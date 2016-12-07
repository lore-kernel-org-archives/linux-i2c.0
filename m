From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v4 1/5] i2c: designware: Refactoring of the i2c-designware
Date: Wed,  7 Dec 2016 17:55:48 +0000
Message-ID: <486c43e4c57116fa955ab99cea7f484ee8a2bdf3.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Factor out all _master() part of code from i2c-designware-core
  and i2c-designware-platdrv to separate functions.
- Standardize all code related with MASTER modes.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V3->V4: (Andy Shevchenko)
- I have to take off DW_IC_INTR_TX_EMPTY from DW_IC_INTR_DEFAULT_MASK
  because is not common to both operating modes 
- Comments were changed to be specific to "master"

 drivers/i2c/busses/i2c-designware-core.c    | 57 +++++++++++++++++++----------
 drivers/i2c/busses/i2c-designware-platdrv.c | 35 +++++++++++-------
 2 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6d81c56184d3..a51addfde565 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -87,10 +87,12 @@
 #define DW_IC_INTR_GEN_CALL	0x800
 
 #define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
-					 DW_IC_INTR_TX_EMPTY | \
 					 DW_IC_INTR_TX_ABRT | \
 					 DW_IC_INTR_STOP_DET)
 
+#define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
+					 DW_IC_INTR_TX_EMPTY)
+
 #define DW_IC_STATUS_ACTIVITY	0x1
 
 #define DW_IC_SDA_HOLD_RX_SHIFT		16
@@ -202,6 +204,16 @@ static void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 	}
 }
 
+static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
+{
+	/* Configure Tx/Rx FIFO threshold levels */
+	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
+	dw_writel(dev, 0, DW_IC_RX_TL);
+
+	/* configure the i2c master */
+	dw_writel(dev, dev->master_cfg, DW_IC_CON);
+}
+
 static u32
 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
@@ -318,10 +330,10 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
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
@@ -440,12 +452,9 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 			"Hardware too old to adjust SDA hold time.\n");
 	}
 
-	/* Configure Tx/Rx FIFO threshold levels */
-	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
-	dw_writel(dev, 0, DW_IC_RX_TL);
-
-	/* configure the i2c master */
-	dw_writel(dev, dev->master_cfg , DW_IC_CON);
+	if ((dev->master_cfg & DW_IC_CON_MASTER) &&
+		 (dev->master_cfg & DW_IC_CON_SLAVE_DISABLE))
+		i2c_dw_configure_fifo_master(dev);
 
 	i2c_dw_release_lock(dev);
 
@@ -513,7 +522,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
-	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
+	dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);
 }
 
 /*
@@ -533,7 +542,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
 
-	intr_mask = DW_IC_INTR_DEFAULT_MASK;
+	intr_mask = DW_IC_INTR_MASTER_MASK;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		u32 flags = msgs[dev->msg_write_idx].flags;
@@ -886,16 +895,9 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
  * Interrupt service routine. This gets called whenever an I2C interrupt
  * occurs.
  */
-static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
+int i2c_dw_irq_handler_master(struct dw_i2c_dev *dev)
 {
-	struct dw_i2c_dev *dev = dev_id;
-	u32 stat, enabled;
-
-	enabled = dw_readl(dev, DW_IC_ENABLE);
-	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
-	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__, enabled, stat);
-	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
-		return IRQ_NONE;
+	u32 stat;
 
 	stat = i2c_dw_read_clear_intrbits(dev);
 
@@ -932,7 +934,22 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		i2c_dw_disable_int(dev);
 		dw_writel(dev, stat, DW_IC_INTR_MASK);
 	}
+	return 0;
+}
+
+static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
+{
+	struct dw_i2c_dev *dev = dev_id;
+	u32 stat, enabled, mode;
+
+	enabled = dw_readl(dev, DW_IC_ENABLE);
+	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__, enabled, stat);
+	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
+		return IRQ_NONE;
 
+	i2c_dw_irq_handler_master(dev);
+	complete(&dev->cmd_complete);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 08153ea4d848..e55b5544c733 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -138,6 +138,27 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 }
 #endif
 
+static void i2c_dw_configure_master(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+
+	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+			  DW_IC_CON_RESTART_EN;
+
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
+}
+
 static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
 {
 	if (IS_ERR(i_dev->clk))
@@ -221,19 +242,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
 
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
2.11.0
