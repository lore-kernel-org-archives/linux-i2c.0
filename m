From: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Subject: [PATCH] i2c-mux-gpio: use deferred probing with the device tree
Date: Tue, 08 Oct 2013 15:20:18 +0200
Message-ID: <52540692.9080208@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If the i2c-parent bus driver is not loaded, returning
-EINVAL will force people to unload and then reload the
module again to get it working.

Also of_get_named_gpio could return -E_PROBE_DEFER or
another error code. This error should be passed further
instead of being ignored.

Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 5d4a99b..6370b47 100644
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
@@ -79,7 +79,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
 	if (!adapter) {
 		dev_err(&pdev->dev, "Cannot find parent bus\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 	mux->data.parent = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
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
