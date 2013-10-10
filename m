From: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Subject: [PATCH 1/2] i2c-mux-gpio: test if the gpio can sleep
Date: Thu, 10 Oct 2013 10:39:32 +0200
Message-ID: <525667C4.3080309@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some gpio chips may have get/set operations that
can sleep. For this type of chips we must use the
_cansleep() version of gpio_set_value.

Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index a764da7..b5f17ef 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -27,11 +27,16 @@ struct gpiomux {
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
+	unsigned gpio;
 	int i;
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_set_value(mux->gpio_base + mux->data.gpios[i],
-			       val & (1 << i));
+	for (i = 0; i < mux->data.n_gpios; i++) {
+		gpio = mux->gpio_base + mux->data.gpios[i];
+		if (gpio_cansleep(gpio))
+			gpio_set_value_cansleep(gpio, val & (1 << i));
+		else
+			gpio_set_value(gpio, val & (1 << i));
+	}
 }
 
 static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
-- 
1.7.1
