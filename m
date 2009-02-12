From: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: [PATCH] I2C: Rename struct s3c2410_platform_i2c to s3c_platform_i2c
Date: Thu, 12 Feb 2009 13:49:30 +0000
Message-ID: <1234446570.9457.28.camel@petitemort>
Reply-To: dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The I2C driver currently known as i2c-s3c2410 is now used by
several different s3cXXXX SoCs. As such, this patch renames the
platform data to be SoC agnostic.

Signed-Off-By: Simtec Linux Team <linux-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Signed-Off-By: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

---
 arch/arm/mach-s3c2410/mach-bast.c    |    2 +-
 arch/arm/mach-s3c2410/mach-n30.c     |    2 +-
 arch/arm/mach-s3c2412/mach-jive.c    |    2 +-
 arch/arm/plat-s3c/dev-i2c0.c         |    8 ++++----
 arch/arm/plat-s3c/dev-i2c1.c         |    8 ++++----
 arch/arm/plat-s3c/include/plat/iic.h |    8 ++++----
 drivers/i2c/busses/i2c-s3c2410.c     |    6 +++---
 7 files changed, 18 insertions(+), 18 deletions(-)

Index: b/arch/arm/mach-s3c2410/mach-bast.c
===================================================================
--- a/arch/arm/mach-s3c2410/mach-bast.c	2009-02-12 10:24:29.394616021 +0000
+++ b/arch/arm/mach-s3c2410/mach-bast.c	2009-02-12 10:25:34.834613727 +0000
@@ -406,7 +406,7 @@ static struct platform_device bast_sio =
  * standard 100KHz i2c bus frequency
 */
 
-static struct s3c2410_platform_i2c __initdata bast_i2c_info = {
+static struct s3c_platform_i2c __initdata bast_i2c_info = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
 	.frequency	= 100*1000,
Index: b/arch/arm/mach-s3c2410/mach-n30.c
===================================================================
--- a/arch/arm/mach-s3c2410/mach-n30.c	2009-02-12 10:24:29.410614435 +0000
+++ b/arch/arm/mach-s3c2410/mach-n30.c	2009-02-12 10:25:34.834613727 +0000
@@ -337,7 +337,7 @@ static struct platform_device *n35_devic
 	&n35_button_device,
 };
 
