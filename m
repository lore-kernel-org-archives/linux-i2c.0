From: Luis.Oliveira@synopsys.com
Subject: [PATCH] Add slave mode to Synopsys I2C driver
Date: Tue, 11 Oct 2016 13:18:13 +0100
Message-ID: <95e8074bcdf85c11db2497a2bf5218ce66446051.1476187036.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

From: Luis Oliveira <lolivei@synopsys.com>

Add support in existing I2C Synopsys Designware Core driver for I2C slave mode.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
 drivers/i2c/busses/i2c-designware-core.c    | 250 +++++++++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h    |   8 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  47 ++++--
 3 files changed, 271 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 1fe93c4..c873a0c 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -21,6 +21,7 @@
  * ----------------------------------------------------------------------------
  *
  */
+
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -37,6 +38,7 @@
  */
 #define DW_IC_CON		0x0
 #define DW_IC_TAR		0x4
+#define DW_IC_SAR		0x8
 #define DW_IC_DATA_CMD		0x10
 #define DW_IC_SS_SCL_HCNT	0x14
 #define DW_IC_SS_SCL_LCNT	0x18
@@ -85,15 +87,27 @@
 #define DW_IC_INTR_STOP_DET	0x200
 #define DW_IC_INTR_START_DET	0x400
 #define DW_IC_INTR_GEN_CALL	0x800
-
-#define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
-					 DW_IC_INTR_TX_EMPTY | \
-					 DW_IC_INTR_TX_ABRT | \
-					 DW_IC_INTR_STOP_DET)
+#define DW_IC_INTR_RESTART_DET	0x1000
+
+#define DW_IC_INTR_MST_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
+				    DW_IC_INTR_TX_EMPTY | \
+				    DW_IC_INTR_TX_ABRT | \
+				    DW_IC_INTR_STOP_DET | \
+				    DW_IC_INTR_RX_DONE | \
+				    DW_IC_INTR_RX_UNDER | \
+				    DW_IC_INTR_RD_REQ)
+
+ #define DW_IC_INTR_SLV_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
+				    DW_IC_INTR_STOP_DET | \
+				    DW_IC_INTR_TX_ABRT | \
+				    DW_IC_INTR_RX_DONE | \
+				    DW_IC_INTR_RX_UNDER | \
+				    DW_IC_INTR_RD_REQ)
 
 #define DW_IC_STATUS_ACTIVITY		0x1
 #define DW_IC_STATUS_TFE		BIT(2)
 #define DW_IC_STATUS_MST_ACTIVITY	BIT(5)
+#define DW_IC_STATUS_SLV_ACTIVITY	BIT(6)
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
@@ -107,7 +121,7 @@
  */
 #define STATUS_IDLE			0x0
 #define STATUS_WRITE_IN_PROGRESS	0x1
-#define STATUS_READ_IN_PROGRESS		0x2
+#define STATUS_READ_IN_PROGRESS	0x2
 
 #define TIMEOUT			20 /* ms */
 
@@ -128,6 +142,9 @@
 #define ABRT_10B_RD_NORSTRT	10
 #define ABRT_MASTER_DIS		11
 #define ARB_LOST		12
+#define ABRT_SLVFLUSH_TXFIFO    13
+#define ABRT_SLV_ARBLOST        14
+#define ABRT_SLVRD_INTX         15
 
 #define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
 #define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
@@ -140,6 +157,9 @@
 #define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
 #define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
 #define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
+#define DW_IC_RX_ABRT_SLVRD_INTX        (1UL << ABRT_SLVRD_INTX)
+#define DW_IC_RX_ABRT_SLV_ARBLOST       (1UL << ABRT_SLV_ARBLOST)
+#define DW_IC_RX_ABRT_SLVFLUSH_TXFIFO   (1UL << ABRT_SLVFLUSH_TXFIFO)
 
 #define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
 					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
@@ -170,6 +190,12 @@ static char *abort_sources[] = {
 		"trying to use disabled adapter",
 	[ARB_LOST] =
 		"lost arbitration",
+	[ABRT_SLVFLUSH_TXFIFO] =
+		"read command so flush old data in the TX FIFO",
+	[ABRT_SLV_ARBLOST] =
+		"slave lost the bus while transmitting data to a remote master",
+	[ABRT_SLVRD_INTX] =
+		"slave request for data to be transmitted and",
 };
 
 static u32 dw_readl(struct dw_i2c_dev *dev, int offset)
