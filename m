From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/6] i2c-puv3: Fix a possible NULL pointer access
Date: Thu, 9 Aug 2012 19:07:46 +0530
Message-ID: <1344519467-14295-6-git-send-email-shubhrajyoti@ti.com>
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
Untested
 drivers/i2c/busses/i2c-puv3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index d8515be..38e67b4 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -245,10 +245,10 @@ static int __devexit puv3_i2c_remove(struct platform_device *pdev)
 	}
 
 	put_device(&pdev->dev);
-	platform_set_drvdata(pdev, NULL);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
+	platform_set_drvdata(pdev, NULL);
 
 	return rc;
 }
-- 
1.7.5.4
