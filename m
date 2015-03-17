From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH] i2c: i2c-gpio: fix some of gpio sleep issues
Date: Tue, 17 Mar 2015 12:04:29 +0000
Message-ID: <1426593869-8724-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-gpio driver can be used in systems where the GPIO itself is
provided by a GPIO driver that may be sleeping (for example, SPI or
USB). In this case, it is preferable to use the _cansleep() variants
of the GPIO code.

We can only fix this up for the case where the i2c-gpio implementation
provides open-drain outputs as there are no gpio_direction_xxx_cansleep()
provided.

This removes the issues on the customer system with the console constantly
showing the following warning:

WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2389 gpiod_set_raw_value

Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
--
CC: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/i2c-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index d1050bd..9d4d59c 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -44,7 +44,7 @@ static void i2c_gpio_setsda_val(void *data, int state)
 {
 	struct i2c_gpio_platform_data *pdata = data;
 
-	gpio_set_value(pdata->sda_pin, state);
+	gpio_set_value_cansleep(pdata->sda_pin, state);
 }
 
 /* Toggle SCL by changing the direction of the pin. */
@@ -68,21 +68,21 @@ static void i2c_gpio_setscl_val(void *data, int state)
 {
 	struct i2c_gpio_platform_data *pdata = data;
 
-	gpio_set_value(pdata->scl_pin, state);
+	gpio_set_value_cansleep(pdata->scl_pin, state);
 }
 
 static int i2c_gpio_getsda(void *data)
 {
 	struct i2c_gpio_platform_data *pdata = data;
 
-	return gpio_get_value(pdata->sda_pin);
+	return gpio_get_value_cansleep(pdata->sda_pin);
 }
 
 static int i2c_gpio_getscl(void *data)
 {
 	struct i2c_gpio_platform_data *pdata = data;
 
-	return gpio_get_value(pdata->scl_pin);
+	return gpio_get_value_cansleep(pdata->scl_pin);
 }
 
 static int of_i2c_gpio_get_pins(struct device_node *np,
-- 
2.1.4
