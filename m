From: Tin Huynh <tnhuynh@apm.com>
Subject: [PATCH V5] i2c: mux: pca954x: Add ACPI support for pca954x
Date: Tue, 29 Nov 2016 17:12:43 +0700
Message-ID: <1480414363-16318-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33342 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757098AbcK2KNI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Nov 2016 05:13:08 -0500
Received: by mail-pf0-f179.google.com with SMTP id d2so31402114pfd.0
        for <linux-i2c@vger.kernel.org>; Tue, 29 Nov 2016 02:13:03 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>

This patch enables ACPI support for mux-pca954x driver.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

Change from V4:
  -Add ACPI_PTR.

Change from V3:
 -Readd CONFIG_ACPI.

Change from V2:
 -Remove CONFIG_ACPI.

Change from V1 :
 -Don't shadow id variable.
 -Include sorted header.
 -Redefine acpi_device_id.
 -Add CONFIG_ACPI.


diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 1091346..f81f8b5 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -35,6 +35,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -120,6 +121,21 @@ struct pca954x {
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pca954x_acpi_ids[] = {
+	{ .id = "PCA9540", .driver_data = pca_9540 },
+	{ .id = "PCA9542", .driver_data = pca_9540 },
+	{ .id = "PCA9543", .driver_data = pca_9543 },
+	{ .id = "PCA9544", .driver_data = pca_9544 },
+	{ .id = "PCA9545", .driver_data = pca_9545 },
+	{ .id = "PCA9546", .driver_data = pca_9545 },
+	{ .id = "PCA9547", .driver_data = pca_9547 },
+	{ .id = "PCA9548", .driver_data = pca_9548 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pca954x_acpi_ids);
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id pca954x_of_match[] = {
 	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
@@ -245,8 +261,17 @@ static int pca954x_probe(struct i2c_client *client,
 	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
 	if (match)
 		data->chip = of_device_get_match_data(&client->dev);
-	else
+	else if (id)
 		data->chip = &chips[id->driver_data];
+	else {
+		const struct acpi_device_id *acpi_id;
+
+		acpi_id = acpi_match_device(ACPI_PTR(pca954x_acpi_ids), 
+						&client->dev);
+		if (!acpi_id)
+			return -ENODEV;
+		data->chip = &chips[acpi_id->driver_data];
+	}
 
 	data->last_chan = 0;		   /* force the first selection */
 
@@ -321,6 +346,7 @@ static int pca954x_resume(struct device *dev)
 		.name	= "pca954x",
 		.pm	= &pca954x_pm,
 		.of_match_table = of_match_ptr(pca954x_of_match),
+		.acpi_match_table = ACPI_PTR(pca954x_acpi_ids),
 	},
 	.probe		= pca954x_probe,
 	.remove		= pca954x_remove,
-- 
1.7.1
