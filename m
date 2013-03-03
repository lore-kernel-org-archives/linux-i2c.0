From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2] i2c-mux-gpio: Check gpio_direction_output return value
Date: Sun, 3 Mar 2013 21:05:02 +0100
Message-ID: <20130303210502.41ca2d69@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

gpio_direction_output() may fail, check for that and deal with it
appropriately. Also log an error message if gpio_request() fails.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
Changes since v1:
 * Add a comment on i++ as suggested by Peter.

 drivers/i2c/muxes/i2c-mux-gpio.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- linux-3.7.orig/drivers/i2c/muxes/i2c-mux-gpio.c	2012-12-15 14:52:47.368991730 +0100
+++ linux-3.7/drivers/i2c/muxes/i2c-mux-gpio.c	2013-03-03 21:02:22.011071012 +0100
@@ -123,10 +123,21 @@ static int __devinit i2c_mux_gpio_probe(
 
 	for (i = 0; i < pdata->n_gpios; i++) {
 		ret = gpio_request(gpio_base + pdata->gpios[i], "i2c-mux-gpio");
-		if (ret)
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
+				pdata->gpios[i]);
 			goto err_request_gpio;
-		gpio_direction_output(gpio_base + pdata->gpios[i],
-				      initial_state & (1 << i));
+		}
+
+		ret = gpio_direction_output(gpio_base + pdata->gpios[i],
+					    initial_state & (1 << i));
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to set direction of GPIO %d to output\n",
+				pdata->gpios[i]);
+			i++;	/* gpio_request above succeeded, so must free */
+			goto err_request_gpio;
+		}
 	}
 
 	for (i = 0; i < pdata->n_values; i++) {


-- 
Jean Delvare
