From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3] i2c-mux-gpio: Check gpio_direction_output return value
Date: Thu, 7 Mar 2013 09:35:53 +0100
Message-ID: <20130307093553.4bc1595f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

gpio_direction_output() may fail, check for that and deal with it
appropriately. Also log an error message if gpio_request() fails.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
Changes since v2:
 * Refreshed so that it applies on top of the most recent version of
   the driver.

 drivers/i2c/muxes/i2c-mux-gpio.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- linux-3.8.orig/drivers/i2c/muxes/i2c-mux-gpio.c	2013-03-07 09:06:31.431159507 +0100
+++ linux-3.8/drivers/i2c/muxes/i2c-mux-gpio.c	2013-03-07 09:07:02.739878467 +0100
@@ -201,10 +201,21 @@ static int i2c_mux_gpio_probe(struct pla
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
 		ret = gpio_request(gpio_base + mux->data.gpios[i], "i2c-mux-gpio");
-		if (ret)
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
+				mux->data.gpios[i]);
 			goto err_request_gpio;
-		gpio_direction_output(gpio_base + mux->data.gpios[i],
-				      initial_state & (1 << i));
+		}
+
+		ret = gpio_direction_output(gpio_base + mux->data.gpios[i],
+					    initial_state & (1 << i));
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to set direction of GPIO %d to output\n",
+				mux->data.gpios[i]);
+			i++;	/* gpio_request above succeeded, so must free */
+			goto err_request_gpio;
+		}
 	}
 
 	for (i = 0; i < mux->data.n_values; i++) {


-- 
Jean Delvare
