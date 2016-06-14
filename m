From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/10] i2c: designware-platdrv: Update runtime PM last busy mark in ->probe()
Date: Tue, 14 Jun 2016 17:07:24 +0200
Message-ID: <1465916848-8207-7-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34147 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcFNPHz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Jun 2016 11:07:55 -0400
Received: by mail-lf0-f46.google.com with SMTP id j7so82552724lfg.1
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jun 2016 08:07:54 -0700 (PDT)
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

To avoid the device to be immediately runtime suspended when ->probe()
returns, update the last busy mark to use the delay from autosuspend.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4083376..106856f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -253,6 +253,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		if (dev->pm_runtime_disabled)
 			pm_runtime_put_noidle(&pdev->dev);
 	}
+	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put(&pdev->dev);
 
 	return r;
-- 
1.9.1
