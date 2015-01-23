From: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Subject: [PATCH v4] of: i2c: Add i2c-mux-idle-disconnect DT property to PCA954x
 mux driver
Date: Fri, 23 Jan 2015 16:41:29 +0100
Message-ID: <54C26BA9.4050405@nsn.com>
References: <5494599A.8050803@nsn.com> <20150115123237.GC2549@katana> <54B7BBF5.4010001@nsn.com> <20150115131935.GE2549@katana> <54B7C206.8030809@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54B7C206.8030809-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ext Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

of: i2c: Add i2c-mux-idle-disconnect DT property to PCA954x mux driver

Add i2c-mux-idle-disconnect device tree property to PCA954x mux driver. The new
property forces the multiplexer to disconnect child buses in idle state. This is
used, for example, when there are several multiplexers on the same bus and the
devices on the underlying buses might have same I2C addresses.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
---

Changes in v4:
- fix compilation warnings
Changes in v3:
- preserve legacy platform data deselect_on_exit flag
- change property name to i2c-mux-idle-disconnect
Changes in v2:
- dropped idle-state binding
- headers in alphabetical order
- removed old platform data deselect_on_exit flag

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |    3 +++
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 34a3fb6..cf53d5f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -16,6 +16,9 @@ Required Properties:
 Optional Properties:
 
   - reset-gpios: Reference to the GPIO connected to the reset input.
+  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
+    children in idle state. This is necessary for example, if there are several
+    multiplexers on the bus and the devices behind them use same I2C addresses.
 
 
 Example:
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index ec11b40..b81f888 100644
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
+	bool idle_disconnect_dt;
 	struct gpio_desc *gpio;
 	int num, force, class;
 	struct pca954x *data;
@@ -217,8 +220,12 @@ static int pca954x_probe(struct i2c_client *client,
 	data->type = id->driver_data;
 	data->last_chan = 0;		   /* force the first selection */
 
+	idle_disconnect_dt = of_node &&
+		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
+
 	/* Now create an adapter for each channel */
 	for (num = 0; num < chips[data->type].nchans; num++) {
+		bool idle_disconnect_pd = false;
 		force = 0;			  /* dynamic adap number */
 		class = 0;			  /* no class by default */
 		if (pdata) {
@@ -229,12 +236,13 @@ static int pca954x_probe(struct i2c_client *client,
 			} else
 				/* discard unconfigured channels */
 				break;
+			idle_disconnect_pd = pdata->modes[num].deselect_on_exit;
 		}
 
 		data->virt_adaps[num] =
 			i2c_add_mux_adapter(adap, &client->dev, client,
 				force, num, class, pca954x_select_chan,
-				(pdata && pdata->modes[num].deselect_on_exit)
+				(idle_disconnect_pd || idle_disconnect_dt)
 					? pca954x_deselect_mux : NULL);
 
 		if (data->virt_adaps[num] == NULL) {
