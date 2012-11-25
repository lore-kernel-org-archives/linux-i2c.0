From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V7 2/2] i2c/designware: Provide i2c bus recovery support
Date: Sun, 25 Nov 2012 12:01:56 +0530
Message-ID: <953d1cb8469ce19c92da447fd4ffac66e31da705.1353824555.git.viresh.kumar@linaro.org>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add bus recovery support for designware_i2c controller. It uses generic gpio
based i2c_gpio_recover_bus() routine. Platforms need to pass struct
i2c_bus_recovery_info as platform data designware I2C controller.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
V6->V7:
- removed include/linux/i2c/i2c-designware.h and use struct
  i2c_bus_recovery_info as platform data.
- initialize recover_bus with i2c_generic_gpio_recovery()

 drivers/i2c/busses/i2c-designware-core.c    |  6 +++++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index cbba7db..24feaaf 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -538,7 +538,11 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
 	if (ret == 0) {
 		dev_err(dev->dev, "controller timed out\n");
-		i2c_dw_init(dev);
+		if (adap->bus_recovery_info) {
+			dev_dbg(dev->dev, "try i2c bus recovery\n");
+			adap->bus_recovery_info->recover_bus(adap);
+		}
+
 		ret = -ETIMEDOUT;
 		goto done;
 	} else if (ret < 0)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0506fef..c7725b2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -55,6 +55,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem, *ioarea;
+	struct i2c_bus_recovery_info *recovery_info;
 	int irq, r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -141,17 +142,28 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
+	/* Bus recovery support */
+	recovery_info = dev_get_platdata(&pdev->dev);
+	if (recovery_info) {
+		recovery_info->recover_bus = i2c_generic_gpio_recovery;
+		recovery_info->clock_rate_khz = clk_get_rate(dev->clk) / 1000;
+		adap->bus_recovery_info = recovery_info;
+	} else {
+		adap->bus_recovery_info = NULL;
+	}
+
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
-		goto err_free_irq;
+		goto err_free_recovery_info;
 	}
 	of_i2c_register_devices(adap);
 
 	return 0;
 
-err_free_irq:
+err_free_recovery_info:
+	kfree(recovery_info);
 	free_irq(dev->irq, dev);
 err_iounmap:
 	iounmap(dev->base);
@@ -174,6 +186,8 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	struct resource *mem;
 
+	kfree(dev->adapter.bus_recovery_info);
+
 	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
-- 
1.7.12.rc2.18.g61b472e
