From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 9/9] i2c-s3c2410: change IRQ to be plain integer.
Date: Fri, 31 Oct 2008 16:04:29 +0000
Message-ID: <20081031160438.463707180@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-improve-irq-code.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Change the code to use a plain integer as the holder
for the IRQ for the device and use platform_get_irq()
to find it.

This makes the code slightly neater, and easier to get
the IRQ number.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:56:12.000000000 +0000
+++ linux.git/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:56:18.000000000 +0000
@@ -62,6 +62,7 @@ struct s3c24xx_i2c {
 	unsigned int		msg_ptr;
 
 	unsigned int		tx_setup;
+	unsigned int		irq;
 
 	enum s3c24xx_i2c_state	state;
 	unsigned long		clkrate;
@@ -69,7 +70,6 @@ struct s3c24xx_i2c {
 	void __iomem		*regs;
 	struct clk		*clk;
 	struct device		*dev;
-	struct resource		*irq;
 	struct resource		*ioarea;
 	struct i2c_adapter	adap;
 
@@ -870,26 +870,20 @@ static int s3c24xx_i2c_probe(struct plat
 	 * ensure no current IRQs pending
 	 */
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
+	i2c->irq = ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
 		dev_err(&pdev->dev, "cannot find IRQ\n");
-		ret = -ENOENT;
 		goto err_iomap;
 	}
 
-	ret = request_irq(res->start, s3c24xx_i2c_irq, IRQF_DISABLED,
-			  pdev->name, i2c);
+	ret = request_irq(i2c->irq, s3c24xx_i2c_irq, IRQF_DISABLED,
+			  dev_name(&pdev->dev), i2c);
 
 	if (ret != 0) {
-		dev_err(&pdev->dev, "cannot claim IRQ\n");
+		dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
 		goto err_iomap;
 	}
 
-	i2c->irq = res;
-
-	dev_dbg(&pdev->dev, "irq resource %p (%lu)\n", res,
-		(unsigned long)res->start);
-
 	ret = s3c24xx_i2c_register_cpufreq(i2c);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register cpufreq notifier\n");
@@ -919,7 +913,7 @@ static int s3c24xx_i2c_probe(struct plat
 	s3c24xx_i2c_deregister_cpufreq(i2c);
 
  err_irq:
-	free_irq(i2c->irq->start, i2c);
+	free_irq(i2c->irq, i2c);
 
  err_iomap:
 	iounmap(i2c->regs);
@@ -949,7 +943,7 @@ static int s3c24xx_i2c_remove(struct pla
 	s3c24xx_i2c_deregister_cpufreq(i2c);
 
 	i2c_del_adapter(&i2c->adap);
-	free_irq(i2c->irq->start, i2c);
+	free_irq(i2c->irq, i2c);
 
 	clk_disable(i2c->clk);
 	clk_put(i2c->clk);

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
