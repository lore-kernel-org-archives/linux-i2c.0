From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v8 3/6] i2c: designware: MASTER mode as separated driver
Date: Wed, 12 Apr 2017 17:47:53 +0100
Message-ID: <f4ffddb9cb8206d299700d9de89b11246757e8c0.1492014220.git.lolivei@synopsys.com>
References: <cover.1492014220.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492014220.git.lolivei@synopsys.com>
In-Reply-To: <cover.1492014220.git.lolivei@synopsys.com>
References: <cover.1492014220.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- The functions related to I2C master mode of operation were transformed
  in a single driver.
- Common definitions were moved to i2c-designware-core.h
- The i2c-designware-core is now only a library file, the functions
  associated are in a source file called i2c-designware-common and
  are used by both i2c-designware-master and i2c-designware-slave.
- To decrease noise in namespace common i2c_dw_*() functions are
  now using ops to keep them private.
- Designware PCI driver had to be changed to match the previous ops
  functions implementation.

Almost all of the "core" source is now part of the "master" source. The
difference is the functions used by both modes and they are in the
"common" source file.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v7-v8
- removed "@dynamic_tar_update_enabled" comment

 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-designware-common.c         | 274 +++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h           | 145 +++++++-
 ...c-designware-core.c => i2c-designware-master.c} | 367 +--------------------
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   8 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |   6 +-
 6 files changed, 432 insertions(+), 369 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-common.c
 rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (65%)

diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 30b60855fbcd..c89a4314c563 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
 obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
 obj-$(CONFIG_I2C_DESIGNWARE_CORE)	+= i2c-designware-core.o
