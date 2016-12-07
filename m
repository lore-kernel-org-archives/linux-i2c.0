From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v4 4/5] i2c: designware: Add slave mode as separated driver
Date: Wed,  7 Dec 2016 17:55:51 +0000
Message-ID: <a7ca5014ad1c3f4905349a02ebe5294fe64c318e.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Slave mode selected by compatibility string in platform module
- Changes in Makefile to Kbuild successfully compile i2c-designware-core
  with slave functions

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V3->V4: (Andy Shevchenko)
- nothing changed

 drivers/i2c/busses/Makefile                 |   2 +-
 drivers/i2c/busses/i2c-designware-core.h    |   1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  73 ++++-
 drivers/i2c/busses/i2c-designware-slave.c   | 433 ++++++++++++++++++++++++++++
 4 files changed, 499 insertions(+), 10 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c

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
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b7dcd134e208..a0e5c88858a9 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -265,6 +265,7 @@ struct dw_i2c_dev {
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_runtime_disabled;
 	bool			dynamic_tar_update_enabled;
+	bool			mode;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index e55b5544c733..300cf2de4ae3 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -142,6 +142,8 @@ static void i2c_dw_configure_master(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
+	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
+
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
 
@@ -159,6 +161,30 @@ static void i2c_dw_configure_master(struct platform_device *pdev)
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
+	dev_info(&pdev->dev, "I am registed as a I2C Slave!\n");
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
@@ -240,9 +266,12 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
-
-	i2c_dw_configure_master(pdev);
+#ifndef CONFIG_ACPI
+	if (!device_property_match_string(&pdev->dev, "mode", "slave"))
+		i2c_dw_configure_slave(pdev);
+	else
+#endif
+		i2c_dw_configure_master(pdev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
@@ -255,7 +284,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	if (!dev->tx_fifo_depth) {
-		u32 param1 = i2c_dw_read_comp_param(dev);
+		u32 param1;
+#ifndef CONFIG_ACPI
+		if (!device_property_match_string(&pdev->dev,
+			 "mode", "slave"))
+			param1 = i2c_dw_read_comp_param_slave(dev);
+		else
+#endif
+			param1 = i2c_dw_read_comp_param(dev);
 
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
@@ -276,8 +312,13 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
 	}
+#ifndef CONFIG_ACPI
+	if (device_property_match_string(&pdev->dev, "mode", "slave") == 0)
+		r = i2c_dw_probe_slave(dev);
+	else
+#endif
+		r = i2c_dw_probe(dev);
 
-	r = i2c_dw_probe(dev);
 	if (r && !dev->pm_runtime_disabled)
 		pm_runtime_disable(&pdev->dev);
 
@@ -292,7 +333,12 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&dev->adapter);
 
-	i2c_dw_disable(dev);
+#ifndef CONFIG_ACPI
+	if (!device_property_match_string(&pdev->dev, "mode", "slave"))
+		i2c_dw_disable_slave(dev);
+	else
+#endif
+		i2c_dw_disable(dev);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
@@ -332,7 +378,12 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
-	i2c_dw_disable(i_dev);
+#ifndef CONFIG_ACPI
+	if (!device_property_match_string(&pdev->dev, "mode", "slave"))
+		i2c_dw_disable_slave(i_dev);
+	else
+#endif
+		i2c_dw_disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
 
 	return 0;
@@ -345,8 +396,12 @@ static int dw_i2c_plat_resume(struct device *dev)
 
 	i2c_dw_plat_prepare_clk(i_dev, true);
 
-	if (!i_dev->pm_runtime_disabled)
-		i2c_dw_init(i_dev);
+	if (!i_dev->pm_runtime_disabled) {
+		if (!device_property_match_string(&pdev->dev, "mode", "slave"))
+			i2c_dw_init_slave(i_dev);
+		else
+			i2c_dw_init(i_dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
new file mode 100644
index 000000000000..1c7f82bb2513
--- /dev/null
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -0,0 +1,433 @@
+/*
+ * Synopsys DesignWare I2C adapter driver (master only).
+ *
+ * Based on the TI DAVINCI I2C adapter driver.
+ *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (C) 2007 MontaVista Software Inc.
+ * Copyright (C) 2009 Provigent Ltd.
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
+#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include "i2c-designware-core.h"
+
+static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
+{
+	/* Configure Tx/Rx FIFO threshold levels */
+	dw_writel(dev, 0, DW_IC_TX_TL);
+	dw_writel(dev, 0, DW_IC_RX_TL);
+
+	/* configure the I2C slave */
+	dw_writel(dev, dev->slave_cfg, DW_IC_CON);
+	dw_writel(dev, DW_IC_INTR_SLAVE_MASK, DW_IC_INTR_MASK);
+}
+
+/**
+ * i2c_dw_init_slave() - initialize the designware i2c slave hardware
+ * @dev: device private data
+ *
+ * This functions configures and enables the I2C.
+ * This function is called during I2C init function, and in case of timeout at
+ * run time.
+ */
+int i2c_dw_init_slave(struct dw_i2c_dev *dev)
+{
+	u32 hcnt, lcnt;
+	u32 reg, comp_param1;
+	u32 sda_falling_time, scl_falling_time;
+	int ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	reg = dw_readl(dev, DW_IC_COMP_TYPE);
+	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
+		/* Configure register endianness access */
+		dev->accessor_flags |= ACCESS_SWAP;
+	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
+		/* Configure register access mode 16bit */
+		dev->accessor_flags |= ACCESS_16BIT;
+	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
+		dev_err(dev->dev, "Unknown Synopsys component type: "
+			"0x%08x\n", reg);
+		i2c_dw_release_lock(dev);
+		return -ENODEV;
+	}
+
+	comp_param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
+
+	/* Disable the adapter */
+	__i2c_dw_enable_and_wait(dev, false);
+
+	/* set standard and fast speed deviders for high/low periods */
+	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
+	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
+
+	/* Set SCL timing parameters for standard-mode */
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
+	/* Set SCL timing parameters for fast-mode or fast-mode plus */
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
+	/* Configure SDA Hold Time if required */
+	reg = dw_readl(dev, DW_IC_COMP_VERSION);
+	reg = dw_readl(dev, DW_IC_COMP_VERSION);
+	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
+		if (!dev->sda_hold_time) {
+			/* Keep previous hold time setting if no one set it */
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
+		/* set slave address in the IC_SAR register,
+		* the address to which the DW_apb_i2c responds */
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
+static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
+{
+	u32 raw_stat, stat, enabled;
+	u8 val, slave_activity;
+
+	stat = dw_readl(dev, DW_IC_INTR_STAT);
+	enabled = dw_readl(dev, DW_IC_ENABLE);
+	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+	slave_activity = ((dw_readl(dev, DW_IC_STATUS) &
+		 DW_IC_STATUS_SLAVE_ACTIVITY)>>6);
+
+	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))
+		return false;
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
+	return true;
+}
+
+static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
+{
+	struct dw_i2c_dev *dev = dev_id;
+
+	i2c_dw_read_clear_intrbits_slave(dev);
+	if (!i2c_dw_irq_handler_slave(dev))
+		return IRQ_NONE;
+
+	complete(&dev->cmd_complete);
+	return IRQ_HANDLED;
+}
+
+static struct i2c_algorithm i2c_dw_algo = {
+	.functionality	= i2c_dw_func,
+	.reg_slave	= i2c_dw_reg_slave,
+	.unreg_slave	= i2c_dw_unreg_slave,
+};
+
+void i2c_dw_disable_slave(struct dw_i2c_dev *dev)
+{
+	/* Disable controller */
+	__i2c_dw_enable_and_wait(dev, false);
+
+	/* Disable all interupts */
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
+	int r;
+
+	init_completion(&dev->cmd_complete);
+
+	r = i2c_dw_init_slave(dev);
+	if (r)
+		return r;
+
+	r = i2c_dw_acquire_lock(dev);
+	if (r)
+		return r;
+
+	i2c_dw_release_lock(dev);
+	snprintf(adap->name, sizeof(adap->name),
+		 "Synopsys DesignWare I2C Slave adapter");
+	adap->retries = 3;
+	adap->algo = &i2c_dw_algo;
+	adap->dev.parent = dev->dev;
+	i2c_set_adapdata(adap, dev);
+
+	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr_slave,
+			     IRQF_SHARED | IRQF_COND_SUSPEND,
+			     dev_name(dev->dev), dev);
+	if (r) {
+		dev_err(dev->dev, "failure requesting irq %i: %d\n",
+			dev->irq, r);
+		return r;
+	}
+	/*
+	 * Increment PM usage count during adapter registration in order to
+	 * avoid possible spurious runtime suspend when adapter device is
+	 * registered to the device core and immediate resume in case bus has
+	 * registered I2C slaves that do I2C transfers in their probe.
+	 */
+	pm_runtime_get_noresume(dev->dev);
+	r = i2c_add_numbered_adapter(adap);
+	if (r)
+		dev_err(dev->dev, "failure adding adapter: %d\n", r);
+	pm_runtime_put_noidle(dev->dev);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(i2c_dw_probe_slave);
+
+MODULE_DESCRIPTION("Synopsys DesignWare I2C bus slave adapter");
+MODULE_LICENSE("GPL");
-- 
2.11.0
