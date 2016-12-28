From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v5 5/7] i2c: designware: add SLAVE mode functions
Date: Wed, 28 Dec 2016 14:43:24 +0000
Message-ID: <15538bd29b3ab62608a4e9153af6ee5d4bdc79e2.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Changes in Kconfig to enable I2C_SLAVE support
- Slave functions added to core library file
- Slave abort sources added to common source file
- New driver: i2c-designware-slave added
- Changes in the Makefile to compile it all

All the SLAVE flow is added but it is not enabled via platform
driver.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V4->V5: (Andy Shevchenko)
- This patch adds the SLAVE support functions but it still not enable it
  via platform module. I think it is more readable now

 drivers/i2c/busses/Kconfig                 |   3 +-
 drivers/i2c/busses/Makefile                |   2 +-
 drivers/i2c/busses/i2c-designware-common.c |  10 +-
 drivers/i2c/busses/i2c-designware-core.h   |   6 +
 drivers/i2c/busses/i2c-designware-slave.c  | 434 +++++++++++++++++++++++++++++
 5 files changed, 452 insertions(+), 3 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0cdc8443deab..b58fdcde93a7 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -469,11 +469,12 @@ config I2C_DESIGNWARE_CORE
 
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
+	select I2C_SLAVE
 	select I2C_DESIGNWARE_CORE
 	depends on (ACPI && COMMON_CLK) || !ACPI
 	help
 	  If you say yes to this option, support will be included for the
-	  Synopsys DesignWare I2C adapter. Only master mode is supported.
+	  Synopsys DesignWare I2C adapter.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-designware-platform.
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 4f8f6a2b9346..c2ed84a86f49 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
 obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
 obj-$(CONFIG_I2C_DESIGNWARE_CORE)	+= i2c-designware-core.o
