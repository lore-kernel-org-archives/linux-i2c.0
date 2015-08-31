From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 6/6] i2c: designware: Move common probe code into i2c_dw_probe()
Date: Mon, 31 Aug 2015 17:31:33 +0300
Message-ID: <1441031493-18938-7-git-send-email-jarkko.nikula@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441031493-18938-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is some code duplication in i2c-designware-platdrv and
i2c-designware-pcidrv probe functions. What is even worse that duplication
requires i2c_dw_xfer(), i2c_dw_func() and i2c_dw_isr() i2c-designware-core
functions to be exported.

Therefore move common code into new i2c_dw_probe() and make functions above
local to i2c-designware-core.

While merging the code patch does following functional changes:

- I2C Adapter name will be "i2c-designware". Previously adapter name was
  "Synopsys DesignWare I2C adapter" for platform and ACPI devices and
  "i2c-designware-pci" for PCI devices.
- Interrupt name too will be "i2c-designware". Previous it was platform
  device name, ACPI device name or "i2c-designware-pci".
- Error code from devm_request_irq() and i2c_add_numbered_adapter() will be
  printed in case of error.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c    | 48 +++++++++++++++++++++++++----
 drivers/i2c/busses/i2c-designware-core.h    |  5 +--
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 30 ++----------------
 drivers/i2c/busses/i2c-designware-platdrv.c | 28 ++---------------
 4 files changed, 48 insertions(+), 63 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 52272a01c679..501c8ac0cf14 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -618,7 +618,7 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 /*
  * Prepare controller for a transaction and call i2c_dw_xfer_msg
  */
-int
+static int
 i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
@@ -702,14 +702,17 @@ done_nolock:
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i2c_dw_xfer);
 
-u32 i2c_dw_func(struct i2c_adapter *adap)
+static u32 i2c_dw_func(struct i2c_adapter *adap)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	return dev->functionality;
 }
-EXPORT_SYMBOL_GPL(i2c_dw_func);
+
+static struct i2c_algorithm i2c_dw_algo = {
+	.master_xfer	= i2c_dw_xfer,
+	.functionality	= i2c_dw_func,
+};
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
@@ -770,7 +773,7 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
  * Interrupt service routine. This gets called whenever an I2C interrupt
  * occurs.
  */
-irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
+static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 {
 	struct dw_i2c_dev *dev = dev_id;
 	u32 stat, enabled;
@@ -813,7 +816,6 @@ tx_aborted:
 
 	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL_GPL(i2c_dw_isr);
 
 void i2c_dw_disable(struct dw_i2c_dev *dev)
 {
@@ -838,5 +840,39 @@ u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
 
+int i2c_dw_probe(struct dw_i2c_dev *dev)
+{
+	struct i2c_adapter *adap = &dev->adapter;
+	int r;
+
+	init_completion(&dev->cmd_complete);
+	mutex_init(&dev->lock);
+
+	r = i2c_dw_init(dev);
+	if (r)
+		return r;
+
+	snprintf(adap->name, sizeof(adap->name), "i2c-designware");
+	adap->algo = &i2c_dw_algo;
+	adap->dev.parent = dev->dev;
+	i2c_set_adapdata(adap, dev);
+
+	i2c_dw_disable_int(dev);
+	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, IRQF_SHARED,
+			     adap->name, dev);
+	if (r) {
+		dev_err(dev->dev, "failure requesting irq %i: %d\n",
+			dev->irq, r);
+		return r;
+	}
+
+	r = i2c_add_numbered_adapter(adap);
+	if (r)
+		dev_err(dev->dev, "failure adding adapter: %d\n", r);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(i2c_dw_probe);
+
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 0e73b8672402..1d50898e7b24 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -113,13 +113,10 @@ struct dw_i2c_dev {
 #define ACCESS_16BIT		0x00000002
 
 extern int i2c_dw_init(struct dw_i2c_dev *dev);
-extern int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
-		int num);
-extern u32 i2c_dw_func(struct i2c_adapter *adap);
-extern irqreturn_t i2c_dw_isr(int this_irq, void *dev_id);
 extern void i2c_dw_disable(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
+extern int i2c_dw_probe(struct dw_i2c_dev *dev);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 extern int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index d9e8937f062f..169be1e26241 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -158,11 +158,6 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 	},
 };
 
-static struct i2c_algorithm i2c_dw_algo = {
-	.master_xfer	= i2c_dw_xfer,
-	.functionality	= i2c_dw_func,
-};
-
 #ifdef CONFIG_PM
 static int i2c_dw_pci_suspend(struct device *dev)
 {
@@ -222,13 +217,12 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	if (!dev)
 		return -ENOMEM;
 
-	init_completion(&dev->cmd_complete);
-	mutex_init(&dev->lock);
 	dev->clk = NULL;
 	dev->controller = controller;
 	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 	dev->base = pcim_iomap_table(pdev)[0];
 	dev->dev = &pdev->dev;
+	dev->irq = pdev->irq;
 	dev->functionality = controller->functionality |
 				DW_DEFAULT_FUNCTIONALITY;
 
@@ -246,33 +240,15 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	dev->tx_fifo_depth = controller->tx_fifo_depth;
 	dev->rx_fifo_depth = controller->rx_fifo_depth;
-	r = i2c_dw_init(dev);
-	if (r)
-		return r;
 
 	adap = &dev->adapter;
-	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = 0;
-	adap->algo = &i2c_dw_algo;
-	adap->dev.parent = &pdev->dev;
 	adap->nr = controller->bus_num;
 
-	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci");
-
-	i2c_dw_disable_int(dev);
-	r = devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr,
-			IRQF_SHARED | IRQF_COND_SUSPEND, adap->name, dev);
-	if (r) {
-		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
-		return r;
-	}
-
-	r = i2c_add_numbered_adapter(adap);
-	if (r) {
-		dev_err(&pdev->dev, "failure adding adapter\n");
+	r = i2c_dw_probe(dev);
+	if (r)
 		return r;
-	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 	pm_runtime_use_autosuspend(&pdev->dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 17167cd4812d..adcf4c3a81f0 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -41,10 +41,6 @@
 #include <linux/platform_data/i2c-designware.h>
 #include "i2c-designware-core.h"
 
-static struct i2c_algorithm i2c_dw_algo = {
-	.master_xfer	= i2c_dw_xfer,
-	.functionality	= i2c_dw_func,
-};
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 {
 	return clk_get_rate(dev->clk)/1000;
@@ -155,8 +151,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->base))
 		return PTR_ERR(dev->base);
 
-	init_completion(&dev->cmd_complete);
-	mutex_init(&dev->lock);
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
@@ -231,33 +225,15 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
 		dev->adapter.nr = pdev->id;
 	}
-	r = i2c_dw_init(dev);
-	if (r)
-		return r;
-
-	i2c_dw_disable_int(dev);
-	r = devm_request_irq(&pdev->dev, dev->irq, i2c_dw_isr, IRQF_SHARED,
-			pdev->name, dev);
-	if (r) {
-		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
-		return r;
-	}
 
 	adap = &dev->adapter;
-	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
-	strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
-			sizeof(adap->name));
-	adap->algo = &i2c_dw_algo;
-	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
-	r = i2c_add_numbered_adapter(adap);
-	if (r) {
-		dev_err(&pdev->dev, "failure adding adapter\n");
+	r = i2c_dw_probe(dev);
+	if (r)
 		return r;
-	}
 
 	if (dev->pm_runtime_disabled) {
 		pm_runtime_forbid(&pdev->dev);
-- 
2.5.0
