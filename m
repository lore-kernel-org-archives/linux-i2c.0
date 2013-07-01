From: Nguyen Viet Dung <user-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH 2/4] ARM: shmobile: r8a7790: add I2C setup
Date: Mon,  1 Jul 2013 19:00:09 +0900
Message-ID: <1372672810-20609-3-git-send-email-user@jinso.co.jp>
References: <1372672810-20609-1-git-send-email-user@jinso.co.jp>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1372672810-20609-1-git-send-email-user-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

This patch add setup for I2C bus.

Signed-off-by: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        |   28 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 2e919e6..85d3567 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -1,7 +1,10 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
+#include <linux/i2c/i2c-rcar.h>
+
 void r8a7790_add_standard_devices(void);
+void r8a7790_add_i2c_device(int idx, struct i2c_rcar_platform_data *pdata);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_timer_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index ed7ee24..0ab912b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -24,6 +24,7 @@
 #include <linux/serial_sci.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
+#include <linux/i2c/i2c-rcar.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7790.h>
@@ -137,6 +138,33 @@ static struct resource irqc0_resources[] = {
 					  &irqc##idx##_data,		\
 					  sizeof(struct renesas_irqc_config))
 
+/* I2C */
+static struct resource rcar_i2c_res[] __initdata = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xe6508000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(287)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xe6518000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(288)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xe6530000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(286)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xe6540000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(290)),
+};
+
+void __init r8a7790_add_i2c_device(int idx,
+				   struct i2c_rcar_platform_data *pdata)
+{
+	BUG_ON(idx < 0 || idx > 3);
+
+	platform_device_register_resndata(
+			&platform_bus, "i2c-rcar", idx,
+			rcar_i2c_res + (2*idx), 2,
+			pdata, sizeof(*pdata));
+}
+
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_register_scif(SCIFA0);
-- 
1.7.9.5
