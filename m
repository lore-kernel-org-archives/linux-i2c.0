From: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: Re: [PATCH] Bugfix for i2c-s3c2410
Date: Fri, 13 Mar 2009 13:53:46 +0000
Message-ID: <1236952426.3897.5.camel@petitemort>
References: <1234446401.9457.25.camel@petitemort>
Reply-To: dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1234446401.9457.25.camel@petitemort>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2009-02-12 at 13:46 +0000, Daniel Silverstone wrote:
[snip]

I have no idea how, but one critical line got missed out of my previous
attempt at this patch. This patch is the corrected version. It still
depends on the sda-in-ns patch in this thread.

Regards,

Daniel.

I2C: Rework i2c-s3c2410 frequency calculator to be much simpler.

The platform data for the i2c-s3c2410 driver used to allow a min,
max and desired frequency for the I2C bus. This patch reduces it
to simply a desired frequency ceiling and corrects all the uses
of the platform data appropriately.

This means, for example, that on a system with a 66MHz fclk, a
request for 100KHz will achieve 65KHz which is safe and
acceptable, rather than 378KHz which it would have achieved
without this change.

Signed-off-by: Simtec Linux Team <linux-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Signed-off-by: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

---
 arch/arm/mach-s3c2410/mach-bast.c    |    3 --
 arch/arm/mach-s3c2410/mach-n30.c     |    3 --
 arch/arm/mach-s3c2412/mach-jive.c    |    3 --
 arch/arm/plat-s3c/dev-i2c0.c         |    5 +--
 arch/arm/plat-s3c/dev-i2c1.c         |    5 +--
 arch/arm/plat-s3c/include/plat/iic.h |   33 +++++++++++++----------
 drivers/i2c/busses/i2c-s3c2410.c     |   50
+++++++----------------------------
 7 files changed, 37 insertions(+), 65 deletions(-)

Index: b/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- a/drivers/i2c/busses/i2c-s3c2410.c	2009-03-13 13:47:05.945607615
+0000
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2009-03-13 13:47:37.057606432
+0000
@@ -1,6 +1,6 @@
 /* linux/drivers/i2c/busses/i2c-s3c2410.c
  *
- * Copyright (C) 2004,2005 Simtec Electronics
+ * Copyright (C) 2004,2005,2009 Simtec Electronics
  *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
  *
  * S3C2410 I2C Controller
@@ -590,18 +590,6 @@ static int s3c24xx_i2c_calcdivisor(unsig
 	return clkin / (calc_divs * calc_div1);
 }
 
-/* freq_acceptable
- *
- * test wether a frequency is within the acceptable range of error
-*/
-
-static inline int freq_acceptable(unsigned int freq, unsigned int
wanted)
-{
-	int diff = freq - wanted;
-
-	return diff >= -2 && diff <= 2;
-}
-
 /* s3c24xx_i2c_clockrate
  *
  * work out a divisor for the user requested frequency setting,
@@ -614,44 +602,28 @@ static int s3c24xx_i2c_clockrate(struct 
 	struct s3c2410_platform_i2c *pdata = i2c->dev->platform_data;
 	unsigned long clkin = clk_get_rate(i2c->clk);
 	unsigned int divs, div1;
+	unsigned long target_frequency;
 	u32 iiccon;
 	int freq;
-	int start, end;
 
 	i2c->clkrate = clkin;
 	clkin /= 1000;		/* clkin now in KHz */
 
-	dev_dbg(i2c->dev, "pdata %p, freq %lu %lu..%lu\n",
-		 pdata, pdata->bus_freq, pdata->min_freq, pdata->max_freq);
+	dev_dbg(i2c->dev, "pdata desired frequency %lu\n", pdata->frequency);
 
