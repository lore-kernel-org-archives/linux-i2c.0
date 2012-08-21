From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] i2c/nomadik: stop fetching the regulator
Date: Tue, 21 Aug 2012 10:45:09 +0200
Message-ID: <1345538709-25201-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The regulator fetched by the Nomadik I2C driver is actually a
voltage domain regulator. Stop doing this in the driver and
let the power domain code handle any regulators, as discussed
on the list.

Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 61b00ed..1b898b6 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -22,7 +22,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/i2c-nomadik.h>
 
@@ -146,7 +145,6 @@ struct i2c_nmk_client {
  * @stop: stop condition.
  * @xfer_complete: acknowledge completion for a I2C message.
  * @result: controller propogated result.
- * @regulator: pointer to i2c regulator.
  * @busy: Busy doing transfer.
  */
 struct nmk_i2c_dev {
@@ -160,7 +158,6 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct completion		xfer_complete;
 	int				result;
-	struct regulator		*regulator;
 	bool				busy;
 };
 
@@ -643,8 +640,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	dev->busy = true;
 
-	if (dev->regulator)
-		regulator_enable(dev->regulator);
 	pm_runtime_get_sync(&dev->adev->dev);
 
 	clk_enable(dev->clk);
@@ -676,8 +671,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 out:
 	clk_disable(dev->clk);
 	pm_runtime_put_sync(&dev->adev->dev);
-	if (dev->regulator)
-		regulator_disable(dev->regulator);
 
 	dev->busy = false;
 
@@ -957,12 +950,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_irq;
 	}
 
-	dev->regulator = regulator_get(&adev->dev, "v-i2c");
-	if (IS_ERR(dev->regulator)) {
-		dev_warn(&adev->dev, "could not get i2c regulator\n");
-		dev->regulator = NULL;
-	}
-
 	pm_suspend_ignore_children(&adev->dev, true);
 
 	dev->clk = clk_get(&adev->dev, NULL);
@@ -1009,8 +996,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
  err_add_adap:
 	clk_put(dev->clk);
  err_no_clk:
-	if (dev->regulator)
-		regulator_put(dev->regulator);
 	free_irq(dev->irq, dev);
  err_irq:
 	iounmap(dev->virtbase);
@@ -1038,8 +1023,6 @@ static int nmk_i2c_remove(struct amba_device *adev)
 	if (res)
 		release_mem_region(res->start, resource_size(res));
 	clk_put(dev->clk);
-	if (dev->regulator)
-		regulator_put(dev->regulator);
 	pm_runtime_disable(&adev->dev);
 	amba_set_drvdata(adev, NULL);
 	kfree(dev);
-- 
1.7.11.3
