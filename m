From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c: designware: Do not calculate SCL timing parameters needlessly
Date: Fri, 23 Jan 2015 11:35:55 +0200
Message-ID: <1422005755-20285-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Do SCL timing parameter calculation conditionally depending are custom
parameters provided since calculated values will get instantly overwritten
by provided parameters.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c | 45 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 23628b7bfb8d..2c7749774a5f 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -309,40 +309,39 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
 	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
 
-	/* Standard-mode */
-	hcnt = i2c_dw_scl_hcnt(input_clock_khz,
-				4000,	/* tHD;STA = tHIGH = 4.0 us */
-				sda_falling_time,
-				0,	/* 0: DW default, 1: Ideal */
-				0);	/* No offset */
-	lcnt = i2c_dw_scl_lcnt(input_clock_khz,
-				4700,	/* tLOW = 4.7 us */
-				scl_falling_time,
-				0);	/* No offset */
-
-	/* Allow platforms to specify the ideal HCNT and LCNT values */
+	/* Set SCL timing parameters for standard-mode */
 	if (dev->ss_hcnt && dev->ss_lcnt) {
 		hcnt = dev->ss_hcnt;
 		lcnt = dev->ss_lcnt;
+	} else {
+		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+					4000,	/* tHD;STA = tHIGH = 4.0 us */
+					sda_falling_time,
+					0,	/* 0: DW default, 1: Ideal */
+					0);	/* No offset */
+		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+					4700,	/* tLOW = 4.7 us */
+					scl_falling_time,
+					0);	/* No offset */
 	}
 	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
 	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
 	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
-	/* Fast-mode */
-	hcnt = i2c_dw_scl_hcnt(input_clock_khz,
-				600,	/* tHD;STA = tHIGH = 0.6 us */
-				sda_falling_time,
-				0,	/* 0: DW default, 1: Ideal */
-				0);	/* No offset */
-	lcnt = i2c_dw_scl_lcnt(input_clock_khz,
-				1300,	/* tLOW = 1.3 us */
-				scl_falling_time,
-				0);	/* No offset */
-
+	/* Set SCL timing parameters for fast-mode */
 	if (dev->fs_hcnt && dev->fs_lcnt) {
 		hcnt = dev->fs_hcnt;
 		lcnt = dev->fs_lcnt;
+	} else {
+		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+					600,	/* tHD;STA = tHIGH = 0.6 us */
+					sda_falling_time,
+					0,	/* 0: DW default, 1: Ideal */
+					0);	/* No offset */
+		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+					1300,	/* tLOW = 1.3 us */
+					scl_falling_time,
+					0);	/* No offset */
 	}
 	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
 	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
-- 
2.1.4
