From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 5/8] OSIRIS: Add i2c device list to Simtec Osiris
Date: Thu, 29 May 2008 14:22:49 +0100
Message-ID: <20080529132406.837870894@fluff.org.uk>
References: <20080529132244.818543231@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-mach-osiris-i2c-boardinfo.patch
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

Add an i2c board information initialisers to the board
to define which devices are present.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

--- linux-2.6.26-rc4-quilt1.orig/arch/arm/mach-s3c2440/mach-osiris.c	2008-05-27 15:14:42.000000000 +0100
+++ linux-2.6.26-rc4-quilt1/arch/arm/mach-s3c2440/mach-osiris.c	2008-05-27 15:22:33.000000000 +0100
@@ -1,6 +1,6 @@
 /* linux/arch/arm/mach-s3c2440/mach-osiris.c
  *
- * Copyright (c) 2005 Simtec Electronics
+ * Copyright (c) 2005,2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
  *
@@ -19,6 +19,7 @@
 #include <linux/sysdev.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/i2c.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -322,6 +323,19 @@ static struct sys_device osiris_pm_sysde
 	.cls		= &osiris_pm_sysclass,
 };
 
+/* I2C devices fitted. */
+
+static struct i2c_board_info osiris_i2c_info[] __initdata = {
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
 /* Standard Osiris devices */
 
 static struct platform_device *osiris_devices[] __initdata = {
@@ -388,6 +402,9 @@ static void __init osiris_init(void)
 	sysdev_class_register(&osiris_pm_sysclass);
 	sysdev_register(&osiris_pm_sysdev);
 
+	i2c_register_board_info(0, osiris_i2c_info,
+				ARRAY_SIZE(osiris_i2c_info));
+
 	platform_add_devices(osiris_devices, ARRAY_SIZE(osiris_devices));
 };
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
