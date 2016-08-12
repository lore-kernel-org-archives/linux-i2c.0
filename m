From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/8] i2c: designware: get fast plus and high speed *CNT configuration
Date: Fri, 12 Aug 2016 17:02:48 +0300
Message-ID: <1471010574-28598-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcHLODJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Aug 2016 10:03:09 -0400
In-Reply-To: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Weifeng Voon <weifeng.voon@intel.com>

I2C designware controller can run at fast mode plus and high speed. This
patch adds the capability to get the HCNT, LCNT configuration via
FPCN (fast plus) and HSCN (high speed) ACPI method.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h    | 8 ++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 63f6d4acee39..84866db2d04f 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -62,6 +62,10 @@
  * @ss_lcnt: standard speed LCNT value
  * @fs_hcnt: fast speed HCNT value
  * @fs_lcnt: fast speed LCNT value
+ * @fp_hcnt: fast plus HCNT value
+ * @fp_lcnt: fast plus LCNT value
+ * @hs_hcnt: high speed HCNT value
+ * @hs_lcnt: high speed LCNT value
  * @acquire_lock: function to acquire a hardware lock on the bus
  * @release_lock: function to release a hardware lock on the bus
  * @pm_runtime_disabled: true if pm runtime is disabled
@@ -105,6 +109,10 @@ struct dw_i2c_dev {
 	u16			ss_lcnt;
 	u16			fs_hcnt;
 	u16			fs_lcnt;
+	u16			fp_hcnt;
+	u16			fp_lcnt;
+	u16			hs_hcnt;
+	u16			hs_lcnt;
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_runtime_disabled;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 1608cf4d3263..cbe4fb31cb4b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -107,6 +107,8 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt, NULL);
 	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
 			   &dev->sda_hold_time);
+	dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev->fp_lcnt, NULL);
+	dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev->hs_lcnt, NULL);
 
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
 	if (id && id->driver_data)
-- 
2.8.1
