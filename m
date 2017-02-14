From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2] i2c: designwear: Fix clk warning on suspend/resume
Date: Mon, 13 Feb 2017 20:05:42 -0800
Message-ID: <1487045142-1434-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36025 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdBNEFr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 13 Feb 2017 23:05:47 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so17600568itd.1
        for <linux-i2c@vger.kernel.org>; Mon, 13 Feb 2017 20:05:47 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On my HiKey board, I'm seeing clk warnings on suspend/resume,
which seem to be caused by runtime pm suspending the device,
then the same suspend hook being called again on suspend time.

This patch fixes this by setting the SYSTEM_SLEEP_PM_OPS to
using pm_runtime_force_suspend and  pm_runtime_force_resume.

Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Suggested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Switch to suggested fix by Jarkko.

 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6ce4313..09f27ec 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -362,7 +362,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	.prepare = dw_i2c_plat_prepare,
 	.complete = dw_i2c_plat_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
 };
 
-- 
2.7.4
