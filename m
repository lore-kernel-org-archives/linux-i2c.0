From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] i2c: nomadik: adopt pinctrl support
Date: Tue, 25 Sep 2012 13:22:47 +0200
Message-ID: <1348572167-3770-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Amend the I2C nomadik pin controller to optionally take a pin control
handle and set the state of the pins to "default" on boot and
before performing an i2c transfer, and to "sleep" after an i2c xfer.

Signed-off-by: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 1b898b6..8ed3962 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/i2c-nomadik.h>
+#include <linux/pinctrl/consumer.h>
 
 #define DRIVER_NAME "nmk-i2c"
 
@@ -158,6 +159,10 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct completion		xfer_complete;
 	int				result;
+	/* Two optional pin states - default & sleep */
+	struct pinctrl			*pinctrl;
+	struct pinctrl_state		*pins_default;
+	struct pinctrl_state		*pins_sleep;
 	bool				busy;
 };
 
@@ -642,6 +647,15 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
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
@@ -670,6 +684,16 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 out:
 	clk_disable(dev->clk);
+
+	/* Optionally let pins go into sleep states */
+	if (!IS_ERR(dev->pins_sleep)) {
+		status = pinctrl_select_state(dev->pinctrl,
+				dev->pins_sleep);
+		if (status)
+			dev_err(&dev->adev->dev,
+				"could not set pins to sleep state\n");
+	}
+
 	pm_runtime_put_sync(&dev->adev->dev);
 
 	dev->busy = false;
@@ -936,6 +960,22 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
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
+
+	dev->pins_sleep = pinctrl_lookup_state(dev->pinctrl,
+					       PINCTRL_STATE_SLEEP);
+	if (IS_ERR(dev->pins_sleep))
+		dev_dbg(&adev->dev, "could not get sleep pinstate\n");
+
 	dev->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
 	if (!dev->virtbase) {
 		ret = -ENOMEM;
@@ -1002,6 +1042,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
  err_no_ioremap:
 	amba_set_drvdata(adev, NULL);
 	kfree(dev);
+ err_pinctrl:
  err_no_mem:
 
 	return ret;
-- 
1.7.11.3
