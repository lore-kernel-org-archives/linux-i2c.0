From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 08/10] i2c-designware: Push all register reads/writes into the core code.
Date: Wed,  2 Feb 2011 18:20:06 -0800
Message-ID: <1296699608-13227-9-git-send-email-dirk.brandewie@gmail.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296699608-13227-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Move all register manipulation into the core code.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c    |   49 ++++++++++++++++++++++++++-
 drivers/i2c/busses/i2c-designware-core.h    |    6 +++
 drivers/i2c/busses/i2c-designware-pcidrv.c  |    4 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |    6 ++--
 4 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 5452e3b..35960db 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -247,7 +247,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		ic_con |= DW_IC_CON_10BITADDR_MASTER;
 	else
 		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
-	dw_writel(dev->base, ic_con, DW_IC_CON);
+	dw_writel(dev, ic_con, DW_IC_CON);
 
 	/* Enable the adapter */
 	dw_writel(dev, 1, DW_IC_ENABLE);
@@ -571,3 +571,50 @@ tx_aborted:
 	return IRQ_HANDLED;
 }
 
+void i2c_dw_enable(struct dw_i2c_dev *dev)
+{
+       /* Enable the adapter */
+	dw_writel(dev, 1, DW_IC_ENABLE);
+}
+
+
+void i2c_dw_disable(struct dw_i2c_dev *dev)
+{
+	int ret;
+
+	/*
+	 * Disabling DW_apb_i2c
+	 *
+	 * The IC_ENABLE register allows software to immediately shut down
+	 * the DW_apb_i2c hardware, preventing its further participation in
+	 * an I2C subsystem.  The I2C protocol, however, does not allow
+	 * transfers to be abruptly stopped, it's necessary for software to
+	 * manage the correct shutdown of DW_apb_i2c, ensuring no data loss
+	 * or bus lockup occurs.
+	 */
+	ret = i2c_dw_wait_bus_not_busy(dev);
+	if (ret < 0)
+		BUG();
+
+	/* Disable controller */
+	dw_writel(dev, 0, DW_IC_ENABLE);
+
+	/* Disable all interupts */
+	dw_writel(dev, 0, DW_IC_INTR_MASK);
+	dw_readl(dev, DW_IC_CLR_INTR);
+}
+
+void i2c_dw_clear_int(struct dw_i2c_dev *dev)
+{
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
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 8d715b9..2060a53 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -195,3 +195,9 @@ extern int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 		int num);
 extern u32 i2c_dw_func(struct i2c_adapter *adap);
 extern irqreturn_t i2c_dw_isr(int this_irq, void *dev_id);
+extern void i2c_dw_enable(struct dw_i2c_dev *dev);
+extern void i2c_dw_disable(struct dw_i2c_dev *dev);
+extern void i2c_dw_clear_int(struct dw_i2c_dev *dev);
+extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
+extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
+
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f548064..d943318 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -231,8 +231,8 @@ const struct pci_device_id *id)
 		goto err_iounmap;
 	}
 
-	dw_readl(dev, DW_IC_CLR_INTR);
-	dw_writel(dev, 0, DW_IC_INTR_MASK); /* disable IRQ */
+	i2c_dw_disable_int(dev);
+	i2c_dw_clear_int(dev);
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 964494e..dff9b52 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -107,7 +107,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 	{
-		u32 param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
+		u32 param1 = i2c_dw_read_comp_param(dev);
 
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
@@ -116,7 +116,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	if (r)
 		goto err_iounmap;
 
-	dw_writel(dev, 0, DW_IC_INTR_MASK); /* disable IRQ */
+	i2c_dw_disable_int(dev);
 	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
@@ -172,7 +172,7 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
 	clk_put(dev->clk);
 	dev->clk = NULL;
 
-	dw_writel(dev, 0, DW_IC_ENABLE);
+	i2c_dw_disable(dev);
 	free_irq(dev->irq, dev);
 	kfree(dev);
 
-- 
1.7.3.4
