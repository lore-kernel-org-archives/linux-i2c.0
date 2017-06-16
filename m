From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 2/2] i2c: designware: add i2c gpio recovery option
Date: Fri, 16 Jun 2017 15:42:57 +0800
Message-ID: <1497598977-37622-3-git-send-email-preid@electromag.com.au>
References: <1497598977-37622-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:49624 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752369AbdFPHnL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Jun 2017 03:43:11 -0400
In-Reply-To: <1497598977-37622-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

From: Tim Sander <tim@krieglstein.org>

This patch contains much input from Phil Reid and has been tested
on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
SCL and SDA GPIO's. I am still a little unsure about the recover
in the timeout case (i2c-designware-core.c:770) as i could not
test this codepath.

Signed-off-by: Tim Sander <tim@krieglstein.org>
Tested-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-designware-core.c    | 12 ++++--
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 58 +++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 3c41995..9696433 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -463,7 +463,11 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 	while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
 		if (timeout <= 0) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
+			i2c_recover_bus(&dev->adapter);
+
+			if (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY)
+				return -ETIMEDOUT;
+			return 0;
 		}
 		timeout--;
 		usleep_range(1000, 1100);
@@ -719,9 +723,10 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
 		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
 
-	if (abort_source & DW_IC_TX_ARB_LOST)
+	if (abort_source & DW_IC_TX_ARB_LOST) {
+		i2c_recover_bus(&dev->adapter);
 		return -EAGAIN;
-	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
+	} else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
 		return -EINVAL; /* wrong msgs[] data */
 	else
 		return -EIO;
@@ -766,6 +771,7 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 	if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
 		dev_err(dev->dev, "controller timed out\n");
 		/* i2c_dw_init implicitly disables the adapter */
+		i2c_recover_bus(&dev->adapter);
 		i2c_dw_init(dev);
 		ret = -ETIMEDOUT;
 		goto done;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index a7cf429..dc203e4 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -129,6 +129,7 @@ struct dw_i2c_dev {
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_disabled;
+	struct i2c_bus_recovery_info rinfo;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d1263b8..f88c061 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -206,6 +207,59 @@ static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
 	}
 }
 
+static void i2c_dw_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct platform_device *pdev = to_platform_device(&adap->dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	i2c_dw_disable(i_dev);
+	reset_control_assert(i_dev->rst);
+	i2c_dw_plat_prepare_clk(i_dev, false);
+}
+
+static void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct platform_device *pdev = to_platform_device(&adap->dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	i2c_dw_plat_prepare_clk(i_dev, true);
+	reset_control_deassert(i_dev->rst);
+	i2c_dw_init(i_dev);
+}
+
+static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev,
+				     struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
+	struct gpio_desc *gpio;
+	int r;
+
+	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
+		if ((r == -ENOENT) || (r == -ENOENT))
+			return 0;
+		return r;
+	}
+	rinfo->scl_gpiod = gpio;
+
+	gpio = devm_gpiod_get_optional(dev->dev, "sda", GPIOD_IN);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+	rinfo->sda_gpiod = gpio;
+
+	rinfo->recover_bus = i2c_generic_scl_recovery;
+	rinfo->prepare_recovery = i2c_dw_prepare_recovery;
+	rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
+	adap->bus_recovery_info = rinfo;
+
+	dev_info(dev->dev,
+		"adapter: %s running with gpio recovery mode! scl:%i sda:%i\n",
+		adap->name, !!rinfo->scl_gpiod, !!rinfo->sda_gpiod);
+
+	return 0;
+}
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -327,6 +381,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
+	r = i2c_dw_init_recovery_info(dev, adap);
+	if (r == -EPROBE_DEFER)
+		goto exit_probe;
+
 	r = i2c_dw_probe(dev);
 	if (r)
 		goto exit_probe;
-- 
1.8.3.1