@@ -317,7 +343,7 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
 }
 
 /**
- * i2c_dw_init() - initialize the designware i2c master hardware
+ * i2c_dw_init() - initialize the designware i2c hardware
  * @dev: device private data
  *
  * This functions configures and enables the I2C master.
@@ -343,8 +369,8 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
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
@@ -431,12 +457,30 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 			"Hardware too old to adjust SDA hold time.\n");
 	}
 
-	/* Configure Tx/Rx FIFO threshold levels */
-	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
-	dw_writel(dev, 0, DW_IC_RX_TL);
-
-	/* configure the i2c master */
-	dw_writel(dev, dev->master_cfg , DW_IC_CON);
+	if ((dev->master_cfg & DW_IC_CON_MASTER) &&
+		(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) {
+		/* IF master */
+
+		/* Configure Tx/Rx FIFO threshold levels */
+		dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
+		dw_writel(dev, 0, DW_IC_RX_TL);
+
+		/* configure the i2c master */
+		dw_writel(dev, dev->master_cfg, DW_IC_CON);
+		dw_writel(dev, DW_IC_INTR_MST_DEFAULT_MASK, DW_IC_INTR_MASK);
+	} else if (!(dev->master_cfg & DW_IC_CON_MASTER) &&
+		!(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) {
+		/*IF slave */
+
+		/* Configure Tx/Rx FIFO threshold levels */
+		dw_writel(dev, 0, DW_IC_TX_TL);
+		dw_writel(dev, 0, DW_IC_RX_TL);
+
+		/* configure the i2c slave */
+		dw_writel(dev, dev->slave_cfg, DW_IC_CON);
+		dw_writel(dev, DW_IC_INTR_SLV_DEFAULT_MASK, DW_IC_INTR_MASK);
+	} else
+		return -EAGAIN;
 
 	i2c_dw_release_lock(dev);
 
@@ -520,7 +564,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
-	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
+	dw_writel(dev, DW_IC_INTR_MST_DEFAULT_MASK, DW_IC_INTR_MASK);
 }
 
 /*
@@ -540,7 +584,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
 
-	intr_mask = DW_IC_INTR_DEFAULT_MASK;
+	intr_mask = DW_IC_INTR_MST_DEFAULT_MASK;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/*
@@ -772,12 +816,64 @@ done_nolock:
 static u32 i2c_dw_func(struct i2c_adapter *adap)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+
 	return dev->functionality;
 }
 
+static int i2c_dw_reg_slave(struct i2c_client *slave)
+{
+	struct dw_i2c_dev *dev =  i2c_get_adapdata(slave->adapter);
+
+	if (dev->slave)
+		return -EBUSY;
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+		/* set slave address in the IC_SAR register,
+		* the address to which the DW_apb_i2c responds
+		*/
+
+	__i2c_dw_enable(dev, false);
+
+	dw_writel(dev, slave->addr, DW_IC_SAR);
+
+	pm_runtime_forbid(dev->dev);
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
+	pm_runtime_allow(dev->dev);
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
@@ -811,8 +907,6 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 		dw_readl(dev, DW_IC_CLR_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
 		dw_readl(dev, DW_IC_CLR_TX_OVER);
-	if (stat & DW_IC_INTR_RD_REQ)
-		dw_readl(dev, DW_IC_CLR_RD_REQ);
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		/*
 		 * The IC_TX_ABRT_SOURCE register is cleared whenever
@@ -839,19 +933,129 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
  * Interrupt service routine. This gets called whenever an I2C interrupt
  * occurs.
  */
+
+static bool i2c_dw_slave_irq_handler(struct dw_i2c_dev *dev)
+{
+	u32 raw_stat, stat, enabled;
+	u8 val;
+	u8 slv_act;
+
+	stat     = dw_readl(dev, DW_IC_INTR_STAT);
+	enabled  = dw_readl(dev, DW_IC_ENABLE);
+	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+
+	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))
+		return false;
+
+	slv_act = ((dw_readl(dev, DW_IC_STATUS) &
+		DW_IC_STATUS_SLV_ACTIVITY)>>6);
+
+	dev_dbg(dev->dev,
+	 "%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n",
+	 __func__, enabled, slv_act, raw_stat, stat);
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
+	if ((stat & DW_IC_INTR_RX_FULL) && (stat & DW_IC_INTR_STOP_DET)) {
+		dev_dbg(dev->dev, "First write\n");
+		i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
+	}
+
+	if (slv_act) {
+		dev_dbg(dev->dev, "I2C GET\n");
+
+		if (stat & DW_IC_INTR_RD_REQ) {
+			if (stat & DW_IC_INTR_RX_FULL) {
+				val = dw_readl(dev, DW_IC_DATA_CMD);
+				if (!i2c_slave_event(dev->slave,
+					I2C_SLAVE_WRITE_RECEIVED, &val)) {
+					dev_dbg(dev->dev, "Byte %X acked! ", val);
+					;
+				}
+				dev_dbg(dev->dev, "I2C GET + add");
+				dw_readl(dev, DW_IC_CLR_RD_REQ);
+				stat = i2c_dw_read_clear_intrbits(dev);
+			} else {
+				dev_dbg(dev->dev, "I2C GET + 0x00");
+				dw_readl(dev, DW_IC_CLR_RD_REQ);
+				dw_readl(dev, DW_IC_CLR_RX_UNDER);
+				stat = i2c_dw_read_clear_intrbits(dev);
+			}
+			if (!i2c_slave_event(dev->slave,
+					I2C_SLAVE_READ_REQUESTED, &val))
+				dw_writel(dev, (0x0 << 8 | val), DW_IC_DATA_CMD);
+		}
+	}
+	if (stat & DW_IC_INTR_RX_DONE) {
+
+		if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED, &val))
+			dw_readl(dev, DW_IC_CLR_RX_DONE);
+
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
+		dev_dbg(dev->dev, "Transmission Complete.");
+		stat = i2c_dw_read_clear_intrbits(dev);
+
+		goto done;
+	}
+
+	if (stat & DW_IC_INTR_RX_FULL) {
+		dev_dbg(dev->dev, "I2C SET");
+		val = dw_readl(dev, DW_IC_DATA_CMD);
+		if (!i2c_slave_event(dev->slave,
+			I2C_SLAVE_WRITE_RECEIVED, &val)) {
+			dev_dbg(dev->dev, "Byte %X acked! ", val);
+			;
+		}
+	} else {
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
+		dev_dbg(dev->dev, "Transmission Complete.");
+		stat = i2c_dw_read_clear_intrbits(dev);
+	}
+
+	if (stat & DW_IC_INTR_TX_OVER) {
+		dw_readl(dev, DW_IC_CLR_TX_OVER);
+		return true;
+	}
+done:
+	return true;
+}
+
 static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 {
 	struct dw_i2c_dev *dev = dev_id;
-	u32 stat, enabled;
+	u32 stat, enabled, mode;
 
 	enabled = dw_readl(dev, DW_IC_ENABLE);
+	mode = dw_readl(dev, DW_IC_CON);
 	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
-	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__, enabled, stat);
+
+	stat = i2c_dw_read_clear_intrbits(dev);
+
+	dev_dbg(dev->dev,
+		"%s: enabled=%#x stat=%#x\n", __func__, enabled, stat);
+
 	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
 		return IRQ_NONE;
 
 	stat = i2c_dw_read_clear_intrbits(dev);
 
