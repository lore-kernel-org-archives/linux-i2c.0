From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c: designware: Make sure the device is suspended before disabling runtime PM
Date: Wed, 17 Jun 2015 12:08:38 +0300
Message-ID: <1434532118-119906-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The driver calls pm_runtime_put() right before pm_runtime_disable() in its
->remove() hook to make sure clock is gated etc. However, it turns out that
pm_runtime_put() only calls ->idle() hook without actually suspending
anything. The following pm_runtime_disable() will prevent the driver from
suspending thus leaving it "active".

It is better to suspend the device synchronously to make sure it is
actually suspended before disabling runtime PM from it.

While there, undo call to pm_runtime_use_autosuspend().

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4794911a6165..3dd2de31a2f8 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -281,7 +281,8 @@ static int dw_i2c_remove(struct platform_device *pdev)
 
 	i2c_dw_disable(dev);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	if (has_acpi_companion(&pdev->dev))
-- 
2.1.4
