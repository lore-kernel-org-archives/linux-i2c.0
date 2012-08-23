From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: omap: Prevent NULL pointer dereference in remove
Date: Thu, 23 Aug 2012 19:51:26 +0530
Message-ID: <1345731686-26026-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Prevent the NULL pointer access of pdev->dev in remove. The platform_device is anyways
deleted so remove  platform_set_drvdata(pdev, NULL);.

[  654.961761] Unable to handle kernel NULL pointer dereference at virtual address 00000070
[  654.970611] pgd = df254000
[  654.973480] [00000070] *pgd=9f1da831, *pte=00000000, *ppte=00000000
[  654.980163] Internal error: Oops: 17 [#1] SMP ARM
[  654.985076] Modules linked in:
[  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #339)
[  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
[  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5d19a49..84fbef6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1098,7 +1098,6 @@ err_unuse_clocks:
 	iounmap(dev->base);
 	pm_runtime_disable(&pdev->dev);
 err_free_mem:
-	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
@@ -1112,8 +1111,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	struct resource		*mem;
 	int ret;
 
-	platform_set_drvdata(pdev, NULL);
-
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
-- 
1.7.5.4
