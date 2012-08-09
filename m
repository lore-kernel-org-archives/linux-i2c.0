From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/6] i2c: at91: Fix a possible NULL pointer access
Date: Thu, 9 Aug 2012 19:07:45 +0530
Message-ID: <1344519467-14295-5-git-send-email-shubhrajyoti@ti.com>
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

 drivers/i2c/busses/i2c-at91.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index e24484b..f748e87 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -263,7 +263,6 @@ static int __devexit at91_i2c_remove(struct platform_device *pdev)
 	int rc;
 
 	rc = i2c_del_adapter(adapter);
-	platform_set_drvdata(pdev, NULL);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iounmap(twi_base);
@@ -271,6 +270,7 @@ static int __devexit at91_i2c_remove(struct platform_device *pdev)
 
 	clk_disable(twi_clk);		/* disable peripheral clock */
 	clk_put(twi_clk);
+	platform_set_drvdata(pdev, NULL);
 
 	return rc;
 }
-- 
1.7.5.4
