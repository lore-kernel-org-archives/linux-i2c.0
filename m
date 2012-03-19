From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c-designware: add optional regulator support
Date: Mon, 19 Mar 2012 14:46:20 +0200
Message-ID: <1332161180-32502-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It is possible that some of the i2c busses are supplied by a separate
regulator which needs to be enabled before we can access the bus. Thus add
support for an optional regulator.

We also implement enabling/disabling the regulator on system and runtime PM
hooks.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 37f4211..26bcdf3 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include "i2c-designware-core.h"
 
 #define DRIVER_NAME "i2c-designware-pci"
@@ -62,6 +63,7 @@ struct dw_pci_controller {
 	u32 tx_fifo_depth;
 	u32 rx_fifo_depth;
 	u32 clk_khz;
+	struct regulator *regulator;
 };
 
 #define INTEL_MID_STD_CFG  (DW_IC_CON_MASTER |			\
@@ -144,6 +146,8 @@ static int i2c_dw_pci_suspend(struct device *dev)
 	struct dw_i2c_dev *i2c = pci_get_drvdata(pdev);
 	int err;
 
+	if (i2c->controller->regulator)
+		regulator_disable(i2c->controller->regulator);
 
 	i2c_dw_disable(i2c);
 
@@ -169,6 +173,9 @@ static int i2c_dw_pci_resume(struct device *dev)
 	int err;
 	u32 enabled;
 
+	if (i2c->controller->regulator)
+		regulator_enable(i2c->controller->regulator);
+
 	enabled = i2c_dw_is_enabled(i2c);
 	if (enabled)
 		return 0;
@@ -281,6 +288,12 @@ const struct pci_device_id *id)
 
 	pci_set_drvdata(pdev, dev);
 
+	controller->regulator = regulator_get(&pdev->dev, "v-i2c");
+	if (IS_ERR(controller->regulator))
+		controller->regulator = NULL;
+	else
+		regulator_enable(controller->regulator);
+
 	dev->tx_fifo_depth = controller->tx_fifo_depth;
 	dev->rx_fifo_depth = controller->rx_fifo_depth;
 	r = i2c_dw_init(dev);
@@ -332,11 +345,17 @@ exit:
 static void __devexit i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
+	struct regulator *regulator = dev->controller->regulator;
 
 	i2c_dw_disable(dev);
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
+	if (regulator) {
+		regulator_disable(regulator);
+		regulator_put(regulator);
+	}
+
 	pci_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
-- 
1.7.9.1
