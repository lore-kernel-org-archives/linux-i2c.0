From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c: designware: Cleaning and comment style fixes.
Date: Tue, 13 Dec 2016 16:34:45 +0000
Message-ID: <32604e59cde19a8981681ad2f0ee447af847bf60.1481646098.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

- Misspelling of some words
- Comment format fix
- Minor fix in coding style

Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
The purpose of this patch is to fix some comments and styling issues in the 
existing code. What is being made here is:

- Sorted the headers files
- Corrected the commentary format
- Reverse tree style in the variables declaration as long as possible
- Add/remove empty lines if needed (style)
- Fix of two misspelled words

 drivers/i2c/busses/i2c-designware-core.c    | 106 ++++++++++++++--------------
 drivers/i2c/busses/i2c-designware-core.h    |   3 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  25 +++----
 3 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6d81c56184d3..565f4e761edd 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -21,19 +21,20 @@
  * ----------------------------------------------------------------------------
  *
  */
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/pm_runtime.h>
-#include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
+
 #include "i2c-designware-core.h"
 
 /*
- * Registers offset
+ * Registers offset.
  */
 #define DW_IC_CON		0x0
 #define DW_IC_TAR		0x4
@@ -98,13 +99,13 @@
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
-#define DW_IC_TAR_10BITADDR_MASTER BIT(12)
+#define DW_IC_TAR_10BITADDR_MASTER	BIT(12)
 
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH	(BIT(2) | BIT(3))
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_MASK	GENMASK(3, 2)
 
 /*
- * status codes
+ * Status codes.
  */
 #define STATUS_IDLE			0x0
 #define STATUS_WRITE_IN_PROGRESS	0x1
@@ -113,10 +114,10 @@
 #define TIMEOUT			20 /* ms */
 
 /*
- * hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
+ * Hardware abort codes from the DW_IC_TX_ABRT_SOURCE register.
  *
- * only expected abort codes are listed here
- * refer to the datasheet for the full list
+ * Only expected abort codes are listed here.
+ * Refer to the datasheet for the full list.
  */
 #define ABRT_7B_ADDR_NOACK	0
 #define ABRT_10ADDR1_NOACK	1
