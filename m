From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v10 2/6] i2c: designware: refactoring of the i2c-designware
Date: Thu,  8 Jun 2017 18:36:46 +0100
Message-ID: <9e3ea00b242a7e97d1ef49476ecba7b529fbd804.1496942505.git.lolivei@synopsys.com>
References: <cover.1496942505.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1496942505.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1496942505.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1496942505.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

- Factor out all _master() part of code from i2c-designware-core
  and i2c-designware-platdrv to separate functions.
- Standardize all code related with MASTER mode.
- I have to take off DW_IC_INTR_TX_EMPTY from DW_IC_INTR_DEFAULT_MASK
  because it is master specific.

The purpose of this is to prepare the controller to have is I2C MASTER
flow in a separate driver. To do this first all the
functions/definitions related to the MASTER flow were identified.

Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Acked-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
v9-v10
- no changes

 drivers/i2c/busses/i2c-designware-core.c    | 56 +++++++++++++++++------------
 drivers/i2c/busses/i2c-designware-platdrv.c | 31 +++++++++-------
 2 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index efe211e8aac5..c45a4ae14d25 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -87,10 +87,10 @@
 #define DW_IC_INTR_GEN_CALL	0x800
 
 #define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
-					 DW_IC_INTR_TX_EMPTY | \
 					 DW_IC_INTR_TX_ABRT | \
 					 DW_IC_INTR_STOP_DET)
-
+#define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
+					 DW_IC_INTR_TX_EMPTY)
 #define DW_IC_STATUS_ACTIVITY	0x1
 
 #define DW_IC_SDA_HOLD_RX_SHIFT		16
@@ -202,6 +202,16 @@ static void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 	}
 }
 
+static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
+{
+	/* Configure Tx/Rx FIFO threshold levels */
+	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
+	dw_writel(dev, 0, DW_IC_RX_TL);
+
+	/* Configure the I2C master */
+	dw_writel(dev, dev->master_cfg, DW_IC_CON);
+}
+
 static u32
 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
@@ -440,13 +450,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 			"Hardware too old to adjust SDA hold time.\n");
 	}
 
-	/* Configure Tx/Rx FIFO threshold levels */
-	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
-	dw_writel(dev, 0, DW_IC_RX_TL);
-
-	/* Configure the I2C master */
-	dw_writel(dev, dev->master_cfg , DW_IC_CON);
-
+	i2c_dw_configure_fifo_master(dev);
 	i2c_dw_release_lock(dev);
 
 	return 0;
@@ -511,7 +515,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
-	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
+	dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);
 }
 
 /*
@@ -531,7 +535,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
 
-	intr_mask = DW_IC_INTR_DEFAULT_MASK;
+	intr_mask = DW_IC_INTR_MASTER_MASK;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		u32 flags = msgs[dev->msg_write_idx].flags;
@@ -881,22 +885,14 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 }
 
 /*
- * Interrupt service routine. This gets called whenever an I2C interrupt
+ * Interrupt service routine. This gets called whenever an I2C master interrupt
  * occurs.
  */
-static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
+static int i2c_dw_irq_handler_master(struct dw_i2c_dev *dev)
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
-
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
@@ -931,6 +927,22 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		dw_writel(dev, stat, DW_IC_INTR_MASK);
 	}
 
+	return 0;
+}
+
+static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
+{
+	struct dw_i2c_dev *dev = dev_id;
+	u32 stat, enabled;
+
+	enabled = dw_readl(dev, DW_IC_ENABLE);
+	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+	dev_dbg(dev->dev, "enabled=%#x stat=%#x\n", enabled, stat);
+	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
+		return IRQ_NONE;
+
+	i2c_dw_irq_handler_master(dev);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 613dfb88307f..fd14b410369e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -172,6 +172,23 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 }
 #endif
 
+static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
+{
+	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+			  DW_IC_CON_RESTART_EN;
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
@@ -287,19 +304,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
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
+	i2c_dw_configure_master(dev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
-- 
2.13.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
