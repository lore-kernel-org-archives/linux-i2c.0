From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/6] i2c: designware: Remove interrupt clearing from i2c_dw_pci_probe()
Date: Mon, 31 Aug 2015 17:31:28 +0300
Message-ID: <1441031493-18938-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441031493-18938-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no need to clear interrupts in i2c_dw_pci_probe() since only place
where interrupts are unmasked is i2c_dw_xfer_init() and there interrupts
are always cleared after commit 2a2d95e9d6d2 ("i2c: designware: always
clear interrupts before enabling them").

This allows to cleanup the code and replace i2c_dw_clear_int() in
i2c_dw_xfer_init() by direct register read as there are no other callers.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c   | 8 +-------
 drivers/i2c/busses/i2c-designware-core.h   | 1 -
 drivers/i2c/busses/i2c-designware-pcidrv.c | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 7441cdc1b34a..dec0af7d0471 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -438,7 +438,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	__i2c_dw_enable(dev, true);
 
 	/* Clear and enable interrupts */
-	i2c_dw_clear_int(dev);
+	dw_readl(dev, DW_IC_CLR_INTR);
 	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
 }
 
@@ -839,12 +839,6 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_disable);
 
-void i2c_dw_clear_int(struct dw_i2c_dev *dev)
-{
-	dw_readl(dev, DW_IC_CLR_INTR);
-}
-EXPORT_SYMBOL_GPL(i2c_dw_clear_int);
-
 void i2c_dw_disable_int(struct dw_i2c_dev *dev)
 {
 	dw_writel(dev, 0, DW_IC_INTR_MASK);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9630222abf32..f44aeeeb91c6 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -122,7 +122,6 @@ extern irqreturn_t i2c_dw_isr(int this_irq, void *dev_id);
 extern void i2c_dw_enable(struct dw_i2c_dev *dev);
 extern u32 i2c_dw_is_enabled(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable(struct dw_i2c_dev *dev);
-extern void i2c_dw_clear_int(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index df23e8c30e6f..e477dddcdae5 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -268,7 +268,6 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	}
 
 	i2c_dw_disable_int(dev);
-	i2c_dw_clear_int(dev);
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
-- 
2.5.0
