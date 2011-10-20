From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/2] i2c/nomadik: runtime PM support
Date: Thu, 20 Oct 2011 18:23:18 +0200
Message-ID: <1319127798-13395-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Turn off the clock and regulator to the I2C block using runtime
PM.

Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
Signed-off-by: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   53 ++++++++++++++++++++++++++++----------
 1 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index ce4fd80..9ac9870 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -628,12 +628,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	dev->busy = true;
 
-	if (dev->regulator)
-		regulator_enable(dev->regulator);
 	pm_runtime_get_sync(&dev->pdev->dev);
 
-	clk_enable(dev->clk);
-
 	status = init_hw(dev);
 	if (status)
 		goto out;
@@ -666,10 +662,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 
 out:
-	clk_disable(dev->clk);
-	pm_runtime_put_sync(&dev->pdev->dev);
-	if (dev->regulator)
-		regulator_disable(dev->regulator);
+
+	pm_runtime_put(&dev->pdev->dev);
 
 	dev->busy = false;
 
@@ -859,9 +853,9 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
 
 #ifdef CONFIG_PM
-static int nmk_i2c_suspend(struct device *dev)
+
+static int nmk_i2c_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct nmk_i2c_dev *nmk_i2c = platform_get_drvdata(pdev);
 
 	if (nmk_i2c->busy)
@@ -870,23 +864,53 @@ static int nmk_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int nmk_i2c_resume(struct device *dev)
+static int nmk_i2c_suspend_noirq(struct device *dev)
 {
+	struct nmk_i2c_dev *nmk_i2c =
+		platform_get_drvdata(to_platform_device(dev));
+
+	if (nmk_i2c->busy)
+		return -EBUSY;
+
 	return 0;
 }
+
 #else
 #define nmk_i2c_suspend	NULL
-#define nmk_i2c_resume	NULL
+#define nmk_i2c_suspend_noirq NULL
 #endif
 
+static int nmk_i2c_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct nmk_i2c_dev *nmk_i2c = platform_get_drvdata(pdev);
+
+	clk_disable(nmk_i2c->clk);
+	if (nmk_i2c->regulator)
+		regulator_disable(nmk_i2c->regulator);
+	return 0;
+}
+
+static int nmk_i2c_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct nmk_i2c_dev *nmk_i2c = platform_get_drvdata(pdev);
+
+	if (nmk_i2c->regulator)
+		regulator_enable(nmk_i2c->regulator);
+	clk_enable(nmk_i2c->clk);
+	return 0;
+}
+
 /*
  * We use noirq so that we suspend late and resume before the wakeup interrupt
  * to ensure that we do the !pm_runtime_suspended() check in resume before
  * there has been a regular pm runtime resume (via pm_runtime_get_sync()).
  */
 static const struct dev_pm_ops nmk_i2c_pm = {
-	.suspend_noirq	= nmk_i2c_suspend,
-	.resume_noirq	= nmk_i2c_resume,
+	SET_RUNTIME_PM_OPS(nmk_i2c_runtime_suspend, nmk_i2c_runtime_resume,
+			   NULL)
+	.suspend_noirq	= nmk_i2c_suspend_noirq,
 };
 
 static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
@@ -1047,6 +1071,7 @@ static struct platform_driver nmk_i2c_driver = {
 	},
 	.probe = nmk_i2c_probe,
 	.remove = __devexit_p(nmk_i2c_remove),
+	.suspend = nmk_i2c_suspend,
 };
 
 static int __init nmk_i2c_init(void)
-- 
1.7.3.2
