From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv3 1/2] i2c: cadence: Move to sensible power management
Date: Tue, 24 Nov 2015 13:01:56 +0530
Message-ID: <1448350317-37077-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:61952
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752034AbbKXHr4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 24 Nov 2015 02:47:56 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: soren.brinkmann@xilinx.com, michal.simek@xilinx.com, anirudh@xilinx.com, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

Currently the clocks are enabled at probe and disabled at remove.
Which keeps the clocks enabled even if no transaction is going on.
This patch enables the clocks at the start of transfer and disables
after it.

Also adapts to runtime pm.

converts dev pm to const to silence a checkpatch warning.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
v2: update the cc list
v3: split the runtime and the suspended flag change

 drivers/i2c/busses/i2c-cadence.c |   66 ++++++++++++++++++++++++++------------
 1 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 84deed6..d54ad46 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 /* Register offsets for the I2C device. */
 #define CDNS_I2C_CR_OFFSET		0x00 /* Control Register, RW */
@@ -96,6 +97,8 @@
 					 CDNS_I2C_IXR_COMP)
 
 #define CDNS_I2C_TIMEOUT		msecs_to_jiffies(1000)
+/* timeout for pm runtime autosuspend */
+#define CNDS_I2C_PM_TIMEOUT		1000	/* ms */
 
 #define CDNS_I2C_FIFO_DEPTH		16
 /* FIFO depth at which the DATA interrupt occurs */
@@ -141,6 +144,7 @@
  * @quirks:		flag for broken hold bit usage in r1p10
  */
 struct cdns_i2c {
+	struct device		*dev;
 	void __iomem *membase;
 	struct i2c_adapter adap;
 	struct i2c_msg *p_msg;
@@ -569,9 +573,14 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	struct cdns_i2c *id = adap->algo_data;
 	bool hold_quirk;
 
+	ret = pm_runtime_get_sync(id->dev);
+	if (ret < 0)
+		return ret;
 	/* Check if the bus is free */
-	if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA)
-		return -EAGAIN;
+	if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA) {
+		ret = -EAGAIN;
+		goto out;
+	}
 
 	hold_quirk = !!(id->quirks & CDNS_I2C_BROKEN_HOLD_BIT);
 	/*
@@ -590,7 +599,8 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			if (msgs[count].flags & I2C_M_RD) {
 				dev_warn(adap->dev.parent,
 					 "Can't do repeated start after a receive message\n");
-				return -EOPNOTSUPP;
+				ret = -EOPNOTSUPP;
+				goto out;
 			}
 		}
 		id->bus_hold_flag = 1;
@@ -608,20 +618,26 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 		ret = cdns_i2c_process_msg(id, msgs, adap);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Report the other error interrupts to application */
 		if (id->err_status) {
 			cdns_i2c_master_reset(adap);
 
-			if (id->err_status & CDNS_I2C_IXR_NACK)
-				return -ENXIO;
-
-			return -EIO;
+			if (id->err_status & CDNS_I2C_IXR_NACK) {
+				ret = -ENXIO;
+				goto out;
+			}
+			ret = -EIO;
+			goto out;
 		}
 	}
 
-	return num;
+	ret = num;
+out:
+	pm_runtime_mark_last_busy(id->dev);
+	pm_runtime_put_autosuspend(id->dev);
+	return ret;
 }
 
 /**
@@ -808,10 +824,9 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
  *
  * Return: 0 always
  */
-static int __maybe_unused cdns_i2c_suspend(struct device *_dev)
+static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(_dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
 
 	clk_disable(xi2c->clk);
@@ -828,16 +843,15 @@ static int __maybe_unused cdns_i2c_suspend(struct device *_dev)
  *
  * Return: 0 on success and error value on error
  */
-static int __maybe_unused cdns_i2c_resume(struct device *_dev)
+static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = container_of(_dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
 	int ret;
 
 	ret = clk_enable(xi2c->clk);
 	if (ret) {
-		dev_err(_dev, "Cannot enable clock.\n");
+		dev_err(dev, "Cannot enable clock.\n");
 		return ret;
 	}
 
@@ -846,8 +860,10 @@ static int __maybe_unused cdns_i2c_resume(struct device *_dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cdns_i2c_dev_pm_ops, cdns_i2c_suspend,
-			 cdns_i2c_resume);
+static const struct dev_pm_ops cdns_i2c_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
+			   cdns_i2c_runtime_resume, NULL)
+};
 
 static const struct cdns_platform_data r1p10_i2c_def = {
 	.quirks = CDNS_I2C_BROKEN_HOLD_BIT,
@@ -881,6 +897,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	if (!id)
 		return -ENOMEM;
 
+	id->dev = &pdev->dev;
 	platform_set_drvdata(pdev, id);
 
 	match = of_match_node(cdns_i2c_of_match, pdev->dev.of_node);
@@ -913,10 +930,14 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(id->clk);
 	}
 	ret = clk_prepare_enable(id->clk);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "Unable to enable clock.\n");
-		return ret;
-	}
+
+	pm_runtime_enable(id->dev);
+	pm_runtime_set_autosuspend_delay(id->dev, CNDS_I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(id->dev);
+	pm_runtime_set_active(id->dev);
+
 	id->clk_rate_change_nb.notifier_call = cdns_i2c_clk_notifier_cb;
 	if (clk_notifier_register(id->clk, &id->clk_rate_change_nb))
 		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
@@ -966,6 +987,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 
 err_clk_dis:
 	clk_disable_unprepare(id->clk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
@@ -984,6 +1007,7 @@ static int cdns_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&id->adap);
 	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
 	clk_disable_unprepare(id->clk);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
1.7.1
