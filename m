From: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Subject: [PATCH 1/2] i2c-mux-gpio: use gpio_set_value_cansleep()
Date: Fri, 11 Oct 2013 14:17:10 +0200
Message-ID: <5257EC46.8040603@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some gpio chips may have get/set operations that
can sleep. gpio_set_value() only works for chips
which do not sleep, for the others we will get a
kernel warning. Using gpio_set_value_cansleep()
will work for both chips that do sleep and those
who don't.

Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index a764da7..4ad9e71 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -30,8 +30,8 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 	int i;
 
 	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_set_value(mux->gpio_base + mux->data.gpios[i],
-			       val & (1 << i));
+		gpio_set_value_cansleep(mux->gpio_base + mux->data.gpios[i],
+					val & (1 << i));
 }
 
 static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
-- 
1.7.1
