From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v2] i2c: designware: Do not require clock when SSCN and FFCN are provided
Date: Wed, 16 Dec 2015 20:23:45 -0600
Message-ID: <1450319025-19120-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]:62561
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753073AbbLQCYI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 16 Dec 2015 21:24:08 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

The current driver uses input clock source frequency to calculate
values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
currently have a good way to provide the frequency information.
Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
to directly provide these values. So, the clock information should
no longer be required during probing.

However, since clk can be invalid, additional checks must be done where
we are making use of it.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---

Note: This has been tested on AMD Seattle RevB for both DT and ACPI.

Changes in V2:
    In v1, I disregarded the clock if SSCN and FMCN are provided,
    assuming that it was not needed. That was incorrect assumption,
    and is now fixed in v2.

 drivers/i2c/busses/i2c-designware-platdrv.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 8ffc36b..4615fe3 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -44,6 +44,9 @@
 
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 {
+	if (IS_ERR(dev->clk))
+		return 0;
+
 	return clk_get_rate(dev->clk)/1000;
 }
 
@@ -206,9 +209,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
-	if (IS_ERR(dev->clk))
-		return PTR_ERR(dev->clk);
-	clk_prepare_enable(dev->clk);
+	if (!IS_ERR(dev->clk))
+		clk_prepare_enable(dev->clk);
 
 	if (!dev->sda_hold_time && ht) {
 		u32 ic_clk = dev->get_clk_rate_khz(dev);
@@ -297,7 +299,8 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
 	i2c_dw_disable(i_dev);
-	clk_disable_unprepare(i_dev->clk);
+	if (!IS_ERR(i_dev->clk))
+		clk_disable_unprepare(i_dev->clk);
 
 	return 0;
 }
@@ -307,7 +310,8 @@ static int dw_i2c_plat_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
-	clk_prepare_enable(i_dev->clk);
+	if (!IS_ERR(i_dev->clk))
+		clk_prepare_enable(i_dev->clk);
 
 	if (!i_dev->pm_runtime_disabled)
 		i2c_dw_init(i_dev);
-- 
2.5.0
