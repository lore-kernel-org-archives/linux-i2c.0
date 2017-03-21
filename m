From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] i2c: mux: pca954x: Allow enumeration via ACPI
Date: Tue, 21 Mar 2017 21:13:10 +0200
Message-ID: <20170321191310.32957-2-andriy.shevchenko@linux.intel.com>
References: <20170321191310.32957-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:56348 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757267AbdCUTNP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 15:13:15 -0400
In-Reply-To: <20170321191310.32957-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Newer ACPI specification introduces a special dedicated IDs for the
devices that would be enumerated using compatible strings.

Excerpt from possible DSDT as example:

	Device (IMX0) {
		Name (_HID, "PRP0001")
		Name (_DDN, "NXP PCA954x compatible I2C muxer")
		...
	})

	Name (_DSD, Package () {
		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
		Package () {
			Package () {"compatible", "nxp,pca9542"},
			...
		}
	})

To allow this we have always to provide OF table.

While here, remove duplicate call to of_match_device().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 333a3918b656..e8a86a3b5131 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -140,7 +140,6 @@ static const struct i2c_device_id pca954x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id pca954x_of_match[] = {
 	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
 	{ .compatible = "nxp,pca9542", .data = &chips[pca_9542] },
@@ -153,7 +152,6 @@ static const struct of_device_id pca954x_of_match[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, pca954x_of_match);
-#endif
 
 /* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
    for this as they will try to lock adapter a second time */
@@ -344,7 +342,7 @@ static int pca954x_probe(struct i2c_client *client,
 	int num, force, class;
 	struct i2c_mux_core *muxc;
 	struct pca954x *data;
-	const struct of_device_id *match;
+	const struct chip_desc *chip;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
@@ -374,9 +372,9 @@ static int pca954x_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
-	if (match)
-		data->chip = of_device_get_match_data(&client->dev);
+	chip = of_device_get_match_data(&client->dev);
+	if (chip)
+		data->chip = chip;
 	else
 		data->chip = &chips[id->driver_data];
 
@@ -466,7 +464,7 @@ static struct i2c_driver pca954x_driver = {
 	.driver		= {
 		.name	= "pca954x",
 		.pm	= &pca954x_pm,
-		.of_match_table = of_match_ptr(pca954x_of_match),
+		.of_match_table = pca954x_of_match,
 	},
 	.probe		= pca954x_probe,
 	.remove		= pca954x_remove,
-- 
2.11.0
