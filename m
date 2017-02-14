From: chin.yew.tan@intel.com
Subject: [PATCH] i2c: designware: Get selected speed mode sda-hold-time via ACPI
Date: Tue, 14 Feb 2017 13:54:01 +0800
Message-ID: <1487051641-31927-2-git-send-email-chin.yew.tan@intel.com>
References: <1487051641-31927-1-git-send-email-chin.yew.tan@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:10565 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdBNFyM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 14 Feb 2017 00:54:12 -0500
In-Reply-To: <1487051641-31927-1-git-send-email-chin.yew.tan@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org

From: Tan Chin Yew <chin.yew.tan@intel.com>

Sda-hold-time is an important parameter for tuning i2c to meet the
electrical specification especially for high speed. I2C with incorrect
sda-hold-time may cause lost arbitration error. Now, the driver is able to
get sda-hold-time for all the speed supported.

Signed-off-by: Tan Chin Yew <chin.yew.tan@intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6ce4313..00c880a 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -101,14 +101,28 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	dev->rx_fifo_depth = 32;
 
 	/*
-	 * Try to get SDA hold time and *CNT values from an ACPI method if
-	 * it exists for both supported speed modes.
+	 * Try to get SDA hold time and *CNT values from an ACPI method for
+	 * selected speed modes.
 	 */
-	dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt, NULL);
-	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
-			   &dev->sda_hold_time);
-	dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev->fp_lcnt, NULL);
-	dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev->hs_lcnt, NULL);
+	switch (dev->clk_freq) {
+	case 100000:
+		dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt,
+				   &dev->sda_hold_time);
+		break;
+	case 1000000:
+		dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev->fp_lcnt,
+				   &dev->sda_hold_time);
+		break;
+	case 3400000:
+		dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev->hs_lcnt,
+				   &dev->sda_hold_time);
+		break;
+	case 400000:
+	default:
+		dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
+				   &dev->sda_hold_time);
+		break;
+	}
 
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
 	if (id && id->driver_data)
-- 
1.9.1
