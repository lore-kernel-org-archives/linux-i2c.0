From: Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 3/5] i2c: designware: Enable fast mode plus
Date: Thu, 26 May 2016 16:01:10 +0800
Message-ID: <1464249672-24566-4-git-send-email-weifeng.voon@intel.com>
References: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com
List-Id: linux-i2c@vger.kernel.org

This patch enabled fast mode plus. The fast mode plus and fast speed
share the same HCNT and LCNT register. So, the fast mode plus will only
run when the HCNT and LCNT value is provided. Else, it will run at fast
speed as default.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c    | 7 +++++--
 drivers/i2c/busses/i2c-designware-platdrv.c | 9 ++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 99b54be..25c78d2 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -347,8 +347,11 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
 	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
-	/* Set SCL timing parameters for fast-mode */
-	if (dev->fs_hcnt && dev->fs_lcnt) {
+	/* Set SCL timing parameters for fast-mode or fast-mode plus */
+	if ((dev->clk_freq == 1000000) && dev->fp_hcnt && dev->fp_lcnt) {
+		hcnt = dev->fp_hcnt;
+		lcnt = dev->fp_lcnt;
+	} else if (dev->fs_hcnt && dev->fs_lcnt) {
 		hcnt = dev->fs_hcnt;
 		lcnt = dev->fs_lcnt;
 	} else {
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index cbe4fb3..ea92e9f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -196,10 +196,13 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		dw_i2c_acpi_configure(pdev);
 
 	/*
-	 * Only standard mode at 100kHz and fast mode at 400kHz are supported.
+	 * Only standard mode at 100kHz, fast mode at 400kHz,
+	 * and fast mode plus at 1MHz are supported.
 	 */
-	if (dev->clk_freq != 100000 && dev->clk_freq != 400000) {
-		dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
+	if (dev->clk_freq != 100000 && dev->clk_freq != 400000
+	    && dev->clk_freq != 1000000) {
+		dev_err(&pdev->dev,
+			"Only 100kHz, 400kHz and 1MHz are supported");
 		return -EINVAL;
 	}
 
-- 
1.9.1
