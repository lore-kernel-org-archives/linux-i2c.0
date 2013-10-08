From: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Subject: [PATCH 2/2] i2c-mux-gpio: don't ignore of_get_named_gpio errors
Date: Tue, 08 Oct 2013 15:51:53 +0200
Message-ID: <52540DF9.3050802@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

of_get_named_gpio could return -E_PROBE_DEFER or another
error code. This error should be passed further instead
of being ignored.

Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index eb99f04..6370b47 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -66,7 +66,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	struct device_node *adapter_np, *child;
 	struct i2c_adapter *adapter;
 	unsigned *values, *gpios;
-	int i = 0;
+	int i = 0, ret;
 
 	if (!np)
 		return -ENODEV;
@@ -116,8 +116,12 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpios[i] = of_get_named_gpio(np, "mux-gpios", i);
+	for (i = 0; i < mux->data.n_gpios; i++) {
+		ret = of_get_named_gpio(np, "mux-gpios", i);
+		if (ret < 0)
+			return ret;
+		gpios[i] = ret;
+	}
 
 	mux->data.gpios = gpios;
 
-- 
1.7.1
