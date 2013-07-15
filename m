From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 7/7] i2c: i2c-bfin-twi: add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Mon, 15 Jul 2013 11:30:57 +0900
Message-ID: <005b01ce8103$5634a9e0$029dfda0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-bfin-twi.c:585:12: warning: 'i2c_bfin_twi_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-bfin-twi.c:600:12: warning: 'i2c_bfin_twi_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 13ea1c2..37d4239 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -582,6 +582,7 @@ static struct i2c_algorithm bfin_twi_algorithm = {
 	.functionality = bfin_twi_functionality,
 };
 
+#ifdef CONFIG_PM_SLEEP
 static int i2c_bfin_twi_suspend(struct device *dev)
 {
 	struct bfin_twi_iface *iface = dev_get_drvdata(dev);
@@ -619,6 +620,10 @@ static int i2c_bfin_twi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(i2c_bfin_twi_pm,
 			 i2c_bfin_twi_suspend, i2c_bfin_twi_resume);
+#define I2C_BFIN_TWI_PM_OPS	(&i2c_bfin_twi_pm)
+#else
+#define I2C_BFIN_TWI_PM_OPS	NULL
+#endif
 
 static int i2c_bfin_twi_probe(struct platform_device *pdev)
 {
@@ -746,7 +751,7 @@ static struct platform_driver i2c_bfin_twi_driver = {
 	.driver		= {
 		.name	= "i2c-bfin-twi",
 		.owner	= THIS_MODULE,
-		.pm	= &i2c_bfin_twi_pm,
+		.pm	= I2C_BFIN_TWI_PM_OPS,
 	},
 };
 
-- 
1.7.10.4