+i2c-designware-core-objs := i2c-designware-common.o i2c-designware-master.o
 obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c-designware-platform.o
 i2c-designware-platform-objs := i2c-designware-platdrv.o
 i2c-designware-platform-$(CONFIG_I2C_DESIGNWARE_BAYTRAIL) += i2c-designware-baytrail.o
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
new file mode 100644
index 000000000000..98b64e4f5977
--- /dev/null
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -0,0 +1,274 @@
+/*
+ * Synopsys DesignWare I2C adapter driver.
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
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+
+#include "i2c-designware-core.h"
+
+static char *abort_sources[] = {
+	[ABRT_7B_ADDR_NOACK] =
+		"slave address not acknowledged (7bit mode)",
+	[ABRT_10ADDR1_NOACK] =
+		"first address byte not acknowledged (10bit mode)",
+	[ABRT_10ADDR2_NOACK] =
+		"second address byte not acknowledged (10bit mode)",
+	[ABRT_TXDATA_NOACK] =
+		"data not acknowledged",
+	[ABRT_GCALL_NOACK] =
+		"no acknowledgement for a general call",
+	[ABRT_GCALL_READ] =
+		"read after general call",
+	[ABRT_SBYTE_ACKDET] =
+		"start byte acknowledged",
+	[ABRT_SBYTE_NORSTRT] =
+		"trying to send start byte when restart is disabled",
+	[ABRT_10B_RD_NORSTRT] =
+		"trying to read when restart is disabled (10bit mode)",
+	[ABRT_MASTER_DIS] =
+		"trying to use disabled adapter",
+	[ARB_LOST] =
+		"lost arbitration",
+};
+
+u32 dw_readl(struct dw_i2c_dev *dev, int offset)
+{
+	u32 value;
+
+	if (dev->flags & ACCESS_16BIT)
+		value = readw_relaxed(dev->base + offset) |
+			(readw_relaxed(dev->base + offset + 2) << 16);
+	else
+		value = readl_relaxed(dev->base + offset);
+
+	if (dev->flags & ACCESS_SWAP)
+		return swab32(value);
+	else
+		return value;
+}
+
+void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
+{
+	if (dev->flags & ACCESS_SWAP)
+		b = swab32(b);
+
+	if (dev->flags & ACCESS_16BIT) {
+		writew_relaxed((u16)b, dev->base + offset);
+		writew_relaxed((u16)(b >> 16), dev->base + offset + 2);
+	} else {
+		writel_relaxed(b, dev->base + offset);
+	}
+}
+
+u32 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
+{
+	/*
+	 * DesignWare I2C core doesn't seem to have solid strategy to meet
+	 * the tHD;STA timing spec.  Configuring _HCNT based on tHIGH spec
+	 * will result in violation of the tHD;STA spec.
+	 */
+	if (cond)
+		/*
+		 * Conditional expression:
+		 *
+		 *   IC_[FS]S_SCL_HCNT + (1+4+3) >= IC_CLK * tHIGH
+		 *
+		 * This is based on the DW manuals, and represents an ideal
+		 * configuration.  The resulting I2C bus speed will be
+		 * faster than any of the others.
+		 *
+		 * If your hardware is free from tHD;STA issue, try this one.
+		 */
+		return (ic_clk * tSYMBOL + 500000) / 1000000 - 8 + offset;
+	else
+		/*
+		 * Conditional expression:
+		 *
+		 *   IC_[FS]S_SCL_HCNT + 3 >= IC_CLK * (tHD;STA + tf)
+		 *
+		 * This is just experimental rule; the tHD;STA period turned
+		 * out to be proportinal to (_HCNT + 3).  With this setting,
+		 * we could meet both tHIGH and tHD;STA timing specs.
+		 *
+		 * If unsure, you'd better to take this alternative.
+		 *
+		 * The reason why we need to take into account "tf" here,
+		 * is the same as described in i2c_dw_scl_lcnt().
+		 */
+		return (ic_clk * (tSYMBOL + tf) + 500000) / 1000000
+			- 3 + offset;
+}
+
+u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
+{
+	/*
+	 * Conditional expression:
+	 *
+	 *   IC_[FS]S_SCL_LCNT + 1 >= IC_CLK * (tLOW + tf)
+	 *
+	 * DW I2C core starts counting the SCL CNTs for the LOW period
+	 * of the SCL clock (tLOW) as soon as it pulls the SCL line.
+	 * In order to meet the tLOW timing spec, we need to take into
+	 * account the fall time of SCL signal (tf).  Default tf value
+	 * should be 0.3 us, for safety.
+	 */
+	return ((ic_clk * (tLOW + tf) + 500000) / 1000000) - 1 + offset;
+}
+
+void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
+{
+	dw_writel(dev, enable, DW_IC_ENABLE);
+}
+
+void __i2c_dw_enable_and_wait(struct dw_i2c_dev *dev, bool enable)
+{
+	int timeout = 100;
+
+	do {
+		__i2c_dw_enable(dev, enable);
+		if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable)
+			return;
+
+		/*
+		 * Wait 10 times the signaling period of the highest I2C
+		 * transfer supported by the driver (for 400KHz this is
+		 * 25us) as described in the DesignWare I2C databook.
+		 */
+		usleep_range(25, 250);
+	} while (timeout--);
+
+	dev_warn(dev->dev, "timeout in %sabling adapter\n",
+		 enable ? "en" : "dis");
+}
+
+unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
+{
+	/*
+	 * Clock is not necessary if we got LCNT/HCNT values directly from
+	 * the platform code.
+	 */
+	if (WARN_ON_ONCE(!dev->get_clk_rate_khz))
+		return 0;
+	return dev->get_clk_rate_khz(dev);
+}
+
+int i2c_dw_acquire_lock(struct dw_i2c_dev *dev)
+{
+	int ret;
+
+	if (!dev->acquire_lock)
+		return 0;
+
+	ret = dev->acquire_lock(dev);
+	if (!ret)
+		return 0;
+
+	dev_err(dev->dev, "couldn't acquire bus ownership\n");
+
+	return ret;
+}
+
+void i2c_dw_release_lock(struct dw_i2c_dev *dev)
+{
+	if (dev->release_lock)
+		dev->release_lock(dev);
+}
+
+/*
+ * Waiting for bus not busy
+ */
+int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
+{
+	int timeout = TIMEOUT;
+
+	while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
+		if (timeout <= 0) {
+			dev_warn(dev->dev, "timeout waiting for bus ready\n");
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		usleep_range(1000, 1100);
+	}
+
+	return 0;
+}
+
+int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
+{
+	unsigned long abort_source = dev->abort_source;
+	int i;
+
+	if (abort_source & DW_IC_TX_ABRT_NOACK) {
+		for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
+			dev_dbg(dev->dev,
+				"%s: %s\n", __func__, abort_sources[i]);
+		return -EREMOTEIO;
+	}
+
+	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
+		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
+
+	if (abort_source & DW_IC_TX_ARB_LOST)
+		return -EAGAIN;
+	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
+		return -EINVAL; /* wrong msgs[] data */
+	else
+		return -EIO;
+}
+
+u32 i2c_dw_func(struct i2c_adapter *adap)
+{
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	return dev->functionality;
+}
+void i2c_dw_disable(struct dw_i2c_dev *dev)
+{
+	/* Disable controller */
+	__i2c_dw_enable_and_wait(dev, false);
+
+	/* Disable all interupts */
+	dw_writel(dev, 0, DW_IC_INTR_MASK);
+	dw_readl(dev, DW_IC_CLR_INTR);
+}
+
+void i2c_dw_disable_int(struct dw_i2c_dev *dev)
+{
+	dw_writel(dev, 0, DW_IC_INTR_MASK);
+}
+
+u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev)
+{
+	return dw_readl(dev, DW_IC_COMP_PARAM_1);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
+
+MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
+MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index fe9b66898a72..81b46c8529fa 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -41,6 +41,124 @@
 #define DW_IC_CON_RESTART_EN		0x20
 #define DW_IC_CON_SLAVE_DISABLE		0x40
 
+/*
+ * Registers offset
+ */
+#define DW_IC_CON		0x0
+#define DW_IC_TAR		0x4
+#define DW_IC_DATA_CMD		0x10
+#define DW_IC_SS_SCL_HCNT	0x14
+#define DW_IC_SS_SCL_LCNT	0x18
+#define DW_IC_FS_SCL_HCNT	0x1c
+#define DW_IC_FS_SCL_LCNT	0x20
+#define DW_IC_HS_SCL_HCNT	0x24
+#define DW_IC_HS_SCL_LCNT	0x28
+#define DW_IC_INTR_STAT		0x2c
+#define DW_IC_INTR_MASK		0x30
+#define DW_IC_RAW_INTR_STAT	0x34
+#define DW_IC_RX_TL		0x38
+#define DW_IC_TX_TL		0x3c
+#define DW_IC_CLR_INTR		0x40
+#define DW_IC_CLR_RX_UNDER	0x44
+#define DW_IC_CLR_RX_OVER	0x48
+#define DW_IC_CLR_TX_OVER	0x4c
+#define DW_IC_CLR_RD_REQ	0x50
+#define DW_IC_CLR_TX_ABRT	0x54
+#define DW_IC_CLR_RX_DONE	0x58
+#define DW_IC_CLR_ACTIVITY	0x5c
+#define DW_IC_CLR_STOP_DET	0x60
+#define DW_IC_CLR_START_DET	0x64
+#define DW_IC_CLR_GEN_CALL	0x68
+#define DW_IC_ENABLE		0x6c
+#define DW_IC_STATUS		0x70
+#define DW_IC_TXFLR		0x74
+#define DW_IC_RXFLR		0x78
+#define DW_IC_SDA_HOLD		0x7c
+#define DW_IC_TX_ABRT_SOURCE	0x80
+#define DW_IC_ENABLE_STATUS	0x9c
+#define DW_IC_COMP_PARAM_1	0xf4
+#define DW_IC_COMP_VERSION	0xf8
+#define DW_IC_SDA_HOLD_MIN_VERS	0x3131312A
+#define DW_IC_COMP_TYPE		0xfc
+#define DW_IC_COMP_TYPE_VALUE	0x44570140
+
+#define DW_IC_INTR_RX_UNDER	0x001
+#define DW_IC_INTR_RX_OVER	0x002
+#define DW_IC_INTR_RX_FULL	0x004
+#define DW_IC_INTR_TX_OVER	0x008
+#define DW_IC_INTR_TX_EMPTY	0x010
+#define DW_IC_INTR_RD_REQ	0x020
+#define DW_IC_INTR_TX_ABRT	0x040
+#define DW_IC_INTR_RX_DONE	0x080
+#define DW_IC_INTR_ACTIVITY	0x100
+#define DW_IC_INTR_STOP_DET	0x200
+#define DW_IC_INTR_START_DET	0x400
+#define DW_IC_INTR_GEN_CALL	0x800
+
+#define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
+					 DW_IC_INTR_TX_ABRT | \
+					 DW_IC_INTR_STOP_DET)
+#define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
+					 DW_IC_INTR_TX_EMPTY)
+#define DW_IC_STATUS_ACTIVITY		0x1
+#define DW_IC_STATUS_TFE		BIT(2)
+#define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
+
+#define DW_IC_SDA_HOLD_RX_SHIFT		16
+#define DW_IC_SDA_HOLD_RX_MASK		GENMASK(23, DW_IC_SDA_HOLD_RX_SHIFT)
+
+#define DW_IC_ERR_TX_ABRT	0x1
+
+#define DW_IC_TAR_10BITADDR_MASTER BIT(12)
+
+#define DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH	(BIT(2) | BIT(3))
+#define DW_IC_COMP_PARAM_1_SPEED_MODE_MASK	GENMASK(3, 2)
+
+/*
+ * Status codes
+ */
+#define STATUS_IDLE			0x0
+#define STATUS_WRITE_IN_PROGRESS	0x1
+#define STATUS_READ_IN_PROGRESS		0x2
+
+#define TIMEOUT			20 /* ms */
+
+/*
+ * Hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
+ *
+ * Only expected abort codes are listed here
+ * refer to the datasheet for the full list
+ */
+#define ABRT_7B_ADDR_NOACK	0
+#define ABRT_10ADDR1_NOACK	1
+#define ABRT_10ADDR2_NOACK	2
+#define ABRT_TXDATA_NOACK	3
+#define ABRT_GCALL_NOACK	4
+#define ABRT_GCALL_READ		5
+#define ABRT_SBYTE_ACKDET	7
+#define ABRT_SBYTE_NORSTRT	9
+#define ABRT_10B_RD_NORSTRT	10
+#define ABRT_MASTER_DIS		11
+#define ARB_LOST		12
+
+#define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
+#define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
+#define DW_IC_TX_ABRT_10ADDR2_NOACK	(1UL << ABRT_10ADDR2_NOACK)
+#define DW_IC_TX_ABRT_TXDATA_NOACK	(1UL << ABRT_TXDATA_NOACK)
+#define DW_IC_TX_ABRT_GCALL_NOACK	(1UL << ABRT_GCALL_NOACK)
+#define DW_IC_TX_ABRT_GCALL_READ	(1UL << ABRT_GCALL_READ)
+#define DW_IC_TX_ABRT_SBYTE_ACKDET	(1UL << ABRT_SBYTE_ACKDET)
+#define DW_IC_TX_ABRT_SBYTE_NORSTRT	(1UL << ABRT_SBYTE_NORSTRT)
+#define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
+#define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
+#define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
+
+#define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
+					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
+					 DW_IC_TX_ABRT_10ADDR2_NOACK | \
+					 DW_IC_TX_ABRT_TXDATA_NOACK | \
+					 DW_IC_TX_ABRT_GCALL_NOACK)
+
 
 /**
  * struct dw_i2c_dev - private i2c-designware data
@@ -80,7 +198,10 @@
  * @acquire_lock: function to acquire a hardware lock on the bus
  * @release_lock: function to release a hardware lock on the bus
  * @pm_disabled: true if power-management should be disabled for this i2c-bus
- *
+ * @disable: function to disable the controller
+ * @disable_int: function to disable all interrupts
+ * @init: function to initialize the I2C hardware
+ * 
  * HCNT and LCNT parameters can be used if the platform knows more accurate
  * values than the one computed based only on the input clock frequency.
  * Leave them to be %0 if not used.
@@ -129,6 +250,9 @@ struct dw_i2c_dev {
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_disabled;
+	void			(*disable)(struct dw_i2c_dev *dev);
+	void			(*disable_int)(struct dw_i2c_dev *dev);
+	int			(*init)(struct dw_i2c_dev *dev);
 };
 
 #define ACCESS_SWAP		0x00000001
@@ -137,9 +261,22 @@ struct dw_i2c_dev {
 
 #define MODEL_CHERRYTRAIL	0x00000100
 
-extern int i2c_dw_init(struct dw_i2c_dev *dev);
-extern void i2c_dw_disable(struct dw_i2c_dev *dev);
-extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
+u32 dw_readl(struct dw_i2c_dev *dev, int offset);
+void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
+u32 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset);
+u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset);
+void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable);
+void __i2c_dw_enable_and_wait(struct dw_i2c_dev *dev, bool enable);
+unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev);
+int i2c_dw_acquire_lock(struct dw_i2c_dev *dev);
+void i2c_dw_release_lock(struct dw_i2c_dev *dev);
+int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev);
+int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev);
+u32 i2c_dw_func(struct i2c_adapter *adap);
+void i2c_dw_disable(struct dw_i2c_dev *dev);
+void i2c_dw_disable_int(struct dw_i2c_dev *dev);
+int i2c_dw_init(struct dw_i2c_dev *dev);
+
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe(struct dw_i2c_dev *dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-master.c
similarity index 65%
rename from drivers/i2c/busses/i2c-designware-core.c
rename to drivers/i2c/busses/i2c-designware-master.c
index ce5d11102070..54d0d5954a6e 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -22,9 +22,9 @@
  *
  */
 #include <linux/delay.h>
