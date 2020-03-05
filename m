From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] i2c: mux: pca954x: Make use of device properties
Date: Thu,  5 Mar 2020 17:53:49 +0200
Message-ID: <20200305155352.39095-2-andriy.shevchenko@linux.intel.com>
References: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:40730 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCEPxz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Mar 2020 10:53:55 -0500
In-Reply-To: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 39 +++++++++++++----------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 819ff95e64ba..2e42a113ef1f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -43,10 +43,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <dt-bindings/mux/mux.h>
@@ -182,23 +180,22 @@ static const struct chip_desc chips[] = {
 };
 
 static const struct i2c_device_id pca954x_id[] = {
-	{ "pca9540", pca_9540 },
-	{ "pca9542", pca_9542 },
-	{ "pca9543", pca_9543 },
-	{ "pca9544", pca_9544 },
-	{ "pca9545", pca_9545 },
-	{ "pca9546", pca_9546 },
-	{ "pca9547", pca_9547 },
-	{ "pca9548", pca_9548 },
-	{ "pca9846", pca_9846 },
-	{ "pca9847", pca_9847 },
-	{ "pca9848", pca_9848 },
-	{ "pca9849", pca_9849 },
+	{ "pca9540", .driver_data = (kernel_ulong_t)&chips[pca_9540] },
+	{ "pca9542", .driver_data = (kernel_ulong_t)&chips[pca_9542] },
+	{ "pca9543", .driver_data = (kernel_ulong_t)&chips[pca_9543] },
+	{ "pca9544", .driver_data = (kernel_ulong_t)&chips[pca_9544] },
+	{ "pca9545", .driver_data = (kernel_ulong_t)&chips[pca_9545] },
+	{ "pca9546", .driver_data = (kernel_ulong_t)&chips[pca_9546] },
+	{ "pca9547", .driver_data = (kernel_ulong_t)&chips[pca_9547] },
+	{ "pca9548", .driver_data = (kernel_ulong_t)&chips[pca_9548] },
+	{ "pca9846", .driver_data = (kernel_ulong_t)&chips[pca_9846] },
+	{ "pca9847", .driver_data = (kernel_ulong_t)&chips[pca_9847] },
+	{ "pca9848", .driver_data = (kernel_ulong_t)&chips[pca_9848] },
+	{ "pca9849", .driver_data = (kernel_ulong_t)&chips[pca_9849] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id pca954x_of_match[] = {
 	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
 	{ .compatible = "nxp,pca9542", .data = &chips[pca_9542] },
@@ -215,7 +212,6 @@ static const struct of_device_id pca954x_of_match[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, pca954x_of_match);
-#endif
 
 /* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
    for this as they will try to lock adapter a second time */
@@ -426,7 +422,6 @@ static int pca954x_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
-	struct device_node *np = dev->of_node;
 	struct gpio_desc *gpio;
 	struct i2c_mux_core *muxc;
 	struct pca954x *data;
@@ -456,7 +451,7 @@ static int pca954x_probe(struct i2c_client *client,
 		udelay(1);
 	}
 
-	data->chip = of_device_get_match_data(dev);
+	data->chip = device_get_match_data(dev);
 	if (!data->chip)
 		data->chip = &chips[id->driver_data];
 
@@ -478,8 +473,8 @@ static int pca954x_probe(struct i2c_client *client,
 	}
 
 	data->idle_state = MUX_IDLE_AS_IS;
-	if (of_property_read_u32(np, "idle-state", &data->idle_state)) {
-		if (np && of_property_read_bool(np, "i2c-mux-idle-disconnect"))
+	if (device_property_read_u32(dev, "idle-state", &data->idle_state)) {
+		if (device_property_read_bool(dev, "i2c-mux-idle-disconnect"))
 			data->idle_state = MUX_IDLE_DISCONNECT;
 	}
 
@@ -562,7 +557,7 @@ static struct i2c_driver pca954x_driver = {
 	.driver		= {
 		.name	= "pca954x",
 		.pm	= &pca954x_pm,
-		.of_match_table = of_match_ptr(pca954x_of_match),
+		.of_match_table = pca954x_of_match,
 	},
 	.probe		= pca954x_probe,
 	.remove		= pca954x_remove,
-- 
2.25.1
