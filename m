From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: chips subdirectory is deprecated
Date: Mon, 10 Mar 2008 21:55:06 +0100
Message-ID: <20080310215506.1bdfd9fe@hyperion.delvare>
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

Let driver authors know that drivers/i2c/chips is usually the wrong place
for new drivers.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/chips/Makefile |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.25-rc5.orig/drivers/i2c/chips/Makefile	2008-02-11 09:48:54.000000000 +0100
+++ linux-2.6.25-rc5/drivers/i2c/chips/Makefile	2008-03-10 21:50:14.000000000 +0100
@@ -1,6 +1,13 @@
 #
 # Makefile for miscellaneous I2C chip drivers.
 #
+# Think twice before you add a new driver to this directory.
+# Device drivers are better grouped according to the functionality they
+# implement rather than to the bus they are connected to. In particular:
+# * Hardware monitoring chip drivers go to drivers/hwmon
+# * RTC chip drivers go to drivers/rtc
+# * I/O expander drivers go to drivers/gpio
+#
 
 obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
