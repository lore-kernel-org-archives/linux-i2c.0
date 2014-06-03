From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2] i2c: pca954x: Use the descriptor-based GPIO API
Date: Tue,  3 Jun 2014 13:15:26 +0200
Message-ID: <1401794126-22244-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1401754973-13274-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401754973-13274-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The ID-based GPIO API pushes handling of GPIO polarity to drivers.
Simplify the driver by switching to the descriptor-based GPIO API.

This also fixes a mismatch between the pca954x DT bindings that document
a "reset-gpios" property and the driver that requests a "reset-gpio"
property.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 550bd36..c2c443f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -186,7 +186,7 @@ static int pca954x_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct device_node *np = client->dev.of_node;
+	struct gpio_desc *gpio;
 	int num, force, class;
 	struct pca954x *data;
 	int ret;
@@ -200,21 +200,10 @@ static int pca954x_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
-	if (IS_ENABLED(CONFIG_OF) && np) {
-		enum of_gpio_flags flags;
-		int gpio;
-
-		/* Get the mux out of reset if a reset GPIO is specified. */
-		gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
-		if (gpio_is_valid(gpio)) {
-			ret = devm_gpio_request_one(&client->dev, gpio,
-					flags & OF_GPIO_ACTIVE_LOW ?
-					GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
-					"pca954x reset");
-			if (ret < 0)
-				return ret;
-		}
-	}
+	/* Get the mux out of reset if a reset GPIO is specified. */
+	gpio = devm_gpiod_get(&client->dev, "reset");
+	if (!IS_ERR(gpio))
+		gpiod_direction_output(gpio, 0);
 
 	/* Write the mux register at addr to verify
 	 * that the mux is in fact present. This also
-- 
Regards,

Laurent Pinchart
