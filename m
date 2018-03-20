From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
Date: Tue, 20 Mar 2018 10:32:00 +0100
Message-ID: <20180320093200.19179-4-peda@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320093200.19179-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Make the arbitrate and release_bus implementation chip specific.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 62 +++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 47685eb4e0e9..cac629e36bf8 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -23,6 +23,7 @@
 #include <linux/i2c-mux.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_data/pca954x.h>
 #include <linux/slab.h>
 
@@ -70,26 +71,22 @@
 #define SELECT_DELAY_SHORT	50
 #define SELECT_DELAY_LONG	1000
 
-struct pca9541 {
-	struct i2c_client *client;
-	unsigned long select_timeout;
-	unsigned long arb_timeout;
+enum chip_name {
+	pca9541,
 };
 
-static const struct i2c_device_id pca9541_id[] = {
-	{"pca9541", 0},
-	{}
+struct chip_desc {
+	int (*arbitrate)(struct i2c_client *client);
+	void (*release_bus)(struct i2c_client *client);
 };
 
-MODULE_DEVICE_TABLE(i2c, pca9541_id);
+struct pca9541 {
+	const struct chip_desc *chip;
 
-#ifdef CONFIG_OF
-static const struct of_device_id pca9541_of_match[] = {
-	{ .compatible = "nxp,pca9541" },
-	{}
+	struct i2c_client *client;
+	unsigned long select_timeout;
+	unsigned long arb_timeout;
 };
-MODULE_DEVICE_TABLE(of, pca9541_of_match);
-#endif
 
 static int pca9541_mybus(int ctl)
 {
@@ -318,7 +315,7 @@ static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
 		/* force bus ownership after this time */
 
 	do {
-		ret = pca9541_arbitrate(client);
+		ret = data->chip->arbitrate(client);
 		if (ret)
 			return ret < 0 ? ret : 0;
 
@@ -336,10 +333,32 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
 	struct pca9541 *data = i2c_mux_priv(muxc);
 	struct i2c_client *client = data->client;
 
-	pca9541_release_bus(client);
+	data->chip->release_bus(client);
 	return 0;
 }
 
+static const struct chip_desc chips[] = {
+	[pca9541] = {
+		.arbitrate = pca9541_arbitrate,
+		.release_bus = pca9541_release_bus,
+	},
+};
+
+static const struct i2c_device_id pca9541_id[] = {
+	{ "pca9541", pca9541 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pca9541_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pca9541_of_match[] = {
+	{ .compatible = "nxp,pca9541", .data = &chips[pca9541] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pca9541_of_match);
+#endif
+
 /*
  * I2C init/probing/exit functions
  */
@@ -348,6 +367,8 @@ static int pca9541_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
+	const struct of_device_id *match;
+	const struct chip_desc *chip;
 	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
 	int force;
@@ -356,12 +377,18 @@ static int pca9541_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
+	match = of_match_device(of_match_ptr(pca9541_of_match), &client->dev);
+	if (match)
+		chip = of_device_get_match_data(&client->dev);
+	else
+		chip = &chips[id->driver_data];
+
 	/*
 	 * I2C accesses are unprotected here.
 	 * We have to lock the adapter before releasing the bus.
 	 */
 	i2c_lock_adapter(adap);
-	pca9541_release_bus(client);
+	chip->release_bus(client);
 	i2c_unlock_adapter(adap);
 
 	/* Create mux adapter */
@@ -376,6 +403,7 @@ static int pca9541_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data = i2c_mux_priv(muxc);
+	data->chip = chip;
 	data->client = client;
 
 	i2c_set_clientdata(client, muxc);
-- 
2.11.0
