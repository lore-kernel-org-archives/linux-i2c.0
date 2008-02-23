From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 6/6] Minor fixes for pxa-driver
Date: Sat, 23 Feb 2008 22:49:53 +0100
Message-ID: <20080223224953.00be842c@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143659.089906703@pengutronix.de>
	<20080213095839.5d99d48a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080213095839.5d99d48a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Patch updated after receiving this comment (in private) from David
Brownell:

> i2c-pxa-misc-fixes ... should use "__exit" and "__exit_p" instead
> 	of "__devexit" and "__devexit_p" on the remove() function.
> 	The PXA platform bus is normal:  it's not hot-unpluggable.

* * * * *

While working on the PCA9564-platform driver, I sometimes had a glimpse at the
pxa-driver. I found some suspicious places, and this patch contains my
suggestions. Note: They are not tested, due to no hardware.

[JD: Some more fixes.]

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Tested-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Tested-by: Eric Miao <ymiao3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- linux-2.6.25-rc2.orig/drivers/i2c/busses/i2c-pxa.c	2008-02-23 18:18:46.000000000 +0100
+++ linux-2.6.25-rc2/drivers/i2c/busses/i2c-pxa.c	2008-02-23 22:42:54.000000000 +0100
@@ -999,7 +999,14 @@ static int i2c_pxa_probe(struct platform
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
-	sprintf(i2c->adap.name, "pxa_i2c-i2c.%u", dev->id);
+	/*
+	 * If "dev->id" is negative we consider it as zero.
+	 * The reason to do so is to avoid sysfs names that only make
+	 * sense when there are multiple adapters.
+	 */
+	i2c->adap.nr = dev->id != -1 ? dev->id : 0;
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u",
+		 i2c->adap.nr);
 
 	i2c->clk = clk_get(&dev->dev, "I2CCLK");
 	if (IS_ERR(i2c->clk)) {
@@ -1050,13 +1057,6 @@ static int i2c_pxa_probe(struct platform
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &dev->dev;
 
-	/*
-	 * If "dev->id" is negative we consider it as zero.
-	 * The reason to do so is to avoid sysfs names that only make
-	 * sense when there are multiple adapters.
-	 */
-	i2c->adap.nr = dev->id != -1 ? dev->id : 0;
-
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
 		printk(KERN_INFO "I2C: Failed to add bus\n");
@@ -1080,6 +1080,7 @@ eadapt:
 ereqirq:
 	clk_disable(i2c->clk);
 	i2c_pxa_disable(dev);
+	iounmap(i2c->reg_base);
 eremap:
 	clk_put(i2c->clk);
 eclk:
@@ -1089,7 +1090,7 @@ emalloc:
 	return ret;
 }
 
-static int i2c_pxa_remove(struct platform_device *dev)
+static int __exit i2c_pxa_remove(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
@@ -1103,6 +1104,7 @@ static int i2c_pxa_remove(struct platfor
 	clk_put(i2c->clk);
 	i2c_pxa_disable(dev);
 
+	iounmap(i2c->reg_base);
 	release_mem_region(i2c->iobase, i2c->iosize);
 	kfree(i2c);
 
@@ -1111,9 +1113,10 @@ static int i2c_pxa_remove(struct platfor
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
-	.remove		= i2c_pxa_remove,
+	.remove		= __exit_p(i2c_pxa_remove),
 	.driver		= {
 		.name	= "pxa2xx-i2c",
+		.owner	= THIS_MODULE,
 	},
 };
 
@@ -1122,7 +1125,7 @@ static int __init i2c_adap_pxa_init(void
 	return platform_driver_register(&i2c_pxa_driver);
 }
 
-static void i2c_adap_pxa_exit(void)
+static void __exit i2c_adap_pxa_exit(void)
 {
 	platform_driver_unregister(&i2c_pxa_driver);
 }


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
