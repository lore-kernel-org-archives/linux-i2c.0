From: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: Re: [PATCH] Bugfix for i2c-s3c2410
Date: Thu, 12 Feb 2009 13:54:44 +0000
Message-ID: <1234446884.9457.30.camel@petitemort>
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
> I2C: Rework i2c-s3c2410 frequency calculator to be much simpler.
[snip]

I'm sorry, I forgot to post the patch this depends on first...

I2C: i2c-s3c2410: sda_delay should be in ns, not clock ticks

The sda_delay field should be specified in ns, not in clock ticks
as when using cpufreq we could be changing the bus rate.

Signed-off-by: Simtec Linux Team <linux-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Signed-off-by: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

---
 arch/arm/plat-s3c/dev-i2c0.c     |    2 +-
 arch/arm/plat-s3c/dev-i2c1.c     |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c |   24 +++++++++++++++++++-----
 3 files changed, 21 insertions(+), 7 deletions(-)

Index: b/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- a/drivers/i2c/busses/i2c-s3c2410.c	2009-02-02 11:29:47.684095135 +0000
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2009-02-02 11:31:04.192098651 +0000
@@ -663,6 +663,23 @@ static int s3c24xx_i2c_clockrate(struct 
 
 	writel(iiccon, i2c->regs + S3C2410_IICCON);
 
+	if (s3c24xx_i2c_is2440(i2c)) {
+		unsigned long sda_delay;
+
+		if (pdata->sda_delay) {
+			sda_delay = (freq / 1000) * pdata->sda_delay;
+			sda_delay /= 1000000;
+			sda_delay = DIV_ROUND_UP(sda_delay, 5);
+			if (sda_delay > 3)
+				sda_delay = 3;
+			sda_delay |= S3C2410_IICLC_FILTER_ON;
+		} else
+			sda_delay = 0;
+
+		dev_dbg(i2c->dev, "IICLC=%08x\n", sda_delay);
+		writel(sda_delay, i2c->regs + S3C2440_IICLC);
+	}
+
 	return 0;
 }
 
@@ -769,11 +786,8 @@ static int s3c24xx_i2c_init(struct s3c24
 
 	/* check for s3c2440 i2c controller  */
 
-	if (s3c24xx_i2c_is2440(i2c)) {
-		dev_dbg(i2c->dev, "S3C2440_IICLC=%08x\n", pdata->sda_delay);
-
-		writel(pdata->sda_delay, i2c->regs + S3C2440_IICLC);
-	}
+	if (s3c24xx_i2c_is2440(i2c))
+		writel(0x0, i2c->regs + S3C2440_IICLC);
 
 	return 0;
 }
Index: b/arch/arm/plat-s3c/dev-i2c0.c
===================================================================
--- a/arch/arm/plat-s3c/dev-i2c0.c	2009-02-02 11:29:47.716092758 +0000
+++ b/arch/arm/plat-s3c/dev-i2c0.c	2009-02-02 11:31:04.243593868 +0000
@@ -52,7 +52,7 @@ static struct s3c2410_platform_i2c defau
 	.slave_addr	= 0x10,
 	.bus_freq	= 100*1000,
 	.max_freq	= 400*1000,
-	.sda_delay	= S3C2410_IICLC_SDA_DELAY5 | S3C2410_IICLC_FILTER_ON,
+	.sda_delay	= 100,
 };
 
 void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
Index: b/arch/arm/plat-s3c/dev-i2c1.c
===================================================================
--- a/arch/arm/plat-s3c/dev-i2c1.c	2009-02-02 11:29:47.732093910 +0000
+++ b/arch/arm/plat-s3c/dev-i2c1.c	2009-02-02 11:31:04.256093253 +0000
@@ -49,7 +49,7 @@ static struct s3c2410_platform_i2c defau
 	.slave_addr	= 0x10,
 	.bus_freq	= 100*1000,
 	.max_freq	= 400*1000,
-	.sda_delay	= S3C2410_IICLC_SDA_DELAY5 | S3C2410_IICLC_FILTER_ON,
+	.sda_delay	= 100,
 };
 
 void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)


-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895
