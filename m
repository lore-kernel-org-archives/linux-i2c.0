From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/5] i2c: pnx: add CONFIG_PM_SLEEP to suspend/resume functions
Date: Tue, 26 Mar 2013 15:56:34 +0900
Message-ID: <001601ce29ef$0e0a1f30$2a1e5d90$%han@samsung.com>
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

drivers/i2c/busses/i2c-pnx.c:599:12: warning: 'i2c_pnx_controller_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-pnx.c:608:12: warning: 'i2c_pnx_controller_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 5f39c6d..af88b722 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -595,7 +595,7 @@ static struct i2c_algorithm pnx_algorithm = {
 	.functionality = i2c_pnx_func,
 };
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int i2c_pnx_controller_suspend(struct device *dev)
 {
 	struct i2c_pnx_algo_data *alg_data = dev_get_drvdata(dev);
@@ -611,13 +611,10 @@ static int i2c_pnx_controller_resume(struct device *dev)
 
 	return clk_enable(alg_data->clk);
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(i2c_pnx_pm,
 			 i2c_pnx_controller_suspend, i2c_pnx_controller_resume);
-#define PNX_I2C_PM	(&i2c_pnx_pm)
-#else
-#define PNX_I2C_PM	NULL
-#endif
 
 static int i2c_pnx_probe(struct platform_device *pdev)
 {
@@ -792,7 +789,7 @@ static struct platform_driver i2c_pnx_driver = {
 		.name = "pnx-i2c",
 		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(i2c_pnx_of_match),
-		.pm = PNX_I2C_PM,
+		.pm = &i2c_pnx_pm,
 	},
 	.probe = i2c_pnx_probe,
 	.remove = i2c_pnx_remove,
-- 
1.7.2.5
