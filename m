From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2] i2c: designware-platdrv: fix unbalanced clk enable and prepare
Date: Thu, 21 Apr 2016 17:26:51 +0800
Message-ID: <1461230811-7495-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8266 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282AbcDUJbL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Apr 2016 05:31:11 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

If i2c_dw_probe() fail, we should disable and unprepare the clk,
otherwise the clk enable and prepare is left unbalanced.

In dw_i2c_plat_remove(), we'd better to not rely on rpm to disable
and unprepare the clk since CONFIG_PM may be disabled when configuring
the kernel. So we explicitly disable and unprepare the clk in
dw_i2c_plat_remove().

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since v1:
 - fix commit msg: "not rely on rpm" rather than "rely on rpm"
 - call i2c_dw_plat_prepare_clk after pm_rumtime_disable()

 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d656657..a771781 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -253,8 +253,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	r = i2c_dw_probe(dev);
-	if (r && !dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	if (r) {
+		if (!dev->pm_runtime_disabled)
+			pm_runtime_disable(&pdev->dev);
+		i2c_dw_plat_prepare_clk(dev, false);
+	}
 
 	return r;
 }
@@ -264,15 +267,16 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!dev->pm_runtime_disabled)
+		pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	i2c_del_adapter(&dev->adapter);
 
 	i2c_dw_disable(dev);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
-	if (!dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	i2c_dw_plat_prepare_clk(dev, false);
 
 	return 0;
 }
-- 
2.8.1
