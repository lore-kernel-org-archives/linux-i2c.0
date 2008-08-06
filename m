From: Carlos Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
Subject: [PATCH 3/6] I2C: MENELAUS: Move menelaus header to
	include/linux/i2c
Date: Wed, 06 Aug 2008 14:00:57 -0400
Message-ID: <4899E6D9.8050306@indt.org.br>
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

This patch moves menelaus header from include/asm-arm/arch-omap/
to include/linux/i2c/

It also includes menelaus' headers to include/linux/i2c

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
---
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/plat-omap/devices.c                       |    2 +-
 drivers/i2c/chips/menelaus.c                       |    2 +-
 drivers/input/keyboard/omap-keypad.c               |    2 +-
 .../{asm-arm/arch-omap => linux/i2c}/menelaus.h    |    0 
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/{asm-arm/arch-omap => linux/i2c}/menelaus.h (100%)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0d28f68..b2e9d95 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -21,6 +21,7 @@
 #include <linux/input.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/i2c/menelaus.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -37,7 +38,6 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/keypad.h>
-#include <asm/arch/menelaus.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/gpmc.h>
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 81002b7..b755ced 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/i2c/menelaus.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -23,7 +24,6 @@
 #include <asm/arch/board.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch/menelaus.h>
 #include <asm/arch/mcbsp.h>
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index 06387b4..1f098c3 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -40,12 +40,12 @@
 #include <linux/delay.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/i2c/menelaus.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 
 #include <asm/arch/gpio.h>
-#include <asm/arch/menelaus.h>
 
 #define DRIVER_NAME			"menelaus"
 
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 10afd20..c379d63 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -34,9 +34,9 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/errno.h>
+#include <linux/i2c/menelaus.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/keypad.h>
-#include <asm/arch/menelaus.h>
 #include <asm/irq.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
diff --git a/include/asm-arm/arch-omap/menelaus.h b/include/linux/i2c/menelaus.h
similarity index 100%
rename from include/asm-arm/arch-omap/menelaus.h
rename to include/linux/i2c/menelaus.h
-- 1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
