From: Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c-s3c2410: Fixup debug print of IICCON register
Date: Thu, 06 May 2010 14:06:16 +0900
Message-ID: <4BE24E48.8010101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch is for debug print of the last IICCON register value applied
by s3c24xx_i2c_clockrate function.

Signed-off-by: Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index d27072b..0445698 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -611,7 +611,7 @@ static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 	unsigned long clkin = clk_get_rate(i2c->clk);
 	unsigned int divs, div1;
 	unsigned long target_frequency;
-	u32 iiccon;
+	unsigned long iiccon;
 	int freq;
 
 	i2c->clkrate = clkin;
@@ -641,6 +641,7 @@ static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 	if (div1 == 512)
 		iiccon |= S3C2410_IICCON_TXDIV_512;
 
+	dev_dbg(i2c->dev, "IICCON=0x%02lx\n", iiccon);
 	writel(iiccon, i2c->regs + S3C2410_IICCON);
 
 	if (s3c24xx_i2c_is2440(i2c)) {
@@ -730,7 +731,7 @@ static inline void s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c)
 
 static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 {
-	unsigned long iicon = S3C2410_IICCON_IRQEN | S3C2410_IICCON_ACKEN;
+	unsigned long iiccon = S3C2410_IICCON_IRQEN | S3C2410_IICCON_ACKEN;
 	struct s3c2410_platform_i2c *pdata;
 	unsigned int freq;
 
@@ -749,7 +750,7 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 	dev_info(i2c->dev, "slave address 0x%02x\n", pdata->slave_addr);
 
-	writel(iicon, i2c->regs + S3C2410_IICCON);
+	writel(iiccon, i2c->regs + S3C2410_IICCON);
 
 	/* we need to work out the divisors for the clock... */
 
@@ -762,7 +763,6 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 	/* todo - check that the i2c lines aren't being dragged anywhere */
 
 	dev_info(i2c->dev, "bus frequency set to %d KHz\n", freq);
-	dev_dbg(i2c->dev, "S3C2410_IICCON=0x%02lx\n", iicon);
 
 	return 0;
 }
-- 
1.6.3.3
