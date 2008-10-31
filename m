From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 2/9] i2c-s3c2410: Use <linux/io.h> over <asm/io.h>
Date: Fri, 31 Oct 2008 16:04:22 +0000
Message-ID: <20081031160436.828437056@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-fix-io-include.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The <linux/io.h> include should be used in prefference
to <asm/io.h>, so replace it.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-10-30 14:51:00.000000000 +0000
+++ linux.git/drivers/i2c/busses/i2c-s3c2410.c	2008-10-30 14:51:16.000000000 +0000
@@ -34,10 +34,10 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/io.h>
 
 #include <mach/regs-gpio.h>
 #include <plat/regs-iic.h>

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
