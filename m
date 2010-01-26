From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 5/6] i2c: davinci: Add cpufreq support
Date: Tue, 26 Jan 2010 15:41:32 -0800
Message-ID: <1264549293-25556-6-git-send-email-khilman@deeprootsystems.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264549293-25556-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>

Add cpufreq support for DaVinci I2C driver.
Tested on DA850/OMAP-L138 EVM. For the purpose of testing, the patches
which add cpufreq support [1] for this SoC are needed.

[1]http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
2009-September/016118.html

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   63 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 66b07bf..35f9daa 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/cpufreq.h>
 
 #include <mach/hardware.h>
 #include <mach/i2c.h>
@@ -106,6 +107,10 @@ struct davinci_i2c_dev {
 	int			stop;
 	u8			terminate;
 	struct i2c_adapter	adapter;
+#ifdef CONFIG_CPU_FREQ
+	struct completion	xfr_complete;
+	struct notifier_block	freq_transition;
+#endif
 };
 
 /* default platform data to use if not supplied in the platform_device */
@@ -388,6 +393,11 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		if (ret < 0)
 			return ret;
 	}
+
+#ifdef CONFIG_CPU_FREQ
+	complete(&dev->xfr_complete);
+#endif
+
 	return num;
 }
 
@@ -520,6 +530,48 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }
 
+#ifdef CONFIG_CPU_FREQ
+static int i2c_davinci_cpufreq_transition(struct notifier_block *nb,
+				     unsigned long val, void *data)
+{
+	struct davinci_i2c_dev *dev;
+
+	dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
+	if (val == CPUFREQ_PRECHANGE) {
+		wait_for_completion(&dev->xfr_complete);
+		davinci_i2c_reset_ctrl(dev, 0);
+	} else if (val == CPUFREQ_POSTCHANGE) {
+		i2c_davinci_calc_clk_dividers(dev);
+		davinci_i2c_reset_ctrl(dev, 1);
+	}
+
+	return 0;
+}
+
+static inline int i2c_davinci_cpufreq_register(struct davinci_i2c_dev *dev)
+{
+	dev->freq_transition.notifier_call = i2c_davinci_cpufreq_transition;
+
+	return cpufreq_register_notifier(&dev->freq_transition,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+static inline void i2c_davinci_cpufreq_deregister(struct davinci_i2c_dev *dev)
+{
+	cpufreq_unregister_notifier(&dev->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+#else
+static inline int i2c_davinci_cpufreq_register(struct davinci_i2c_dev *dev)
+{
+	return 0;
+}
+
+static inline void i2c_davinci_cpufreq_deregister(struct davinci_i2c_dev *dev)
+{
+}
+#endif
+
 static struct i2c_algorithm i2c_davinci_algo = {
 	.master_xfer	= i2c_davinci_xfer,
 	.functionality	= i2c_davinci_func,
@@ -559,6 +611,9 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&dev->cmd_complete);
+#ifdef CONFIG_CPU_FREQ
+	init_completion(&dev->xfr_complete);
+#endif
 	dev->dev = get_device(&pdev->dev);
 	dev->irq = irq->start;
 	platform_set_drvdata(pdev, dev);
@@ -584,6 +639,12 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
+	r = i2c_davinci_cpufreq_register(dev);
+	if (r) {
+		dev_err(&pdev->dev, "failed to register cpufreq\n");
+		goto err_free_irq;
+	}
+
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -625,6 +686,8 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
 	struct resource *mem;
 
+	i2c_davinci_cpufreq_deregister(dev);
+
 	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
-- 
1.6.6
