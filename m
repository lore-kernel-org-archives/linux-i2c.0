From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/3] i2c: designware: Default to fast mode in case of ACPI
Date: Tue, 30 Sep 2014 13:04:53 +0300
Message-ID: <1412071495-15323-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1412071495-15323-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412071495-15323-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no way in ACPI to tell in which speed the host controller is
supposed to run, so we default to fast mode (400KHz). Since this has been
the default all the time there should be no functional changes with this
change.

This is the first step required to refactor the driver probe so that we can
supply source clock from ACPI part of the driver to the core.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4d6a6b94e2fa..353adc4dc583 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -80,7 +80,6 @@ static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
 static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
-	bool fs_mode = dev->master_cfg & DW_IC_CON_SPEED_FAST;
 
 	if (!ACPI_HANDLE(&pdev->dev))
 		return -ENODEV;
@@ -93,10 +92,9 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	 * Try to get SDA hold time and *CNT values from an ACPI method if
 	 * it exists for both supported speed modes.
 	 */
-	dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt,
-			   fs_mode ? NULL : &dev->sda_hold_time);
+	dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt, NULL);
 	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
-			   fs_mode ? &dev->sda_hold_time : NULL);
+			   &dev->sda_hold_time);
 
 	return 0;
 }
-- 
2.1.0
