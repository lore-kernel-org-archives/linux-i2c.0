From: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Subject: [PATCH] of: i2c: Add DT bindings for idle states to PCA954x mux driver
Date: Mon, 15 Dec 2014 02:25:18 +0100
Message-ID: <548E387E.2020502@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

of: i2c: Add DT bindings for idle states to PCA954x mux driver

Introduce two new device tree bindings to specify idle state of PCA954x family
of I2C multiplexors:
  - idle-state: specifies particular child bus to be selected in idle;
  - idle-disconnect: signals that mux should disconnect all child buses in idle;

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |    3 +
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   51 +++++++++++++++++--
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 34a3fb6..1fbe287 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -16,6 +16,9 @@ Required Properties:
 Optional Properties:
 
   - reset-gpios: Reference to the GPIO connected to the reset input.
+  - idle-state: Child bus connected in idle state (specified by its "reg" value)
+  - idle-disconnect: Boolean; if defined, forces mux to disconnect all children
+    in idle state
 
 
 Example:
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index ec11b40..69cf603 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #define PCA954X_MAX_NCHANS 8
 
@@ -62,6 +63,8 @@ struct pca954x {
 	struct i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
 
 	u8 last_chan;		/* last register value */
+	bool idle_disconnect;
+	s8 idle_chan;		/* valid if not negative */
 };
 
 struct chip_desc {
@@ -172,10 +175,20 @@ static int pca954x_deselect_mux(struct i2c_adapter *adap,
 				void *client, u32 chan)
 {
 	struct pca954x *data = i2c_get_clientdata(client);
+	struct pca954x_platform_data *pdata =
+		dev_get_platdata(&((struct i2c_client *)client)->dev);
+
+	if ((pdata && pdata->modes[chan].deselect_on_exit) ||
+	    data->idle_disconnect) {
+		/* Deselect active channel */
+		data->last_chan = 0;
+		return pca954x_reg_write(adap, client, data->last_chan);
+	}
 
-	/* Deselect active channel */
-	data->last_chan = 0;
-	return pca954x_reg_write(adap, client, data->last_chan);
+	if (data->idle_chan >= 0)
+		return pca954x_select_chan(adap, client, data->idle_chan);
+
+	return 0;
 }
 
 /*
@@ -186,6 +199,7 @@ static int pca954x_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device_node *of_node = client->dev.of_node;
 	struct gpio_desc *gpio;
 	int num, force, class;
 	struct pca954x *data;
@@ -216,6 +230,27 @@ static int pca954x_probe(struct i2c_client *client,
 
 	data->type = id->driver_data;
 	data->last_chan = 0;		   /* force the first selection */
+	data->idle_chan = -1;		   /* no forced idle state */
+
+	if (of_node) {
+		u32 ch;
+
+		if (of_property_read_bool(of_node, "idle-disconnect"))
+			data->idle_disconnect = true;
+
+		if (!of_property_read_u32_index(of_node, "idle-state", 0, &ch)) {
+			if (ch < PCA954X_MAX_NCHANS) {
+				data->idle_chan = ch;
+				/* Force idle state from the beginning */
+				ret = pca954x_select_chan(adap, client, ch);
+				if (ret)
+					return ret;
+			} else {
+				dev_warn(&client->dev,
+				         "Invalid idle-state property\n");
+			}
+		}
+	}
 
 	/* Now create an adapter for each channel */
 	for (num = 0; num < chips[data->type].nchans; num++) {
@@ -234,8 +269,7 @@ static int pca954x_probe(struct i2c_client *client,
 		data->virt_adaps[num] =
 			i2c_add_mux_adapter(adap, &client->dev, client,
 				force, num, class, pca954x_select_chan,
-				(pdata && pdata->modes[num].deselect_on_exit)
-					? pca954x_deselect_mux : NULL);
+				pca954x_deselect_mux);
 
 		if (data->virt_adaps[num] == NULL) {
 			ret = -ENODEV;
@@ -281,7 +315,12 @@ static int pca954x_resume(struct device *dev)
 	struct pca954x *data = i2c_get_clientdata(client);
 
 	data->last_chan = 0;
-	return i2c_smbus_write_byte(client, 0);
+	/* Restore idle state on resume */
+	if (data->idle_chan >= 0)
+		return pca954x_select_chan(to_i2c_adapter(client->dev.parent),
+		                           client, data->idle_chan);
+	else
+		return i2c_smbus_write_byte(client, 0);
 }
 #endif
 
-- 
1.7.1
