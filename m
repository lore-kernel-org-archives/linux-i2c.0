From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 8/9] S3C: Add i2c1 device definition
Date: Fri, 31 Oct 2008 16:04:28 +0000
Message-ID: <20081031160438.182603988@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-add-second-i2c-bus.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add device definition and support functions for the
second i2c device (i2c1). If this is selected, the first
i2c bus will become index 0 instead of index -1.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/arch/arm/plat-s3c/dev-i2c1.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/arch/arm/plat-s3c/dev-i2c1.c	2008-10-31 00:06:44.000000000 +0000
@@ -0,0 +1,68 @@
+/* linux/arch/arm/plat-s3c/dev-i2c1.c
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * S3C series device definition for i2c device 1
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/map.h>
+
+#include <plat/regs-iic.h>
+#include <plat/iic.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+static struct resource s3c_i2c_resource[] = {
+	[0] = {
+		.start = S3C_PA_IIC1,
+		.end   = S3C_PA_IIC1 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IIC1,
+		.end   = IRQ_IIC1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c1 = {
+	.name		  = "s3c2410-i2c",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
+	.resource	  = s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data1 __initdata = {
+	.flags		= 0,
+	.bus_num	= 1,
+	.slave_addr	= 0x10,
+	.bus_freq	= 100*1000,
+	.max_freq	= 400*1000,
+	.sda_delay	= S3C2410_IICLC_SDA_DELAY5 | S3C2410_IICLC_FILTER_ON,
+};
+
+void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data1;
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	else if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
+
+	s3c_device_i2c1.dev.platform_data = npd;
+}
Index: linux.git/arch/arm/mach-s3c6400/include/mach/map.h
===================================================================
--- linux.git.orig/arch/arm/mach-s3c6400/include/mach/map.h	2008-10-31 00:00:24.000000000 +0000
+++ linux.git/arch/arm/mach-s3c6400/include/mach/map.h	2008-10-31 00:00:36.000000000 +0000
@@ -41,6 +41,7 @@
 #define S3C64XX_PA_SYSCON	(0x7E00F000)
 #define S3C64XX_PA_TIMER	(0x7F006000)
 #define S3C64XX_PA_IIC0		(0x7F004000)
+#define S3C64XX_PA_IIC1		(0x7F00F000)
 
 #define S3C64XX_PA_GPIO		(0x7F008000)
 #define S3C64XX_VA_GPIO		S3C_ADDR(0x00500000)
@@ -60,5 +61,6 @@
 #define S3C_PA_HSMMC1		S3C64XX_PA_HSMMC1
 #define S3C_PA_HSMMC2		S3C64XX_PA_HSMMC2
 #define S3C_PA_IIC		S3C64XX_PA_IIC0
+#define S3C_PA_IIC1		S3C64XX_PA_IIC1
 
 #endif /* __ASM_ARCH_6400_MAP_H */
Index: linux.git/arch/arm/plat-s3c/Kconfig
===================================================================
--- linux.git.orig/arch/arm/plat-s3c/Kconfig	2008-10-31 00:00:24.000000000 +0000
+++ linux.git/arch/arm/plat-s3c/Kconfig	2008-10-31 00:00:36.000000000 +0000
@@ -160,3 +160,9 @@ config S3C_DEV_HSMMC1
 	depends on PLAT_S3C
 	help
 	  Compile in platform device definitions for HSMMC channel 1
+
+config S3C_DEV_I2C1
+	bool
+	depends on PLAT_S3C
+	help
+	  Compile in platform device definitions for I2C channel 1
Index: linux.git/arch/arm/plat-s3c/Makefile
===================================================================
--- linux.git.orig/arch/arm/plat-s3c/Makefile	2008-10-31 00:00:24.000000000 +0000
+++ linux.git/arch/arm/plat-s3c/Makefile	2008-10-31 00:00:36.000000000 +0000
@@ -23,3 +23,4 @@ obj-y				+= gpio-config.o
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
 obj-y				+= dev-i2c0.o
+obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
Index: linux.git/arch/arm/plat-s3c/dev-i2c0.c
===================================================================
--- linux.git.orig/arch/arm/plat-s3c/dev-i2c0.c	2008-10-31 00:00:24.000000000 +0000
+++ linux.git/arch/arm/plat-s3c/dev-i2c0.c	2008-10-31 00:07:05.000000000 +0000
@@ -37,12 +37,16 @@ static struct resource s3c_i2c_resource[
 
 struct platform_device s3c_device_i2c0 = {
 	.name		  = "s3c2410-i2c",
+#ifdef CONFIG_S3C_DEV_I2C1
+	.id		  = 0,
+#else
 	.id		  = -1,
+#endif
 	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
 	.resource	  = s3c_i2c_resource,
 };
 
-struct s3c2410_platform_i2c default_i2c_data __initdata = {
+static struct s3c2410_platform_i2c default_i2c_data0 __initdata = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
 	.bus_freq	= 100*1000,
@@ -55,7 +59,7 @@ void __init s3c_i2c0_set_platdata(struct
 	struct s3c2410_platform_i2c *npd;
 
 	if (!pd)
-		pd = &default_i2c_data;
+		pd = &default_i2c_data0;
 
 	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
 	if (!npd)
Index: linux.git/arch/arm/plat-s3c/include/plat/iic.h
===================================================================
--- linux.git.orig/arch/arm/plat-s3c/include/plat/iic.h	2008-10-31 00:00:24.000000000 +0000
+++ linux.git/arch/arm/plat-s3c/include/plat/iic.h	2008-10-31 00:00:36.000000000 +0000
@@ -48,8 +48,10 @@ struct s3c2410_platform_i2c {
  * as the driver will no longer carry defaults.
  */
 extern void s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *i2c);
+extern void s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *i2c);
 
 /* defined by architecture to configure gpio */
 extern void s3c_i2c0_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c1_cfg_gpio(struct platform_device *dev);
 
 #endif /* __ASM_ARCH_IIC_H */
Index: linux.git/arch/arm/plat-s3c/include/plat/devs.h
===================================================================
--- linux.git.orig/arch/arm/plat-s3c/include/plat/devs.h	2008-10-31 00:00:24.000000000 +0000
+++ linux.git/arch/arm/plat-s3c/include/plat/devs.h	2008-10-31 00:00:36.000000000 +0000
@@ -28,6 +28,7 @@ extern struct platform_device s3c_device
 extern struct platform_device s3c_device_lcd;
 extern struct platform_device s3c_device_wdt;
 extern struct platform_device s3c_device_i2c0;
+extern struct platform_device s3c_device_i2c1;
 extern struct platform_device s3c_device_iis;
 extern struct platform_device s3c_device_rtc;
 extern struct platform_device s3c_device_adc;
Index: linux.git/arch/arm/plat-s3c64xx/include/plat/irqs.h
===================================================================
--- linux.git.orig/arch/arm/plat-s3c64xx/include/plat/irqs.h	2008-10-31 00:03:34.000000000 +0000
+++ linux.git/arch/arm/plat-s3c64xx/include/plat/irqs.h	2008-10-31 00:13:33.000000000 +0000
@@ -70,6 +70,7 @@
 #define IRQ_CAMIF_C		S3C64XX_IRQ_VIC0(3)
 #define IRQ_CAMIF_P		S3C64XX_IRQ_VIC0(4)
 #define IRQ_CAMIF_MC		S3C64XX_IRQ_VIC0(5)
+#define IRQ_S3C6410_IIC1	S3C64XX_IRQ_VIC0(5)
 #define IRQ_S3C6410_IIS		S3C64XX_IRQ_VIC0(6)
 #define IRQ_S3C6400_CAMIF_MP	S3C64XX_IRQ_VIC0(6)
 #define IRQ_CAMIF_WE_C		S3C64XX_IRQ_VIC0(7)
@@ -144,6 +145,10 @@
 #define IRQ_TIMER3		S3C64XX_TIMER_IRQ(3)
 #define IRQ_TIMER4		S3C64XX_TIMER_IRQ(4)
 
+/* compatibility for device defines */
+
+#define IRQ_IIC1		IRQ_S3C6410_IIC1
+
 /* Since the IRQ_EINT(x) are a linear mapping on current s3c64xx series
  * we just defined them as an IRQ_EINT(x) macro from S3C_IRQ_EINT_BASE
  * which we place after the pair of VICs. */

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