-	if (pdata->bus_freq != 0) {
-		freq = s3c24xx_i2c_calcdivisor(clkin, pdata->bus_freq/1000,
-					       &div1, &divs);
-		if (freq_acceptable(freq, pdata->bus_freq/1000))
-			goto found;
-	}
-
-	/* ok, we may have to search for something suitable... */
-
-	start = (pdata->max_freq == 0) ? pdata->bus_freq : pdata->max_freq;
-	end = pdata->min_freq;
+	target_frequency = pdata->frequency ? pdata->frequency : 100000;
 
-	start /= 1000;
-	end /= 1000;
+	target_frequency /= 1000; /* Target frequency now in KHz */
 
-	/* search loop... */
+	freq = s3c24xx_i2c_calcdivisor(clkin, target_frequency, &div1, &divs);
 
-	for (; start > end; start--) {
-		freq = s3c24xx_i2c_calcdivisor(clkin, start, &div1, &divs);
-		if (freq_acceptable(freq, start))
-			goto found;
+	if (freq > target_frequency) {
+		dev_err(i2c->dev,
+			"Unable to achieve desired frequency %luKHz."	\
+			" Lowest achievable %dKHz\n", target_frequency, freq);
+		return -EINVAL;
 	}
 
-	/* cannot find frequency spec */
-
-	return -EINVAL;
-
- found:
 	*got = freq;
 
 	iiccon = readl(i2c->regs + S3C2410_IICCON);
Index: b/arch/arm/plat-s3c/include/plat/iic.h
===================================================================
--- a/arch/arm/plat-s3c/include/plat/iic.h	2009-03-13 13:30:56.181950363
+0000
+++ b/arch/arm/plat-s3c/include/plat/iic.h	2009-03-13 13:47:09.077105973
+0000
@@ -1,9 +1,9 @@
-/* arch/arm/mach-s3c2410/include/mach/iic.h
+/* arch/arm/plat-s3c/include/plat/iic.h
  *
- * Copyright (c) 2004 Simtec Electronics
+ * Copyright 2004,2009 Simtec Electronics
  *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
  *
- * S3C2410 - I2C Controller platfrom_device info
+ * S3C - I2C Controller platform_device info
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -15,19 +15,24 @@
 
 #define S3C_IICFLG_FILTER	(1<<0)	/* enable s3c2440 filter */
 
-/* Notes:
- *	1) All frequencies are expressed in Hz
- *	2) A value of zero is `do not care`
-*/
-
+/**
+ *	struct s3c2410_platform_i2c - Platform data for s3c I2C.
+ *	@bus_num: The bus number to use (if possible).
+ *	@flags: Any flags for the I2C bus (E.g. S3C_IICFLK_FILTER).
+ *	@slave_addr: The I2C address for the slave device (if enabled).
+ *	@frequency: The desired frequency in Hz of the bus.  This is
+ *                  guaranteed to not be exceeded.  If the caller does
+ *                  not care, use zero and the driver will select a
+ *                  useful default.
+ *	@sda_delay: The delay (in ns) applied to SDA edges.
+ *	@cfg_gpio: A callback to configure the pins for I2C operation.
+ */
 struct s3c2410_platform_i2c {
-	int		bus_num;	/* bus number to use */
+	int		bus_num;
 	unsigned int	flags;
-	unsigned int	slave_addr;	/* slave address for controller */
-	unsigned long	bus_freq;	/* standard bus frequency */
-	unsigned long	max_freq;	/* max frequency for the bus */
-	unsigned long	min_freq;	/* min frequency for the bus */
-	unsigned int	sda_delay;	/* pclks (s3c2440 only) */
+	unsigned int	slave_addr;
+	unsigned long	frequency;
+	unsigned int	sda_delay;
 
 	void	(*cfg_gpio)(struct platform_device *dev);
 };
Index: b/arch/arm/plat-s3c/dev-i2c0.c
===================================================================
--- a/arch/arm/plat-s3c/dev-i2c0.c	2009-03-13 13:47:06.359240433 +0000
+++ b/arch/arm/plat-s3c/dev-i2c0.c	2009-03-13 13:47:09.145148780 +0000
@@ -1,6 +1,6 @@
 /* linux/arch/arm/plat-s3c/dev-i2c0.c
  *
- * Copyright 2008 Simtec Electronics
+ * Copyright 2008,2009 Simtec Electronics
  *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
  *	http://armlinux.simtec.co.uk/
  *
@@ -50,8 +50,7 @@ struct platform_device s3c_device_i2c0 =
 static struct s3c2410_platform_i2c default_i2c_data0 __initdata = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
-	.bus_freq	= 100*1000,
-	.max_freq	= 400*1000,
+	.frequency	= 100*1000,
 	.sda_delay	= 100,
 };
 
Index: b/arch/arm/plat-s3c/dev-i2c1.c
===================================================================
--- a/arch/arm/plat-s3c/dev-i2c1.c	2009-03-13 13:47:06.437106932 +0000
+++ b/arch/arm/plat-s3c/dev-i2c1.c	2009-03-13 13:47:09.193107506 +0000
@@ -1,6 +1,6 @@
 /* linux/arch/arm/plat-s3c/dev-i2c1.c
  *
- * Copyright 2008 Simtec Electronics
+ * Copyright 2008,2009 Simtec Electronics
  *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
  *	http://armlinux.simtec.co.uk/
  *
@@ -47,8 +47,7 @@ static struct s3c2410_platform_i2c defau
 	.flags		= 0,
 	.bus_num	= 1,
 	.slave_addr	= 0x10,
-	.bus_freq	= 100*1000,
-	.max_freq	= 400*1000,
+	.frequency	= 100*1000,
 	.sda_delay	= 100,
 };
 
Index: b/arch/arm/mach-s3c2410/mach-bast.c
===================================================================
--- a/arch/arm/mach-s3c2410/mach-bast.c	2009-03-13 13:30:34.373454339
+0000
+++ b/arch/arm/mach-s3c2410/mach-bast.c	2009-03-13 13:47:09.329606615
+0000
@@ -409,8 +409,7 @@ static struct platform_device bast_sio =
 static struct s3c2410_platform_i2c __initdata bast_i2c_info = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
-	.bus_freq	= 100*1000,
-	.max_freq	= 130*1000,
+	.frequency	= 100*1000,
 };
 
 /* Asix AX88796 10/100 ethernet controller */
Index: b/arch/arm/mach-s3c2410/mach-n30.c
===================================================================
--- a/arch/arm/mach-s3c2410/mach-n30.c	2009-03-13 13:30:34.729606502
+0000
+++ b/arch/arm/mach-s3c2410/mach-n30.c	2009-03-13 13:47:09.433606496
+0000
@@ -340,8 +340,7 @@ static struct platform_device *n35_devic
 static struct s3c2410_platform_i2c n30_i2ccfg = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
-	.bus_freq	= 10*1000,
-	.max_freq	= 10*1000,
+	.frequency	= 10*1000,
 };
 
 /* Lots of hardcoded stuff, but it sets up the hardware in a useful
Index: b/arch/arm/mach-s3c2412/mach-jive.c
===================================================================
--- a/arch/arm/mach-s3c2412/mach-jive.c	2009-03-13 13:30:36.150487287
+0000
+++ b/arch/arm/mach-s3c2412/mach-jive.c	2009-03-13 13:47:09.573607130
+0000
@@ -453,8 +453,7 @@ static struct spi_board_info __initdata 
 /* I2C bus and device configuration. */
 
 static struct s3c2410_platform_i2c jive_i2c_cfg __initdata = {
-	.max_freq	= 80 * 1000,
-	.bus_freq	= 50 * 1000,
+	.frequency	= 80 * 1000,
 	.flags		= S3C_IICFLG_FILTER,
 	.sda_delay	= 2,
 };


-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895
