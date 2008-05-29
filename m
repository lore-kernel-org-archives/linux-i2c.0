From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 6/8] BAST: Add i2c device list on Simtec Bast
Date: Thu, 29 May 2008 14:22:50 +0100
Message-ID: <20080529132407.003503849@fluff.org.uk>
References: <20080529132244.818543231@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-mach-bast-add-i2c-boardinfo.patch
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

Add i2c boardinfo for the connected i2c devices on the
Simtec Bast.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc4-quilt2/arch/arm/mach-s3c2410/mach-bast.c
===================================================================
--- linux-2.6.26-rc4-quilt2.orig/arch/arm/mach-s3c2410/mach-bast.c	2008-05-28 22:37:09.000000000 +0100
+++ linux-2.6.26-rc4-quilt2/arch/arm/mach-s3c2410/mach-bast.c	2008-05-29 10:20:54.000000000 +0100
@@ -1,6 +1,6 @@
 /* linux/arch/arm/mach-s3c2410/mach-bast.c
  *
- * Copyright (c) 2003-2005 Simtec Electronics
+ * Copyright (c) 2003-2005,2008 Simtec Electronics
  *   Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
  *
  * http://www.simtec.co.uk/products/EB2410ITX/
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/dm9000.h>
 #include <linux/ata_platform.h>
+#include <linux/i2c.h>
 
 #include <net/ax88796.h>
 
@@ -534,6 +535,23 @@ static struct s3c2410fb_mach_info __init
 	.default_display = 1,
 };
 
+/* I2C devices fitted. */
+
+static struct i2c_board_info bast_i2c_devs[] __initdata = {
+	{
+		.type	= "tlv320aic23",
+		.addr	= 0x1a,
+	}, {
+		.type	= "eeprom",
+		.addr	= 0x50,
+	}, {
+		.type	= "simtec-pmu",
+		.addr	= 0x6b,
+	}, {
+		.type	= "ch7013",
+		.addr	= 0x75,
+	},
+};
 
 /* Standard BAST devices */
 
@@ -593,6 +611,9 @@ static void __init bast_init(void)
 	s3c24xx_fb_set_platdata(&bast_fb_info);
 	platform_add_devices(bast_devices, ARRAY_SIZE(bast_devices));
 
+	i2c_register_board_info(0, bast_i2c_devs,
+				ARRAY_SIZE(bast_i2c_devs));
+
 	nor_simtec_init();
 }
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
