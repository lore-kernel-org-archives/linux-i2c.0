From: Luis.Oliveira@synopsys.com
Subject: [PATCH v2 4/4] Cleaned the code, no functional changes.
Date: Fri, 14 Oct 2016 17:52:51 +0100
Message-ID: <3df96f37129d81eb2275e0151d1aab6ae43fbaa2.1476462204.git.lolivei@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:59111 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755482AbcJNQxp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Oct 2016 12:53:45 -0400
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
 drivers/i2c/busses/i2c-designware-core.c    | 113 ++++++++++++++--------------
 drivers/i2c/busses/i2c-designware-platdrv.c |  24 +++---
 2 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 71a377e..4196491 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -90,15 +90,15 @@
 #define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
 					 DW_IC_INTR_TX_ABRT | \
 					 DW_IC_INTR_STOP_DET)
- 
+
 #define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
 					 DW_IC_INTR_TX_EMPTY)
-					 
+
 #define DW_IC_INTR_SLAVE_MASK		(DW_IC_INTR_DEFAULT_MASK | \
 					 DW_IC_INTR_RX_DONE | \
-                                    DW_IC_INTR_RX_UNDER | \
-                                    DW_IC_INTR_RD_REQ)
-					 
+				    DW_IC_INTR_RX_UNDER | \
+				    DW_IC_INTR_RD_REQ)
+
 #define DW_IC_STATUS_ACTIVITY		0x1
 #define DW_IC_STATUS_TFE		BIT(2)
 #define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
@@ -229,7 +229,7 @@ static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
 		dw_writel(dev, 0, DW_IC_RX_TL);
 
 		/* configure the i2c master */
-		dw_writel(dev, dev->master_cfg , DW_IC_CON);
+		dw_writel(dev, dev->master_cfg, DW_IC_CON);
 		dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);
 }
 
@@ -240,7 +240,7 @@ static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
 		dw_writel(dev, 0, DW_IC_RX_TL);
 
 		/* configure the i2c slave */
-		dw_writel(dev, dev->slave_cfg , DW_IC_CON);
+		dw_writel(dev, dev->slave_cfg, DW_IC_CON);
 		dw_writel(dev, DW_IC_INTR_SLAVE_MASK, DW_IC_INTR_MASK);
 }
 
@@ -386,8 +386,8 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		/* Configure register access mode 16bit */
 		dev->accessor_flags |= ACCESS_16BIT;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
-		dev_err(dev->dev, "Unknown Synopsys component type: "
-			"0x%08x\n", reg);
+		dev_err(dev->dev, "Unknown Synopsys component type: 0x%08x\n",
+			reg);
 		i2c_dw_release_lock(dev);
 		return -ENODEV;
 	}
@@ -475,7 +475,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	}
 
 	if ((dev->master_cfg & DW_IC_CON_MASTER) &&
-		(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) 
+		(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE))
 		i2c_dw_configure_fifo_master(dev);
 	else
 		i2c_dw_configure_fifo_slave(dev);
@@ -814,6 +814,7 @@ done_nolock:
 static u32 i2c_dw_func(struct i2c_adapter *adap)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+
 	return dev->functionality;
 }
 
