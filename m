From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data found
Date: Wed, 24 Apr 2019 15:34:11 +0300
Message-ID: <20190424123414.25311-3-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

It's pointless and might be even errors prone to proceed with further
initialization if neither of- no platform-based settings were discovered.
Just return an error in this case.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 24cf6ec02e75..a14fe132b0c3 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -132,7 +132,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 					struct platform_device *pdev)
 {
-	return 0;
+	return -EINVAL;
 }
 #endif
 
@@ -142,6 +142,9 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
 	struct i2c_mux_gpio_platform_data *data = dev_get_platdata(&pdev->dev);
 	struct gpio_chip *gpio;
 
+	if (!data)
+		return -EINVAL;
+
 	/*
 	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
 	 * relative to its base GPIO number. Otherwise they are absolute.
@@ -175,11 +178,10 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	if (!mux)
 		return -ENOMEM;
 
-	if (!dev_get_platdata(&pdev->dev))
+	ret = i2c_mux_gpio_probe_plat(mux, pdev);
+	if (ret)
 		ret = i2c_mux_gpio_probe_dt(mux, pdev);
-	else
-		ret = i2c_mux_gpio_probe_plat(mux, pdev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	parent = i2c_get_adapter(mux->data.parent);
-- 
2.21.0
