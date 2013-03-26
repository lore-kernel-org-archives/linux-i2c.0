From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/5] i2c:i2c-bfin-twi: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Tue, 26 Mar 2013 15:57:15 +0900
Message-ID: <001801ce29ef$262981a0$727c84e0$%han@samsung.com>
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

drivers/i2c/busses/i2c-bfin-twi.c:580:12: warning: 'i2c_bfin_twi_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-bfin-twi.c:595:12: warning: 'i2c_bfin_twi_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 05080c4..93663c0 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -575,6 +575,7 @@ static struct i2c_algorithm bfin_twi_algorithm = {
 	.functionality = bfin_twi_functionality,
 };
 
+#ifdef CONFIG_PM_SLEEP
 static int i2c_bfin_twi_suspend(struct device *dev)
 {
 	struct bfin_twi_iface *iface = dev_get_drvdata(dev);
@@ -609,6 +610,7 @@ static int i2c_bfin_twi_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(i2c_bfin_twi_pm,
 			 i2c_bfin_twi_suspend, i2c_bfin_twi_resume);
-- 
1.7.2.5
