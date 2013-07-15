From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 1/7] i2c: i2c-mpc: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Mon, 15 Jul 2013 11:28:23 +0900
Message-ID: <005501ce8102$faa66690$eff333b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-mpc.c:724:12: warning: 'mpc_i2c_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-mpc.c:734:12: warning: 'mpc_i2c_resume' defined but not used [-Wunused-function]

Also, this patch makes mpc_i2c_pm_ops static, because mpc_i2c_pm_ops
is not exported.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 7607dc0..e902e62 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -64,7 +64,7 @@ struct mpc_i2c {
 	struct i2c_adapter adap;
 	int irq;
 	u32 real_clk;
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	u8 fdr, dfsrr;
 #endif
 };
@@ -720,7 +720,7 @@ static int fsl_i2c_remove(struct platform_device *op)
 	return 0;
 };
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int mpc_i2c_suspend(struct device *dev)
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(dev);
@@ -741,7 +741,10 @@ static int mpc_i2c_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
+static SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
+#define MPC_I2C_PM_OPS	(&mpc_i2c_pm_ops)
+#else
+#define MPC_I2C_PM_OPS	NULL
 #endif
 
 static const struct mpc_i2c_data mpc_i2c_data_512x = {
@@ -788,9 +791,7 @@ static struct platform_driver mpc_i2c_driver = {
 		.owner = THIS_MODULE,
 		.name = DRV_NAME,
 		.of_match_table = mpc_i2c_of_match,
-#ifdef CONFIG_PM
-		.pm = &mpc_i2c_pm_ops,
-#endif
+		.pm = MPC_I2C_PM_OPS,
 	},
 };
 
-- 
1.7.10.4