-#include <linux/export.h>
-#include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -32,175 +32,6 @@
 #include <linux/pm_runtime.h>
 
 #include "i2c-designware-core.h"
-/*
- * Registers offset
- */
-#define DW_IC_CON		0x0
-#define DW_IC_TAR		0x4
-#define DW_IC_DATA_CMD		0x10
-#define DW_IC_SS_SCL_HCNT	0x14
-#define DW_IC_SS_SCL_LCNT	0x18
-#define DW_IC_FS_SCL_HCNT	0x1c
-#define DW_IC_FS_SCL_LCNT	0x20
-#define DW_IC_HS_SCL_HCNT	0x24
-#define DW_IC_HS_SCL_LCNT	0x28
-#define DW_IC_INTR_STAT		0x2c
-#define DW_IC_INTR_MASK		0x30
-#define DW_IC_RAW_INTR_STAT	0x34
-#define DW_IC_RX_TL		0x38
-#define DW_IC_TX_TL		0x3c
-#define DW_IC_CLR_INTR		0x40
-#define DW_IC_CLR_RX_UNDER	0x44
-#define DW_IC_CLR_RX_OVER	0x48
-#define DW_IC_CLR_TX_OVER	0x4c
-#define DW_IC_CLR_RD_REQ	0x50
-#define DW_IC_CLR_TX_ABRT	0x54
-#define DW_IC_CLR_RX_DONE	0x58
-#define DW_IC_CLR_ACTIVITY	0x5c
-#define DW_IC_CLR_STOP_DET	0x60
-#define DW_IC_CLR_START_DET	0x64
-#define DW_IC_CLR_GEN_CALL	0x68
-#define DW_IC_ENABLE		0x6c
-#define DW_IC_STATUS		0x70
-#define DW_IC_TXFLR		0x74
-#define DW_IC_RXFLR		0x78
-#define DW_IC_SDA_HOLD		0x7c
-#define DW_IC_TX_ABRT_SOURCE	0x80
-#define DW_IC_ENABLE_STATUS	0x9c
-#define DW_IC_COMP_PARAM_1	0xf4
-#define DW_IC_COMP_VERSION	0xf8
-#define DW_IC_SDA_HOLD_MIN_VERS	0x3131312A
-#define DW_IC_COMP_TYPE		0xfc
-#define DW_IC_COMP_TYPE_VALUE	0x44570140
-
-#define DW_IC_INTR_RX_UNDER	0x001
-#define DW_IC_INTR_RX_OVER	0x002
-#define DW_IC_INTR_RX_FULL	0x004
-#define DW_IC_INTR_TX_OVER	0x008
-#define DW_IC_INTR_TX_EMPTY	0x010
-#define DW_IC_INTR_RD_REQ	0x020
-#define DW_IC_INTR_TX_ABRT	0x040
-#define DW_IC_INTR_RX_DONE	0x080
-#define DW_IC_INTR_ACTIVITY	0x100
-#define DW_IC_INTR_STOP_DET	0x200
-#define DW_IC_INTR_START_DET	0x400
-#define DW_IC_INTR_GEN_CALL	0x800
-
-#define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
-					 DW_IC_INTR_TX_ABRT | \
-					 DW_IC_INTR_STOP_DET)
-#define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
-					 DW_IC_INTR_TX_EMPTY)
-#define DW_IC_STATUS_ACTIVITY	0x1
-
-#define DW_IC_SDA_HOLD_RX_SHIFT		16
-#define DW_IC_SDA_HOLD_RX_MASK		GENMASK(23, DW_IC_SDA_HOLD_RX_SHIFT)
-
-#define DW_IC_ERR_TX_ABRT	0x1
-
-#define DW_IC_TAR_10BITADDR_MASTER		BIT(12)
-
-#define DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH	(BIT(2) | BIT(3))
-#define DW_IC_COMP_PARAM_1_SPEED_MODE_MASK	GENMASK(3, 2)
-
-/*
- * status codes
- */
-#define STATUS_IDLE			0x0
-#define STATUS_WRITE_IN_PROGRESS	0x1
-#define STATUS_READ_IN_PROGRESS		0x2
-
-#define TIMEOUT			20 /* ms */
-
-/*
- * Hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
- *
- * Only expected abort codes are listed here,
- * refer to the datasheet for the full list.
- */
-#define ABRT_7B_ADDR_NOACK	0
-#define ABRT_10ADDR1_NOACK	1
-#define ABRT_10ADDR2_NOACK	2
-#define ABRT_TXDATA_NOACK	3
-#define ABRT_GCALL_NOACK	4
-#define ABRT_GCALL_READ		5
-#define ABRT_SBYTE_ACKDET	7
-#define ABRT_SBYTE_NORSTRT	9
-#define ABRT_10B_RD_NORSTRT	10
-#define ABRT_MASTER_DIS		11
-#define ARB_LOST		12
-
-#define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
-#define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
-#define DW_IC_TX_ABRT_10ADDR2_NOACK	(1UL << ABRT_10ADDR2_NOACK)
-#define DW_IC_TX_ABRT_TXDATA_NOACK	(1UL << ABRT_TXDATA_NOACK)
-#define DW_IC_TX_ABRT_GCALL_NOACK	(1UL << ABRT_GCALL_NOACK)
-#define DW_IC_TX_ABRT_GCALL_READ	(1UL << ABRT_GCALL_READ)
-#define DW_IC_TX_ABRT_SBYTE_ACKDET	(1UL << ABRT_SBYTE_ACKDET)
-#define DW_IC_TX_ABRT_SBYTE_NORSTRT	(1UL << ABRT_SBYTE_NORSTRT)
-#define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
-#define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
-#define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
-
-#define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
-					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
-					 DW_IC_TX_ABRT_10ADDR2_NOACK | \
-					 DW_IC_TX_ABRT_TXDATA_NOACK | \
-					 DW_IC_TX_ABRT_GCALL_NOACK)
-
-static char *abort_sources[] = {
-	[ABRT_7B_ADDR_NOACK] =
-		"slave address not acknowledged (7bit mode)",
-	[ABRT_10ADDR1_NOACK] =
-		"first address byte not acknowledged (10bit mode)",
-	[ABRT_10ADDR2_NOACK] =
-		"second address byte not acknowledged (10bit mode)",
-	[ABRT_TXDATA_NOACK] =
-		"data not acknowledged",
-	[ABRT_GCALL_NOACK] =
-		"no acknowledgement for a general call",
-	[ABRT_GCALL_READ] =
-		"read after general call",
-	[ABRT_SBYTE_ACKDET] =
-		"start byte acknowledged",
-	[ABRT_SBYTE_NORSTRT] =
-		"trying to send start byte when restart is disabled",
-	[ABRT_10B_RD_NORSTRT] =
-		"trying to read when restart is disabled (10bit mode)",
-	[ABRT_MASTER_DIS] =
-		"trying to use disabled adapter",
-	[ARB_LOST] =
-		"lost arbitration",
-};
-
-static u32 dw_readl(struct dw_i2c_dev *dev, int offset)
-{
-	u32 value;
-
-	if (dev->flags & ACCESS_16BIT)
-		value = readw_relaxed(dev->base + offset) |
-			(readw_relaxed(dev->base + offset + 2) << 16);
-	else
-		value = readl_relaxed(dev->base + offset);
-
-	if (dev->flags & ACCESS_SWAP)
-		return swab32(value);
-	else
-		return value;
-}
-
-static void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
-{
-	if (dev->flags & ACCESS_SWAP)
-		b = swab32(b);
-
-	if (dev->flags & ACCESS_16BIT) {
-		writew_relaxed((u16)b, dev->base + offset);
-		writew_relaxed((u16)(b >> 16), dev->base + offset + 2);
-	} else {
-		writel_relaxed(b, dev->base + offset);
-	}
-}
 
 static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
 {
@@ -212,121 +43,6 @@ static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
 	dw_writel(dev, dev->master_cfg, DW_IC_CON);
 }
 
