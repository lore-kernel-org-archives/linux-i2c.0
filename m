From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Remove the algorithm drivers from the config menu
Date: Wed, 13 Feb 2008 11:03:07 +0100
Message-ID: <20080213110307.16528fd8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The algorithm drivers are helper drivers that are selected automatically
as needed. There's no point in listing them in the config menu, it can
only confuse users and waste their time.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/Kconfig |   39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

--- linux-2.6.25-rc1.orig/drivers/i2c/algos/Kconfig	2008-02-13 09:51:09.000000000 +0100
+++ linux-2.6.25-rc1/drivers/i2c/algos/Kconfig	2008-02-13 10:04:46.000000000 +0100
@@ -1,45 +1,16 @@
 #
-# Character device configuration
+# I2C algorithm drivers configuration
 #
 
-menu "I2C Algorithms"
-
 config I2C_ALGOBIT
-	tristate "I2C bit-banging interfaces"
-	help
-	  This allows you to use a range of I2C adapters called bit-banging
-	  adapters.  Say Y if you own an I2C adapter belonging to this class
-	  and then say Y to the specific driver for you adapter below.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-algo-bit.
+	tristate
 
 config I2C_ALGOPCF
-	tristate "I2C PCF 8584 interfaces"
-	help
-	  This allows you to use a range of I2C adapters called PCF adapters.
-	  Say Y if you own an I2C adapter belonging to this class and then say
-	  Y to the specific driver for you adapter below.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-algo-pcf.
+	tristate
 
 config I2C_ALGOPCA
-	tristate "I2C PCA 9564 interfaces"
-	help
-	  This allows you to use a range of I2C adapters called PCA adapters.
-	  Say Y if you own an I2C adapter belonging to this class and then say
-	  Y to the specific driver for you adapter below.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-algo-pca.
+	tristate
 
 config I2C_ALGO_SGI
-	tristate "I2C SGI interfaces"
+	tristate
 	depends on SGI_IP22 || SGI_IP32 || X86_VISWS
-	help
-	  Supports the SGI interfaces like the ones found on SGI Indy VINO
-	  or SGI O2 MACE.
-
-endmenu
-


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
