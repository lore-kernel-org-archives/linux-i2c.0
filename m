From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: i2c-mux-gpio: rename i2c-gpio-mux to i2c-mux-gpio
Date: Tue, 7 Feb 2017 22:41:55 +0100
Message-ID: <1486503715-9224-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0136.outbound.protection.outlook.com ([104.47.2.136]:4448
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932176AbdBGV5a (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 7 Feb 2017 16:57:30 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org

The rename did the wrong thing for this documentation file all those
years ago. Fix that as well as the neglected rename of the platform
data structure.

Fixes: e7065e20d9a6 ("i2c: Rename last mux driver to standard pattern")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/i2c/muxes/i2c-mux-gpio | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/i2c/muxes/i2c-mux-gpio b/Documentation/i2c/muxes/i2c-mux-gpio
index d4d91a53fc39..7a8d7d261632 100644
--- a/Documentation/i2c/muxes/i2c-mux-gpio
+++ b/Documentation/i2c/muxes/i2c-mux-gpio
@@ -1,11 +1,11 @@
-Kernel driver i2c-gpio-mux
+Kernel driver i2c-mux-gpio
 
 Author: Peter Korsgaard <peter.korsgaard@barco.com>
 
 Description
 -----------
 
-i2c-gpio-mux is an i2c mux driver providing access to I2C bus segments
+i2c-mux-gpio is an i2c mux driver providing access to I2C bus segments
 from a master I2C bus and a hardware MUX controlled through GPIO pins.
 
 E.G.:
@@ -26,16 +26,16 @@ according to the settings of the GPIO pins 1..N.
 Usage
 -----
 
-i2c-gpio-mux uses the platform bus, so you need to provide a struct
+i2c-mux-gpio uses the platform bus, so you need to provide a struct
 platform_device with the platform_data pointing to a struct
-gpio_i2cmux_platform_data with the I2C adapter number of the master
+i2c_mux_gpio_platform_data with the I2C adapter number of the master
 bus, the number of bus segments to create and the GPIO pins used
-to control it. See include/linux/i2c-gpio-mux.h for details.
+to control it. See include/linux/i2c-mux-gpio.h for details.
 
 E.G. something like this for a MUX providing 4 bus segments
 controlled through 3 GPIO pins:
 
-#include <linux/i2c-gpio-mux.h>
+#include <linux/i2c-mux-gpio.h>
 #include <linux/platform_device.h>
 
 static const unsigned myboard_gpiomux_gpios[] = {
@@ -46,7 +46,7 @@ static const unsigned myboard_gpiomux_values[] = {
 	0, 1, 2, 3
 };
 
-static struct gpio_i2cmux_platform_data myboard_i2cmux_data = {
+static struct i2c_mux_gpio_platform_data myboard_i2cmux_data = {
 	.parent		= 1,
 	.base_nr	= 2, /* optional */
 	.values		= myboard_gpiomux_values,
@@ -57,7 +57,7 @@ static struct gpio_i2cmux_platform_data myboard_i2cmux_data = {
 };
 
 static struct platform_device myboard_i2cmux = {
-	.name		= "i2c-gpio-mux",
+	.name		= "i2c-mux-gpio",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &myboard_i2cmux_data,
@@ -66,14 +66,14 @@ static struct platform_device myboard_i2cmux = {
 
 If you don't know the absolute GPIO pin numbers at registration time,
 you can instead provide a chip name (.chip_name) and relative GPIO pin
-numbers, and the i2c-gpio-mux driver will do the work for you,
+numbers, and the i2c-mux-gpio driver will do the work for you,
 including deferred probing if the GPIO chip isn't immediately
 available.
 
 Device Registration
 -------------------
 
-When registering your i2c-gpio-mux device, you should pass the number
+When registering your i2c-mux-gpio device, you should pass the number
 of any GPIO pin it uses as the device ID. This guarantees that every
 instance has a different ID.
 
-- 
2.1.4
