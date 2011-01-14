From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 8/9] i2c-designware-pci: Add runtime power management support
Date: Fri, 14 Jan 2011 11:27:35 -0800
Message-ID: <1295033256-30077-9-git-send-email-dirk.brandewie@gmail.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |   33 +++++++++-
 drivers/i2c/busses/i2c-designware-core.h |    2 +
 drivers/i2c/busses/i2c-designware-pci.c  |  111 +++++++++++++++++++++++++++---
 3 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 746b4bb..e8b354b 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -25,6 +25,7 @@
  * ----------------------------------------------------------------------------
  *
  */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -37,6 +38,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include "i2c-designware-core.h"
 
 static u32 i2c_dw_clk_get_rate(struct dw_i2c_dev *dev)
@@ -418,6 +420,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
+	pm_runtime_get_sync(dev->dev);
 	mutex_lock(&dev->lock);
 
 	INIT_COMPLETION(dev->cmd_complete);
@@ -469,7 +472,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 done:
 	mutex_unlock(&dev->lock);
-
+	pm_runtime_put(dev->dev);
 	return ret;
 }
 EXPORT_SYMBOL(i2c_dw_xfer);
@@ -580,3 +583,31 @@ tx_aborted:
 }
 EXPORT_SYMBOL(i2c_dw_isr);
 
+void i2c_dw_enable(struct dw_i2c_dev *dev)
+{
+	/* Enable the adapter */
+	writel(1, dev->base + DW_IC_ENABLE);
+}
+EXPORT_SYMBOL(i2c_dw_enable);
+
+void i2c_dw_disable(struct dw_i2c_dev *i2c)
+{
+	/* Disable controller */
+	writel(0, i2c->base + DW_IC_ENABLE);
+
+	/* Disable all interupts */
+	writel(0x0000, i2c->base + DW_IC_INTR_MASK);
+
+	/* Clear all interrupts */
+	readl(i2c->base + DW_IC_CLR_INTR);
+	readl(i2c->base + DW_IC_CLR_STOP_DET);
+	readl(i2c->base + DW_IC_CLR_START_DET);
+	readl(i2c->base + DW_IC_CLR_ACTIVITY);
+	readl(i2c->base + DW_IC_CLR_TX_ABRT);
+	readl(i2c->base + DW_IC_CLR_RX_OVER);
+	readl(i2c->base + DW_IC_CLR_RX_UNDER);
+	readl(i2c->base + DW_IC_CLR_TX_OVER);
+	readl(i2c->base + DW_IC_CLR_RX_DONE);
+	readl(i2c->base + DW_IC_CLR_GEN_CALL);
+}
+EXPORT_SYMBOL(i2c_dw_disable);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 148717f..e82b4dd 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -210,3 +210,5 @@ extern u32 i2c_dw_func(struct i2c_adapter *adap);
 extern irqreturn_t i2c_dw_isr(int this_irq, void *dev_id);
 extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
 extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
+extern void i2c_dw_enable(struct dw_i2c_dev *dev);
+extern void i2c_dw_disable(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
index 1d57761..bea467e 100644
--- a/drivers/i2c/busses/i2c-designware-pci.c
+++ b/drivers/i2c/busses/i2c-designware-pci.c
@@ -138,7 +138,88 @@ static struct i2c_algorithm i2c_dw_algo = {
 	.functionality	= i2c_dw_func,
 };
 
-static int __devinit dw_i2c_pci_probe(struct pci_dev *pdev,
+static int i2c_dw_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct dw_i2c_dev *i2c = pci_get_drvdata(pdev);
+	int err;
+
+
+	i2c_dw_disable(i2c);
+
+	err = pci_save_state(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "pci_save_state failed\n");
+		return err;
+	}
+
+	err = pci_set_power_state(pdev, PCI_D3hot);
+	if (err) {
+		dev_err(&pdev->dev, "pci_set_power_state failed\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int i2c_dw_pci_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	dev_dbg(dev, "PCI suspend called\n");
+	return i2c_dw_pci_suspend(pdev, PMSG_SUSPEND);
+}
+
+static int i2c_dw_pci_resume(struct pci_dev *pdev)
+{
+	struct dw_i2c_dev *i2c = pci_get_drvdata(pdev);
+	int err;
+	u32 enabled;
+
+	enabled = dw_readl(i2c, DW_IC_ENABLE);
+	if (enabled)
+		return 0;
+
+	err = pci_set_power_state(pdev, PCI_D0);
+	if (err) {
+		dev_err(&pdev->dev, "pci_set_power_state() failed\n");
+		return err;
+	}
+
+	err = pci_restore_state(pdev);
+	if (err) {
+		dev_err(&pdev->dev, " pci_restore_state() failed\n");
+		return err;
+	}
+
+	i2c_dw_enable(i2c);
+	return 0;
+}
+
+static int i2c_dw_pci_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	dev_dbg(dev, "runtime_resume called\n");
+	return i2c_dw_pci_resume(pdev);
+}
+
+static int i2c_dw_pci_runtime_idle(struct device *dev)
+{
+	int err = pm_schedule_suspend(dev, 500);
+	dev_dbg(dev, "runtime_idle called\n");
+
+	if (err != 0)
+		return 0;
+	return -EBUSY;
+}
+
+
+
+static const struct dev_pm_ops i2c_dw_pm_ops = {
+	.runtime_suspend = i2c_dw_pci_runtime_suspend,
+	.runtime_resume = i2c_dw_pci_runtime_resume,
+	.runtime_idle = i2c_dw_pci_runtime_idle,
+};
+
+static int __devinit i2c_dw_pci_probe(struct pci_dev *pdev,
 const struct pci_device_id *id)
 {
 	struct dw_i2c_dev *dev;
@@ -219,27 +300,28 @@ const struct pci_device_id *id)
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_HWMON;
-	strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
-			sizeof(adap->name));
+	adap->class = 0;
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = &pdev->dev;
-
 	adap->nr = controller->bus_num;
+	snprintf(adap->name, sizeof(adap->name), "i2c-dw-pci-%d",
+		adap->nr);
 
-	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
 	r = request_irq(pdev->irq, i2c_dw_isr, IRQF_SHARED, adap->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
 		goto err_iounmap;
 	}
 
+	dw_readl(dev, DW_IC_CLR_INTR);
+	dw_writel(dev, 0, DW_IC_INTR_MASK); /* disable IRQ */
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
 		goto err_free_irq;
 	}
 
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 
 err_free_irq:
@@ -255,11 +337,15 @@ exit:
 	return r;
 }
 
-static void __devexit dw_i2c_pci_remove(struct pci_dev *pdev)
+static void __devexit i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
-	writel(0, dev->base + DW_IC_ENABLE);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	i2c_dw_disable(dev);
 	pci_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
@@ -291,8 +377,13 @@ MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
 static struct pci_driver dw_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= i2_designware_pci_ids,
-	.probe		= dw_i2c_pci_probe,
-	.remove		= __devexit_p(dw_i2c_pci_remove),
+	.probe		= i2c_dw_pci_probe,
+	.remove		= __devexit_p(i2c_dw_pci_remove),
+	.resume		= i2c_dw_pci_resume,
+	.suspend	= i2c_dw_pci_suspend,
+	.driver		= {
+		.pm	= &i2c_dw_pm_ops,
+	},
 };
 
 static int __init dw_i2c_init_driver(void)
-- 
1.7.3.4
