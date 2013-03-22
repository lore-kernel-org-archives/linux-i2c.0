From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] i2c: ocores: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Fri, 22 Mar 2013 11:13:52 +0900
Message-ID: <00ba01ce26a2$e5f74cb0$b1e5e610$%han@samsung.com>
References: <00b901ce26a2$cb3c57d0$61b50770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <00b901ce26a2$cb3c57d0$61b50770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-ocores.c:460:12: warning: 'ocores_i2c_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-ocores.c:471:12: warning: 'ocores_i2c_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 0e1f824..1ecea5e 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -456,7 +456,7 @@ static int ocores_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ocores_i2c_suspend(struct device *dev)
 {
 	struct ocores_i2c *i2c = dev_get_drvdata(dev);
@@ -476,12 +476,9 @@ static int ocores_i2c_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(ocores_i2c_pm, ocores_i2c_suspend, ocores_i2c_resume);
-#define OCORES_I2C_PM	(&ocores_i2c_pm)
-#else
-#define OCORES_I2C_PM	NULL
-#endif
 
 static struct platform_driver ocores_i2c_driver = {
 	.probe   = ocores_i2c_probe,
@@ -490,7 +487,7 @@ static struct platform_driver ocores_i2c_driver = {
 		.owner = THIS_MODULE,
 		.name = "ocores-i2c",
 		.of_match_table = ocores_i2c_match,
-		.pm = OCORES_I2C_PM,
+		.pm = &ocores_i2c_pm,
 	},
 };
 
-- 
1.7.2.5
