From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] i2c: designware: Keep pm_runtime_enable/_disable calls in sync
Date: Thu, 10 Dec 2015 13:48:43 +0200
Message-ID: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29920 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbbLJLsx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Dec 2015 06:48:53 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On an hardware shared I2C bus (certain Intel Baytrail SoC platforms) the
runtime PM disable depth keeps increasing over repeated modprobe/rmmod
cycle because pm_runtime_disable() is called without checking should it
be disabled already because of bus sharing.

This hasn't made any other harm than dev->power.disable_depth keeps
increasing but keep it sync by calling pm_runtime_disable() only when
runtime PM is not disabled.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 809579ecb5a4..1308666b054b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -240,12 +240,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	r = i2c_dw_probe(dev);
-	if (r) {
+	if (r && !dev->pm_runtime_disabled)
 		pm_runtime_disable(&pdev->dev);
-		return r;
-	}
 
-	return 0;
+	return r;
 }
 
 static int dw_i2c_plat_remove(struct platform_device *pdev)
@@ -260,7 +258,8 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	if (!dev->pm_runtime_disabled)
+		pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.6.2
