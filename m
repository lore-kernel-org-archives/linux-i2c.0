From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/14] i2c/i2c-nomadik: add regulator support
Date: Fri, 13 May 2011 12:29:02 +0200
Message-ID: <1305282542-20537-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

This on-chip I2C controller needs to fetch the regulator
representing its voltage domain so that it won't be switched off.

Signed-off-by: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   73 ++++++++++++++++++++++++++++++--------
 1 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index e10e5cf..182761e 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regulator/consumer.h>
 
 #include <plat/i2c.h>
 
@@ -151,6 +152,7 @@ struct i2c_nmk_client {
  * @stop: stop condition
  * @xfer_complete: acknowledge completion for a I2C message
  * @result: controller propogated result
+ * @busy: Busy doing transfer
  */
 struct nmk_i2c_dev {
 	struct platform_device		*pdev;
@@ -163,6 +165,8 @@ struct nmk_i2c_dev {
 	int 				stop;
 	struct completion		xfer_complete;
 	int 				result;
+	struct regulator		*regulator;
+	bool				busy;
 };
 
 /* controller's abort causes */
@@ -257,7 +261,7 @@ static int init_hw(struct nmk_i2c_dev *dev)
 
 	stat = flush_i2c_fifo(dev);
 	if (stat)
-		return stat;
+		goto exit;
 
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR , I2C_CR_PE);
@@ -268,10 +272,16 @@ static int init_hw(struct nmk_i2c_dev *dev)
 
 	dev->cli.operation = I2C_NO_OPERATION;
 
+exit:
+	/* TODO: Why disable clocks after init hw? */
 	clk_disable(dev->clk);
-
+	/*
+	 * TODO: What is this delay for?
+	 * Must be pretty pointless since the hw block
+	 * is frozen. Or?
+	 */
 	udelay(I2C_DELAY);
-	return 0;
+	return stat;
 }
 
 /* enable peripheral, master mode operation */
@@ -562,9 +572,14 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	u32 cause;
 	struct nmk_i2c_dev *dev = i2c_get_adapdata(i2c_adap);
 
+	dev->busy = true;
+
+	if (dev->regulator)
+		regulator_enable(dev->regulator);
+
 	status = init_hw(dev);
 	if (status)
-		return status;
+		goto out2;
 
 	clk_enable(dev->clk);
 
@@ -575,7 +590,9 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 		if (unlikely(msgs[i].flags & I2C_M_TEN)) {
 			dev_err(&dev->pdev->dev, "10 bit addressing"
 					"not supported\n");
-			return -EINVAL;
+
+			status = -EINVAL;
+			goto out;
 		}
 		dev->cli.slave_adr	= msgs[i].addr;
 		dev->cli.buffer		= msgs[i].buf;
@@ -600,12 +617,19 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 			dev_err(&dev->pdev->dev, "%s\n",
 				cause >= ARRAY_SIZE(abort_causes)
 				? "unknown reason" : abort_causes[cause]);
-			clk_disable(dev->clk);
-			return status;
+
+			goto out;
 		}
 		udelay(I2C_DELAY);
 	}
+
+out:
 	clk_disable(dev->clk);
+out2:
+	if (dev->regulator)
+		regulator_disable(dev->regulator);
+
+	dev->busy = false;
 
 	/* return the no. messages processed */
 	if (status)
@@ -805,6 +829,21 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+
+#ifdef CONFIG_PM
+static int nmk_i2c_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct nmk_i2c_dev *dev = platform_get_drvdata(pdev);
+
+	if (dev->busy)
+		return -EBUSY;
+	else
+		return 0;
+}
+#else
+#define nmk_i2c_suspend	NULL
+#endif
+
 static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
@@ -830,7 +869,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_no_mem;
 	}
-
+	dev->busy = false;
 	dev->pdev = pdev;
 	platform_set_drvdata(pdev, dev);
 
@@ -860,6 +899,12 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	dev->regulator = regulator_get(&pdev->dev, "v-i2c");
+	if (IS_ERR(dev->regulator)) {
+		dev_warn(&pdev->dev, "could not get i2c regulator\n");
+		dev->regulator = NULL;
+	}
+
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		dev_err(&pdev->dev, "could not get i2c clock\n");
@@ -887,12 +932,6 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 
 	i2c_set_adapdata(adap, dev);
 
-	ret = init_hw(dev);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "error in initializing i2c hardware\n");
-		goto err_init_hw;
-	}
-
 	dev_info(&pdev->dev, "initialize %s on virtual "
 		"base %p\n", adap->name, dev->virtbase);
 
@@ -904,10 +943,11 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 
 	return 0;
 
- err_init_hw:
  err_add_adap:
 	clk_put(dev->clk);
  err_no_clk:
+	if (dev->regulator)
+		regulator_put(dev->regulator);
 	free_irq(dev->irq, dev);
  err_irq:
 	iounmap(dev->virtbase);
@@ -938,6 +978,8 @@ static int __devexit nmk_i2c_remove(struct platform_device *pdev)
 	if (res)
 		release_mem_region(res->start, resource_size(res));
 	clk_put(dev->clk);
+	if (dev->regulator)
+		regulator_put(dev->regulator);
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
 
@@ -951,6 +993,7 @@ static struct platform_driver nmk_i2c_driver = {
 	},
 	.probe = nmk_i2c_probe,
 	.remove = __devexit_p(nmk_i2c_remove),
+	.suspend = nmk_i2c_suspend,
 };
 
 static int __init nmk_i2c_init(void)
-- 
1.7.5.1
