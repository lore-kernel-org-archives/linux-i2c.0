From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/10] i2c: designware-platdrv: Disable autosuspend in error path in ->probe()
Date: Tue, 14 Jun 2016 17:07:22 +0200
Message-ID: <1465916848-8207-5-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35890 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcFNPH5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Jun 2016 11:07:57 -0400
Received: by mail-lf0-f43.google.com with SMTP id q132so68629893lfe.3
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jun 2016 08:07:51 -0700 (PDT)
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Disable runtime PM autosuspend in the error path in ->probe() to make sure
it's disabled at the next probe attempt.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 94ff953..7f67d801 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -249,6 +249,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		if (!IS_ERR(dev->clk))
 			clk_disable_unprepare(dev->clk);
 		pm_runtime_disable(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		if (dev->pm_runtime_disabled)
 			pm_runtime_put_noidle(&pdev->dev);
 	}
-- 
1.9.1
