From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/5] i2c: mpc: add CONFIG_PM_SLEEP to suspend/resume functions
Date: Tue, 26 Mar 2013 15:57:34 +0900
Message-ID: <001901ce29ef$31515760$93f40620$%han@samsung.com>
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

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-mpc.c:724:12: warning: 'mpc_i2c_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-mpc.c:734:12: warning: 'mpc_i2c_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 5e705ee..9c103c2 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -720,7 +720,7 @@ static int fsl_i2c_remove(struct platform_device *op)
 	return 0;
 };
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int mpc_i2c_suspend(struct device *dev)
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(dev);
@@ -740,9 +740,9 @@ static int mpc_i2c_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
-#endif
 
 static const struct mpc_i2c_data mpc_i2c_data_512x = {
 	.setup = mpc_i2c_setup_512x,
@@ -788,9 +788,7 @@ static struct platform_driver mpc_i2c_driver = {
 		.owner = THIS_MODULE,
 		.name = DRV_NAME,
 		.of_match_table = mpc_i2c_of_match,
-#ifdef CONFIG_PM
 		.pm = &mpc_i2c_pm_ops,
-#endif
 	},
 };
 
-- 
1.7.2.5
