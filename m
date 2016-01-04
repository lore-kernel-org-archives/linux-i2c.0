From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v4] i2c: designware: Do not require clock when SSCN and FFCN are provided
Date: Mon, 4 Jan 2016 09:17:35 -0600
Message-ID: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0053.outbound.protection.outlook.com ([207.46.100.53]:55316
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751581AbcADPSG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 10:18:06 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: mika.westerberg@linux.intel.com, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc: lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

The current driver uses input clock source frequency to calculate
values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
currently have a good way to provide the frequency information.
Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
to directly provide these values. So, the clock information should
no longer be required during probing.

However, since clk can be invalid, additional checks must be done where
we are making use of it.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Loc Ho <lho@apm.com> 
---

Note: This has been tested on AMD Seattle RevB for both DT and ACPI.

Changes from V3 (https://lkml.org/lkml/2015/12/22/596):
    * Add i2c_dw_plat_prepare_clk() per Andy's suggestion
    * Add tested-by Loc Ho.

Changes from V2 (https://lkml.org/lkml/2015/12/22/584):
    * Add the i2c_dw_clk_rate from Mika.
    * Add check if get_clk_rate_khz is set before setting sda_hold_time

Changes from V1 (https://lkml.org/lkml/2015/12/15/792):
    In v1, I disregarded the clock if SSCN and FMCN are provided,
    assuming that it was not needed. That was incorrect assumption,
    and is now fixed in v2.

 drivers/i2c/busses/i2c-designware-core.c    | 22 +++++++++++++-------
 drivers/i2c/busses/i2c-designware-platdrv.c | 31 +++++++++++++++++++----------
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 8c48b27..25dccd8 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -271,6 +271,17 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
 		 enable ? "en" : "dis");
 }
 
+static unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
+{
+	/*
+	 * Clock is not necessary if we got LCNT/HCNT values directly from
+	 * the platform code.
+	 */
+	if (WARN_ON_ONCE(!dev->get_clk_rate_khz))
+		return 0;
+	return dev->get_clk_rate_khz(dev);
+}
+
 /**
  * i2c_dw_init() - initialize the designware i2c master hardware
  * @dev: device private data
@@ -281,7 +292,6 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
  */
 int i2c_dw_init(struct dw_i2c_dev *dev)
 {
-	u32 input_clock_khz;
 	u32 hcnt, lcnt;
 	u32 reg;
 	u32 sda_falling_time, scl_falling_time;
@@ -295,8 +305,6 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		}
 	}
 
-	input_clock_khz = dev->get_clk_rate_khz(dev);
-
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
 		/* Configure register endianess access */
@@ -325,12 +333,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		hcnt = dev->ss_hcnt;
 		lcnt = dev->ss_lcnt;
 	} else {
-		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
 					4000,	/* tHD;STA = tHIGH = 4.0 us */
 					sda_falling_time,
 					0,	/* 0: DW default, 1: Ideal */
 					0);	/* No offset */
-		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
 					4700,	/* tLOW = 4.7 us */
 					scl_falling_time,
 					0);	/* No offset */
@@ -344,12 +352,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		hcnt = dev->fs_hcnt;
 		lcnt = dev->fs_lcnt;
 	} else {
-		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
 					600,	/* tHD;STA = tHIGH = 0.6 us */
 					sda_falling_time,
 					0,	/* 0: DW default, 1: Ideal */
 					0);	/* No offset */
-		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
 					1300,	/* tLOW = 1.3 us */
 					scl_falling_time,
 					0);	/* No offset */
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 8ffc36b..965512c 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -128,6 +128,18 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 }
 #endif
 
+static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
+{
+	if (IS_ERR(i_dev->clk))
+		return PTR_ERR(i_dev->clk);
+
+	if (prepare)
+		return clk_prepare_enable(i_dev->clk);
+
+	clk_disable_unprepare(i_dev->clk);
+	return 0;
+}
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
@@ -205,16 +217,13 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
-	if (IS_ERR(dev->clk))
-		return PTR_ERR(dev->clk);
-	clk_prepare_enable(dev->clk);
+	if (!i2c_dw_plat_prepare_clk(dev, true)) {
+		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 
-	if (!dev->sda_hold_time && ht) {
-		u32 ic_clk = dev->get_clk_rate_khz(dev);
-
-		dev->sda_hold_time = div_u64((u64)ic_clk * ht + 500000,
-					     1000000);
+		if (!dev->sda_hold_time && ht)
+			dev->sda_hold_time = div_u64(
+				(u64)dev->get_clk_rate_khz(dev) * ht + 500000,
+				1000000);
 	}
 
 	if (!dev->tx_fifo_depth) {
@@ -297,7 +306,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
 	i2c_dw_disable(i_dev);
-	clk_disable_unprepare(i_dev->clk);
+	i2c_dw_plat_prepare_clk(i_dev, false);
 
 	return 0;
 }
@@ -307,7 +316,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
-	clk_prepare_enable(i_dev->clk);
+	i2c_dw_plat_prepare_clk(i_dev, true);
 
 	if (!i_dev->pm_runtime_disabled)
 		i2c_dw_init(i_dev);
-- 
2.5.0
