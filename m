From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: designware: Fix a possible NULL pointer access
Date: Thu, 23 Aug 2012 20:09:00 +0530
Message-ID: <1345732740-26599-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

    After platform_set_drvdata(pdev, NULL) the pdev->dev should not be accessed.
    Also since the platform device is deleted anyways just remove the
    call to platform_set_drvdata(pdev, NULL).

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
Untested.

 drivers/i2c/busses/i2c-designware-platdrv.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0506fef..2884688 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -160,7 +160,6 @@ err_unuse_clocks:
 	clk_put(dev->clk);
 	dev->clk = NULL;
 err_free_mem:
-	platform_set_drvdata(pdev, NULL);
 	put_device(&pdev->dev);
 	kfree(dev);
 err_release_region:
@@ -174,7 +173,6 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	struct resource *mem;
 
-	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
 
-- 
1.7.5.4
