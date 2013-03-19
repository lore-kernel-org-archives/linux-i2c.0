From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: i2c-mpc: make mpc_i2c_pm_ops static
Date: Tue, 19 Mar 2013 10:07:28 +0900
Message-ID: <006601ce243e$200a47c0$601ed740$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

mpc_i2c_pm_ops is not exported. Also, CONFIG_PM_SLEEP is used to
remove unnecessary ifdefs.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 5e705ee..40e8ff4 100644
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
@@ -740,10 +740,10 @@ static int mpc_i2c_resume(struct device *dev)
 
 	return 0;
 }
-
-SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 #endif
 
+static SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
+
 static const struct mpc_i2c_data mpc_i2c_data_512x = {
 	.setup = mpc_i2c_setup_512x,
 };
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
