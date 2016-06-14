From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/10] i2c: designware-platdrv: Unconditionally enable runtime PM
Date: Tue, 14 Jun 2016 17:07:21 +0200
Message-ID: <1465916848-8207-4-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33263 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcFNPHz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Jun 2016 11:07:55 -0400
Received: by mail-lf0-f53.google.com with SMTP id f6so85411978lfg.0
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jun 2016 08:07:54 -0700 (PDT)
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

In cases when the designware specific flag "pm_runtime_disable" is set,
->probe() calls pm_runtime_forbid() for the device, but without enabling
runtime PM. This increases the runtime PM usage count for the device, but
as runtime PM is disabled it's pointless.

Let's instead convert to unconditionally enable runtime PM, which has the
effect of making a parent device aware of its child.

To also maintain the old behaviour when the "pm_runtime_disable" flag is
set, which prevents userspace to enable runtime PM suspend via sysfs,
switch from calling pm_runtime_forbid() into pm_runtime_get_noresume()
during ->probe().

While changing this, let's also also correct the error path in ->probe()
and fix ->remove(), as to decrease the runtime PM usage count when it has
been in increased by pm_runtime_forbid() (after this change, by
pm_runtime_get_noresume()).

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 19174e7..94ff953 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -236,21 +236,21 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	adap->dev.of_node = pdev->dev.of_node;
 
 	pm_runtime_get_noresume(&pdev->dev);
-	if (dev->pm_runtime_disabled) {
-		pm_runtime_forbid(&pdev->dev);
-	} else {
-		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
-		pm_runtime_use_autosuspend(&pdev->dev);
-		pm_runtime_set_active(&pdev->dev);
-		pm_runtime_enable(&pdev->dev);
-	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	if (dev->pm_runtime_disabled)
+		pm_runtime_get_noresume(&pdev->dev);
 
 	r = i2c_dw_probe(dev);
 	if (r) {
 		if (!IS_ERR(dev->clk))
 			clk_disable_unprepare(dev->clk);
-		if (!dev->pm_runtime_disabled)
-			pm_runtime_disable(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+		if (dev->pm_runtime_disabled)
+			pm_runtime_put_noidle(&pdev->dev);
 	}
 	pm_runtime_put(&pdev->dev);
 
@@ -267,10 +267,11 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 
 	i2c_dw_disable(dev);
 
+	if (dev->pm_runtime_disabled)
+		pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
-	if (!dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
1.9.1
