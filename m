From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: davinci: Fix a possible NULL pointer access
Date: Thu, 23 Aug 2012 20:02:22 +0530
Message-ID: <1345732342-26359-1-git-send-email-shubhrajyoti@ti.com>
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

 drivers/i2c/busses/i2c-davinci.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 79b4bcb..328a6b8 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -730,7 +730,6 @@ err_mem_ioremap:
 	clk_put(dev->clk);
 	dev->clk = NULL;
 err_free_mem:
-	platform_set_drvdata(pdev, NULL);
 	put_device(&pdev->dev);
 	kfree(dev);
 err_release_region:
@@ -746,7 +745,6 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 
 	i2c_davinci_cpufreq_deregister(dev);
 
-	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
 
-- 
1.7.5.4
