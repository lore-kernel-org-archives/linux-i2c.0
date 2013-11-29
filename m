From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 4/4] i2c: pca954x: Add reset GPIO support
Date: Fri, 29 Nov 2013 01:51:25 +0100
Message-ID: <1385686285-23780-5-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1385686285-23780-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385686285-23780-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If a reset GPIO support is specified, request the GPIO and get the chip
out of reset at probe time.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt       |  4 ++++
 drivers/i2c/muxes/i2c-mux-pca954x.c                   | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index cc7e7fd..34a3fb6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -13,6 +13,10 @@ Required Properties:
   - Standard I2C mux properties. See i2c-mux.txt in this directory.
   - I2C child bus nodes. See i2c-mux.txt in this directory.
 
+Optional Properties:
+
+  - reset-gpios: Reference to the GPIO connected to the reset input.
+
 
 Example:
 
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 2880c38..e835304 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -36,11 +36,13 @@
  */
 
 #include <linux/device.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/i2c/pca954x.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 
 #define PCA954X_MAX_NCHANS 8
@@ -185,6 +187,7 @@ static int pca954x_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device_node *np = client->dev.of_node;
 	int num, force, class;
 	struct pca954x *data;
 	int ret;
@@ -198,6 +201,22 @@ static int pca954x_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
+	if (IS_ENABLED(CONFIG_OF) && np) {
+		enum of_gpio_flags flags;
+		int gpio;
+
+		/* Get the mux out of reset if a reset GPIO is specified. */
+		gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
+		if (gpio_is_valid(gpio)) {
+			ret = devm_gpio_request_one(&client->dev, gpio,
+					flags & OF_GPIO_ACTIVE_LOW ?
+					GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
+					"pca954x reset");
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	/* Write the mux register at addr to verify
 	 * that the mux is in fact present. This also
 	 * initializes the mux to disconnected state.
-- 
1.8.3.2