@@ -821,19 +822,19 @@ static int i2c_dw_reg_slave(struct i2c_client *slave)
 {
 	struct dw_i2c_dev *dev =  i2c_get_adapdata(slave->adapter);
 
-	if(dev->slave)
+	if (dev->slave)
 		return -EBUSY;
-	if(slave->flags & I2C_CLIENT_TEN)
+	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
-		/* set slave address in the IC_SAR register, 
-		* the address to which the DW_apb_i2c responds */
+		/* set slave address in the IC_SAR register,
+		 * the address to which the DW_apb_i2c responds */
 
 	__i2c_dw_enable(dev, false);
-	
+
 	dw_writel(dev, slave->addr, DW_IC_SAR);
 
 	pm_runtime_get_sync(dev->dev);
-	
+
 	dev->slave = slave;
 
 	__i2c_dw_enable(dev, true);
@@ -929,78 +930,76 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
  * Interrupt service routine. This gets called whenever an I2C interrupt
  * occurs.
  */
- 
-static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev )
+
+static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 {
 	u32 raw_stat, stat, enabled;
 	u8 val, slave_activity;
-	
+
 	stat = dw_readl(dev, DW_IC_INTR_STAT);
 	enabled = dw_readl(dev, DW_IC_ENABLE);
 	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
-	slave_activity = ((dw_readl(dev,DW_IC_STATUS) & 
-	DW_IC_STATUS_SLAVE_ACTIVITY)>>6);
-		
-	dev_dbg(dev->dev, 
-	"%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n", 
-	 __func__, enabled, slave_activity, raw_stat, stat); 
+	slave_activity = ((dw_readl(dev, DW_IC_STATUS)
+		& DW_IC_STATUS_SLAVE_ACTIVITY)>>6);
+
+	dev_dbg(dev->dev,
+	"%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n",
+	 __func__, enabled, slave_activity, raw_stat, stat);
 
 	if (stat & DW_IC_INTR_START_DET)
 		dw_readl(dev, DW_IC_CLR_START_DET);
-		
+
 	if (stat & DW_IC_INTR_ACTIVITY)
 		dw_readl(dev, DW_IC_CLR_ACTIVITY);
 
 	if (stat & DW_IC_INTR_RX_OVER)
 		dw_readl(dev, DW_IC_CLR_RX_OVER);
-	
-       if ((stat & DW_IC_INTR_RX_FULL) && (stat & DW_IC_INTR_STOP_DET)) 
+
+	if ((stat & DW_IC_INTR_RX_FULL) && (stat & DW_IC_INTR_STOP_DET))
 		i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
-	
-	if (slave_activity) {     
-		if (stat & DW_IC_INTR_RD_REQ) {                 
+
+	if (slave_activity) {
+		if (stat & DW_IC_INTR_RD_REQ) {
 			if (stat & DW_IC_INTR_RX_FULL) {
 				val = dw_readl(dev, DW_IC_DATA_CMD);
-				if (!i2c_slave_event(dev->slave, 
+				if (!i2c_slave_event(dev->slave,
 					I2C_SLAVE_WRITE_RECEIVED, &val)) {
-					dev_dbg(dev->dev, "Byte %X acked! ",val);
+					dev_dbg(dev->dev, "Byte %X acked! ", val);
 				}
 				dw_readl(dev, DW_IC_CLR_RD_REQ);
 				stat = i2c_dw_read_clear_intrbits(dev);
-			}
-			else {
+			} else {
 				dw_readl(dev, DW_IC_CLR_RD_REQ);
 				dw_readl(dev, DW_IC_CLR_RX_UNDER);
 				stat = i2c_dw_read_clear_intrbits(dev);
-			}     
-			if (!i2c_slave_event(dev->slave, 
+			}
+			if (!i2c_slave_event(dev->slave,
 					I2C_SLAVE_READ_REQUESTED, &val))
 				dw_writel(dev, val, DW_IC_DATA_CMD);
 		}
-	}        
-	
+	}
+
 	if (stat & DW_IC_INTR_RX_DONE) {
-		
-		if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED, &val)) 
+
+		if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED, &val))
 			dw_readl(dev, DW_IC_CLR_RX_DONE);
-		
-		i2c_slave_event(dev->slave, I2C_SLAVE_STOP , &val);
+
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
 		stat = i2c_dw_read_clear_intrbits(dev);
 
 		return true;
 	}
-        
-	if (stat & DW_IC_INTR_RX_FULL) { 
+
+	if (stat & DW_IC_INTR_RX_FULL) {
 		val = dw_readl(dev, DW_IC_DATA_CMD);
 		if (!i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED, &val))
-			dev_dbg(dev->dev, "Byte %X acked! ",val);
-	} 
-	else {
-		i2c_slave_event(dev->slave, I2C_SLAVE_STOP , &val);
+			dev_dbg(dev->dev, "Byte %X acked! ", val);
+	} else {
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
 		stat = i2c_dw_read_clear_intrbits(dev);
 	}
 
-	if (stat & DW_IC_INTR_TX_OVER) {		
+	if (stat & DW_IC_INTR_TX_OVER) {
 		dw_readl(dev, DW_IC_CLR_TX_OVER);
 		return true;
 	}
@@ -1008,12 +1007,12 @@ static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev )
 	return true;
 }
 
-static bool i2c_dw_irq_handler_master(struct dw_i2c_dev *dev )
+static bool i2c_dw_irq_handler_master(struct dw_i2c_dev *dev)
 {
 	u32 stat;
-	
+
 	stat = i2c_dw_read_clear_intrbits(dev);
-	
+
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
@@ -1068,17 +1067,17 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	enabled = dw_readl(dev, DW_IC_ENABLE);
 	mode = dw_readl(dev, DW_IC_CON);
 	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
-	
+
 	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__, enabled, stat);
 	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
 		return IRQ_NONE;
-	
+
 	if (!(mode & DW_IC_CON_MASTER) && !(mode & DW_IC_CON_SLAVE_DISABLE)) {
 		stat = i2c_dw_read_clear_intrbits(dev);
 		if (!i2c_dw_irq_handler_slave(dev))
 			return IRQ_NONE;
 	} else {
-	if(i2c_dw_irq_handler_master(dev))
+	if (i2c_dw_irq_handler_master(dev))
 		return IRQ_HANDLED;
 	}
 
@@ -1148,7 +1147,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
-	if (!i2c_check_functionality(adap,I2C_FUNC_SLAVE)) 
+	if (!i2c_check_functionality(adap, I2C_FUNC_SLAVE))
 		i2c_dw_disable_int(dev);
 
 	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index f29e657..035b93f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -141,13 +141,13 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 static void i2c_dw_configure_master(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
-	
+
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
-			  
+
 	dev->functionality |= I2C_FUNC_10BIT_ADDR;
 	dev_info(&pdev->dev, "I am registed as a I2C Master!\n");
-	
+
 	switch (dev->clk_freq) {
 	case 100000:
 		dev->master_cfg |= DW_IC_CON_SPEED_STD;
@@ -158,25 +158,25 @@ static void i2c_dw_configure_master(struct platform_device *pdev)
 	default:
 		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
 	}
-	
+
 }
 
 static void i2c_dw_configure_slave(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
-	
-	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL | 
-			  DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED | 
+
+	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
+			  DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED |
 			  DW_IC_CON_SPEED_FAST;
-		  
+
 	dev->functionality |= I2C_FUNC_SLAVE;
 	dev->functionality &= ~I2C_FUNC_10BIT_ADDR;
 	dev_info(&pdev->dev, "I am registed as a I2C Slave!\n");
-	
+
 	switch (dev->clk_freq) {
 	case 100000:
 		dev->slave_cfg |= DW_IC_CON_SPEED_STD;
-		
+
 	case 3400000:
 		dev->slave_cfg |= DW_IC_CON_SPEED_HIGH;
 		break;
@@ -272,10 +272,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
-	
+
 	if (is_slave)
 		i2c_dw_configure_slave(pdev);
-	else 
+	else
 		i2c_dw_configure_master(pdev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.10.1
