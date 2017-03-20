From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v7 1/6] i2c: designware: Cleaning and comment style fixes.
Date: Mon, 20 Mar 2017 11:10:40 +0000
Message-ID: <a0d64c4d31674e3948e50d649e35a780056e89c7.1490007620.git.lolivei@synopsys.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490007620.git.lolivei@synopsys.com>
In-Reply-To: <cover.1490007620.git.lolivei@synopsys.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

The purpose of this commit is to fix some comments and styling in the
existing code due to the need of reuse this code. What is being made
here is:

- Sorted the headers files
- Corrected some comments style (capital letters, lowcase i2c)
- Reverse tree in the variables declaration
- Add/remove empty lines and tabs where needed
- Fix of misspelled word "endianness" and "transferred"
- Replaced the return variable "r" with the more standard "ret"

The value of this, besides the rules of coding style, is because I
will use this code after and it will make my future patch a lot bigger and
complicated to review. The work here won't bring any additional work to
backported fixes because is just style and reordering.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v6-v7
- no changes

 drivers/i2c/busses/i2c-designware-core.c    | 80 ++++++++++++++---------------
 drivers/i2c/busses/i2c-designware-core.h    |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c | 43 ++++++++--------
 3 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 7a3faa551cf8..46937865ef8f 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -21,17 +21,17 @@
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
-#include "i2c-designware-core.h"
+#include <linux/pm_runtime.h>
 
+#include "i2c-designware-core.h"
 /*
  * Registers offset
  */
@@ -98,7 +98,7 @@
 
 #define DW_IC_ERR_TX_ABRT	0x1
 
-#define DW_IC_TAR_10BITADDR_MASTER BIT(12)
+#define DW_IC_TAR_10BITADDR_MASTER		BIT(12)
 
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH	(BIT(2) | BIT(3))
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_MASK	GENMASK(3, 2)
@@ -113,10 +113,10 @@
 #define TIMEOUT			20 /* ms */
 
 /*
- * hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
+ * Hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
  *
- * only expected abort codes are listed here
- * refer to the datasheet for the full list
+ * Only expected abort codes are listed here,
+ * refer to the datasheet for the full list.
  */
 #define ABRT_7B_ADDR_NOACK	0
 #define ABRT_10ADDR1_NOACK	1
@@ -318,7 +318,7 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
 }
 
 /**
- * i2c_dw_init() - initialize the designware i2c master hardware
+ * i2c_dw_init() - Initialize the designware I2C master hardware
  * @dev: device private data
  *
  * This functions configures and enables the I2C master.
@@ -338,14 +338,14 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
-		/* Configure register endianess access */
+		/* Configure register endianness access */
 		dev->accessor_flags |= ACCESS_SWAP;
 	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
 		/* Configure register access mode 16bit */
 		dev->accessor_flags |= ACCESS_16BIT;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
-		dev_err(dev->dev, "Unknown Synopsys component type: "
-			"0x%08x\n", reg);
+		dev_err(dev->dev,
+			"Unknown Synopsys component type: 0x%08x\n", reg);
 		i2c_dw_release_lock(dev);
 		return -ENODEV;
 	}
@@ -355,7 +355,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	/* Disable the adapter */
 	__i2c_dw_enable_and_wait(dev, false);
 
-	/* set standard and fast speed deviders for high/low periods */
+	/* Set standard and fast speed deviders for high/low periods */
 
 	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
 	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
@@ -444,7 +444,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
 	dw_writel(dev, 0, DW_IC_RX_TL);
 
-	/* configure the i2c master */
+	/* Configure the I2C master */
 	dw_writel(dev, dev->master_cfg , DW_IC_CON);
 
 	i2c_dw_release_lock(dev);
@@ -480,7 +480,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	/* Disable the adapter */
 	__i2c_dw_enable_and_wait(dev, false);
 
-	/* if the slave address is ten bit address, enable 10BITADDR */
+	/* If the slave address is ten bit address, enable 10BITADDR */
 	ic_con = dw_readl(dev, DW_IC_CON);
 	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
 		ic_con |= DW_IC_CON_10BITADDR_MASTER;
@@ -503,7 +503,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	 */
 	dw_writel(dev, msgs[dev->msg_write_idx].addr | ic_tar, DW_IC_TAR);
 
-	/* enforce disabled interrupts (due to HW issues) */
+	/* Enforce disabled interrupts (due to HW issues) */
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
@@ -537,9 +537,9 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
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
@@ -599,7 +599,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
 
-				/* avoid rx buffer overrun */
+				/* Avoid rx buffer overrun */
 				if (dev->rx_outstanding >= dev->rx_fifo_depth)
 					break;
 
@@ -728,7 +728,7 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 }
 
 /*
- * Prepare controller for a transaction and call i2c_dw_xfer_msg
+ * Prepare controller for a transaction and call i2c_dw_xfer_msg.
  */
 static int
 i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
@@ -759,10 +759,10 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (ret < 0)
 		goto done;
 
-	/* start the transfers */
+	/* Start the transfers */
 	i2c_dw_xfer_init(dev);
 
