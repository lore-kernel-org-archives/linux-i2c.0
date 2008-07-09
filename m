From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 2/2] I2C: S3C24XX I2C frequency scaling support.
Date: Wed, 09 Jul 2008 13:51:49 +0100
Message-ID: <20080709125215.826049573@fluff.org>
References: <20080709125147.721679556@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/cpufreq/s3c24xx-cpufreq-drivers-i2c.patch
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

Add support for CPU frequency scaling to the S3C24XX I2C driver.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc9/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux-2.6.26-rc9.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-07-09 13:46:08.000000000 +0100
+++ linux-2.6.26-rc9/drivers/i2c/busses/i2c-s3c2410.c	2008-07-09 13:48:46.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -64,6 +65,7 @@ struct s3c24xx_i2c {
 	unsigned int		tx_setup;
 
 	enum s3c24xx_i2c_state	state;
+	unsigned long		clkrate;
 
 	void __iomem		*regs;
 	struct clk		*clk;
@@ -71,6 +73,10 @@ struct s3c24xx_i2c {
 	struct resource		*irq;
 	struct resource		*ioarea;
 	struct i2c_adapter	adap;
+
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	freq_transition;
+#endif
 };
 
 /* default platform data to use if not supplied in the platform_device
@@ -501,6 +507,9 @@ static int s3c24xx_i2c_doxfer(struct s3c
 	unsigned long timeout;
 	int ret;
 
+	if (!readl(i2c->regs + S3C2410_IICCON) & S3C2410_IICCON_IRQEN)
+		return -EIO;
+
 	ret = s3c24xx_i2c_set_master(i2c);
 	if (ret != 0) {
 		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
@@ -636,27 +645,28 @@ static inline int freq_acceptable(unsign
 	return (diff >= -2 && diff <= 2);
 }
 
-/* s3c24xx_i2c_getdivisor
+/* s3c24xx_i2c_clockrate
  *
  * work out a divisor for the user requested frequency setting,
  * either by the requested frequency, or scanning the acceptable
  * range of frequencies until something is found
 */
 
-static int s3c24xx_i2c_getdivisor(struct s3c24xx_i2c *i2c,
-				  struct s3c2410_platform_i2c *pdata,
-				  unsigned long *iicon,
-				  unsigned int *got)
+static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 {
+	struct s3c2410_platform_i2c *pdata;
 	unsigned long clkin = clk_get_rate(i2c->clk);
-	
 	unsigned int divs, div1;
+	u32 iiccon;
 	int freq;
 	int start, end;
 
+	i2c->clkrate = clkin;
+
+	pdata = s3c24xx_i2c_get_platformdata(i2c->adap.dev.parent);
 	clkin /= 1000;		/* clkin now in KHz */
      
-	dev_dbg(i2c->dev,  "pdata %p, freq %lu %lu..%lu\n",
+	dev_dbg(i2c->dev, "pdata %p, freq %lu %lu..%lu\n",
 		 pdata, pdata->bus_freq, pdata->min_freq, pdata->max_freq);
 
 	if (pdata->bus_freq != 0) {
@@ -688,11 +698,79 @@ static int s3c24xx_i2c_getdivisor(struct
 
  found:
 	*got = freq;
-	*iicon |= (divs-1);
-	*iicon |= (div1 == 512) ? S3C2410_IICCON_TXDIV_512 : 0;
+
+	iiccon = readl(i2c->regs + S3C2410_IICCON);
+	iiccon &= ~(S3C2410_IICCON_SCALEMASK | S3C2410_IICCON_TXDIV_512);
+	iiccon |= (divs-1);
+
+	if (div1 == 512)
+		iiccon |= S3C2410_IICCON_TXDIV_512;
+
+	writel(iiccon, i2c->regs + S3C2410_IICCON);
+
+	return 0;
+}
+
+#ifdef CONFIG_CPU_FREQ
+
+#define freq_to_i2c(_n) container_of(_n, struct s3c24xx_i2c, freq_transition)
+
+static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
+					  unsigned long val, void *data)
+{
+	struct s3c24xx_i2c *i2c = freq_to_i2c(nb);
+	unsigned long clkrate;
+	unsigned long flags;
+	unsigned int got;
+	int ret;
+
+	clkrate = clk_get_rate(i2c->clk);
+
+	/* if we're post-change and the input clock has slowed down
+	 * or at pre-change and the clock is about to speed up, then
+	 * adjust our clock rate.
+	 */
+
+	if ((val == CPUFREQ_POSTCHANGE && clkrate < i2c->clkrate) ||
+	    (val == CPUFREQ_PRECHANGE && clkrate > i2c->clkrate)) {
+		spin_lock_irqsave(&i2c->lock, flags);
+		ret = s3c24xx_i2c_clockrate(i2c, &got);
+		spin_unlock_irqrestore(&i2c->lock, flags);
+
+		if (ret < 0)
+			dev_err(i2c->dev, "cannot find frequency\n");
+		else
+			dev_info(i2c->dev, "setting freq %d\n", got);
+	}
+
 	return 0;
 }
 
+static inline int s3c24xx_i2c_register_cpufreq(struct s3c24xx_i2c *i2c)
+{
+	i2c->freq_transition.notifier_call = s3c24xx_i2c_cpufreq_transition;
+
+	return cpufreq_register_notifier(&i2c->freq_transition,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+static inline void s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c)
+{
+	cpufreq_unregister_notifier(&i2c->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+#else
+static inline int s3c24xx_i2c_register_cpufreq(struct s3c24xx_i2c *i2c)
+{
+	return 0;
+}
+
+static inline void s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c)
+{
+}
+#endif
+
 /* s3c24xx_i2c_init
  *
  * initialise the controller, set the IO lines and frequency 
@@ -719,9 +797,12 @@ static int s3c24xx_i2c_init(struct s3c24
 
 	dev_info(i2c->dev, "slave address 0x%02x\n", pdata->slave_addr);
 
+	writel(iicon, i2c->regs + S3C2410_IICCON);
+
 	/* we need to work out the divisors for the clock... */
 
-	if (s3c24xx_i2c_getdivisor(i2c, pdata, &iicon, &freq) != 0) {
+	if (s3c24xx_i2c_clockrate(i2c, &freq) != 0) {
+		writel(0, i2c->regs + S3C2410_IICCON);
 		dev_err(i2c->dev, "cannot meet bus frequency required\n");
 		return -EINVAL;
 	}
@@ -730,8 +811,6 @@ static int s3c24xx_i2c_init(struct s3c24
 
 	dev_info(i2c->dev, "bus frequency set to %d KHz\n", freq);
 	dev_dbg(i2c->dev, "S3C2410_IICCON=0x%02lx\n", iicon);
-	
-	writel(iicon, i2c->regs + S3C2410_IICCON);
 
 	/* check for s3c2440 i2c controller  */
 
@@ -835,6 +914,12 @@ static int s3c24xx_i2c_probe(struct plat
 	dev_dbg(&pdev->dev, "irq resource %p (%lu)\n", res,
 		(unsigned long)res->start);
 
+	ret = s3c24xx_i2c_register_cpufreq(i2c);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register cpufreq notifier\n");
+		goto err_irq;
+	}
+
 	/* Note, previous versions of the driver used i2c_add_adapter()
 	 * to add an bus at any number. We now pass the bus number via
 	 * the platform data, so if unset it will now default to always
@@ -846,7 +931,7 @@ static int s3c24xx_i2c_probe(struct plat
 
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
-		goto err_irq;
+		goto err_cpufreq;
 	}
 
 	platform_set_drvdata(pdev, i2c);
@@ -854,6 +939,9 @@ static int s3c24xx_i2c_probe(struct plat
 	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", i2c->adap.dev.bus_id);
 	return 0;
 
+ err_cpufreq:
+	s3c24xx_i2c_deregister_cpufreq(i2c);
+
  err_irq:
 	free_irq(i2c->irq->start, i2c);
 
@@ -881,6 +969,8 @@ static int s3c24xx_i2c_remove(struct pla
 {
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
+	s3c24xx_i2c_deregister_cpufreq(i2c);
+
 	i2c_del_adapter(&i2c->adap);
 	free_irq(i2c->irq->start, i2c);
 

-- 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