-static u32
-i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
-{
-	/*
-	 * DesignWare I2C core doesn't seem to have solid strategy to meet
-	 * the tHD;STA timing spec.  Configuring _HCNT based on tHIGH spec
-	 * will result in violation of the tHD;STA spec.
-	 */
-	if (cond)
-		/*
-		 * Conditional expression:
-		 *
-		 *   IC_[FS]S_SCL_HCNT + (1+4+3) >= IC_CLK * tHIGH
-		 *
-		 * This is based on the DW manuals, and represents an ideal
-		 * configuration.  The resulting I2C bus speed will be
-		 * faster than any of the others.
-		 *
-		 * If your hardware is free from tHD;STA issue, try this one.
-		 */
-		return (ic_clk * tSYMBOL + 500000) / 1000000 - 8 + offset;
-	else
-		/*
-		 * Conditional expression:
-		 *
-		 *   IC_[FS]S_SCL_HCNT + 3 >= IC_CLK * (tHD;STA + tf)
-		 *
-		 * This is just experimental rule; the tHD;STA period turned
-		 * out to be proportinal to (_HCNT + 3).  With this setting,
-		 * we could meet both tHIGH and tHD;STA timing specs.
-		 *
-		 * If unsure, you'd better to take this alternative.
-		 *
-		 * The reason why we need to take into account "tf" here,
-		 * is the same as described in i2c_dw_scl_lcnt().
-		 */
-		return (ic_clk * (tSYMBOL + tf) + 500000) / 1000000
-			- 3 + offset;
-}
-
-static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
-{
-	/*
-	 * Conditional expression:
-	 *
-	 *   IC_[FS]S_SCL_LCNT + 1 >= IC_CLK * (tLOW + tf)
-	 *
-	 * DW I2C core starts counting the SCL CNTs for the LOW period
-	 * of the SCL clock (tLOW) as soon as it pulls the SCL line.
-	 * In order to meet the tLOW timing spec, we need to take into
-	 * account the fall time of SCL signal (tf).  Default tf value
-	 * should be 0.3 us, for safety.
-	 */
-	return ((ic_clk * (tLOW + tf) + 500000) / 1000000) - 1 + offset;
-}
-
-static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
-{
-	dw_writel(dev, enable, DW_IC_ENABLE);
-}
-
-static void __i2c_dw_enable_and_wait(struct dw_i2c_dev *dev, bool enable)
-{
-	int timeout = 100;
-
-	do {
-		__i2c_dw_enable(dev, enable);
-		if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable)
-			return;
-
-		/*
-		 * Wait 10 times the signaling period of the highest I2C
-		 * transfer supported by the driver (for 400KHz this is
-		 * 25us) as described in the DesignWare I2C databook.
-		 */
-		usleep_range(25, 250);
-	} while (timeout--);
-
-	dev_warn(dev->dev, "timeout in %sabling adapter\n",
-		 enable ? "en" : "dis");
-}
-
-static unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
-{
-	/*
-	 * Clock is not necessary if we got LCNT/HCNT values directly from
-	 * the platform code.
-	 */
-	if (WARN_ON_ONCE(!dev->get_clk_rate_khz))
-		return 0;
-	return dev->get_clk_rate_khz(dev);
-}
-
-static int i2c_dw_acquire_lock(struct dw_i2c_dev *dev)
-{
-	int ret;
-
-	if (!dev->acquire_lock)
-		return 0;
-
-	ret = dev->acquire_lock(dev);
-	if (!ret)
-		return 0;
-
-	dev_err(dev->dev, "couldn't acquire bus ownership\n");
-
-	return ret;
-}
-
-static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
-{
-	if (dev->release_lock)
-		dev->release_lock(dev);
-}
-
 /**
  * i2c_dw_init() - Initialize the designware I2C master hardware
  * @dev: device private data
@@ -457,25 +173,6 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_init);
 
-/*
- * Waiting for bus not busy
- */
-static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
-{
-	int timeout = TIMEOUT;
-
-	while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
-		if (timeout <= 0) {
-			dev_warn(dev->dev, "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		usleep_range(1000, 1100);
-	}
-
-	return 0;
-}
-
 static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
@@ -708,29 +405,6 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 	}
 }
 