-	/* wait for tx to complete */
+	/* Wait for tx to complete */
 	if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
 		dev_err(dev->dev, "controller timed out\n");
 		/* i2c_dw_init implicitly disables the adapter */
@@ -786,7 +786,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		goto done;
 	}
 
-	/* no error */
+	/* No error */
 	if (likely(!dev->cmd_err && !dev->status)) {
 		ret = num;
 		goto done;
@@ -821,8 +821,8 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm i2c_dw_algo = {
-	.master_xfer	= i2c_dw_xfer,
-	.functionality	= i2c_dw_func,
+	.master_xfer = i2c_dw_xfer,
+	.functionality = i2c_dw_func,
 };
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
@@ -903,7 +903,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 		/*
 		 * Anytime TX_ABRT is set, the contents of the tx/rx
-		 * buffers are flushed.  Make sure to skip them.
+		 * buffers are flushed. Make sure to skip them.
 		 */
 		dw_writel(dev, 0, DW_IC_INTR_MASK);
 		goto tx_aborted;
@@ -925,7 +925,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
 	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
-		/* workaround to trigger pending interrupt */
+		/* Workaround to trigger pending interrupt */
 		stat = dw_readl(dev, DW_IC_INTR_MASK);
 		i2c_dw_disable_int(dev);
 		dw_writel(dev, stat, DW_IC_INTR_MASK);
@@ -960,13 +960,13 @@ EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
 int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
-	int r;
-
+	int ret;
+	
 	init_completion(&dev->cmd_complete);
 
-	r = i2c_dw_init(dev);
-	if (r)
-		return r;
+	ret = i2c_dw_init(dev);
+	if (ret)
+		return ret;
 
 	snprintf(adap->name, sizeof(adap->name),
 		 "Synopsys DesignWare I2C adapter");
@@ -976,13 +976,13 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	i2c_set_adapdata(adap, dev);
 
 	i2c_dw_disable_int(dev);
-	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
+	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
 			     IRQF_SHARED | IRQF_COND_SUSPEND,
 			     dev_name(dev->dev), dev);
-	if (r) {
+	if (ret) {
 		dev_err(dev->dev, "failure requesting irq %i: %d\n",
-			dev->irq, r);
-		return r;
+			dev->irq, ret);
+		return ret;
 	}
 
 	/*
@@ -992,12 +992,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	 * registered I2C slaves that do I2C transfers in their probe.
 	 */
 	pm_runtime_get_noresume(dev->dev);
-	r = i2c_add_numbered_adapter(adap);
-	if (r)
-		dev_err(dev->dev, "failure adding adapter: %d\n", r);
+	ret = i2c_add_numbered_adapter(adap);
+	if (ret)
+		dev_err(dev->dev, "failure adding adapter: %d\n", ret);
 	pm_runtime_put_noidle(dev->dev);
 
-	return r;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_probe);
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index d9aaf1790e0e..426e7f4a23bd 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -48,7 +48,7 @@
  * @cmd_complete: tx completion indicator
  * @clk: input reference clock
  * @cmd_err: run time hadware error code
- * @msgs: points to an array of messages currently being transfered
+ * @msgs: points to an array of messages currently being transferred
  * @msgs_num: the number of elements in msgs
  * @msg_write_idx: the element index of the current tx message in the msgs
  *	array
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 79c4b4ea0539..41fcfc645781 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -21,27 +21,28 @@
  * ----------------------------------------------------------------------------
  *
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
-#include <linux/i2c.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/errno.h>
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
 #include <linux/reset.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
-#include <linux/platform_data/i2c-designware.h>
+
 #include "i2c-designware-core.h"
 
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
@@ -177,11 +178,11 @@ static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem;
-	int irq, r;
+	struct dw_i2c_dev *dev;
 	u32 acpi_speed, ht = 0;
+	struct resource *mem;
+	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -244,12 +245,12 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	    && dev->clk_freq != 1000000 && dev->clk_freq != 3400000) {
 		dev_err(&pdev->dev,
 			"Only 100kHz, 400kHz, 1MHz and 3.4MHz supported");
-		r = -EINVAL;
+		ret = -EINVAL;
 		goto exit_reset;
 	}
 
-	r = i2c_dw_eval_lock_support(dev);
-	if (r)
+	ret = i2c_dw_eval_lock_support(dev);
+	if (ret)
 		goto exit_reset;
 
 	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
@@ -295,11 +296,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
-	r = i2c_dw_probe(dev);
-	if (r)
+	ret = i2c_dw_probe(dev);
+	if (ret)
 		goto exit_probe;
 
-	return r;
+	return ret;
 
 exit_probe:
 	if (!dev->pm_runtime_disabled)
@@ -307,7 +308,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 exit_reset:
 	if (!IS_ERR_OR_NULL(dev->rst))
 		reset_control_assert(dev->rst);
-	return r;
+	return ret;
 }
 
 static int dw_i2c_plat_remove(struct platform_device *pdev)
@@ -391,7 +392,7 @@ static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 #define DW_I2C_DEV_PMOPS NULL
 #endif
 
-/* work with hotplug and coldplug */
+/* Work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
-- 
2.11.0
