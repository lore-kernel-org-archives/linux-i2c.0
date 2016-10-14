From: Luis.Oliveira@synopsys.com
Subject: [PATCH v2 2/4] Added I2C_SLAVE as a dependency to I2C_DESIGNWARE_CORE Enable _slave() mode Review of the pm_runtime...() methods and cleaning
Date: Fri, 14 Oct 2016 17:52:49 +0100
Message-ID: <ffbbaeace295a28ade33aafde7f287c6bcc901eb.1476462204.git.lolivei@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:59097 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755465AbcJNQxp (ORCPT
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
 drivers/i2c/busses/Kconfig                  |   3 +-
 drivers/i2c/busses/i2c-designware-core.c    | 180 ++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h    |   6 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  33 ++++-
 4 files changed, 212 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6d94e2e..f93ad70 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -470,10 +470,11 @@ config I2C_DESIGNWARE_CORE
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
 	select I2C_DESIGNWARE_CORE
+	select I2C_SLAVE
 	depends on (ACPI && COMMON_CLK) || !ACPI
 	help
 	  If you say yes to this option, support will be included for the
-	  Synopsys DesignWare I2C adapter. Only master mode is supported.
+	  Synopsys DesignWare I2C adapter.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-designware-platform.
diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index cc38329..71a377e 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -37,6 +37,7 @@
  */
 #define DW_IC_CON		0x0
 #define DW_IC_TAR		0x4
+#define DW_IC_SAR		0x8
 #define DW_IC_DATA_CMD		0x10
 #define DW_IC_SS_SCL_HCNT	0x14
 #define DW_IC_SS_SCL_LCNT	0x18
@@ -92,10 +93,16 @@
  
 #define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
 					 DW_IC_INTR_TX_EMPTY)
-
+					 
+#define DW_IC_INTR_SLAVE_MASK		(DW_IC_INTR_DEFAULT_MASK | \
+					 DW_IC_INTR_RX_DONE | \
+                                    DW_IC_INTR_RX_UNDER | \
+                                    DW_IC_INTR_RD_REQ)
+					 
 #define DW_IC_STATUS_ACTIVITY		0x1
 #define DW_IC_STATUS_TFE		BIT(2)
 #define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
+#define DW_IC_STATUS_SLAVE_ACTIVITY	BIT(6)
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
@@ -130,6 +137,9 @@
 #define ABRT_10B_RD_NORSTRT	10
 #define ABRT_MASTER_DIS		11
 #define ARB_LOST		12
+#define ABRT_SLAVE_FLUSH_TXFIFO	13
+#define ABRT_SLAVE_ARBLOST	14
+#define ABRT_SLAVE_RD_INTX	15
 
 #define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
 #define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
@@ -142,6 +152,9 @@
 #define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
 #define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
 #define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
+#define DW_IC_RX_ABRT_SLAVE_RD_INTX        (1UL << ABRT_SLAVE_RD_INTX)
+#define DW_IC_RX_ABRT_SLAVE_ARBLOST       (1UL << ABRT_SLAVE_ARBLOST)
+#define DW_IC_RX_ABRT_SLAVE_FLUSH_TXFIFO   (1UL << ABRT_SLAVE_FLUSH_TXFIFO)
 
 #define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
 					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
@@ -172,6 +185,12 @@ static char *abort_sources[] = {
 		"trying to use disabled adapter",
 	[ARB_LOST] =
 		"lost arbitration",
+	[ABRT_SLAVE_FLUSH_TXFIFO] =
+		"read command so flush old data in the TX FIFO",
+	[ABRT_SLAVE_ARBLOST] =
+		"slave lost the bus while transmitting data to a remote master",
+	[ABRT_SLAVE_RD_INTX] =
+		"slave request for data to be transmitted and",
 };
 
 static u32 dw_readl(struct dw_i2c_dev *dev, int offset)
@@ -214,6 +233,17 @@ static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
 		dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);
 }
 
+static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
+{
+		/* Configure Tx/Rx FIFO threshold levels */
+		dw_writel(dev, 0, DW_IC_TX_TL);
+		dw_writel(dev, 0, DW_IC_RX_TL);
+
+		/* configure the i2c slave */
+		dw_writel(dev, dev->slave_cfg , DW_IC_CON);
+		dw_writel(dev, DW_IC_INTR_SLAVE_MASK, DW_IC_INTR_MASK);
+}
+
 static u32
 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
