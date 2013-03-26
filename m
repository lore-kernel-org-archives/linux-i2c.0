From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/5] i2c: puv3: add CONFIG_PM_SLEEP to suspend function
Date: Tue, 26 Mar 2013 15:56:56 +0900
Message-ID: <001701ce29ef$1af32cf0$50d986d0$%han@samsung.com>
References: <001501ce29ee$fd997150$f8cc53f0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001501ce29ee$fd997150$f8cc53f0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend function to fix the following build
warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-puv3.c:255:12: warning: 'puv3_i2c_suspend' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-puv3.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index 8acef65..1a73ce0 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -251,7 +251,7 @@ static int puv3_i2c_remove(struct platform_device *pdev)
 	return rc;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int puv3_i2c_suspend(struct device *dev)
 {
 	int poll_count;
@@ -264,13 +264,9 @@ static int puv3_i2c_suspend(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(puv3_i2c_pm, puv3_i2c_suspend, NULL);
-#define PUV3_I2C_PM	(&puv3_i2c_pm)
-
-#else
-#define PUV3_I2C_PM	NULL
-#endif
 
 static struct platform_driver puv3_i2c_driver = {
 	.probe		= puv3_i2c_probe,
@@ -278,7 +274,7 @@ static struct platform_driver puv3_i2c_driver = {
 	.driver		= {
 		.name	= "PKUnity-v3-I2C",
 		.owner	= THIS_MODULE,
-		.pm	= PUV3_I2C_PM,
+		.pm	= &puv3_i2c_pm,
 	}
 };
 
-- 
1.7.2.5