-static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
-{
-	unsigned long abort_source = dev->abort_source;
-	int i;
-
-	if (abort_source & DW_IC_TX_ABRT_NOACK) {
-		for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
-			dev_dbg(dev->dev,
-				"%s: %s\n", __func__, abort_sources[i]);
-		return -EREMOTEIO;
-	}
-
-	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
-		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
-
-	if (abort_source & DW_IC_TX_ARB_LOST)
-		return -EAGAIN;
-	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
-		return -EINVAL; /* wrong msgs[] data */
-	else
-		return -EIO;
-}
-
 /*
  * Prepare controller for a transaction and call i2c_dw_xfer_msg.
  */
@@ -818,12 +492,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	return ret;
 }
 
-static u32 i2c_dw_func(struct i2c_adapter *adap)
-{
-	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
-	return dev->functionality;
-}
-
 static const struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer = i2c_dw_xfer,
 	.functionality = i2c_dw_func,
@@ -946,29 +614,6 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-void i2c_dw_disable(struct dw_i2c_dev *dev)
-{
-	/* Disable controller */
-	__i2c_dw_enable_and_wait(dev, false);
-
-	/* Disable all interupts */
-	dw_writel(dev, 0, DW_IC_INTR_MASK);
-	dw_readl(dev, DW_IC_CLR_INTR);
-}
-EXPORT_SYMBOL_GPL(i2c_dw_disable);
-
-void i2c_dw_disable_int(struct dw_i2c_dev *dev)
-{
-	dw_writel(dev, 0, DW_IC_INTR_MASK);
-}
-EXPORT_SYMBOL_GPL(i2c_dw_disable_int);
-
-u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev)
-{
-	return dw_readl(dev, DW_IC_COMP_PARAM_1);
-}
-EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
-
 int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
