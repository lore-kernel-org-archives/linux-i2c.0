From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] Revert "i2c: mux: pca954x: Add ACPI support for pca954x"
Date: Tue, 21 Mar 2017 21:13:09 +0200
Message-ID: <20170321191310.32957-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42763 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757781AbdCUTNQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 15:13:16 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tin Huynh <tnhuynh@apm.com>

In ACPI world any ID should be carefully chosen and registered
officially. The commit bbf9d262a147 seems did a wrong assumption because
PCA is the registered PNP ID for "PHILIPS BU ADD ON CARD". I'm pretty
sure this prefix has nothing to do with the driver in question.

Moreover, newer ACPI specification has a support of _DSD method and
special device IDs to allow drivers be enumerated via compatible string.
The slight change to support this kind of enumeration will be added in
sequential patch against pca954x.c.

Revert the commit bbf9d262a147 for good.

Cc: Tin Huynh <tnhuynh@apm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index dfc1c0e37c40..333a3918b656 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -35,7 +35,6 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -141,21 +140,6 @@ static const struct i2c_device_id pca954x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id pca954x_acpi_ids[] = {
-	{ .id = "PCA9540", .driver_data = pca_9540 },
-	{ .id = "PCA9542", .driver_data = pca_9542 },
-	{ .id = "PCA9543", .driver_data = pca_9543 },
-	{ .id = "PCA9544", .driver_data = pca_9544 },
-	{ .id = "PCA9545", .driver_data = pca_9545 },
-	{ .id = "PCA9546", .driver_data = pca_9545 },
-	{ .id = "PCA9547", .driver_data = pca_9547 },
-	{ .id = "PCA9548", .driver_data = pca_9548 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, pca954x_acpi_ids);
-#endif
-
 #ifdef CONFIG_OF
 static const struct of_device_id pca954x_of_match[] = {
 	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
@@ -393,17 +377,8 @@ static int pca954x_probe(struct i2c_client *client,
 	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
 	if (match)
 		data->chip = of_device_get_match_data(&client->dev);
-	else if (id)
+	else
 		data->chip = &chips[id->driver_data];
-	else {
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(ACPI_PTR(pca954x_acpi_ids),
-						&client->dev);
-		if (!acpi_id)
-			return -ENODEV;
-		data->chip = &chips[acpi_id->driver_data];
-	}
 
 	data->last_chan = 0;		   /* force the first selection */
 
@@ -492,7 +467,6 @@ static struct i2c_driver pca954x_driver = {
 		.name	= "pca954x",
 		.pm	= &pca954x_pm,
 		.of_match_table = of_match_ptr(pca954x_of_match),
-		.acpi_match_table = ACPI_PTR(pca954x_acpi_ids),
 	},
 	.probe		= pca954x_probe,
 	.remove		= pca954x_remove,
-- 
2.11.0
