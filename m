From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 4/5] i2c-mux-gpio: Unpin the platform-specific GPIOs request code
Date: Wed, 24 Apr 2019 15:34:13 +0300
Message-ID: <20190424123414.25311-5-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The GPIOs request loop can be safely moved to a separate function.
First of all it shall improve the code readability. Secondly the
initialization loop at this point is used for both of- and
platform_data-based initialization paths, but it will be changed in
the next patch, so by isolating the code we'll simplify the future
work.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 105 +++++++++++++++++++------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 535c83c43371..317c019e1415 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -165,12 +165,68 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
 	return 0;
 }
 
+static int i2c_mux_gpio_request_plat(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct gpio_desc *gpio_desc;
+	struct i2c_adapter *root;
+	struct device *gpio_dev;
+	int i, ret;
+
+	root = i2c_root_adapter(&muxc->parent->dev);
+
+	for (i = 0; i < mux->data.n_gpios; i++) {
+		ret = gpio_request(mux->gpio_base + mux->data.gpios[i],
+				   "i2c-mux-gpio");
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
+				mux->data.gpios[i]);
+			goto err_request_gpio;
+		}
+
+		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
+					    mux->data.idle & (1 << i));
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to set direction of GPIO %d to output\n",
+				mux->data.gpios[i]);
+			i++;	/* gpio_request above succeeded, so must free */
+			goto err_request_gpio;
+		}
+
+		gpio_desc = gpio_to_desc(mux->gpio_base + mux->data.gpios[i]);
+		mux->gpios[i] = gpio_desc;
+
+		if (!muxc->mux_locked)
+			continue;
+
+		gpio_dev = &gpio_desc->gdev->dev;
+		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
+	}
+
+	return 0;
+
+err_request_gpio:
+	for (; i > 0; i--)
+		gpio_free(mux->gpio_base + mux->data.gpios[i - 1]);
+
+	return ret;
+}
+
+static void i2c_mux_gpio_free(struct gpiomux *mux)
+{
+	int i;
+
+	for (i = 0; i < mux->data.n_gpios; i++)
+		gpiod_free(mux->gpios[i]);
+}
+
 static int i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc;
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
-	struct i2c_adapter *root;
 	int i, ret;
 
 	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
@@ -199,8 +255,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, muxc);
 
-	root = i2c_root_adapter(&parent->dev);
-
 	muxc->mux_locked = true;
 
 	/*
@@ -212,37 +266,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	else
 		mux->data.idle = mux->data.values[0];
 
-	for (i = 0; i < mux->data.n_gpios; i++) {
-		struct device *gpio_dev;
-		struct gpio_desc *gpio_desc;
-
-		ret = gpio_request(mux->gpio_base + mux->data.gpios[i],
-				   "i2c-mux-gpio");
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
-				mux->data.gpios[i]);
-			goto err_request_gpio;
-		}
-
-		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
-					    mux->data.idle & (1 << i));
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to set direction of GPIO %d to output\n",
-				mux->data.gpios[i]);
-			i++;	/* gpio_request above succeeded, so must free */
-			goto err_request_gpio;
-		}
-
-		gpio_desc = gpio_to_desc(mux->gpio_base + mux->data.gpios[i]);
-		mux->gpios[i] = gpio_desc;
-
-		if (!muxc->mux_locked)
-			continue;
-
-		gpio_dev = &gpio_desc->gdev->dev;
-		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
-	}
+	ret = i2c_mux_gpio_request_plat(mux, pdev);
+	if (ret)
+		goto alloc_failed;
 
 	if (muxc->mux_locked)
 		dev_info(&pdev->dev, "mux-locked i2c mux\n");
@@ -263,10 +289,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 add_adapter_failed:
 	i2c_mux_del_adapters(muxc);
-	i = mux->data.n_gpios;
-err_request_gpio:
-	for (; i > 0; i--)
-		gpio_free(mux->gpio_base + mux->data.gpios[i - 1]);
+
+	i2c_mux_gpio_free(mux);
+
 alloc_failed:
 	i2c_put_adapter(parent);
 
@@ -277,12 +302,10 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
 	struct gpiomux *mux = i2c_mux_priv(muxc);
-	int i;
 
 	i2c_mux_del_adapters(muxc);
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_free(mux->gpio_base + mux->data.gpios[i]);
+	i2c_mux_gpio_free(mux);
 
 	i2c_put_adapter(muxc->parent);
 
-- 
2.21.0
