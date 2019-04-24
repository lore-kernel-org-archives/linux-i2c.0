From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 1/5] i2c-mux-gpio: Unpin a platform-based device initialization
Date: Wed, 24 Apr 2019 15:34:10 +0300
Message-ID: <20190424123414.25311-2-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We can unpin a code specific for i2c-mux-gpio device declared
as platform device. In this case the platform data just needs to be
copied to the private storage and if GPIO chip pointer is referring to
a valid GPIO chip descriptor save it' base number for further GPIOs
request and initialization. The rest of the code is common for both
platform and OF-based setups.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 67 ++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 13882a2a4f60..24cf6ec02e75 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -136,44 +136,51 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 }
 #endif
 
+static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	struct i2c_mux_gpio_platform_data *data = dev_get_platdata(&pdev->dev);
+	struct gpio_chip *gpio;
+
+	/*
+	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
+	 * relative to its base GPIO number. Otherwise they are absolute.
+	 */
+	if (data->gpio_chip) {
+		gpio = gpiochip_find(data->gpio_chip,
+				     match_gpio_chip_by_label);
+		if (!gpio)
+			return -EPROBE_DEFER;
+
+		mux->gpio_base = gpio->base;
+	} else {
+		mux->gpio_base = 0;
+	}
+
+	memcpy(&mux->data, data, sizeof(mux->data));
+
+	return 0;
+}
+
 static int i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc;
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
 	struct i2c_adapter *root;
-	unsigned initial_state, gpio_base;
+	unsigned initial_state;
 	int i, ret;
 
 	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
 		return -ENOMEM;
 
-	if (!dev_get_platdata(&pdev->dev)) {
+	if (!dev_get_platdata(&pdev->dev))
 		ret = i2c_mux_gpio_probe_dt(mux, pdev);
-		if (ret < 0)
-			return ret;
-	} else {
-		memcpy(&mux->data, dev_get_platdata(&pdev->dev),
-			sizeof(mux->data));
-	}
-
-	/*
-	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
-	 * relative to its base GPIO number. Otherwise they are absolute.
-	 */
-	if (mux->data.gpio_chip) {
-		struct gpio_chip *gpio;
-
-		gpio = gpiochip_find(mux->data.gpio_chip,
-				     match_gpio_chip_by_label);
-		if (!gpio)
-			return -EPROBE_DEFER;
-
-		gpio_base = gpio->base;
-	} else {
-		gpio_base = 0;
-	}
+	else
+		ret = i2c_mux_gpio_probe_plat(mux, pdev);
+	if (ret < 0)
+		return ret;
 
 	parent = i2c_get_adapter(mux->data.parent);
 	if (!parent)
@@ -194,7 +201,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	root = i2c_root_adapter(&parent->dev);
 
 	muxc->mux_locked = true;
-	mux->gpio_base = gpio_base;
 
 	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
 		initial_state = mux->data.idle;
@@ -207,14 +213,15 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		struct device *gpio_dev;
 		struct gpio_desc *gpio_desc;
 
-		ret = gpio_request(gpio_base + mux->data.gpios[i], "i2c-mux-gpio");
+		ret = gpio_request(mux->gpio_base + mux->data.gpios[i],
+				   "i2c-mux-gpio");
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
 				mux->data.gpios[i]);
 			goto err_request_gpio;
 		}
 
-		ret = gpio_direction_output(gpio_base + mux->data.gpios[i],
+		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
 					    initial_state & (1 << i));
 		if (ret) {
 			dev_err(&pdev->dev,
@@ -224,7 +231,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 			goto err_request_gpio;
 		}
 
-		gpio_desc = gpio_to_desc(gpio_base + mux->data.gpios[i]);
+		gpio_desc = gpio_to_desc(mux->gpio_base + mux->data.gpios[i]);
 		mux->gpios[i] = gpio_desc;
 
 		if (!muxc->mux_locked)
@@ -256,7 +263,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	i = mux->data.n_gpios;
 err_request_gpio:
 	for (; i > 0; i--)
-		gpio_free(gpio_base + mux->data.gpios[i - 1]);
+		gpio_free(mux->gpio_base + mux->data.gpios[i - 1]);
 alloc_failed:
 	i2c_put_adapter(parent);
 
-- 
2.21.0
