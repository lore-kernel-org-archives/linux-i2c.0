From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.26-rc5] i2c: deprecate the legacy gpio drivers
Date: Wed, 11 Jun 2008 13:08:15 -0700
Message-ID: <200806111308.15166.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
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
List-Id: linux-i2c@vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

The legacy pcf8574/8574a and pcf8575 drivers should be avoided
on systems using the new gpiolib code, and generally deprecated
in the same way the legacy pca9539 driver is deprecated.

Also, correct the pca9539 deprecation to match the current name
of the preferred driver:  pca953x, supporting several more chips.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

--- a/drivers/i2c/chips/Kconfig	2008-06-11 12:46:52.000000000 -0700
+++ b/drivers/i2c/chips/Kconfig	2008-06-11 12:21:45.000000000 -0700
@@ -52,8 +52,8 @@ config SENSORS_EEPROM
 	  will be called eeprom.
 
 config SENSORS_PCF8574
-	tristate "Philips PCF8574 and PCF8574A"
-	depends on EXPERIMENTAL
+	tristate "Philips PCF8574 and PCF8574A (DEPRECATED)"
+	depends on EXPERIMENTAL && GPIO_PCF857X = "n"
 	default n
 	help
 	  If you say yes here you get support for Philips PCF8574 and 
@@ -62,12 +62,16 @@ config SENSORS_PCF8574
 	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8574.
 
+	  This driver is deprecated and will be dropped soon. Use
+	  drivers/gpio/pcf857x.c instead.
+
 	  These devices are hard to detect and rarely found on mainstream
 	  hardware.  If unsure, say N.
 
 config PCF8575
-	tristate "Philips PCF8575"
+	tristate "Philips PCF8575 (DEPRECATED)"
 	default n
+	depends on GPIO_PCF857X = "n"
 	help
 	  If you say yes here you get support for Philips PCF8575 chip.
 	  This chip is a 16-bit I/O expander for the I2C bus.  Several other
@@ -76,12 +80,15 @@ config PCF8575
 	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8575.
 
+	  This driver is deprecated and will be dropped soon. Use
+	  drivers/gpio/pcf857x.c instead.
+
 	  This device is hard to detect and is rarely found on mainstream
 	  hardware.  If unsure, say N.
 
 config SENSORS_PCA9539
 	tristate "Philips PCA9539 16-bit I/O port (DEPRECATED)"
-	depends on EXPERIMENTAL && GPIO_PCA9539 = "n"
+	depends on EXPERIMENTAL && GPIO_PCA953X = "n"
 	help
 	  If you say yes here you get support for the Philips PCA9539
 	  16-bit I/O port.
@@ -90,7 +97,7 @@ config SENSORS_PCA9539
 	  will be called pca9539.
 
 	  This driver is deprecated and will be dropped soon. Use
-	  drivers/gpio/pca9539.c instead.
+	  drivers/gpio/pca953x.c instead.
 
 config SENSORS_PCF8591
 	tristate "Philips PCF8591"

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
