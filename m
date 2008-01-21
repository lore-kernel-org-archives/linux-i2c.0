From: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Subject: [patch 3/6] Minor typos in i2c/algos/Kconfig
Date: Mon, 21 Jan 2008 15:20:13 +0100
Message-ID: <20080121143657.830988061@pengutronix.de>
References: <20080121142010.988419876@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline; filename=i2c_algos_Kconfig_typo.diff
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

This patch corrects some minor typos. The term "below" in these paragraphs
might also be replaced by "later" or something similar?

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/algos/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-playground/drivers/i2c/algos/Kconfig
===================================================================
--- linux-playground.orig/drivers/i2c/algos/Kconfig	2008-01-21 11:04:53.000000000 +0100
+++ linux-playground/drivers/i2c/algos/Kconfig	2008-01-21 11:35:19.000000000 +0100
@@ -9,7 +9,7 @@
 	help
 	  This allows you to use a range of I2C adapters called bit-banging
 	  adapters.  Say Y if you own an I2C adapter belonging to this class
-	  and then say Y to the specific driver for you adapter below.
+	  and then say Y to the specific driver for your adapter below.
 
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-bit.
@@ -19,7 +19,7 @@
 	help
 	  This allows you to use a range of I2C adapters called PCF adapters.
 	  Say Y if you own an I2C adapter belonging to this class and then say
-	  Y to the specific driver for you adapter below.
+	  Y to the specific driver for your adapter below.
 
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-pcf.
@@ -29,7 +29,7 @@
 	help
 	  This allows you to use a range of I2C adapters called PCA adapters.
 	  Say Y if you own an I2C adapter belonging to this class and then say
-	  Y to the specific driver for you adapter below.
+	  Y to the specific driver for your adapter below.
 
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-pca.

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
