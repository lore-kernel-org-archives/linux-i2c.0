From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 5/9] i2c-s3c2410: Add ARCH_S3C64XX to allowed archs
Date: Fri, 31 Oct 2008 16:04:25 +0000
Message-ID: <20081031160437.506489883@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-allow-s3c64xx-build.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-s3c2410 driver should be able to support the
ARCH_S3C64XX as well as the ARCH_S3C2410.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/drivers/i2c/busses/Kconfig
===================================================================
--- linux.git.orig/drivers/i2c/busses/Kconfig	2008-10-30 15:28:48.000000000 +0000
+++ linux.git/drivers/i2c/busses/Kconfig	2008-10-30 15:29:42.000000000 +0000
@@ -455,11 +455,12 @@ config I2C_PXA_SLAVE
 	  I2C bus.
 
 config I2C_S3C2410
-	tristate "S3C2410 I2C Driver"
-	depends on ARCH_S3C2410
+	tristate "Samsung SoC I2C Driver (S3C24XX and S3C64XX series)"
+	depends on ARCH_S3C2410 || ARCH_S3C64XX
 	help
 	  Say Y here to include support for I2C controller in the
-	  Samsung S3C2410 based System-on-Chip devices.
+	  Samsung S3C based System-on-Chip devices such as the S3C2410,
+	  S3C2440, S3C2442, S3C2443 and S3C6410.
 
 config I2C_SH7760
 	tristate "Renesas SH7760 I2C Controller"

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
