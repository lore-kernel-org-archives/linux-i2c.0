From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/10] i2c: designware-platdrv: Check return value from clk_prepare_enable()
Date: Tue, 14 Jun 2016 17:07:26 +0200
Message-ID: <1465916848-8207-9-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35967 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcFNPID (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Jun 2016 11:08:03 -0400
Received: by mail-lf0-f50.google.com with SMTP id q132so68633469lfe.3
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jun 2016 08:08:02 -0700 (PDT)
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

As clk_prepare_enable() can fail, let's not ignore the error in the
->runtime_resume() callback, but instead propagate it.

This change decreases the callers of i2c_dw_plat_prepare_clk() down to
one, which seems like a justification of removing it. Instead let's call
clk_disable_unprepare() directly when needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 95a9f4e..2b91af3 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -308,25 +308,15 @@ static void dw_i2c_plat_complete(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM
-static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
-{
-	if (IS_ERR(i_dev->clk))
-		return PTR_ERR(i_dev->clk);
-
-	if (prepare)
-		return clk_prepare_enable(i_dev->clk);
-
-	clk_disable_unprepare(i_dev->clk);
-	return 0;
-}
-
 static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
 	i2c_dw_disable(i_dev);
-	i2c_dw_plat_prepare_clk(i_dev, false);
+
+	if (!IS_ERR(i_dev->clk))
+		clk_disable_unprepare(i_dev->clk);
 
 	return 0;
 }
@@ -335,10 +325,15 @@ static int dw_i2c_plat_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+	int ret;
 
-	i2c_dw_plat_prepare_clk(i_dev, true);
-	i2c_dw_init(i_dev);
+	if (!IS_ERR(i_dev->clk)) {
+		ret = clk_prepare_enable(i_dev->clk);
+		if (ret)
+			return ret;
+	}
 
+	i2c_dw_init(i_dev);
 	return 0;
 }
 
-- 
1.9.1
