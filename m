From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/6] i2c-xiic:  Fix a possible NULL pointer access
Date: Thu, 9 Aug 2012 19:07:43 +0530
Message-ID: <1344519467-14295-3-git-send-email-shubhrajyoti@ti.com>
References: <1344519467-14295-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344519467-14295-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

platform_get_resource uses pdev so move the function
platform_set_drvdata(pdev, NULL) after the get_resource.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
untested

 drivers/i2c/busses/i2c-xiic.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 641d0e5..a28479a 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -784,8 +784,6 @@ static int __devexit xiic_i2c_remove(struct platform_device* pdev)
 
 	xiic_deinit(i2c);
 
-	platform_set_drvdata(pdev, NULL);
-
 	free_irq(platform_get_irq(pdev, 0), i2c);
 
 	iounmap(i2c->base);
@@ -795,6 +793,7 @@ static int __devexit xiic_i2c_remove(struct platform_device* pdev)
 		release_mem_region(res->start, resource_size(res));
 
 	kfree(i2c);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.5.4
