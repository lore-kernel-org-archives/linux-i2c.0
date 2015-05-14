From: Ray Jui <rjui@broadcom.com>
Subject: [PATCH v2] i2c: iproc: Add suspend/resume support
Date: Thu, 14 May 2015 15:36:04 -0700
Message-ID: <1431642964-6948-2-git-send-email-rjui@broadcom.com>
References: <1431642964-6948-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431642964-6948-1-git-send-email-rjui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Add suspend/resume support to the Broadcom iProc I2C driver

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c |   57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index f9f2c20..0419f52 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -91,6 +91,7 @@ struct bcm_iproc_i2c_dev {
 	void __iomem *base;
 
 	struct i2c_adapter adapter;
+	unsigned int bus_speed;
 
 	struct completion done;
 	int xfer_is_done;
@@ -309,6 +310,7 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 		bus_speed = 400000;
 	}
 
+	iproc_i2c->bus_speed = bus_speed;
 	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
 	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
 	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
@@ -439,6 +441,60 @@ static int bcm_iproc_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static int bcm_iproc_i2c_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
+
+	/* make sure there's no pending interrupt when we go into suspend */
+	writel(0, iproc_i2c->base + IE_OFFSET);
+	readl(iproc_i2c->base + IE_OFFSET);
+	synchronize_irq(iproc_i2c->irq);
+
+	/* now disable the controller */
+	bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+
+	return 0;
+}
+
+static int bcm_iproc_i2c_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
+	int ret;
+	u32 val;
+
+	/*
+	 * Power domain could have been shut off completely in system deep
+	 * sleep, so re-initialize the block here
+	 */
+	ret = bcm_iproc_i2c_init(iproc_i2c);
+	if (ret)
+		return ret;
+
+	/* configure to the desired bus speed */
+	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
+	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
+	val |= (iproc_i2c->bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
+	writel(val, iproc_i2c->base + TIM_CFG_OFFSET);
+
+	bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+
+	return 0;
+}
+
+static const struct dev_pm_ops bcm_iproc_i2c_pm_ops = {
+	.suspend_late = &bcm_iproc_i2c_suspend,
+	.resume_early = &bcm_iproc_i2c_resume
+};
+
+#define BCM_IPROC_I2C_PM_OPS (&bcm_iproc_i2c_pm_ops)
+#else
+#define BCM_IPROC_I2C_PM_OPS NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct of_device_id bcm_iproc_i2c_of_match[] = {
 	{ .compatible = "brcm,iproc-i2c" },
 	{ /* sentinel */ }
@@ -449,6 +505,7 @@ static struct platform_driver bcm_iproc_i2c_driver = {
 	.driver = {
 		.name = "bcm-iproc-i2c",
 		.of_match_table = bcm_iproc_i2c_of_match,
+		.pm = BCM_IPROC_I2C_PM_OPS,
 	},
 	.probe = bcm_iproc_i2c_probe,
 	.remove = bcm_iproc_i2c_remove,
-- 
1.7.9.5
