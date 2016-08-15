From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 8/8] i2c: pca954x: add device tree binding
Date: Mon, 15 Aug 2016 15:40:31 +0200
Message-ID: <1471268431-5148-9-git-send-email-peda@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471268431-5148-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

No longer rely on the implicit matching with the i2c device name, use
an explicit compatible string instead.

Keep a direct pointer to the chip description instead of an index into
the chip description array.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 46 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 528e755c468f..6dfd31ba29a0 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -42,6 +42,7 @@
 #include <linux/i2c/pca954x.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 
@@ -58,14 +59,6 @@ enum pca_type {
 	pca_9548,
 };
 
-struct pca954x {
-	enum pca_type type;
-
-	u8 last_chan;		/* last register value */
-	u8 deselect;
-	struct i2c_client *client;
-};
-
 struct chip_desc {
 	u8 nchans;
 	u8 enable;	/* used for muxes only */
@@ -75,6 +68,14 @@ struct chip_desc {
 	} muxtype;
 };
 
+struct pca954x {
+	const struct chip_desc *chip;
+
+	u8 last_chan;		/* last register value */
+	u8 deselect;
+	struct i2c_client *client;
+};
+
 /* Provide specs for the PCA954x types we know about */
 static const struct chip_desc chips[] = {
 	[pca_9540] = {
@@ -119,6 +120,20 @@ static const struct i2c_device_id pca954x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id pca954x_of_match[] = {
+	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
+	{ .compatible = "nxp,pca9542", .data = &chips[pca_9542] },
+	{ .compatible = "nxp,pca9543", .data = &chips[pca_9543] },
+	{ .compatible = "nxp,pca9544", .data = &chips[pca_9544] },
+	{ .compatible = "nxp,pca9545", .data = &chips[pca_9545] },
+	{ .compatible = "nxp,pca9546", .data = &chips[pca_9546] },
+	{ .compatible = "nxp,pca9547", .data = &chips[pca_9547] },
+	{ .compatible = "nxp,pca9548", .data = &chips[pca_9548] },
+	{}
+};
+#endif
+
 /* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
    for this as they will try to lock adapter a second time */
 static int pca954x_reg_write(struct i2c_adapter *adap,
@@ -151,7 +166,7 @@ static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
 {
 	struct pca954x *data = i2c_mux_priv(muxc);
 	struct i2c_client *client = data->client;
-	const struct chip_desc *chip = &chips[data->type];
+	const struct chip_desc *chip = data->chip;
 	u8 regval;
 	int ret = 0;
 
@@ -197,6 +212,7 @@ static int pca954x_probe(struct i2c_client *client,
 	int num, force, class;
 	struct i2c_mux_core *muxc;
 	struct pca954x *data;
+	const struct of_device_id *match;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
@@ -226,14 +242,19 @@ static int pca954x_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	data->type = id->driver_data;
+	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
+	if (match)
+		data->chip = of_device_get_match_data(&client->dev);
+	else
+		data->chip = &chips[id->driver_data];
+
 	data->last_chan = 0;		   /* force the first selection */
 
 	idle_disconnect_dt = of_node &&
 		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
 
 	/* Now create an adapter for each channel */
-	for (num = 0; num < chips[data->type].nchans; num++) {
+	for (num = 0; num < data->chip->nchans; num++) {
 		bool idle_disconnect_pd = false;
 
 		force = 0;			  /* dynamic adap number */
@@ -263,7 +284,7 @@ static int pca954x_probe(struct i2c_client *client,
 
 	dev_info(&client->dev,
 		 "registered %d multiplexed busses for I2C %s %s\n",
-		 num, chips[data->type].muxtype == pca954x_ismux
+		 num, data->chip->muxtype == pca954x_ismux
 				? "mux" : "switch", client->name);
 
 	return 0;
@@ -299,6 +320,7 @@ static struct i2c_driver pca954x_driver = {
 	.driver		= {
 		.name	= "pca954x",
 		.pm	= &pca954x_pm,
+		.of_match_table = of_match_ptr(pca954x_of_match),
 	},
 	.probe		= pca954x_probe,
 	.remove		= pca954x_remove,
-- 
2.1.4
