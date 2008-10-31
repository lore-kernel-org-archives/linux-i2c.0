From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 6/9] i2c-s3c2410: remove default platform data.
Date: Fri, 31 Oct 2008 16:04:26 +0000
Message-ID: <20081031160437.750524660@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-remove-default-platdata.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The platform data should now always be present when the device
is initialised, so we can remove the default platform data in
the driver.

All the device initialisation points in the board specific code
should already have been changed to initialise this as necessary.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:55:54.000000000 +0000
+++ linux.git/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:56:08.000000000 +0000
@@ -78,16 +78,7 @@ struct s3c24xx_i2c {
 #endif
 };
 
-/* default platform data to use if not supplied in the platform_device
-*/
-
-static struct s3c2410_platform_i2c s3c24xx_i2c_default_platform = {
-	.flags		= 0,
-	.slave_addr	= 0x10,
-	.bus_freq	= 100*1000,
-	.max_freq	= 400*1000,
-	.sda_delay	= S3C2410_IICLC_SDA_DELAY5 | S3C2410_IICLC_FILTER_ON,
-};
+/* default platform data removed, dev should always carry data. */
 
 /* s3c24xx_i2c_is2440()
  *
@@ -101,22 +92,6 @@ static inline int s3c24xx_i2c_is2440(str
 	return !strcmp(pdev->name, "s3c2440-i2c");
 }
 
-
-/* s3c24xx_i2c_get_platformdata
- *
- * get the platform data associated with the given device, or return
- * the default if there is none
-*/
-
-static inline struct s3c2410_platform_i2c *
-s3c24xx_i2c_get_platformdata(struct device *dev)
-{
-	if (dev->platform_data != NULL)
-		return (struct s3c2410_platform_i2c *)dev->platform_data;
-
-	return &s3c24xx_i2c_default_platform;
-}
-
 /* s3c24xx_i2c_master_complete
  *
  * complete the message and wake up the caller, using the given return code,
@@ -649,7 +624,7 @@ static inline int freq_acceptable(unsign
 
 static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 {
-	struct s3c2410_platform_i2c *pdata;
+	struct s3c2410_platform_i2c *pdata = i2c->dev->platform_data;
 	unsigned long clkin = clk_get_rate(i2c->clk);
 	unsigned int divs, div1;
 	u32 iiccon;
@@ -657,8 +632,6 @@ static int s3c24xx_i2c_clockrate(struct 
 	int start, end;
 
 	i2c->clkrate = clkin;
-
-	pdata = s3c24xx_i2c_get_platformdata(i2c->adap.dev.parent);
 	clkin /= 1000;		/* clkin now in KHz */
 
 	dev_dbg(i2c->dev, "pdata %p, freq %lu %lu..%lu\n",
@@ -779,7 +752,7 @@ static int s3c24xx_i2c_init(struct s3c24
 
 	/* get the plafrom data */
 
-	pdata = s3c24xx_i2c_get_platformdata(i2c->dev);
+	pdata = i2c->dev->platform_data;
 
 	/* inititalise the gpio */
 
@@ -830,7 +803,11 @@ static int s3c24xx_i2c_probe(struct plat
 	struct resource *res;
 	int ret;
 
-	pdata = s3c24xx_i2c_get_platformdata(&pdev->dev);
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -EINVAL;
+	}
 
 	/* find the clock and enable it */
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
