From: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Subject: [patch 6/6] Minor fixes for pxa-driver
Date: Mon, 21 Jan 2008 15:20:16 +0100
Message-ID: <20080121143659.089906703@pengutronix.de>
References: <20080121142010.988419876@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline; filename=i2c_busses_i2c_pxa-fixes.diff
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

While working on the PCA9564-platform driver, I sometimes had a glimpse at the
pxa-driver. I found some suspicious places, and this patch contains my
suggestions. Note: They are not tested, due to no hardware.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-playground/drivers/i2c/busses/i2c-pxa.c
===================================================================
--- linux-playground.orig/drivers/i2c/busses/i2c-pxa.c	2008-01-21 12:39:28.000000000 +0100
+++ linux-playground/drivers/i2c/busses/i2c-pxa.c	2008-01-21 13:21:10.000000000 +0100
@@ -870,7 +870,7 @@
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
-	sprintf(i2c->adap.name, "pxa_i2c-i2c.%u", dev->id);
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u", dev->id);
 
 	i2c->clk = clk_get(&dev->dev, "I2CCLK");
 	if (IS_ERR(i2c->clk)) {
@@ -963,6 +963,7 @@
 		local_irq_enable();
 	}
 #endif
+	iounmap(i2c->reg_base);
 eremap:
 	clk_put(i2c->clk);
 eclk:
@@ -991,7 +992,7 @@
 		local_irq_enable();
 	}
 #endif
-
+	iounmap(i2c->reg_base);
 	release_mem_region(i2c->iobase, i2c->iosize);
 	kfree(i2c);
 
@@ -1011,9 +1012,9 @@
 	return platform_driver_register(&i2c_pxa_driver);
 }
 
-static void i2c_adap_pxa_exit(void)
+static void __exit i2c_adap_pxa_exit(void)
 {
-	return platform_driver_unregister(&i2c_pxa_driver);
+	platform_driver_unregister(&i2c_pxa_driver);
 }
 
 MODULE_LICENSE("GPL");

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
