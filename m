From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 4/9] i2c-s3c2410: use platform data for gpio configuration
Date: Fri, 31 Oct 2008 16:04:24 +0000
Message-ID: <20081031160437.274275162@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-remove-gpio-config.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add a callback to set the gpio configuration for the
i2c device instead of a set include. This also allows
the remvoal of the machine gpio and hardware files.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:55:50.000000000 +0000
+++ linux.git/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:55:54.000000000 +0000
@@ -36,10 +36,8 @@
 #include <linux/cpufreq.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 
-#include <mach/regs-gpio.h>
 #include <plat/regs-iic.h>
 #include <plat/iic.h>
 
@@ -490,9 +488,6 @@ static int s3c24xx_i2c_set_master(struct
 		msleep(1);
 	}
 
-	dev_dbg(i2c->dev, "timeout: GPEDAT is %08x\n",
-		__raw_readl(S3C2410_GPEDAT));
-
 	return -ETIMEDOUT;
 }
 
@@ -784,12 +779,12 @@ static int s3c24xx_i2c_init(struct s3c24
 
 	/* get the plafrom data */
 
-	pdata = s3c24xx_i2c_get_platformdata(i2c->adap.dev.parent);
+	pdata = s3c24xx_i2c_get_platformdata(i2c->dev);
 
 	/* inititalise the gpio */
 
-	s3c2410_gpio_cfgpin(S3C2410_GPE15, S3C2410_GPE15_IICSDA);
-	s3c2410_gpio_cfgpin(S3C2410_GPE14, S3C2410_GPE14_IICSCL);
+	if (pdata->cfg_gpio)
+		pdata->cfg_gpio(to_platform_device(i2c->dev));
 
 	/* write slave address */
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
