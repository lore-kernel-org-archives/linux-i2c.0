From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v3 3/4] i2c: designware: rename i2c_dw_plat_prepare_clk to i2c_dw_prepare_clk
Date: Wed, 30 Aug 2017 14:17:36 +0800
Message-ID: <1504073857-122449-4-git-send-email-preid@electromag.com.au>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:45732 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750835AbdH3GRo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Aug 2017 02:17:44 -0400
In-Reply-To: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, preid@electromag.com.au, linux-i2c@vger.kernel.org

For consistency with the reset of the file rename function and parameter to
be consistent with the reset of the common file.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-designware-common.c  | 10 +++++-----
 drivers/i2c/busses/i2c-designware-core.h    |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index b79f342..3d684c6 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -186,15 +186,15 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 	return dev->get_clk_rate_khz(dev);
 }
 
-int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
+int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
 {
-	if (IS_ERR(i_dev->clk))
-		return PTR_ERR(i_dev->clk);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
 	if (prepare)
-		return clk_prepare_enable(i_dev->clk);
+		return clk_prepare_enable(dev->clk);
 
-	clk_disable_unprepare(i_dev->clk);
+	clk_disable_unprepare(dev->clk);
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b2a31cb..fef44b5 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -299,7 +299,7 @@ struct dw_i2c_dev {
 void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable);
 void __i2c_dw_enable_and_wait(struct dw_i2c_dev *dev, bool enable);
 unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev);
-int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare);
+int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare);
 int i2c_dw_acquire_lock(struct dw_i2c_dev *dev);
 void i2c_dw_release_lock(struct dw_i2c_dev *dev);
 int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 14e7fab..58f55a8 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -325,7 +325,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		i2c_dw_configure_master(dev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!i2c_dw_plat_prepare_clk(dev, true)) {
+	if (!i2c_dw_prepare_clk(dev, true)) {
 		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 
 		if (!dev->sda_hold_time && ht)
@@ -422,7 +422,7 @@ static int dw_i2c_plat_runtime_suspend(struct device *dev)
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
 	i_dev->disable(i_dev);
-	i2c_dw_plat_prepare_clk(i_dev, false);
+	i2c_dw_prepare_clk(i_dev, false);
 
 	return 0;
 }
@@ -431,7 +431,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
-	i2c_dw_plat_prepare_clk(i_dev, true);
+	i2c_dw_prepare_clk(i_dev, true);
 	i_dev->init(i_dev);
 
 	return 0;
-- 
1.8.3.1
