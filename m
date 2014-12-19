From: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Subject: [PATCH v2] of: i2c: Add idle-disconnect DT property to PCA954x mux
 driver
Date: Fri, 19 Dec 2014 18:00:10 +0100
Message-ID: <5494599A.8050803@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

of: i2c: Add idle-disconnect DT property to PCA954x mux driver

Add idle-disconnect device tree property to PCA954x mux driver. The new property
forces the multiplexer to disconnect child buses in idle state. This is used, for
example, when there are several multiplexers on the same bus and the devices on
the underlying buses might have same I2C addresses.

At the same time old (and not used in the tree) platform data binding
deselect_on_exit is removed to simplify the implementation. Old binding has
different (per-channel) semantics and doesn't fit well in the new concept.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
---

Changes in v2:
- dropped idle-state binding
- headers in alphabetical order
- removed old platform data deselect_on_exit flag

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |    3 +++
 drivers/i2c/muxes/i2c-mux-pca954x.c                |    9 +++++++--
 include/linux/i2c/pca954x.h                        |    3 ---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 34a3fb6..0272463 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -16,6 +16,9 @@ Required Properties:
 Optional Properties:
 
   - reset-gpios: Reference to the GPIO connected to the reset input.
+  - idle-disconnect: Boolean; if defined, forces mux to disconnect all children
+    in idle state. This is necessary, for example, if there are several
+    multiplexers on the bus and the devices behind them use same I2C addresses.
 
 
 Example:
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index ec11b40..3fe966f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -41,6 +41,7 @@
 #include <linux/i2c-mux.h>
 #include <linux/i2c/pca954x.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 
@@ -186,6 +187,8 @@ static int pca954x_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device_node *of_node = client->dev.of_node;
+	bool idle_disconnect;
 	struct gpio_desc *gpio;
 	int num, force, class;
 	struct pca954x *data;
@@ -217,6 +220,9 @@ static int pca954x_probe(struct i2c_client *client,
 	data->type = id->driver_data;
 	data->last_chan = 0;		   /* force the first selection */
 
+	idle_disconnect = of_node &&
+		of_property_read_bool(of_node, "idle-disconnect");
+
 	/* Now create an adapter for each channel */
 	for (num = 0; num < chips[data->type].nchans; num++) {
 		force = 0;			  /* dynamic adap number */
@@ -234,8 +240,7 @@ static int pca954x_probe(struct i2c_client *client,
 		data->virt_adaps[num] =
 			i2c_add_mux_adapter(adap, &client->dev, client,
 				force, num, class, pca954x_select_chan,
-				(pdata && pdata->modes[num].deselect_on_exit)
-					? pca954x_deselect_mux : NULL);
+				idle_disconnect ? pca954x_deselect_mux : NULL);
 
 		if (data->virt_adaps[num] == NULL) {
 			ret = -ENODEV;
diff --git a/include/linux/i2c/pca954x.h b/include/linux/i2c/pca954x.h
index 1712677..66bf1fb 100644
--- a/include/linux/i2c/pca954x.h
+++ b/include/linux/i2c/pca954x.h
@@ -29,13 +29,10 @@
 
 /* Per channel initialisation data:
  * @adap_id: bus number for the adapter. 0 = don't care
- * @deselect_on_exit: set this entry to 1, if your H/W needs deselection
- *                    of this channel after transaction.
  *
  */
 struct pca954x_platform_mode {
 	int		adap_id;
-	unsigned int	deselect_on_exit:1;
 	unsigned int	class;
 };
 