@@ -158,7 +159,7 @@ static char *abort_sources[] = {
 	[ABRT_TXDATA_NOACK] =
 		"data not acknowledged",
 	[ABRT_GCALL_NOACK] =
-		"no acknowledgement for a general call",
+		"no acknowledgment for a general call",
 	[ABRT_GCALL_READ] =
 		"read after general call",
 	[ABRT_SBYTE_ACKDET] =
@@ -207,7 +208,7 @@ i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
 	/*
 	 * DesignWare I2C core doesn't seem to have solid strategy to meet
-	 * the tHD;STA timing spec.  Configuring _HCNT based on tHIGH spec
+	 * the tHD;STA timing spec. Configuring _HCNT based on tHIGH spec
 	 * will result in violation of the tHD;STA spec.
 	 */
 	if (cond)
@@ -327,9 +328,9 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
  */
 int i2c_dw_init(struct dw_i2c_dev *dev)
 {
-	u32 hcnt, lcnt;
-	u32 reg, comp_param1;
 	u32 sda_falling_time, scl_falling_time;
+	u32 reg, comp_param1;
+	u32 hcnt, lcnt;
 	int ret;
 
 	ret = i2c_dw_acquire_lock(dev);
@@ -338,29 +339,28 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
-		/* Configure register endianess access */
+		/* Configure register endianness access. */
 		dev->accessor_flags |= ACCESS_SWAP;
 	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
-		/* Configure register access mode 16bit */
+		/* Configure register access mode 16bit. */
 		dev->accessor_flags |= ACCESS_16BIT;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
-		dev_err(dev->dev, "Unknown Synopsys component type: "
-			"0x%08x\n", reg);
+		dev_err(dev->dev,
+			"Unknown Synopsys component type: 0x%08x\n", reg);
 		i2c_dw_release_lock(dev);
 		return -ENODEV;
 	}
 
 	comp_param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
 
-	/* Disable the adapter */
+	/* Disable the adapter. */
 	__i2c_dw_enable_and_wait(dev, false);
 
-	/* set standard and fast speed deviders for high/low periods */
-
+	/* Set standard and fast speed deviders for high/low periods. */
 	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
 	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
 
-	/* Set SCL timing parameters for standard-mode */
+	/* Set SCL timing parameters for standard-mode. */
 	if (dev->ss_hcnt && dev->ss_lcnt) {
 		hcnt = dev->ss_hcnt;
 		lcnt = dev->ss_lcnt;
@@ -379,7 +379,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
 	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
-	/* Set SCL timing parameters for fast-mode or fast-mode plus */
+	/* Set SCL timing parameters for fast-mode or fast-mode plus. */
 	if ((dev->clk_freq == 1000000) && dev->fp_hcnt && dev->fp_lcnt) {
 		hcnt = dev->fp_hcnt;
 		lcnt = dev->fp_lcnt;
@@ -418,11 +418,11 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		}
 	}
 
-	/* Configure SDA Hold Time if required */
+	/* Configure SDA Hold Time if required. */
 	reg = dw_readl(dev, DW_IC_COMP_VERSION);
 	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
 		if (!dev->sda_hold_time) {
-			/* Keep previous hold time setting if no one set it */
+			/* Keep previous hold time setting if no one set it. */
 			dev->sda_hold_time = dw_readl(dev, DW_IC_SDA_HOLD);
 		}
 		/*
@@ -440,11 +440,11 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 			"Hardware too old to adjust SDA hold time.\n");
 	}
 
-	/* Configure Tx/Rx FIFO threshold levels */
+	/* Configure Tx/Rx FIFO threshold levels. */
 	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
 	dw_writel(dev, 0, DW_IC_RX_TL);
 
-	/* configure the i2c master */
+	/* Configure the I2C master. */
 	dw_writel(dev, dev->master_cfg , DW_IC_CON);
 
 	i2c_dw_release_lock(dev);
@@ -454,7 +454,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 EXPORT_SYMBOL_GPL(i2c_dw_init);
 
 /*
- * Waiting for bus not busy
+ * Waiting for bus not busy.
  */
 static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 {
@@ -477,10 +477,10 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	struct i2c_msg *msgs = dev->msgs;
 	u32 ic_tar = 0;
 
-	/* Disable the adapter */
+	/* Disable the adapter. */
 	__i2c_dw_enable_and_wait(dev, false);
 
-	/* if the slave address is ten bit address, enable 10BITADDR */
+	/* If the slave address is ten bit address, enable 10BITADDR. */
 	if (dev->dynamic_tar_update_enabled) {
 		/*
 		 * If I2C_DYNAMIC_TAR_UPDATE is set, the 10-bit addressing
@@ -505,13 +505,13 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	 */
 	dw_writel(dev, msgs[dev->msg_write_idx].addr | ic_tar, DW_IC_TAR);
 
-	/* enforce disabled interrupts (due to HW issues) */
+	/* Enforce disabled interrupts (due to HW issues). */
 	i2c_dw_disable_int(dev);
 
-	/* Enable the adapter */
+	/* Enable the adapter. */
 	__i2c_dw_enable(dev, true);
 
-	/* Clear and enable interrupts */
+	/* Clear and enable interrupts. */
 	dw_readl(dev, DW_IC_CLR_INTR);
 	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
 }
@@ -526,12 +526,12 @@ static void
 i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	u32 intr_mask;
-	int tx_limit, rx_limit;
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
-	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
+	int tx_limit, rx_limit;
+	u8 *buf = dev->tx_buf;
+	u32 intr_mask;
 
 	intr_mask = DW_IC_INTR_DEFAULT_MASK;
 
@@ -539,9 +539,9 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		u32 flags = msgs[dev->msg_write_idx].flags;
 
 		/*
-		 * if target address has changed, we need to
-		 * reprogram the target address in the i2c
-		 * adapter when we are done with this transfer
+		 * If target address has changed, we need to
+		 * reprogram the target address in the I2C
+		 * adapter when we are done with this transfer.
 		 */
 		if (msgs[dev->msg_write_idx].addr != addr) {
 			dev_err(dev->dev,
@@ -558,7 +558,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		}
 
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
-			/* new i2c_msg */
+			/* New i2c_msg */
 			buf = msgs[dev->msg_write_idx].buf;
 			buf_len = msgs[dev->msg_write_idx].len;
 
@@ -601,7 +601,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
 
-				/* avoid rx buffer overrun */
+				/* Avoid rx buffer overrun. */
 				if (dev->rx_outstanding >= dev->rx_fifo_depth)
 					break;
 
@@ -622,7 +622,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		 * the transaction here.
 		 */
 		if (buf_len > 0 || flags & I2C_M_RECV_LEN) {
-			/* more bytes to be written */
+			/* More bytes to be written. */
 			dev->status |= STATUS_WRITE_IN_PROGRESS;
 			break;
 		} else
@@ -687,7 +687,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			u32 flags = msgs[dev->msg_read_idx].flags;
 
 			*buf = dw_readl(dev, DW_IC_DATA_CMD);
-			/* Ensure length byte is a valid value */
+			/* Ensure length byte is a valid value. */
 			if (flags & I2C_M_RECV_LEN &&
 				*buf <= I2C_SMBUS_BLOCK_MAX && *buf > 0) {
 				len = i2c_dw_recv_len(dev, *buf);
@@ -724,13 +724,13 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 	if (abort_source & DW_IC_TX_ARB_LOST)
 		return -EAGAIN;
 	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
-		return -EINVAL; /* wrong msgs[] data */
+		return -EINVAL; /* Wrong msgs[] data. */
 	else
 		return -EIO;
 }
 
 /*
- * Prepare controller for a transaction and call i2c_dw_xfer_msg
+ * Prepare controller for a transaction and call i2c_dw_xfer_msg.
  */
 static int
 i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
@@ -761,13 +761,13 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (ret < 0)
 		goto done;
 
-	/* start the transfers */
+	/* Start the transfers. */
 	i2c_dw_xfer_init(dev);
 
-	/* wait for tx to complete */
+	/* Wait for tx to complete. */
 	if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
 		dev_err(dev->dev, "controller timed out\n");
-		/* i2c_dw_init implicitly disables the adapter */
+		/* i2c_dw_init implicitly disables the adapter. */
 		i2c_dw_init(dev);
 		ret = -ETIMEDOUT;
 		goto done;
@@ -788,13 +788,13 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		goto done;
 	}
 
-	/* no error */
+	/* No error. */
 	if (likely(!dev->cmd_err && !dev->status)) {
 		ret = num;
 		goto done;
 	}
 
-	/* We have an error */
+	/* We have an error. */
 	if (dev->cmd_err == DW_IC_ERR_TX_ABRT) {
 		ret = i2c_dw_handle_tx_abort(dev);
 		goto done;
@@ -905,7 +905,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 		/*
 		 * Anytime TX_ABRT is set, the contents of the tx/rx
-		 * buffers are flushed.  Make sure to skip them.
+		 * buffers are flushed. Make sure to skip them.
 		 */
 		dw_writel(dev, 0, DW_IC_INTR_MASK);
 		goto tx_aborted;
@@ -927,7 +927,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
 	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
-		/* workaround to trigger pending interrupt */
+		/* Workaround to trigger pending interrupt. */
 		stat = dw_readl(dev, DW_IC_INTR_MASK);
 		i2c_dw_disable_int(dev);
 		dw_writel(dev, stat, DW_IC_INTR_MASK);
@@ -938,10 +938,10 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 void i2c_dw_disable(struct dw_i2c_dev *dev)
 {
-	/* Disable controller */
+	/* Disable controller. */
 	__i2c_dw_enable_and_wait(dev, false);
 
-	/* Disable all interupts */
+	/* Disable all interupts. */
 	dw_writel(dev, 0, DW_IC_INTR_MASK);
 	dw_readl(dev, DW_IC_CLR_INTR);
 }
@@ -978,7 +978,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	/*
 	 * Test if dynamic TAR update is enabled in this controller by writing
 	 * to IC_10BITADDR_MASTER field in IC_CON: when it is enabled this
-	 * field is read-only so it should not succeed
+	 * field is read-only so it should not succeed.
 	 */
 	reg = dw_readl(dev, DW_IC_CON);
 	dw_writel(dev, reg ^ DW_IC_CON_10BITADDR_MASTER, DW_IC_CON);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 26250b425e2f..3d13a9f0bb7c 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -36,11 +36,10 @@
 #define DW_IC_CON_SPEED_FAST		0x4
 #define DW_IC_CON_SPEED_HIGH		0x6
 #define DW_IC_CON_SPEED_MASK		0x6
-#define DW_IC_CON_10BITADDR_MASTER	0x10
+#define DW_IC_CON_10BITADDR_MASTER		0x10
 #define DW_IC_CON_RESTART_EN		0x20
 #define DW_IC_CON_SLAVE_DISABLE		0x40
 
-
 /**
  * struct dw_i2c_dev - private i2c-designware data
  * @dev: driver model device node
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 08153ea4d848..989ae0299cd0 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -21,26 +21,27 @@
  * ----------------------------------------------------------------------------
  *
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/dmi.h>
-#include <linux/i2c.h>
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_data/i2c-designware.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
-#include <linux/io.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
-#include <linux/platform_data/i2c-designware.h>
+
 #include "i2c-designware-core.h"
 
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
@@ -153,11 +154,11 @@ static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
+	struct dw_i2c_dev *dev;
+	u32 acpi_speed, ht = 0;
 	struct resource *mem;
 	int irq, r;
-	u32 acpi_speed, ht = 0;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -354,7 +355,7 @@ static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 #define DW_I2C_DEV_PMOPS NULL
 #endif
 
-/* work with hotplug and coldplug */
+/* Work with hotplug and coldplug. */
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
-- 
2.11.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
