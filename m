From: Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 2/5] i2c: designware: get fast plus and high speed *CNT configuration
Date: Thu, 26 May 2016 16:01:09 +0800
Message-ID: <1464249672-24566-3-git-send-email-weifeng.voon@intel.com>
References: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com
List-Id: linux-i2c@vger.kernel.org

I2C designware controller can run at fast mode plus and high speed. This
patch adds the capability to get the HCNT, LCNT configuration via
FPCN (fast plus) and HSCN (high speed) ACPI method.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h    | 8 ++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 87d406e..1124240 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -61,6 +61,10 @@
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
@@ -104,6 +108,10 @@ struct dw_i2c_dev {
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
index 1608cf4..cbe4fb3 100644
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
1.9.1
