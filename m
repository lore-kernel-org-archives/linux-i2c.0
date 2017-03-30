From: John Stultz <john.stultz@linaro.org>
Subject: [RESEND][PATCH v2] i2c: designwear: Fix clk warning on suspend/resume
Date: Wed, 29 Mar 2017 20:26:17 -0700
Message-ID: <1490844377-32182-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

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
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 79c4b4e..286447c 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -382,7 +382,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	.prepare = dw_i2c_plat_prepare,
 	.complete = dw_i2c_plat_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
 };
 
-- 
2.7.4
