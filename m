From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/2] eeprom: at24: add support for the write-protect pin
Date: Wed, 20 Dec 2017 09:26:33 +0100
Message-ID: <20171220082633.32237-3-brgl@bgdev.pl>
References: <20171220082633.32237-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46767 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbdLTI0l (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 03:26:41 -0500
Received: by mail-wr0-f193.google.com with SMTP id g17so12322746wrd.13
        for <linux-i2c@vger.kernel.org>; Wed, 20 Dec 2017 00:26:41 -0800 (PST)
In-Reply-To: <20171220082633.32237-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

AT24 EEPROMs have a write-protect pin, which - when pulled high -
inhibits writes to the upper quadrant of memory (although it has been
observed that on some chips it disables writing to the entire memory
range).

On some boards, this pin is connected to a GPIO and pulled high by
default, which forces the user to manually change its state before
writing. On linux this means that we either need to hog the line all
the time, or set the GPIO value before writing from outside of the
at24 driver.

Make the driver check if the write-protect GPIO was defined in the
device tree and pull it low whenever writing to the EEPROM.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b44a3d2b2b20..4456e192681c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -27,6 +27,7 @@
 #include <linux/regmap.h>
 #include <linux/platform_data/at24.h>
 #include <linux/pm_runtime.h>
+#include <linux/gpio/consumer.h>
 
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
@@ -77,6 +78,8 @@ struct at24_data {
 	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 
+	struct gpio_desc *wp_gpio;
+
 	/*
 	 * Some chips tie up multiple I2C addresses; dummy devices reserve
 	 * them for us, and we'll use them with SMBus calls.
@@ -442,12 +445,14 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	 * from this host, but not from other I2C masters.
 	 */
 	mutex_lock(&at24->lock);
+	gpiod_set_value_cansleep(at24->wp_gpio, 0);
 
 	while (count) {
 		int status;
 
 		status = at24_regmap_write(at24, buf, off, count);
 		if (status < 0) {
+			gpiod_set_value_cansleep(at24->wp_gpio, 1);
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(dev);
 			return status;
@@ -457,6 +462,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 		count -= status;
 	}
 
+	gpiod_set_value_cansleep(at24->wp_gpio, 1);
 	mutex_unlock(&at24->lock);
 
 	pm_runtime_put(dev);
@@ -604,6 +610,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->num_addresses = num_addresses;
 	at24->offset_adj = at24_get_offset_adj(chip.flags, chip.byte_len);
 
+	at24->wp_gpio = devm_gpiod_get_optional(&client->dev,
+						"wp", GPIOD_OUT_HIGH);
+	if (IS_ERR(at24->wp_gpio))
+		return PTR_ERR(at24->wp_gpio);
+
 	at24->client[0].client = client;
 	at24->client[0].regmap = devm_regmap_init_i2c(client, &regmap_config);
 	if (IS_ERR(at24->client[0].regmap))
-- 
2.15.1
