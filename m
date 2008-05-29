From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 8/8] ANUBIS: Add i2c device list to Simtec Anubis
Date: Thu, 29 May 2008 14:22:52 +0100
Message-ID: <20080529132407.411945350@fluff.org.uk>
References: <20080529132244.818543231@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-mach-anubis-add-i2c-boardinfo.patch
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
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add i2c board info initialiser to setup the list of
I2C devices present on an Simtec Anubis.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc4-quilt1/arch/arm/mach-s3c2440/mach-anubis.c
===================================================================
--- linux-2.6.26-rc4-quilt1.orig/arch/arm/mach-s3c2440/mach-anubis.c	2008-05-28 00:04:12.000000000 +0100
+++ linux-2.6.26-rc4-quilt1/arch/arm/mach-s3c2440/mach-anubis.c	2008-05-28 00:05:42.000000000 +0100
@@ -1,6 +1,6 @@
 /* linux/arch/arm/mach-s3c2440/mach-anubis.c
  *
- * Copyright (c) 2003-2005 Simtec Electronics
+ * Copyright (c) 2003-2005,2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
  *
@@ -18,6 +18,7 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
+#include <linux/i2c.h>
 
 #include <linux/sm501.h>
 #include <linux/sm501-regs.h>
@@ -421,6 +422,19 @@ static struct clk *anubis_clocks[] = {
 	&s3c24xx_uclk,
 };
 
+/* I2C devices. */
+
+static struct i2c_board_info anubis_i2c_info[] __initdata = {
+	{
+		.type	= "tps65011",
+		.addr	= 0x48,
+		.irq	= IRQ_EINT20,
+	}, {
+		.type	= "eeprom",
+		.addr	= 0x50,
+	}
+};
+
 static void __init anubis_map_io(void)
 {
 	/* initialise the clocks */
@@ -460,6 +474,9 @@ static void __init anubis_map_io(void)
 static void __init anubis_init(void)
 {
 	platform_add_devices(anubis_devices, ARRAY_SIZE(anubis_devices));
+
+	i2c_register_board_info(0, anubis_i2c_info,
+				ARRAY_SIZE(anubis_i2c_info));
 }
 
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