-i2c-designware-core-objs := i2c-designware-common.o i2c-designware-master.o
+i2c-designware-core-objs := i2c-designware-common.o i2c-designware-slave.o i2c-designware-master.o
 obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c-designware-platform.o
 i2c-designware-platform-objs := i2c-designware-platdrv.o
 i2c-designware-platform-$(CONFIG_I2C_DESIGNWARE_BAYTRAIL) += i2c-designware-baytrail.o
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 012b8f9dec15..b3beba639e98 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -30,6 +30,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+
 #include "i2c-designware-core.h"
 
 static char *abort_sources[] = {
@@ -42,7 +43,7 @@ static char *abort_sources[] = {
 	[ABRT_TXDATA_NOACK] =
 		"data not acknowledged",
 	[ABRT_GCALL_NOACK] =
-		"no acknowledgement for a general call",
+		"no acknowledgment for a general call",
 	[ABRT_GCALL_READ] =
 		"read after general call",
 	[ABRT_SBYTE_ACKDET] =
@@ -55,6 +56,13 @@ static char *abort_sources[] = {
 		"trying to use disabled adapter",
 	[ARB_LOST] =
 		"lost arbitration",
+	[ABRT_SLAVE_FLUSH_TXFIFO] =
+		"read command so flush old data in the TX FIFO",
+	[ABRT_SLAVE_ARBLOST] =
+		"slave lost the bus while transmitting data to a remote master",
+	[ABRT_SLAVE_RD_INTX] =
+		"slave request for data to be transmitted and there is a 1 in "
+		"bit 8 of IC_DATA_CMD",
 };
 
 u32 dw_readl(struct dw_i2c_dev *dev, int offset)
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 5080f1d2d2ec..1729b6bb5239 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -271,6 +271,7 @@ struct dw_i2c_dev {
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_runtime_disabled;
 	bool			dynamic_tar_update_enabled;
+	bool			mode;
 };
 
 #define ACCESS_SWAP		0x00000001
@@ -295,6 +296,11 @@ extern void i2c_dw_disable(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe(struct dw_i2c_dev *dev);
+extern int i2c_dw_init_slave(struct dw_i2c_dev *dev);
+extern void i2c_dw_disable_slave(struct dw_i2c_dev *dev);
+extern void i2c_dw_disable_int_slave(struct dw_i2c_dev *dev);
+extern u32 i2c_dw_read_comp_param_slave(struct dw_i2c_dev *dev);
+extern int i2c_dw_probe_slave(struct dw_i2c_dev *dev);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 extern int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
new file mode 100644
index 000000000000..5afc88d9e6b7
--- /dev/null
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -0,0 +1,434 @@
+/*
+ * Synopsys DesignWare I2C adapter driver (slave only).
+ *
+ * Based on the Synopsys DesignWare I2C adapter driver (master).
+ *
+ * Copyright (C) 2016 Synopsys Inc.
+ *
+ * ----------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * ----------------------------------------------------------------------------
+ *
+ */
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+
+#include "i2c-designware-core.h"
+
+static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
+{
+	/* Configure Tx/Rx FIFO threshold levels. */
+	dw_writel(dev, 0, DW_IC_TX_TL);
+	dw_writel(dev, 0, DW_IC_RX_TL);
+
+	/* Configure the I2C slave. */
+	dw_writel(dev, dev->slave_cfg, DW_IC_CON);
+	dw_writel(dev, DW_IC_INTR_SLAVE_MASK, DW_IC_INTR_MASK);
+}
+
+/**
+ * i2c_dw_init_slave() - Initialize the designware i2c slave hardware
+ * @dev: device private data
+ *
+ * This functions configures and enables the I2C.
+ * This function is called during I2C init function, and in case of timeout at
+ * run time.
+ */
+int i2c_dw_init_slave(struct dw_i2c_dev *dev)
+{
+	u32 sda_falling_time, scl_falling_time;
+	u32 reg, comp_param1;
+	u32 hcnt, lcnt;
+	int ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	reg = dw_readl(dev, DW_IC_COMP_TYPE);
+	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
+		/* Configure register endianness access. */
+		dev->accessor_flags |= ACCESS_SWAP;
+	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
+		/* Configure register access mode 16bit. */
+		dev->accessor_flags |= ACCESS_16BIT;
+	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
+		dev_err(dev->dev,
+			 "Unknown Synopsys component type: 0x%08x\n", reg);
+		i2c_dw_release_lock(dev);
+		return -ENODEV;
+	}
+
+	comp_param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
+
+	/* Disable the adapter. */
+	__i2c_dw_enable_and_wait(dev, false);
+
+	/* Set standard and fast speed deviders for high/low periods. */
+	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
+	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
+
+	/* Set SCL timing parameters for standard-mode. */
+	if (dev->ss_hcnt && dev->ss_lcnt) {
+		hcnt = dev->ss_hcnt;
+		lcnt = dev->ss_lcnt;
+	} else {
+		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
+					4000,	/* tHD;STA = tHIGH = 4.0 us */
+					sda_falling_time,
+					0,	/* 0: DW default, 1: Ideal */
+					0);	/* No offset */
+		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
+					4700,	/* tLOW = 4.7 us */
+					scl_falling_time,
+					0);	/* No offset */
+	}
+	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
+	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
+	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
+
+	/* Set SCL timing parameters for fast-mode or fast-mode plus. */
+	if ((dev->clk_freq == 1000000) && dev->fp_hcnt && dev->fp_lcnt) {
+		hcnt = dev->fp_hcnt;
+		lcnt = dev->fp_lcnt;
+	} else if (dev->fs_hcnt && dev->fs_lcnt) {
+		hcnt = dev->fs_hcnt;
+		lcnt = dev->fs_lcnt;
+	} else {
+		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
+					600,	/* tHD;STA = tHIGH = 0.6 us */
+					sda_falling_time,
+					0,	/* 0: DW default, 1: Ideal */
+					0);	/* No offset */
+		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
+					1300,	/* tLOW = 1.3 us */
+					scl_falling_time,
+					0);	/* No offset */
+	}
+	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
+	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
+	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
+
+	if ((dev->slave_cfg & DW_IC_CON_SPEED_MASK) ==
+		DW_IC_CON_SPEED_HIGH) {
+		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
+			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
+			dev_err(dev->dev, "High Speed not supported!\n");
+			dev->slave_cfg &= ~DW_IC_CON_SPEED_MASK;
+			dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
+		} else if (dev->hs_hcnt && dev->hs_lcnt) {
+			hcnt = dev->hs_hcnt;
+			lcnt = dev->hs_lcnt;
+			dw_writel(dev, hcnt, DW_IC_HS_SCL_HCNT);
+			dw_writel(dev, lcnt, DW_IC_HS_SCL_LCNT);
+			dev_dbg(dev->dev, "HighSpeed-mode HCNT:LCNT = %d:%d\n",
+				hcnt, lcnt);
+		}
+	}
+
+	/* Configure SDA Hold Time if required. */
+	reg = dw_readl(dev, DW_IC_COMP_VERSION);
+	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
+		if (!dev->sda_hold_time) {
+			/* Keep previous hold time setting if no one set it. */
+			dev->sda_hold_time = dw_readl(dev, DW_IC_SDA_HOLD);
+		}
+		/*
+		 * Workaround for avoiding TX arbitration lost in case I2C
+		 * slave pulls SDA down "too quickly" after falling egde of
+		 * SCL by enabling non-zero SDA RX hold. Specification says it
+		 * extends incoming SDA low to high transition while SCL is
+		 * high but it apprears to help also above issue.
+		 */
+		if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
+			dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
+		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
+	} else {
+		dev_warn(dev->dev,
+			"Hardware too old to adjust SDA hold time.\n");
+	}
+
+	i2c_dw_configure_fifo_slave(dev);
+	i2c_dw_release_lock(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_dw_init_slave);
+
+int i2c_dw_reg_slave(struct i2c_client *slave)
+{
+	struct dw_i2c_dev *dev = i2c_get_adapdata(slave->adapter);
+
+	if (dev->slave)
+		return -EBUSY;
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+		/*
+		 * Set slave address in the IC_SAR register,
+		 * the address to which the DW_apb_i2c responds.
+		 */
+
+	__i2c_dw_enable(dev, false);
+	dw_writel(dev, slave->addr, DW_IC_SAR);
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
+	i2c_dw_disable_int_slave(dev);
+	i2c_dw_disable_slave(dev);
+	dev->slave =  NULL;
+
+	return 0;
+}
+
+static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
+{
+	u32 stat;
+
+	/*
+	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
+	 * Ths unmasked raw version of interrupt status bits are available
+	 * in the IC_RAW_INTR_STAT register.
+	 *
+	 * That is,
+	 *   stat = dw_readl(IC_INTR_STAT);
+	 * equals to,
+	 *   stat = dw_readl(IC_RAW_INTR_STAT) & dw_readl(IC_INTR_MASK);
+	 *
+	 * The raw version might be useful for debugging purposes.
+	 */
+	stat = dw_readl(dev, DW_IC_INTR_STAT);
+
+	/*
+	 * Do not use the IC_CLR_INTR register to clear interrupts, or
+	 * you'll miss some interrupts, triggered during the period from
+	 * dw_readl(IC_INTR_STAT) to dw_readl(IC_CLR_INTR).
+	 *
+	 * Instead, use the separately-prepared IC_CLR_* registers.
+	 */
+	if (stat & DW_IC_INTR_TX_ABRT)
+		dw_readl(dev, DW_IC_CLR_TX_ABRT);
+	if (stat & DW_IC_INTR_RX_UNDER)
+		dw_readl(dev, DW_IC_CLR_RX_UNDER);
+	if (stat & DW_IC_INTR_RX_OVER)
+		dw_readl(dev, DW_IC_CLR_RX_OVER);
+	if (stat & DW_IC_INTR_TX_OVER)
+		dw_readl(dev, DW_IC_CLR_TX_OVER);
+	if (stat & DW_IC_INTR_RX_DONE)
+		dw_readl(dev, DW_IC_CLR_RX_DONE);
+	if (stat & DW_IC_INTR_ACTIVITY)
+		dw_readl(dev, DW_IC_CLR_ACTIVITY);
+	if (stat & DW_IC_INTR_STOP_DET)
+		dw_readl(dev, DW_IC_CLR_STOP_DET);
+	if (stat & DW_IC_INTR_START_DET)
+		dw_readl(dev, DW_IC_CLR_START_DET);
+	if (stat & DW_IC_INTR_GEN_CALL)
+		dw_readl(dev, DW_IC_CLR_GEN_CALL);
+
+	return stat;
+}
+
+/*
+ * Interrupt service routine. This gets called whenever an I2C slave interrupt
+ * occurs.
+ */
+
+static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
+{
+	u32 raw_stat, stat, enabled;
+	u8 val, slave_activity;
+
+	stat = dw_readl(dev, DW_IC_INTR_STAT);
+	enabled = dw_readl(dev, DW_IC_ENABLE);
+	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+	slave_activity = ((dw_readl(dev, DW_IC_STATUS) &
+		 DW_IC_STATUS_SLAVE_ACTIVITY) >> 6);
+
+	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))
+		return 0;
+
+	dev_dbg(dev->dev,
+	 "%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n",
+	 __func__, enabled, slave_activity, raw_stat, stat);
+
+	if (stat & DW_IC_INTR_RESTART_DET)
+		dw_readl(dev, DW_IC_CLR_RESTART_DET);
+	if (stat & DW_IC_INTR_START_DET)
+		dw_readl(dev, DW_IC_CLR_START_DET);
+	if (stat & DW_IC_INTR_ACTIVITY)
+		dw_readl(dev, DW_IC_CLR_ACTIVITY);
+	if (stat & DW_IC_INTR_RX_OVER)
+		dw_readl(dev, DW_IC_CLR_RX_OVER);
+	if ((stat & DW_IC_INTR_RX_FULL) && (stat & DW_IC_INTR_STOP_DET))
+		i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
+
+	if (slave_activity) {
+		if (stat & DW_IC_INTR_RD_REQ) {
+			if (stat & DW_IC_INTR_RX_FULL) {
+				val = dw_readl(dev, DW_IC_DATA_CMD);
+				if (!i2c_slave_event(dev->slave,
+				 I2C_SLAVE_WRITE_RECEIVED, &val)) {
+					dev_dbg(dev->dev, "Byte %X acked!",
+					 val);
+				}
+				dw_readl(dev, DW_IC_CLR_RD_REQ);
+				stat = i2c_dw_read_clear_intrbits_slave(dev);
+			} else {
+				dw_readl(dev, DW_IC_CLR_RD_REQ);
+				dw_readl(dev, DW_IC_CLR_RX_UNDER);
+				stat = i2c_dw_read_clear_intrbits_slave(dev);
+			}
+			if (!i2c_slave_event(dev->slave,
+					 I2C_SLAVE_READ_REQUESTED, &val))
+				dw_writel(dev, val, DW_IC_DATA_CMD);
+		}
+	}
+
+	if (stat & DW_IC_INTR_RX_DONE) {
+		if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED,
+		 &val))
+			dw_readl(dev, DW_IC_CLR_RX_DONE);
+
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
+		stat = i2c_dw_read_clear_intrbits_slave(dev);
+		return true;
+	}
+
+	if (stat & DW_IC_INTR_RX_FULL) {
+		val = dw_readl(dev, DW_IC_DATA_CMD);
+		if (!i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED,
+		 &val))
+			dev_dbg(dev->dev, "Byte %X acked!", val);
+	} else {
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
+		stat = i2c_dw_read_clear_intrbits_slave(dev);
+	}
+
+	if (stat & DW_IC_INTR_TX_OVER)
+		dw_readl(dev, DW_IC_CLR_TX_OVER);
+
+	return 1;
+}
+
+static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
+{
+	struct dw_i2c_dev *dev = dev_id;
+	int ret;
+
+	i2c_dw_read_clear_intrbits_slave(dev);
+	ret = i2c_dw_irq_handler_slave(dev);
+
+	if (ret > 0)
+		complete(&dev->cmd_complete);
+
+	return IRQ_RETVAL(ret);
+}
+
+static struct i2c_algorithm i2c_dw_algo = {
+	.functionality = i2c_dw_func,
+	.reg_slave = i2c_dw_reg_slave,
+	.unreg_slave = i2c_dw_unreg_slave,
+};
+
+void i2c_dw_disable_slave(struct dw_i2c_dev *dev)
+{
+	/* Disable controller. */
+	__i2c_dw_enable_and_wait(dev, false);
+
+	/* Disable all interupts. */
+	dw_writel(dev, 0, DW_IC_INTR_MASK);
+	dw_readl(dev, DW_IC_CLR_INTR);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_disable_slave);
+
+void i2c_dw_disable_int_slave(struct dw_i2c_dev *dev)
+{
+	dw_writel(dev, 0, DW_IC_INTR_MASK);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_disable_int_slave);
+
+u32 i2c_dw_read_comp_param_slave(struct dw_i2c_dev *dev)
+{
+	return dw_readl(dev, DW_IC_COMP_PARAM_1);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param_slave);
+
+int i2c_dw_probe_slave(struct dw_i2c_dev *dev)
+{
+	struct i2c_adapter *adap = &dev->adapter;
+	int ret;
+
+	init_completion(&dev->cmd_complete);
+
+	ret = i2c_dw_init_slave(dev);
+	if (ret)
+		return ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	i2c_dw_release_lock(dev);
+	snprintf(adap->name, sizeof(adap->name),
+		 "Synopsys DesignWare I2C Slave adapter");
+	adap->retries = 3;
+	adap->algo = &i2c_dw_algo;
+	adap->dev.parent = dev->dev;
+	i2c_set_adapdata(adap, dev);
+
+	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr_slave,
+			     IRQF_SHARED, dev_name(dev->dev), dev);
+	if (ret) {
+		dev_err(dev->dev, "failure requesting irq %i: %d\n",
+			dev->irq, ret);
+		return ret;
+	}
+	/*
+	 * Increment PM usage count during adapter registration in order to
+	 * avoid possible spurious runtime suspend when adapter device is
+	 * registered to the device core and immediate resume in case bus has
+	 * registered I2C slaves that do I2C transfers in their probe.
+	 */
+	pm_runtime_get_noresume(dev->dev);
+	ret = i2c_add_numbered_adapter(adap);
+	if (ret)
+		dev_err(dev->dev, "failure adding adapter: %d\n", ret);
+	pm_runtime_put_noidle(dev->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_dw_probe_slave);
+
+MODULE_AUTHOR("Luis Oliveira <lolivei@synopsys.com>");
+MODULE_DESCRIPTION("Synopsys DesignWare I2C bus slave adapter");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
