From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH v2] i2c: nomadik: adopt pinctrl support
Date: Fri, 28 Sep 2012 14:59:11 +0200
Message-ID: <1348837151-20820-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Amend the I2C nomadik pin controller to optionally take a pin control
handle and set the state of the pins to:

- "default" on boot, resume and before performing an i2c transfer
- "idle" after initial default, after resume default, and after each
   i2c xfer
- "sleep" on suspend()

This should make it possible to optimize energy usage for the pins
both for the suspend/resume cycle, and for runtime cases inbetween
I2C transfers.

Signed-off-by: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- We used only two states initially: default and sleep. It turns
  out you can save some energy when idling (between transfers)
  and even more when suspending on our platform, so grab all
  three states and use them as applicable.
---
 drivers/i2c/busses/i2c-nomadik.c | 102 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 1b898b6..bd3da46 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/i2c-nomadik.h>
+#include <linux/pinctrl/consumer.h>
 
 #define DRIVER_NAME "nmk-i2c"
 
@@ -145,6 +146,10 @@ struct i2c_nmk_client {
  * @stop: stop condition.
  * @xfer_complete: acknowledge completion for a I2C message.
  * @result: controller propogated result.
+ * @pinctrl: pinctrl handle.
+ * @pins_default: default state for the pins.
+ * @pins_idle: idle state for the pins.
+ * @pins_sleep: sleep state for the pins.
  * @busy: Busy doing transfer.
  */
 struct nmk_i2c_dev {
@@ -158,6 +163,11 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct completion		xfer_complete;
 	int				result;
+	/* Three pin states - default, idle & sleep */
+	struct pinctrl			*pinctrl;
+	struct pinctrl_state		*pins_default;
+	struct pinctrl_state		*pins_idle;
+	struct pinctrl_state		*pins_sleep;
 	bool				busy;
 };
 
@@ -642,6 +652,15 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	pm_runtime_get_sync(&dev->adev->dev);
 
+	/* Optionaly enable pins to be muxed in and configured */
+	if (!IS_ERR(dev->pins_default)) {
+		status = pinctrl_select_state(dev->pinctrl,
+				dev->pins_default);
+		if (status)
+			dev_err(&dev->adev->dev,
+				"could not set default pins\n");
+	}
+
 	clk_enable(dev->clk);
 
 	status = init_hw(dev);
@@ -670,6 +689,16 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 out:
 	clk_disable(dev->clk);
+
+	/* Optionally let pins go into idle state */
+	if (!IS_ERR(dev->pins_idle)) {
+		status = pinctrl_select_state(dev->pinctrl,
+				dev->pins_idle);
+		if (status)
+			dev_err(&dev->adev->dev,
+				"could not set pins to idle state\n");
+	}
+
 	pm_runtime_put_sync(&dev->adev->dev);
 
 	dev->busy = false;
@@ -864,15 +893,44 @@ static int nmk_i2c_suspend(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
 	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
+	int ret;
 
 	if (nmk_i2c->busy)
 		return -EBUSY;
 
+	if (!IS_ERR(nmk_i2c->pins_sleep)) {
+		ret = pinctrl_select_state(nmk_i2c->pinctrl,
+				nmk_i2c->pins_sleep);
+		if (ret)
+			dev_err(dev,
+				"could not set pins to sleep state\n");
+	}
+
 	return 0;
 }
 
 static int nmk_i2c_resume(struct device *dev)
 {
+	struct amba_device *adev = to_amba_device(dev);
+	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
+	int ret;
+
+	/* First go to the default state */
+	if (!IS_ERR(nmk_i2c->pins_default)) {
+		ret = pinctrl_select_state(nmk_i2c->pinctrl,
+				nmk_i2c->pins_default);
+		if (ret)
+			dev_err(dev,
+				"could not set pins to default state\n");
+	}
+	/* Then let's idle the pins until the next transfer happens */
+	if (!IS_ERR(nmk_i2c->pins_idle)) {
+		ret = pinctrl_select_state(nmk_i2c->pinctrl,
+				nmk_i2c->pins_idle);
+		if (ret)
+			dev_err(dev,
+				"could not set pins to idle state\n");
+	}
 	return 0;
 }
 #else
@@ -936,6 +994,40 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	dev->adev = adev;
 	amba_set_drvdata(adev, dev);
 
+	dev->pinctrl = devm_pinctrl_get(&adev->dev);
+	if (IS_ERR(dev->pinctrl)) {
+		ret = PTR_ERR(dev->pinctrl);
+		goto err_pinctrl;
+	}
+
+	dev->pins_default = pinctrl_lookup_state(dev->pinctrl,
+						 PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(dev->pins_default))
+		dev_err(&adev->dev, "could not get default pinstate\n");
+	else {
+		ret = pinctrl_select_state(dev->pinctrl,
+					   dev->pins_default);
+		if (ret)
+			dev_dbg(&adev->dev, "could not set default pinstate\n");
+	}
+
+	dev->pins_idle = pinctrl_lookup_state(dev->pinctrl,
+					      PINCTRL_STATE_IDLE);
+	if (IS_ERR(dev->pins_idle))
+		dev_dbg(&adev->dev, "could not get idle pinstate\n");
+	else {
+		/* If possible, let's go to idle until the first transfer */
+		ret = pinctrl_select_state(dev->pinctrl,
+					   dev->pins_idle);
+		if (ret)
+			dev_dbg(&adev->dev, "could not set idle pinstate\n");
+	}
+
+	dev->pins_sleep = pinctrl_lookup_state(dev->pinctrl,
+					       PINCTRL_STATE_SLEEP);
+	if (IS_ERR(dev->pins_sleep))
+		dev_dbg(&adev->dev, "could not get sleep pinstate\n");
+
 	dev->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
 	if (!dev->virtbase) {
 		ret = -ENOMEM;
@@ -959,6 +1051,12 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_clk;
 	}
 
+	ret = clk_prepare(dev->clk);
+	if (ret) {
+		dev_err(&adev->dev, "can't prepare clock\n");
+		goto err_prep_clk;
+	}
+
 	adap = &dev->adap;
 	adap->dev.parent = &adev->dev;
 	adap->owner	= THIS_MODULE;
@@ -994,6 +1092,8 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 
  err_add_adap:
+	clk_unprepare(dev->clk);
+ err_prep_clk:
 	clk_put(dev->clk);
  err_no_clk:
 	free_irq(dev->irq, dev);
@@ -1002,6 +1102,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
  err_no_ioremap:
 	amba_set_drvdata(adev, NULL);
 	kfree(dev);
+ err_pinctrl:
  err_no_mem:
 
 	return ret;
@@ -1022,6 +1123,7 @@ static int nmk_i2c_remove(struct amba_device *adev)
 	iounmap(dev->virtbase);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
+	clk_unprepare(dev->clk);
 	clk_put(dev->clk);
 	pm_runtime_disable(&adev->dev);
 	amba_set_drvdata(adev, NULL);
-- 
1.7.11.3
