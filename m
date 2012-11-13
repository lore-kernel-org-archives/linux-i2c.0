From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: rcar: fix section mismatch
Date: Tue, 13 Nov 2012 11:27:29 +0100
Message-ID: <1352802449-12908-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Give the driver struct a name according to the 'standard' to fix:

WARNING: vmlinux.o(.data+0x11798): Section mismatch in reference from the variable rcar_i2c_drv to the function .devinit.text:rcar_i2c_probe()
...
WARNING: vmlinux.o(.data+0x1179c): Section mismatch in reference from the variable rcar_i2c_drv to the function .devexit.text:rcar_i2c_remove()

Reported-by: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-rcar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 2bce56d..72a8071 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -693,7 +693,7 @@ static int __devexit rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver rcar_i2c_drv = {
+static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
 		.owner	= THIS_MODULE,
@@ -702,7 +702,7 @@ static struct platform_driver rcar_i2c_drv = {
 	.remove		= __devexit_p(rcar_i2c_remove),
 };
 
-module_platform_driver(rcar_i2c_drv);
+module_platform_driver(rcar_i2c_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Renesas R-Car I2C bus driver");
-- 
1.7.10.4
