From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 5/5] i2c-mux-gpio: Create of-based GPIOs request method
Date: Wed, 24 Apr 2019 15:34:14 +0300
Message-ID: <20190424123414.25311-6-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Most modern platforms provide a dts with description of the devices
available in the system. It may also include i2c-gpio-mux'es.
Up until now the i2c-mux-gpio driver supported it' dts nodes, but
performed the GPIOs request by means of legacy GPIO API, which by design
and due to being legacy doesn't know anything about of/dtb/fdt/dts stuff.
It means even though the i2c-gpio-mux dts nodes are successfully mapped
to the kernel i2c-mux devices, the GPIOs used for initialization are
requested without OF_GPIO_* flags setup. It causes problems on the
platforms which fully rely on dts and reside, for instance,
i2c-gpio-muxes with active low or open drain GPIOs connected.

It is fixed by implementing a dedicated method for full dts-based
GPIOs requests. It is mostly similar to the platform one, but
utilizes the gpiod_get_from_of_node() method to request the GPIOs.

Finally the platform code i2c-gpio-mux devices are also supported.
So the fallback to dtb is performed only if array with GPIOs isn't
detected.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 65 ++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 317c019e1415..e5e10ba35ad9 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -65,8 +65,8 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *adapter_np, *child;
 	struct i2c_adapter *adapter;
-	unsigned *values, *gpios;
-	int i = 0, ret;
+	unsigned int *values;
+	int i = 0;
 
 	if (!np)
 		return -ENODEV;
@@ -109,24 +109,48 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 		return -EINVAL;
 	}
 
-	gpios = devm_kcalloc(&pdev->dev,
-			     mux->data.n_gpios, sizeof(*mux->data.gpios),
-			     GFP_KERNEL);
-	if (!gpios) {
-		dev_err(&pdev->dev, "Cannot allocate gpios array");
-		return -ENOMEM;
-	}
+	return 0;
+}
+
+static int i2c_mux_gpio_request_dt(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct i2c_adapter *root;
+	struct device *gpio_dev;
+	enum gpiod_flags dflags;
+	int i, ret;
+
+	root = i2c_root_adapter(&muxc->parent->dev);
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
-		ret = of_get_named_gpio(np, "mux-gpios", i);
-		if (ret < 0)
-			return ret;
-		gpios[i] = ret;
-	}
+		if (mux->data.idle & (1 << i))
+			dflags = GPIOD_OUT_HIGH;
+		else
+			dflags = GPIOD_OUT_LOW;
+
+		mux->gpios[i] = gpiod_get_from_of_node(np, "mux-gpios", i,
+						       dflags, "i2c-mux-gpio");
+		if (IS_ERR(mux->gpios[i])) {
+			ret = PTR_ERR(mux->gpios[i]);
+			goto err_request_gpio;
+		}
 
-	mux->data.gpios = gpios;
+		if (!muxc->mux_locked)
+			continue;
+
+		gpio_dev = &mux->gpios[i]->gdev->dev;
+		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
+	}
 
 	return 0;
+
+err_request_gpio:
+	for (i--; i >= 0; i--)
+		gpiod_free(mux->gpios[i]);
+
+	return ret;
 }
 #else
 static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
@@ -134,6 +158,12 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 {
 	return -EINVAL;
 }
+
+static int i2c_mux_gpio_request_dt(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	return -EINVAL;
+}
 #endif
 
 static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
@@ -174,6 +204,9 @@ static int i2c_mux_gpio_request_plat(struct gpiomux *mux,
 	struct device *gpio_dev;
 	int i, ret;
 
+	if (!mux->data.gpios)
+		return -EINVAL;
+
 	root = i2c_root_adapter(&muxc->parent->dev);
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
@@ -267,6 +300,8 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		mux->data.idle = mux->data.values[0];
 
 	ret = i2c_mux_gpio_request_plat(mux, pdev);
+	if (ret)
+		ret = i2c_mux_gpio_request_dt(mux, pdev);
 	if (ret)
 		goto alloc_failed;
 
-- 
2.21.0
