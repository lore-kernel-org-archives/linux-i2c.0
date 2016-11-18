From: tnhuynh@apm.com
Subject: [v1] i2c: mux: pca954x : Supports ACPI
Date: Fri, 18 Nov 2016 22:01:09 +0700
Message-ID: <1479481269-16363-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>
List-Id: linux-i2c@vger.kernel.org

From: Tin Huynh <tnhuynh@apm.com>

This patch enable ACPI support for mux-pca954x driver.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 1091346..e7ef93b 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -42,6 +42,7 @@
 #include <linux/i2c/pca954x.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 #include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -120,6 +121,19 @@ struct pca954x {
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
+static const struct acpi_device_id pca954x_acpi_ids[] = {
+	{ "PCA9540", pca_9540 },
+	{ "PCA9542", pca_9540 },
+	{ "PCA9543", pca_9543 },
+	{ "PCA9544", pca_9544 },
+	{ "PCA9545", pca_9545 },
+	{ "PCA9546", pca_9545 },
+	{ "PCA9547", pca_9547 },
+	{ "PCA9548", pca_9548 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pca954x_acpi_ids);
+
 #ifdef CONFIG_OF
 static const struct of_device_id pca954x_of_match[] = {
 	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
@@ -245,8 +259,16 @@ static int pca954x_probe(struct i2c_client *client,
 	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
 	if (match)
 		data->chip = of_device_get_match_data(&client->dev);
-	else
+	else if (id) {
 		data->chip = &chips[id->driver_data];
+	} else {
+		const struct acpi_device_id *id;
+
+		id = acpi_match_device(pca954x_acpi_ids, &client->dev);
+		if (!id)
+			return -ENODEV;
+		data->chip = &chips[id->driver_data];
+	}
 
 	data->last_chan = 0;		   /* force the first selection */
 
@@ -321,6 +343,7 @@ static int pca954x_resume(struct device *dev)
 		.name	= "pca954x",
 		.pm	= &pca954x_pm,
 		.of_match_table = of_match_ptr(pca954x_of_match),
+		.acpi_match_table = ACPI_PTR(pca954x_acpi_ids),
 	},
 	.probe		= pca954x_probe,
 	.remove		= pca954x_remove,
-- 
1.7.1
