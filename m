From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [next] i2c-s3c2410: Change IRQ to be plain integer.
Date: Tue, 16 Dec 2008 21:04:43 +0000
Message-ID: <1229461483-1747-6-git-send-email-ben-linux@fluff.org>
References: <1229461483-1747-1-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-2-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-3-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-4-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-5-git-send-email-ben-linux@fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1229461483-1747-5-git-send-email-ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
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
---
 drivers/i2c/busses/i2c-s3c2410.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index f14007f..2a0de64 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -61,6 +61,7 @@ struct s3c24xx_i2c {
 	unsigned int		msg_ptr;
 
 	unsigned int		tx_setup;
+	unsigned int		irq;
 
 	enum s3c24xx_i2c_state	state;
 	unsigned long		clkrate;
@@ -68,7 +69,6 @@ struct s3c24xx_i2c {
 	void __iomem		*regs;
 	struct clk		*clk;
 	struct device		*dev;
-	struct resource		*irq;
 	struct resource		*ioarea;
 	struct i2c_adapter	adap;
 
@@ -869,26 +869,20 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
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
@@ -918,7 +912,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	s3c24xx_i2c_deregister_cpufreq(i2c);
 
  err_irq:
-	free_irq(i2c->irq->start, i2c);
+	free_irq(i2c->irq, i2c);
 
  err_iomap:
 	iounmap(i2c->regs);
@@ -948,7 +942,7 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 	s3c24xx_i2c_deregister_cpufreq(i2c);
 
 	i2c_del_adapter(&i2c->adap);
-	free_irq(i2c->irq->start, i2c);
+	free_irq(i2c->irq, i2c);
 
 	clk_disable(i2c->clk);
 	clk_put(i2c->clk);
-- 
1.5.6.5
