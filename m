From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] i2c: exynos5: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Tue, 11 Mar 2014 10:21:57 +0900
Message-ID: <000501cf3cc8$4b7f8d90$e27ea8b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Naveen Krishna Ch' <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Taekgyun Ko' <taeggyun.ko-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

  warning: 'exynos5_i2c_suspend_noirq' defined but not used [-Wunused-function]
  warning: 'exynos5_i2c_resume_noirq' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-exynos5.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 9fd711c..60601ef 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -715,6 +715,7 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int exynos5_i2c_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -745,6 +746,7 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(exynos5_i2c_dev_pm_ops, exynos5_i2c_suspend_noirq,
 			 exynos5_i2c_resume_noirq);
-- 
1.7.10.4
