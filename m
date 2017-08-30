From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v3 4/4] i2c: designware: add i2c gpio recovery option
Date: Wed, 30 Aug 2017 14:17:37 +0800
Message-ID: <1504073857-122449-5-git-send-email-preid@electromag.com.au>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:47409 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750824AbdH3GRp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Aug 2017 02:17:45 -0400
In-Reply-To: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, preid@electromag.com.au, linux-i2c@vger.kernel.org

From: Tim Sander <tim@krieglstein.org>

This patch contains much input from Phil Reid and has been tested
on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
SCL and SDA GPIO's. I am still a little unsure about the recover
in the timeout case (i2c-designware-core.c:770) as i could not
test this codepath.

Signed-off-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-designware-common.c | 11 ++++--
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 drivers/i2c/busses/i2c-designware-master.c | 57 ++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 3d684c6..e3120987 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -230,7 +230,11 @@ int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
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
@@ -254,9 +258,10 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
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
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index fef44b5..8707c76 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -284,6 +284,7 @@ struct dw_i2c_dev {
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
 	int			mode;
+	struct i2c_bus_recovery_info rinfo;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 418c233..07e34fe 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -25,11 +25,13 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "i2c-designware-core.h"
 
@@ -443,6 +445,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
 		dev_err(dev->dev, "controller timed out\n");
 		/* i2c_dw_init implicitly disables the adapter */
+		i2c_recover_bus(&dev->adapter);
 		i2c_dw_init_master(dev);
 		ret = -ETIMEDOUT;
 		goto done;
@@ -613,6 +616,57 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void i2c_dw_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	i2c_dw_disable(dev);
+	reset_control_assert(dev->rst);
+	i2c_dw_prepare_clk(dev, false);
+}
+
+static void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	i2c_dw_prepare_clk(dev, true);
+	reset_control_deassert(dev->rst);
+	i2c_dw_init_master(dev);
+}
+
+static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
+{
+	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
+	struct i2c_adapter *adap = &dev->adapter;
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
 int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
@@ -664,6 +718,9 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 		dev_err(dev->dev, "failure adding adapter: %d\n", ret);
 	pm_runtime_put_noidle(dev->dev);
 
+	if (!ret)
+		ret = i2c_dw_init_recovery_info(dev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_probe);
-- 
1.8.3.1
