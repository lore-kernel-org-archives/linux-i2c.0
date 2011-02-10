From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 12/13] i2c-designware: Add runtime power management support
Date: Thu, 10 Feb 2011 08:21:28 -0800
Message-ID: <1297354889-20721-13-git-send-email-dirk.brandewie@gmail.com>
References: <1297354889-20721-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297354889-20721-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add runtime power management to the PCI driver.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c   |    3 +
 drivers/i2c/busses/i2c-designware-pcidrv.c |   86 ++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 666d71c..ba8ee49 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -31,6 +31,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include "i2c-designware-core.h"
 
 /*
@@ -500,6 +501,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
 	mutex_lock(&dev->lock);
+	pm_runtime_get_sync(dev->dev);
 
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->msgs = msgs;
@@ -549,6 +551,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = -EIO;
 
 done:
+	pm_runtime_put(dev->dev);
 	mutex_unlock(&dev->lock);
 
 	return ret;
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 83307ef..9869e21 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include "i2c-designware-core.h"
 
 #define DRIVER_NAME "i2c-designware-pci"
@@ -137,6 +138,81 @@ static struct i2c_algorithm i2c_dw_algo = {
 	.functionality	= i2c_dw_func,
 };
 
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
+	pci_restore_state(pdev);
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
+static const struct dev_pm_ops i2c_dw_pm_ops = {
+	.runtime_suspend = i2c_dw_pci_runtime_suspend,
+	.runtime_resume = i2c_dw_pci_runtime_resume,
+	.runtime_idle = i2c_dw_pci_runtime_idle,
+};
+
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 {
 	return dev->controller->clk_khz;
@@ -264,6 +340,11 @@ static void __devexit i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
+	i2c_dw_disable(dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	pci_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
@@ -297,6 +378,11 @@ static struct pci_driver dw_i2c_driver = {
 	.id_table	= i2_designware_pci_ids,
 	.probe		= i2c_dw_pci_probe,
 	.remove		= __devexit_p(i2c_dw_pci_remove),
+	.resume         = i2c_dw_pci_resume,
+	.suspend        = i2c_dw_pci_suspend,
+	.driver         = {
+		.pm     = &i2c_dw_pm_ops,
+	},
 };
 
 static int __init dw_i2c_init_driver(void)
-- 
1.7.3.4
