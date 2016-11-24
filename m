From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v3] i2c: i2c-mux-gpio: update mux with gpiod_set_array_value_cansleep
Date: Thu, 24 Nov 2016 19:19:28 +0100
Message-ID: <1480011568-13254-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

If the gpio controller supports it and the gpio lines are concentrated
to one gpio chip, the mux controller pins will get updated simultaneously.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Hi!

v2 -> v3 changes
- preallocate temporary storage for the values array needed by the
  gpiod_set_array_value_cansleep call, killing a warning about variable
  length arrays reported by Wolfram.
- allocate a correctly sized array for gpios (number of pins, not
  number of channels).

v1 -> v2 changes
- rebase onto something without interference from other patches

Cheers,
Peter

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index e5cf26eefa97..655684d621a4 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -21,6 +21,8 @@
 struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
+	struct gpio_desc **gpios;
+	int *values;
 };
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
@@ -28,8 +30,10 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 	int i;
 
 	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_set_value_cansleep(mux->gpio_base + mux->data.gpios[i],
-					val & (1 << i));
+		mux->values[i] = (val >> i) & 1;
+
+	gpiod_set_array_value_cansleep(mux->data.n_gpios,
+				       mux->gpios, mux->values);
 }
 
 static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
@@ -176,12 +180,16 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	if (!parent)
 		return -EPROBE_DEFER;
 
-	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values, 0, 0,
+	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values,
+			     mux->data.n_gpios * sizeof(*mux->gpios) +
+			     mux->data.n_gpios * sizeof(*mux->values), 0,
 			     i2c_mux_gpio_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
 		goto alloc_failed;
 	}
+	mux->gpios = muxc->priv;
+	mux->values = (int *)(mux->gpios + mux->data.n_gpios);
 	muxc->priv = mux;
 
 	platform_set_drvdata(pdev, muxc);
@@ -219,10 +227,12 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
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