@@ -447,6 +477,8 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	if ((dev->master_cfg & DW_IC_CON_MASTER) &&
 		(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) 
 		i2c_dw_configure_fifo_master(dev);
+	else
+		i2c_dw_configure_fifo_slave(dev);
 
 	i2c_dw_release_lock(dev);
 
@@ -785,9 +817,59 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
 	return dev->functionality;
 }
 
+static int i2c_dw_reg_slave(struct i2c_client *slave)
+{
+	struct dw_i2c_dev *dev =  i2c_get_adapdata(slave->adapter);
+
+	if(dev->slave)
+		return -EBUSY;
+	if(slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+		/* set slave address in the IC_SAR register, 
+		* the address to which the DW_apb_i2c responds */
+
+	__i2c_dw_enable(dev, false);
+	
+	dw_writel(dev, slave->addr, DW_IC_SAR);
+
+	pm_runtime_get_sync(dev->dev);
+	
+	dev->slave = slave;
+
+	__i2c_dw_enable(dev, true);
+
+	dev->cmd_err = 0;
+	dev->msg_write_idx = 0;
+	dev->msg_read_idx = 0;
+	dev->msg_err = 0;
+	dev->status = STATUS_IDLE;
+	dev->abort_source = 0;
+	dev->rx_outstanding = 0;
+
+	return 0;
+}
+
+static int i2c_dw_unreg_slave(struct i2c_client *slave)
+{
+	struct dw_i2c_dev *dev =  i2c_get_adapdata(slave->adapter);
+
+	WARN_ON(!dev->slave);
+
+	i2c_dw_disable_int(dev);
+	i2c_dw_disable(dev);
+
+	dev->slave =  NULL;
+
+	pm_runtime_put(dev->dev);
+
+	return 0;
+}
+
 static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
 	.functionality	= i2c_dw_func,
+	.reg_slave	= i2c_dw_reg_slave,
+	.unreg_slave	= i2c_dw_unreg_slave,
 };
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
@@ -821,8 +903,6 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 		dw_readl(dev, DW_IC_CLR_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
 		dw_readl(dev, DW_IC_CLR_TX_OVER);
-	if (stat & DW_IC_INTR_RD_REQ)
-		dw_readl(dev, DW_IC_CLR_RD_REQ);
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		/*
 		 * The IC_TX_ABRT_SOURCE register is cleared whenever
@@ -849,6 +929,84 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
  * Interrupt service routine. This gets called whenever an I2C interrupt
  * occurs.
  */
+ 
+static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev )
+{
+	u32 raw_stat, stat, enabled;
+	u8 val, slave_activity;
+	
+	stat = dw_readl(dev, DW_IC_INTR_STAT);
+	enabled = dw_readl(dev, DW_IC_ENABLE);
+	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+	slave_activity = ((dw_readl(dev,DW_IC_STATUS) & 
+	DW_IC_STATUS_SLAVE_ACTIVITY)>>6);
+		
+	dev_dbg(dev->dev, 
+	"%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n", 
+	 __func__, enabled, slave_activity, raw_stat, stat); 
+
+	if (stat & DW_IC_INTR_START_DET)
+		dw_readl(dev, DW_IC_CLR_START_DET);
+		
+	if (stat & DW_IC_INTR_ACTIVITY)
+		dw_readl(dev, DW_IC_CLR_ACTIVITY);
+
+	if (stat & DW_IC_INTR_RX_OVER)
+		dw_readl(dev, DW_IC_CLR_RX_OVER);
+	
+       if ((stat & DW_IC_INTR_RX_FULL) && (stat & DW_IC_INTR_STOP_DET)) 
+		i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
+	
+	if (slave_activity) {     
+		if (stat & DW_IC_INTR_RD_REQ) {                 
+			if (stat & DW_IC_INTR_RX_FULL) {
+				val = dw_readl(dev, DW_IC_DATA_CMD);
+				if (!i2c_slave_event(dev->slave, 
+					I2C_SLAVE_WRITE_RECEIVED, &val)) {
+					dev_dbg(dev->dev, "Byte %X acked! ",val);
+				}
+				dw_readl(dev, DW_IC_CLR_RD_REQ);
+				stat = i2c_dw_read_clear_intrbits(dev);
+			}
+			else {
+				dw_readl(dev, DW_IC_CLR_RD_REQ);
+				dw_readl(dev, DW_IC_CLR_RX_UNDER);
+				stat = i2c_dw_read_clear_intrbits(dev);
+			}     
+			if (!i2c_slave_event(dev->slave, 
+					I2C_SLAVE_READ_REQUESTED, &val))
+				dw_writel(dev, val, DW_IC_DATA_CMD);
+		}
+	}        
+	
+	if (stat & DW_IC_INTR_RX_DONE) {
+		
+		if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED, &val)) 
+			dw_readl(dev, DW_IC_CLR_RX_DONE);
+		
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP , &val);
+		stat = i2c_dw_read_clear_intrbits(dev);
+
+		return true;
+	}
+        
+	if (stat & DW_IC_INTR_RX_FULL) { 
+		val = dw_readl(dev, DW_IC_DATA_CMD);
+		if (!i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED, &val))
+			dev_dbg(dev->dev, "Byte %X acked! ",val);
+	} 
+	else {
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP , &val);
+		stat = i2c_dw_read_clear_intrbits(dev);
+	}
+
+	if (stat & DW_IC_INTR_TX_OVER) {		
+		dw_readl(dev, DW_IC_CLR_TX_OVER);
+		return true;
+	}
+
+	return true;
+}
 
 static bool i2c_dw_irq_handler_master(struct dw_i2c_dev *dev )
 {
@@ -910,14 +1068,20 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
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
+	if (!(mode & DW_IC_CON_MASTER) && !(mode & DW_IC_CON_SLAVE_DISABLE)) {
+		stat = i2c_dw_read_clear_intrbits(dev);
+		if (!i2c_dw_irq_handler_slave(dev))
+			return IRQ_NONE;
+	} else {
 	if(i2c_dw_irq_handler_master(dev))
 		return IRQ_HANDLED;
-			
+	}
+
 	complete(&dev->cmd_complete);
 	return IRQ_HANDLED;
 }
