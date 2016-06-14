From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/10] i2c: designware-platdrv: Re-init the HW when resuming
Date: Tue, 14 Jun 2016 17:07:25 +0200
Message-ID: <1465916848-8207-8-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34901 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcFNPH6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Jun 2016 11:07:58 -0400
Received: by mail-lf0-f51.google.com with SMTP id u74so106495180lff.2
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jun 2016 08:07:57 -0700 (PDT)
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

In cases when the designware specific flag "pm_runtime_disable" is set,
the HW becomes disabled during system PM suspend. Let's make sure it
becomes operational when resuming by re-initialize it again.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 106856f..95a9f4e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -337,9 +337,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
 	i2c_dw_plat_prepare_clk(i_dev, true);
-
-	if (!i_dev->pm_runtime_disabled)
-		i2c_dw_init(i_dev);
+	i2c_dw_init(i_dev);
 
 	return 0;
 }
-- 
1.9.1
