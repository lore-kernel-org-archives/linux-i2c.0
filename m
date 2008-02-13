From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 6/6] Minor fixes for pxa-driver
Date: Wed, 13 Feb 2008 09:58:39 +0100
Message-ID: <20080213095839.5d99d48a@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143659.089906703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080121143659.089906703-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 21 Jan 2008 15:20:16 +0100, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
> While working on the PCA9564-platform driver, I sometimes had a glimpse at the
> pxa-driver. I found some suspicious places, and this patch contains my
> suggestions. Note: They are not tested, due to no hardware.

Looks good. I've added a couple more fixes, resulting patch is below.
As I don't have hardware for testing either, I would appreciate if
someone with a PXA board could test it and confirm that it causes no
regression. Mike? Eric? I plan to send this patch to Linus for 2.6.25
(i.e. quickly.)

From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: i2c-pxa: Misc fixes

While working on the PCA9564-platform driver, I sometimes had a glimpse at the
pxa-driver. I found some suspicious places, and this patch contains my
suggestions. Note: They are not tested, due to no hardware.

[JD: Some more fixes.]

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--- linux-2.6.25-rc1.orig/drivers/i2c/busses/i2c-pxa.c	2008-02-13 09:51:09.000000000 +0100
+++ linux-2.6.25-rc1/drivers/i2c/busses/i2c-pxa.c	2008-02-13 09:57:33.000000000 +0100
@@ -997,7 +997,14 @@ static int i2c_pxa_probe(struct platform
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
@@ -1048,13 +1055,6 @@ static int i2c_pxa_probe(struct platform
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
@@ -1078,6 +1078,7 @@ eadapt:
 ereqirq:
 	clk_disable(i2c->clk);
 	i2c_pxa_disable(dev);
+	iounmap(i2c->reg_base);
 eremap:
 	clk_put(i2c->clk);
 eclk:
@@ -1087,7 +1088,7 @@ emalloc:
 	return ret;
 }
 
-static int i2c_pxa_remove(struct platform_device *dev)
+static int __devexit i2c_pxa_remove(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
@@ -1101,6 +1102,7 @@ static int i2c_pxa_remove(struct platfor
 	clk_put(i2c->clk);
 	i2c_pxa_disable(dev);
 
+	iounmap(i2c->reg_base);
 	release_mem_region(i2c->iobase, i2c->iosize);
 	kfree(i2c);
 
@@ -1109,9 +1111,10 @@ static int i2c_pxa_remove(struct platfor
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
-	.remove		= i2c_pxa_remove,
+	.remove		= __devexit_p(i2c_pxa_remove),
 	.driver		= {
 		.name	= "pxa2xx-i2c",
+		.owner	= THIS_DRIVER,
 	},
 };
 
@@ -1120,9 +1123,9 @@ static int __init i2c_adap_pxa_init(void
 	return platform_driver_register(&i2c_pxa_driver);
 }
 
-static void i2c_adap_pxa_exit(void)
+static void __exit i2c_adap_pxa_exit(void)
 {
-	return platform_driver_unregister(&i2c_pxa_driver);
+	platform_driver_unregister(&i2c_pxa_driver);
 }
 
 MODULE_LICENSE("GPL");

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
