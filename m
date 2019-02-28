From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH v4 1/3] i2c: mux: pca954x: remove support for unused platform data
Date: Thu, 28 Feb 2019 11:43:41 +0000
Message-ID: <20190228114343.36443-2-robertshearman@gmail.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228114343.36443-1-robertshearman@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Shearman <robert.shearman@att.com>
List-Id: linux-i2c@vger.kernel.org

From: Robert Shearman <robert.shearman@att.com>

There are no in-tree users of the pca954x platform data and the
per-channel deselect configuration complicates efforts to export the
configuration to user-space in a way that could be applied to other
muxes. Therefore, remove support for the pca954x platform data.

Signed-off-by: Robert Shearman <robert.shearman@att.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index bfabf985e830..e32fef560684 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -46,7 +46,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/platform_data/pca954x.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -348,14 +347,13 @@ static int pca954x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adap = client->adapter;
-	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
 	bool idle_disconnect_dt;
 	struct gpio_desc *gpio;
-	int num, force, class;
 	struct i2c_mux_core *muxc;
 	struct pca954x *data;
+	int num;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
@@ -422,24 +420,9 @@ static int pca954x_probe(struct i2c_client *client,
 
 	/* Now create an adapter for each channel */
 	for (num = 0; num < data->chip->nchans; num++) {
-		bool idle_disconnect_pd = false;
-
-		force = 0;			  /* dynamic adap number */
-		class = 0;			  /* no class by default */
-		if (pdata) {
-			if (num < pdata->num_modes) {
-				/* force static number */
-				force = pdata->modes[num].adap_id;
-				class = pdata->modes[num].class;
-			} else
-				/* discard unconfigured channels */
-				break;
-			idle_disconnect_pd = pdata->modes[num].deselect_on_exit;
-		}
-		data->deselect |= (idle_disconnect_pd ||
-				   idle_disconnect_dt) << num;
+		data->deselect |= idle_disconnect_dt << num;
 
-		ret = i2c_mux_add_adapter(muxc, force, num, class);
+		ret = i2c_mux_add_adapter(muxc, 0, num, 0);
 		if (ret)
 			goto fail_cleanup;
 	}
-- 
2.20.1
