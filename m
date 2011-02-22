From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 1/2] i2c: i2c-omap: fix build break with CONFIG_SUSPEND=n
Date: Tue, 22 Feb 2011 12:21:26 +0530
Message-ID: <1298357487-10966-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-next@vger.kernel.org
Cc: Sourav Poddar <sourav.poddar@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

From: Sourav Poddar <sourav.poddar@ti.com>

When CONFIG_SUSPEND=n, we get the following build break when
building for OMAP targets. Fix this.

  CC      drivers/i2c/busses/i2c-omap.o
drivers/i2c/busses/i2c-omap.c:1173: error: lvalue required as unary '&' operand
make[1]: *** [drivers/i2c/busses/i2c-omap.o] Error 1
make: *** [drivers/i2c/busses/] Error 2

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>
--
This is a fix for a trivial build error, seen with linux-next
as of 20110217.

 drivers/i2c/busses/i2c-omap.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-omap-usb/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-usb.orig/drivers/i2c/busses/i2c-omap.c
+++ linux-omap-usb/drivers/i2c/busses/i2c-omap.c
@@ -1156,10 +1156,11 @@ static int omap_i2c_resume(struct device
 	return 0;
 }
 
-static struct dev_pm_ops omap_i2c_pm_ops = {
+static struct dev_pm_ops omap_i2c_pm = {
 	.suspend = omap_i2c_suspend,
 	.resume = omap_i2c_resume,
 };
+#define omap_i2c_pm_ops (&omap_i2c_pm)
 #else
 #define omap_i2c_pm_ops NULL
 #endif
@@ -1170,7 +1171,7 @@ static struct platform_driver omap_i2c_d
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-		.pm     = &omap_i2c_pm_ops,
+		.pm     = omap_i2c_pm_ops,
 	},
 };
 