@@ -984,7 +1148,9 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
-	i2c_dw_disable_int(dev);
+	if (!i2c_check_functionality(adap,I2C_FUNC_SLAVE)) 
+		i2c_dw_disable_int(dev);
+
 	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
 			     IRQF_SHARED | IRQF_COND_SUSPEND,
 			     dev_name(dev->dev), dev);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 0d44d2a..de5e4a0 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -28,9 +28,13 @@
 #define DW_IC_CON_SPEED_FAST		0x4
 #define DW_IC_CON_SPEED_HIGH		0x6
 #define DW_IC_CON_SPEED_MASK		0x6
+#define DW_IC_CON_10BITADDR_SLAVE       0x8
 #define DW_IC_CON_10BITADDR_MASTER	0x10
 #define DW_IC_CON_RESTART_EN		0x20
 #define DW_IC_CON_SLAVE_DISABLE		0x40
+#define DW_IC_CON_STOP_DET_IFADDRESSED  0x80
+#define DW_IC_CON_TX_EMPTY_CTRL		0x100
+#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL	0x200
 
 
 /**
@@ -80,6 +84,7 @@ struct dw_i2c_dev {
 	void __iomem		*base;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
 	struct dw_pci_controller *controller;
 	int			cmd_err;
@@ -99,6 +104,7 @@ struct dw_i2c_dev {
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
+	u32			slave_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 	int			rx_outstanding;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d5986c2..b9076da 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -161,6 +161,30 @@ static void i2c_dw_configure_master(struct platform_device *pdev)
 	
 }
 
+static void i2c_dw_configure_slave(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	
+	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL | 
+			  DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED | 
+			  DW_IC_CON_SPEED_FAST;
+		  
+	dev->functionality |= I2C_FUNC_SLAVE;
+	dev->functionality &= ~I2C_FUNC_10BIT_ADDR;
+	dev_info(&pdev->dev, "I am registed as a I2C Slave!\n");
+	
+	switch (dev->clk_freq) {
+	case 100000:
+		dev->slave_cfg |= DW_IC_CON_SPEED_STD;
+		
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
@@ -181,6 +205,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct resource *mem;
 	int irq, r;
 	u32 acpi_speed, ht = 0;
+	bool is_slave = false;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -213,6 +238,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 					 &dev->scl_falling_time);
 		device_property_read_u32(&pdev->dev, "clock-frequency",
 					 &dev->clk_freq);
+		is_slave = device_property_read_bool(&pdev->dev, "isslave");
 	}
 
 	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
@@ -244,8 +270,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
-
-	i2c_dw_configure_master(pdev);
+	
+	if (is_slave)
+		i2c_dw_configure_slave(pdev);
+	else 
+		i2c_dw_configure_master(pdev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
-- 
2.10.1
