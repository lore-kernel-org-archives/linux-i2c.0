From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2] i2c: i2c-mux-gpio: update mux with gpiod_set_array_value_cansleep
Date: Wed, 23 Nov 2016 14:33:55 +0100
Message-ID: <1479908035-18284-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:8350
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936613AbcKWNul (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 23 Nov 2016 08:50:41 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

If the gpio controller supports it and the gpio lines are concentrated
to one gpio chip, the mux controller pins will get updated simultaneously.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Sorry about any confusion with v1, it had another unrelated patch
underneath that made it hard to apply it. I had forgot about that
one...

Anyway, this version should be better. Sorry again.

Cheers,
Peter

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index e5cf26eefa97..62d033a7adf2 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -21,15 +21,18 @@
 struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
+	struct gpio_desc **gpios;
 };
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
+	int values[mux->data.n_gpios];
 	int i;
 
 	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_set_value_cansleep(mux->gpio_base + mux->data.gpios[i],
-					val & (1 << i));
+		values[i] = (val >> i) & 1;
+
+	gpiod_set_array_value_cansleep(mux->data.n_gpios, mux->gpios, values);
 }
 
 static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
@@ -176,12 +179,14 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	if (!parent)
 		return -EPROBE_DEFER;
 
-	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values, 0, 0,
+	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values,
+			     mux->data.n_values * sizeof(*mux->gpios), 0,
 			     i2c_mux_gpio_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
 		goto alloc_failed;
 	}
+	mux->gpios = muxc->priv;
 	muxc->priv = mux;
 
 	platform_set_drvdata(pdev, muxc);
@@ -219,10 +224,12 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 			goto err_request_gpio;
 		}
 
+		gpio_desc = gpio_to_desc(gpio_base + mux->data.gpios[i]);
+		mux->gpios[i] = gpio_desc;
+
 		if (!muxc->mux_locked)
 			continue;
 
-		gpio_desc = gpio_to_desc(gpio_base + mux->data.gpios[i]);
 		gpio_dev = &gpio_desc->gdev->dev;
 		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
 	}
-- 
2.1.4
