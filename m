From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH] i2c: designwear: Fix clk warning on suspend/resume
Date: Fri,  3 Feb 2017 15:01:33 -0800
Message-ID: <1486162893-12313-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33006 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbdBCXBh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Feb 2017 18:01:37 -0500
Received: by mail-pg0-f52.google.com with SMTP id 204so10183321pge.0
        for <linux-i2c@vger.kernel.org>; Fri, 03 Feb 2017 15:01:37 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On my HiKey board, I'm seeing clk warnings on suspend/resume, which
seem to be caused by runtime pm suspending the device, then the same
suspend hook being called again on suspend time.

Thus this patch adds suspend state tracking to avoid runtime pm and
suspend causing double suspend calls on i2c-designware-platdrv.

Feedback would be greatly appreciated!

Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/i2c/busses/i2c-designware-core.h    | 1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 26250b4..386cacb 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -126,6 +126,7 @@ struct dw_i2c_dev {
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_runtime_disabled;
 	bool			dynamic_tar_update_enabled;
+	bool			suspended;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6ce4313..54084fe 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -340,8 +340,12 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (i_dev->suspended)
+		return 0;
+
 	i2c_dw_disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
+	i_dev->suspended = true;
 
 	return 0;
 }
@@ -351,11 +355,16 @@ static int dw_i2c_plat_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (!i_dev->suspended)
+		return 0;
+
 	i2c_dw_plat_prepare_clk(i_dev, true);
 
 	if (!i_dev->pm_runtime_disabled)
 		i2c_dw_init(i_dev);
 
+	i_dev->suspended = false;
+
 	return 0;
 }
 
-- 
2.7.4
