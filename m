From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/7 v3] i2c: gpio: Add support for named gpios in DT
Date: Thu,  5 Oct 2017 13:03:10 +0200
Message-ID: <20171005110310.5900-8-linus.walleij@linaro.org>
References: <20171005110310.5900-1-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:49689 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdJELDr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 5 Oct 2017 07:03:47 -0400
Received: by mail-wm0-f54.google.com with SMTP id b189so1358497wmd.4
        for <linux-i2c@vger.kernel.org>; Thu, 05 Oct 2017 04:03:46 -0700 (PDT)
In-Reply-To: <20171005110310.5900-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>

This adds support for using the "sda" and "scl" GPIOs in
device tree instead of anonymously using index 0 and 1 of
the "gpios" property.

We add a helper function to retrieve the GPIO descriptors
and some explicit error handling since the probe may have
to be deferred. At least this happened to me when moving
to using named "sda" and "scl" lines (all of a sudden this
started to probe before the GPIO driver) so we need to
gracefully defer probe when we ge -ENOENT in the error
pointer.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Switched using %d to print error code rather than %ld

This is pretty much a rewrite of Geerts patch on top of
my own changes to support descriptors.
---
 drivers/i2c/busses/i2c-gpio.c | 59 +++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index a702e493275c..d80ea6ce91bb 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -82,6 +82,42 @@ static void of_i2c_gpio_get_props(struct device_node *np,
 		of_property_read_bool(np, "i2c-gpio,scl-output-only");
 }
 
+static struct gpio_desc *i2c_gpio_get_desc(struct device *dev,
+					   const char *con_id,
+					   unsigned int index,
+					   enum gpiod_flags gflags)
+{
+	struct gpio_desc *retdesc;
+	int ret;
+
+	retdesc = devm_gpiod_get(dev, con_id, gflags);
+	if (!IS_ERR(retdesc)) {
+		dev_dbg(dev, "got GPIO from name %s\n", con_id);
+		return retdesc;
+	}
+
+	retdesc = devm_gpiod_get_index(dev, NULL, index, gflags);
+	if (!IS_ERR(retdesc)) {
+		dev_dbg(dev, "got GPIO from index %u\n", index);
+		return retdesc;
+	}
+
+	ret = PTR_ERR(retdesc);
+
+	/* FIXME: hack in the old code, is this really necessary? */
+	if (ret == -EINVAL)
+		retdesc = ERR_PTR(-EPROBE_DEFER);
+
+	/* This happens if the GPIO driver is not yet probed, let's defer */
+	if (ret == -ENOENT)
+		retdesc = ERR_PTR(-EPROBE_DEFER);
+
+	if (ret != -EPROBE_DEFER)
+		dev_err(dev, "error trying to get descriptor: %d\n", ret);
+
+	return retdesc;
+}
+
 static int i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
@@ -124,14 +160,10 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_HIGH;
 	else
 		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
-	priv->sda = devm_gpiod_get_index(dev, NULL, 0, gflags);
-	if (IS_ERR(priv->sda)) {
-		ret = PTR_ERR(priv->sda);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
+	priv->sda = i2c_gpio_get_desc(dev, "sda", 0, gflags);
+	if (IS_ERR(priv->sda))
+		return PTR_ERR(priv->sda);
+
 	/*
 	 * If the SCL line is marked from platform data or device tree as
 	 * "open drain" it means something outside of our control is making
@@ -143,14 +175,9 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_LOW;
 	else
 		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
-	priv->scl = devm_gpiod_get_index(dev, NULL, 1, gflags);
-	if (IS_ERR(priv->scl)) {
-		ret = PTR_ERR(priv->scl);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
+	priv->scl = i2c_gpio_get_desc(dev, "scl", 1, gflags);
+	if (IS_ERR(priv->scl))
+		return PTR_ERR(priv->scl);
 
 	bit_data->setsda = i2c_gpio_setsda_val;
 	bit_data->setscl = i2c_gpio_setscl_val;
-- 
2.13.5