@@ -977,7 +622,11 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 
 	init_completion(&dev->cmd_complete);
 
-	ret = i2c_dw_init(dev);
+	dev->init = i2c_dw_init;
+	dev->disable = i2c_dw_disable;
+	dev->disable_int = i2c_dw_disable_int;
+
+	ret = dev->init(dev);
 	if (ret)
 		return ret;
 
@@ -1020,5 +669,5 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_probe);
 
-MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
+MODULE_DESCRIPTION("Synopsys DesignWare I2C bus master adapter");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index ed485b69b449..b582a5f2fb94 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -187,16 +187,18 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 static int i2c_dw_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
+	i_dev->disable(i_dev);
 
-	i2c_dw_disable(pci_get_drvdata(pdev));
 	return 0;
 }
 
 static int i2c_dw_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
 
-	return i2c_dw_init(pci_get_drvdata(pdev));
+	return i_dev->init(i_dev);
 }
 #endif
 
@@ -296,7 +298,7 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
-	i2c_dw_disable(dev);
+	dev->disable(dev);
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 7dece6f325d4..96c04a4475d2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -339,7 +339,7 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&dev->adapter);
 
-	i2c_dw_disable(dev);
+	dev->disable(dev);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
@@ -383,7 +383,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
-	i2c_dw_disable(i_dev);
+	i_dev->disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
 
 	return 0;
@@ -395,7 +395,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
 	i2c_dw_plat_prepare_clk(i_dev, true);
-	i2c_dw_init(i_dev);
+	i_dev->init(i_dev);
 
 	return 0;
 }
-- 
2.11.0