-static struct s3c2410_platform_i2c n30_i2ccfg = {
+static struct s3c_platform_i2c n30_i2ccfg = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
 	.frequency	= 10*1000,
Index: b/arch/arm/mach-s3c2412/mach-jive.c
===================================================================
--- a/arch/arm/mach-s3c2412/mach-jive.c	2009-02-12 10:24:29.430615021 +0000
+++ b/arch/arm/mach-s3c2412/mach-jive.c	2009-02-12 10:25:34.879282354 +0000
@@ -452,7 +452,7 @@ static struct spi_board_info __initdata 
 
 /* I2C bus and device configuration. */
 
-static struct s3c2410_platform_i2c jive_i2c_cfg __initdata = {
+static struct s3c_platform_i2c jive_i2c_cfg __initdata = {
 	.frequency	= 80 * 1000,
 	.flags		= S3C_IICFLG_FILTER,
 	.sda_delay	= 2,
Index: b/arch/arm/plat-s3c/dev-i2c0.c
===================================================================
--- a/arch/arm/plat-s3c/dev-i2c0.c	2009-02-12 10:24:29.450615087 +0000
+++ b/arch/arm/plat-s3c/dev-i2c0.c	2009-02-12 10:25:34.896066163 +0000
@@ -47,21 +47,21 @@ struct platform_device s3c_device_i2c0 =
 	.resource	  = s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data0 __initdata = {
+static struct s3c_platform_i2c default_i2c_data0 __initdata = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
 	.frequency	= 100*1000,
 	.sda_delay	= 100,
 };
 
-void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
+void __init s3c_i2c0_set_platdata(struct s3c_platform_i2c *pd)
 {
-	struct s3c2410_platform_i2c *npd;
+	struct s3c_platform_i2c *npd;
 
 	if (!pd)
 		pd = &default_i2c_data0;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	npd = kmemdup(pd, sizeof(struct s3c_platform_i2c), GFP_KERNEL);
 	if (!npd)
 		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
 	else if (!npd->cfg_gpio)
Index: b/arch/arm/plat-s3c/dev-i2c1.c
===================================================================
--- a/arch/arm/plat-s3c/dev-i2c1.c	2009-02-12 10:24:29.466616700 +0000
+++ b/arch/arm/plat-s3c/dev-i2c1.c	2009-02-12 10:25:34.914112380 +0000
@@ -43,7 +43,7 @@ struct platform_device s3c_device_i2c1 =
 	.resource	  = s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data1 __initdata = {
+static struct s3c_platform_i2c default_i2c_data1 __initdata = {
 	.flags		= 0,
 	.bus_num	= 1,
 	.slave_addr	= 0x10,
@@ -51,14 +51,14 @@ static struct s3c2410_platform_i2c defau
 	.sda_delay	= 100,
 };
 
-void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
+void __init s3c_i2c1_set_platdata(struct s3c_platform_i2c *pd)
 {
-	struct s3c2410_platform_i2c *npd;
+	struct s3c_platform_i2c *npd;
 
 	if (!pd)
 		pd = &default_i2c_data1;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	npd = kmemdup(pd, sizeof(struct s3c_platform_i2c), GFP_KERNEL);
 	if (!npd)
 		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
 	else if (!npd->cfg_gpio)
Index: b/arch/arm/plat-s3c/include/plat/iic.h
===================================================================
--- a/arch/arm/plat-s3c/include/plat/iic.h	2009-02-12 10:24:29.502615860 +0000
+++ b/arch/arm/plat-s3c/include/plat/iic.h	2009-02-12 10:25:34.938112460 +0000
@@ -16,7 +16,7 @@
 #define S3C_IICFLG_FILTER	(1<<0)	/* enable s3c2440 filter */
 
 /**
- *	struct s3c2410_platform_i2c - Platform data for s3c I2C.
+ *	struct s3c_platform_i2c - Platform data for s3c I2C.
  *	@bus_num: The bus number to use (if possible).
  *	@flags: Any flags for the I2C bus (E.g. S3C_IICFLK_FILTER).
  *	@slave_addr: The I2C address for the slave device (if enabled).
@@ -27,7 +27,7 @@
  *	@sda_delay: The delay (in ns) applied to SDA edges.
  *	@cfg_gpio: A callback to configure the pins for I2C operation.
  */
-struct s3c2410_platform_i2c {
+struct s3c_platform_i2c {
 	int		bus_num;
 	unsigned int	flags;
 	unsigned int	slave_addr;
@@ -52,8 +52,8 @@ struct s3c2410_platform_i2c {
  * NULL to ensure that the device is given the default platform data
  * as the driver will no longer carry defaults.
  */
-extern void s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *i2c);
+extern void s3c_i2c0_set_platdata(struct s3c_platform_i2c *i2c);
+extern void s3c_i2c1_set_platdata(struct s3c_platform_i2c *i2c);
 
 /* defined by architecture to configure gpio */
 extern void s3c_i2c0_cfg_gpio(struct platform_device *dev);
Index: b/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- a/drivers/i2c/busses/i2c-s3c2410.c	2009-02-12 10:24:29.530615073 +0000
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2009-02-12 10:25:34.954113072 +0000
@@ -599,7 +599,7 @@ static int s3c24xx_i2c_calcdivisor(unsig
 
 static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 {
-	struct s3c2410_platform_i2c *pdata = i2c->dev->platform_data;
+	struct s3c_platform_i2c *pdata = i2c->dev->platform_data;
 	unsigned long clkin = clk_get_rate(i2c->clk);
 	unsigned int divs, div1;
 	unsigned long target_frequency;
@@ -721,7 +721,7 @@ static inline void s3c24xx_i2c_deregiste
 static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 {
 	unsigned long iicon = S3C2410_IICCON_IRQEN | S3C2410_IICCON_ACKEN;
-	struct s3c2410_platform_i2c *pdata;
+	struct s3c_platform_i2c *pdata;
 	unsigned int freq;
 
 	/* get the plafrom data */
@@ -770,7 +770,7 @@ static int s3c24xx_i2c_init(struct s3c24
 static int s3c24xx_i2c_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c;
-	struct s3c2410_platform_i2c *pdata;
+	struct s3c_platform_i2c *pdata;
 	struct resource *res;
 	int ret;
 

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895
