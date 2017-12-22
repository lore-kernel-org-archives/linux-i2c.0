From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH] i2c: gpio: Enable working over slow can_sleep GPIOs
Date: Fri, 22 Dec 2017 22:47:16 +0100
Message-ID: <f105ae7f6b9ae9f5a26ecdac8d71c55dfedfe688.1513979394.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from office2.cesnet.cz ([195.113.144.244]:43348 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756259AbdLVV71 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Dec 2017 16:59:27 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

"Slow" GPIOs (usually those connected over an SPI or an I2C bus) are,
well, slow in their operation. It is generally a good idea to avoid
using them for time-critical operation, but sometimes the hardware just
sucks, and the software has to cope. In addition to that, the I2C bus
itself does not actually define any strict timing limits; the bus is
free to go all the way down to DC. The timeouts (and therefore the
slowest acceptable frequency) are present only in SMBus.

The `can_sleep` is IMHO a wrong concept to use here. My SPI-to-quad-UART
chip (MAX14830) is connected via a 26MHz SPI bus, and it happily drives
SCL at 200kHz (5µs pulses) during my benchmarks. That's faster than the
maximal allowed speed of the traditional I2C.

The previous version of this code did not really block operation over
slow GPIO pins, anyway. Instead, it just resorted to printing a warning
with a backtrace each time a GPIO pin was accessed, thereby slowing
things down even more.

Finally, it's not just me. A similar patch was originally submitted in
2015 [1].

[1] https://patchwork.ozlabs.org/patch/450956/

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
---
 drivers/i2c/busses/i2c-gpio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index d80ea6ce91bb..5f84c23162a6 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -34,7 +34,7 @@ static void i2c_gpio_setsda_val(void *data, int state)
 {
 	struct i2c_gpio_private_data *priv = data;
 
-	gpiod_set_value(priv->sda, state);
+	gpiod_set_value_cansleep(priv->sda, state);
 }
 
 /*
@@ -47,21 +47,21 @@ static void i2c_gpio_setscl_val(void *data, int state)
 {
 	struct i2c_gpio_private_data *priv = data;
 
-	gpiod_set_value(priv->scl, state);
+	gpiod_set_value_cansleep(priv->scl, state);
 }
 
 static int i2c_gpio_getsda(void *data)
 {
 	struct i2c_gpio_private_data *priv = data;
 
-	return gpiod_get_value(priv->sda);
+	return gpiod_get_value_cansleep(priv->sda);
 }
 
 static int i2c_gpio_getscl(void *data)
 {
 	struct i2c_gpio_private_data *priv = data;
 
-	return gpiod_get_value(priv->scl);
+	return gpiod_get_value_cansleep(priv->scl);
 }
 
 static void of_i2c_gpio_get_props(struct device_node *np,
@@ -179,6 +179,9 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->scl))
 		return PTR_ERR(priv->scl);
 
+	if (gpiod_cansleep(priv->sda) || gpiod_cansleep(priv->scl))
+		dev_warn(dev, "Slow GPIO pins might wreak havoc into I2C/SMBus bus timing");
+
 	bit_data->setsda = i2c_gpio_setsda_val;
 	bit_data->setscl = i2c_gpio_setscl_val;
 
-- 
2.14.3
