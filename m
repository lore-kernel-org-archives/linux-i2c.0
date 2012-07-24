From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-mux: Add support for device auto-detection
Date: Tue, 24 Jul 2012 16:54:02 +0200
Message-ID: <20120724165402.3647210b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Let I2C bus segments behind multiplexers have a class. This allows for
device auto-detection on these segments. As long as parent segments
don't share the same class, it should be fine.

I implemented support in drivers i2c-mux-gpio and i2c-mux-pca954x. I
left i2c-mux-pca9541 alone for the moment as I don't know if this
feature makes sense for the use cases of that driver.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
I need this for proper support of SPD access and memory module
temperature monitoring on my Asus Z8NA-D6 board. I'll post code adding
support for SMBus multiplexing on that board later this week.

 drivers/i2c/i2c-mux.c               |   22 ++++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-gpio.c    |    4 +++-
 drivers/i2c/muxes/i2c-mux-pca9541.c |    2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c |   10 ++++++----
 include/linux/i2c-mux-gpio.h        |    2 ++
 include/linux/i2c-mux.h             |    1 +
 include/linux/i2c/pca954x.h         |    1 +
 7 files changed, 36 insertions(+), 6 deletions(-)

--- linux-3.5.orig/drivers/i2c/i2c-mux.c	2012-07-24 15:01:56.000000000 +0200
+++ linux-3.5/drivers/i2c/i2c-mux.c	2012-07-24 16:38:24.994743016 +0200
@@ -88,9 +88,23 @@ static u32 i2c_mux_functionality(struct
 	return parent->algo->functionality(parent);
 }
 
+/* Return all parent classes, merged */
+static unsigned int i2c_mux_parent_classes(struct i2c_adapter *parent)
+{
+	unsigned int class = 0;
+
+	do {
+		class |= parent->class;
+		parent = i2c_parent_is_i2c_adapter(parent);
+	} while (parent);
+
+	return class;
+}
+
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 				struct device *mux_dev,
 				void *mux_priv, u32 force_nr, u32 chan_id,
+				unsigned int class,
 				int (*select) (struct i2c_adapter *,
 					       void *, u32),
 				int (*deselect) (struct i2c_adapter *,
@@ -127,6 +141,14 @@ struct i2c_adapter *i2c_add_mux_adapter(
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
 
+	/* Sanity check on class */
+	if (i2c_mux_parent_classes(parent) & class)
+		dev_err(&parent->dev,
+			"Segment %d behind mux can't share classes with ancestors\n",
+			chan_id);
+	else
+		priv->adap.class = class;
+
 	/*
 	 * Try to populate the mux adapter's of_node, expands to
 	 * nothing if !CONFIG_OF.
--- linux-3.5.orig/drivers/i2c/muxes/i2c-mux-gpio.c	2012-07-24 15:01:56.000000000 +0200
+++ linux-3.5/drivers/i2c/muxes/i2c-mux-gpio.c	2012-07-24 15:37:44.282044411 +0200
@@ -104,8 +104,10 @@ static int __devinit i2c_mux_gpio_probe(
 
 	for (i = 0; i < pdata->n_values; i++) {
 		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
+		unsigned int class = pdata->classes ? pdata->classes[i] : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr, i,
+		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
+						   i, class,
 						   i2c_mux_gpio_select, deselect);
 		if (!mux->adap[i]) {
 			ret = -ENODEV;
--- linux-3.5.orig/drivers/i2c/muxes/i2c-mux-pca9541.c	2012-07-24 15:01:56.000000000 +0200
+++ linux-3.5/drivers/i2c/muxes/i2c-mux-pca9541.c	2012-07-24 15:10:00.142334435 +0200
@@ -354,7 +354,7 @@ static int pca9541_probe(struct i2c_clie
 	if (pdata)
 		force = pdata->modes[0].adap_id;
 	data->mux_adap = i2c_add_mux_adapter(adap, &client->dev, client,
-					     force, 0,
+					     force, 0, 0,
 					     pca9541_select_chan,
 					     pca9541_release_chan);
 
--- linux-3.5.orig/drivers/i2c/muxes/i2c-mux-pca954x.c	2012-07-24 15:01:56.000000000 +0200
+++ linux-3.5/drivers/i2c/muxes/i2c-mux-pca954x.c	2012-07-24 15:43:41.451049259 +0200
@@ -186,7 +186,7 @@ static int pca954x_probe(struct i2c_clie
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct pca954x_platform_data *pdata = client->dev.platform_data;
-	int num, force;
+	int num, force, class;
 	struct pca954x *data;
 	int ret = -ENODEV;
 
@@ -216,18 +216,20 @@ static int pca954x_probe(struct i2c_clie
 	/* Now create an adapter for each channel */
 	for (num = 0; num < chips[data->type].nchans; num++) {
 		force = 0;			  /* dynamic adap number */
+		class = 0;			  /* no class by default */
 		if (pdata) {
-			if (num < pdata->num_modes)
+			if (num < pdata->num_modes) {
 				/* force static number */
 				force = pdata->modes[num].adap_id;
-			else
+				class = pdata->modes[num].class;
+			} else
 				/* discard unconfigured channels */
 				break;
 		}
 
 		data->virt_adaps[num] =
 			i2c_add_mux_adapter(adap, &client->dev, client,
-				force, num, pca954x_select_chan,
+				force, num, class, pca954x_select_chan,
 				(pdata && pdata->modes[num].deselect_on_exit)
 					? pca954x_deselect_mux : NULL);
 
--- linux-3.5.orig/include/linux/i2c-mux-gpio.h	2012-07-24 15:01:56.000000000 +0200
+++ linux-3.5/include/linux/i2c-mux-gpio.h	2012-07-24 16:51:05.157982939 +0200
@@ -21,6 +21,7 @@
  * @values: Array of bitmasks of GPIO settings (low/high) for each
  *	position
  * @n_values: Number of multiplexer positions (busses to instantiate)
+ * @classes: Optional I2C auto-detection classes
  * @gpios: Array of GPIO numbers used to control MUX
  * @n_gpios: Number of GPIOs used to control MUX
  * @idle: Bitmask to write to MUX when idle or GPIO_I2CMUX_NO_IDLE if not used
@@ -30,6 +31,7 @@ struct i2c_mux_gpio_platform_data {
 	int base_nr;
 	const unsigned *values;
 	int n_values;
+	const unsigned *classes;
 	const unsigned *gpios;
 	int n_gpios;
 	unsigned idle;
--- linux-3.5.orig/include/linux/i2c-mux.h	2012-07-24 15:01:56.000000000 +0200
+++ linux-3.5/include/linux/i2c-mux.h	2012-07-24 15:09:20.454333846 +0200
@@ -36,6 +36,7 @@
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 				struct device *mux_dev,
 				void *mux_priv, u32 force_nr, u32 chan_id,
+				unsigned int class,
 				int (*select) (struct i2c_adapter *,
 					       void *mux_dev, u32 chan_id),
 				int (*deselect) (struct i2c_adapter *,
--- linux-3.5.orig/include/linux/i2c/pca954x.h	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.5/include/linux/i2c/pca954x.h	2012-07-24 16:39:47.928744246 +0200
@@ -36,6 +36,7 @@
 struct pca954x_platform_mode {
 	int		adap_id;
 	unsigned int	deselect_on_exit:1;
+	unsigned int	class;
 };
 
 /* Per mux/switch data, used with i2c_register_board_info */

-- 
Jean Delvare
