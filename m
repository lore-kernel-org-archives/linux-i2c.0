From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/5] i2c: stu300: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Tue, 26 Mar 2013 15:56:07 +0900
Message-ID: <001501ce29ee$fd997150$f8cc53f0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-stu300.c:941:12: warning: 'stu300_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-stu300.c:950:12: warning: 'stu300_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-stu300.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 0a6f941..a17874d 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -937,7 +937,7 @@ stu300_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int stu300_suspend(struct device *device)
 {
 	struct stu300_dev *dev = dev_get_drvdata(device);
@@ -960,12 +960,9 @@ static int stu300_resume(struct device *device)
 		dev_err(device, "error re-initializing hardware.\n");
 	return ret;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(stu300_pm, stu300_suspend, stu300_resume);
-#define STU300_I2C_PM	(&stu300_pm)
-#else
-#define STU300_I2C_PM	NULL
-#endif
 
 static int __exit
 stu300_remove(struct platform_device *pdev)
@@ -982,7 +979,7 @@ static struct platform_driver stu300_i2c_driver = {
 	.driver = {
 		.name	= NAME,
 		.owner	= THIS_MODULE,
-		.pm	= STU300_I2C_PM,
+		.pm	= &stu300_pm,
 	},
 	.remove		= __exit_p(stu300_remove),
 
-- 
1.7.2.5
