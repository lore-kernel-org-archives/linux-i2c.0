From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v6 1/3] i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
Date: Wed, 25 Jan 2017 09:31:06 +0800
Message-ID: <1485307868-5408-2-git-send-email-preid@electromag.com.au>
References: <1485307868-5408-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485307868-5408-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The spec for the pca954x was missing. This chip is the same as the pca9540
except that it has interrupt lines. While the i2c_device_id table mapped
the pca9542 to the pca9540 definition the compatible table did not. In
preparation for irq support add the pca9542 definition.

Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index dd18b9c..bbf088e 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -84,6 +84,11 @@ struct pca954x {
 		.enable = 0x4,
 		.muxtype = pca954x_ismux,
 	},
+	[pca_9542] = {
+		.nchans = 2,
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+	},
 	[pca_9543] = {
 		.nchans = 2,
 		.muxtype = pca954x_isswi,
@@ -110,7 +115,7 @@ struct pca954x {
 
 static const struct i2c_device_id pca954x_id[] = {
 	{ "pca9540", pca_9540 },
-	{ "pca9542", pca_9540 },
+	{ "pca9542", pca_9542 },
 	{ "pca9543", pca_9543 },
 	{ "pca9544", pca_9544 },
 	{ "pca9545", pca_9545 },
@@ -124,7 +129,7 @@ struct pca954x {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id pca954x_acpi_ids[] = {
 	{ .id = "PCA9540", .driver_data = pca_9540 },
-	{ .id = "PCA9542", .driver_data = pca_9540 },
+	{ .id = "PCA9542", .driver_data = pca_9542 },
 	{ .id = "PCA9543", .driver_data = pca_9543 },
 	{ .id = "PCA9544", .driver_data = pca_9544 },
 	{ .id = "PCA9545", .driver_data = pca_9545 },
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
