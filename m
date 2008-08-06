From: Carlos Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
Subject: [PATCH 6/6] I2C: MENELAUS: Renaming menelaus to twl92230
Date: Wed, 06 Aug 2008 14:01:11 -0400
Message-ID: <4899E6E7.5020003@indt.org.br>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>

This patch renames menelaus files and includes to twl92230,
as discussed at linux-omap mailing list.

It also fix wrong menelaus chip name at drivers/i2c/chips/Kconfig

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
---
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/plat-omap/devices.c                 |    2 +-
 drivers/i2c/chips/Kconfig                    |    4 ++--
 drivers/i2c/chips/{menelaus.c => twl92230.c} |    2 +-
 drivers/input/keyboard/omap-keypad.c         |    2 +-
 include/linux/i2c/{menelaus.h => twl92230.h} |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/i2c/chips/{menelaus.c => twl92230.c} (99%)
 rename include/linux/i2c/{menelaus.h => twl92230.h} (99%)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index b2e9d95..bde92e1 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -21,7 +21,7 @@
 #include <linux/input.h>
 #include <linux/err.h>
 #include <linux/clk.h>
-#include <linux/i2c/menelaus.h>
+#include <linux/i2c/twl92230.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index b755ced..8d2ca62 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/menelaus.h>
+#include <linux/i2c/twl92230.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index a95cb94..165b77c 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -163,11 +163,11 @@ config SENSORS_TSL2550
 	  will be called tsl2550.
 
 config MENELAUS
-	bool "TWL92330/Menelaus PM chip"
+	bool "TWL92230/Menelaus PM chip"
 	depends on I2C=y && ARCH_OMAP24XX
 	help
 	  If you say yes here you get support for the Texas Instruments
-	  TWL92330/Menelaus Power Management chip. This include voltage
+	  TWL92230/Menelaus Power Management chip. This include voltage
 	  regulators, Dual slot memory card tranceivers, real-time clock
 	  and other features that are often used in portable devices like
 	  cell phones and PDAs.
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/twl92230.c
similarity index 99%
rename from drivers/i2c/chips/menelaus.c
rename to drivers/i2c/chips/twl92230.c
index 87c4246..614edc0 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/twl92230.c
@@ -40,7 +40,7 @@
 #include <linux/delay.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
-#include <linux/i2c/menelaus.h>
+#include <linux/i2c/twl92230.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index c379d63..51c9118 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -34,7 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/errno.h>
-#include <linux/i2c/menelaus.h>
+#include <linux/i2c/twl92230.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/keypad.h>
 #include <asm/irq.h>
diff --git a/include/linux/i2c/menelaus.h b/include/linux/i2c/twl92230.h
similarity index 99%
rename from include/linux/i2c/menelaus.h
rename to include/linux/i2c/twl92230.h
index 9587398..ce4ec2a 100644
--- a/include/linux/i2c/menelaus.h
+++ b/include/linux/i2c/twl92230.h
@@ -1,5 +1,5 @@
 /*
- * include/linux/i2c/menelaus.h
+ * include/linux/i2c/twl92230.h
  *
  * Functions to access Menelaus power management chip
  */
-- 1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
