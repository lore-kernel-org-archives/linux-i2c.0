From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 2/3] i2c-mux-gpio: Unpin the platform-specific GPIOs request code
Date: Fri, 26 Apr 2019 02:20:27 +0300
Message-ID: <20190425232028.9333-3-fancer.lancer@gmail.com>
References: <20190425232028.9333-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425232028.9333-1-fancer.lancer@gmail.com>
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
Changelog v2
- Create a dedicated initial_state field in the "gpiomux" structure to
  keep an initial channel selector state.
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 113 +++++++++++++++++++------------
 1 file changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 54158b825acd..e10f72706b99 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -20,7 +20,8 @@
 
 struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
-	unsigned gpio_base;
+	unsigned int gpio_base;
+	unsigned int initial_state;
 	struct gpio_desc **gpios;
 };
 
@@ -162,13 +163,68 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
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
+					    mux->initial_state & (1 << i));
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
-	unsigned initial_state;
 	int i, ret;
 
 	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
@@ -198,48 +254,18 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, muxc);
 
-	root = i2c_root_adapter(&parent->dev);
-
 	muxc->mux_locked = true;
 
 	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
-		initial_state = mux->data.idle;
+		mux->initial_state = mux->data.idle;
 		muxc->deselect = i2c_mux_gpio_deselect;
 	} else {
-		initial_state = mux->data.values[0];
+		mux->initial_state = mux->data.values[0];
 	}
 
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
-					    initial_state & (1 << i));
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
@@ -260,10 +286,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
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
 
@@ -274,12 +299,10 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
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
