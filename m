From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] i2c: xiic: Implement Power management
Date: Mon, 4 Jan 2016 13:20:33 +0530
Message-ID: <1451893834-1066-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:16064
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751340AbcADIXc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 03:23:32 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

Enable power management. This patch enables the clocks
before transfer and disables after the transfer.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 drivers/i2c/busses/i2c-xiic.c |   86 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 0b20449..b464a35 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -37,6 +37,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 
 #define DRIVER_NAME "xiic-i2c"
 
@@ -66,6 +68,7 @@ enum xiic_endian {
  * @endianness: big/little-endian byte order
  */
 struct xiic_i2c {
+	struct device		*dev;
 	void __iomem		*base;
 	wait_queue_head_t	wait;
 	struct i2c_adapter	adap;
@@ -77,6 +80,7 @@ struct xiic_i2c {
 	struct i2c_msg		*rx_msg;
 	int			rx_pos;
 	enum xiic_endian	endianness;
+	struct clk *clk;
 };
 
 
@@ -164,6 +168,7 @@ struct xiic_i2c {
 
 #define XIIC_RESET_MASK             0xAUL
 
+#define XIIC_PM_TIMEOUT		1000	/* ms */
 /*
  * The following constant is used for the device global interrupt enable
  * register, to enable all interrupts for the device, this is the only bit
@@ -676,9 +681,13 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	dev_dbg(adap->dev.parent, "%s entry SR: 0x%x\n", __func__,
 		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET));
 
+	err = pm_runtime_get_sync(i2c->dev);
+	if (err < 0)
+		return err;
+
 	err = xiic_busy(i2c);
 	if (err)
-		return err;
+		goto out;
 
 	i2c->tx_msg = msgs;
 	i2c->nmsgs = num;
@@ -686,14 +695,20 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	xiic_start_xfer(i2c);
 
 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-		(i2c->state == STATE_DONE), HZ))
-		return (i2c->state == STATE_DONE) ? num : -EIO;
-	else {
+		(i2c->state == STATE_DONE), HZ)) {
+		err = (i2c->state == STATE_DONE) ? num : -EIO;
+		goto out;
+	} else {
 		i2c->tx_msg = NULL;
 		i2c->rx_msg = NULL;
 		i2c->nmsgs = 0;
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto out;
 	}
+out:
+	pm_runtime_mark_last_busy(i2c->dev);
+	pm_runtime_put_autosuspend(i2c->dev);
+	return err;
 }
 
 static u32 xiic_func(struct i2c_adapter *adap)
@@ -748,13 +763,26 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(i2c->clk)) {
+		dev_err(&pdev->dev, "input clock not found.\n");
+		return PTR_ERR(i2c->clk);
+	}
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+
+	pm_runtime_enable(i2c->dev);
+	pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(i2c->dev);
+	pm_runtime_set_active(i2c->dev);
 	ret = devm_request_threaded_irq(&pdev->dev, irq, xiic_isr,
 					xiic_process, IRQF_ONESHOT,
 					pdev->name, i2c);
 
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		return ret;
+		goto err_clk_dis;
 	}
 
 	/*
@@ -776,7 +804,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add adapter\n");
 		xiic_deinit(i2c);
-		return ret;
+		goto err_clk_dis;
 	}
 
 	if (pdata) {
@@ -786,16 +814,30 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_clk_dis:
+	clk_disable_unprepare(i2c->clk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int xiic_i2c_remove(struct platform_device *pdev)
 {
 	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+	int ret;
 
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+		return ret;
+	}
 	xiic_deinit(i2c);
+	clk_disable_unprepare(i2c->clk);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
@@ -808,12 +850,42 @@ static const struct of_device_id xiic_of_match[] = {
 MODULE_DEVICE_TABLE(of, xiic_of_match);
 #endif
 
+static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+
+	clk_disable(i2c->clk);
+
+	return 0;
+}
+
+static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_enable(i2c->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops xiic_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
+			   cdns_i2c_runtime_resume, NULL)
+};
 static struct platform_driver xiic_i2c_driver = {
 	.probe   = xiic_i2c_probe,
 	.remove  = xiic_i2c_remove,
 	.driver  = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(xiic_of_match),
+		.pm = &xiic_dev_pm_ops,
 	},
 };
 
-- 
1.7.1