+	if (!(mode & DW_IC_CON_MASTER) && !(mode & DW_IC_CON_SLAVE_DISABLE)) {
+
+		/* slave  mode*/
+		if (!i2c_dw_slave_irq_handler(dev))
+			return IRQ_NONE;
+
+		complete(&dev->cmd_complete);
+		return IRQ_HANDLED;
+	}
+
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
@@ -961,7 +1165,9 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
-	i2c_dw_disable_int(dev);
+	if (!i2c_check_functionality(adap, I2C_FUNC_SLAVE))
+		i2c_dw_disable_int(dev);
+
 	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
 			     IRQF_SHARED | IRQF_COND_SUSPEND,
 			     dev_name(dev->dev), dev);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 0d44d2a..5875410 100644
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
@@ -80,7 +84,8 @@ struct dw_i2c_dev {
 	void __iomem		*base;
 	struct completion	cmd_complete;
 	struct clk		*clk;
-	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
+	struct i2c_client		*slave;
+	u32			(*get_clk_rate_khz)(struct dw_i2c_dev *dev);
 	struct dw_pci_controller *controller;
 	int			cmd_err;
 	struct i2c_msg		*msgs;
@@ -99,6 +104,7 @@ struct dw_i2c_dev {
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
+	u32			slave_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 	int			rx_outstanding;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12..cad0218 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -21,6 +21,7 @@
  * ----------------------------------------------------------------------------
  *
  */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -158,6 +159,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct resource *mem;
 	int irq, r;
 	u32 acpi_speed, ht = 0;
+	bool isslave = false;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -190,6 +192,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 					 &dev->scl_falling_time);
 		device_property_read_u32(&pdev->dev, "clock-frequency",
 					 &dev->clk_freq);
+		isslave = device_property_read_bool(&pdev->dev, "isslave");
 	}
 
 	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
@@ -216,24 +219,46 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 	dev->functionality =
 		I2C_FUNC_I2C |
-		I2C_FUNC_10BIT_ADDR |
 		I2C_FUNC_SMBUS_BYTE |
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
 
-	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+	if (!isslave) {
+		dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
+		dev->functionality |= I2C_FUNC_10BIT_ADDR;
+		dev_info(&pdev->dev, "I am registed as a I2C Master!\n");
+		switch (dev->clk_freq) {
+		case 100000:
+			dev->master_cfg |= DW_IC_CON_SPEED_STD;
+			break;
+		case 3400000:
+			dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
+			break;
+		default:
+			dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+		}
+	} else {
+		dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
+			  DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED |
+			  DW_IC_CON_SPEED_FAST;
+
+		dev->functionality |= I2C_FUNC_SLAVE;
+		dev->functionality &= ~I2C_FUNC_10BIT_ADDR;
+		dev_info(&pdev->dev, "I am registed as a I2C Slave!\n");
+
+		switch (dev->clk_freq) {
+		case 100000:
+			dev->slave_cfg |= DW_IC_CON_SPEED_STD;
+
+		case 3400000:
+			dev->slave_cfg |= DW_IC_CON_SPEED_HIGH;
+			break;
+		default:
+			dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
 
-	switch (dev->clk_freq) {
-	case 100000:
-		dev->master_cfg |= DW_IC_CON_SPEED_STD;
-		break;
-	case 3400000:
-		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
-		break;
-	default:
-		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+		}
 	}
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.10.1
