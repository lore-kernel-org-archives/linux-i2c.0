From: Alexander Sverdlin <asv-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] of_i2c: Honour "status=disabled" property of device
Date: Wed, 28 Nov 2012 15:21:14 +0100
Message-ID: <50B61DDA.5090109@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: alexander sverdlin <alexander.sverdlin.ext-OYasijW0DpE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>

of_i2c: Honour "status=disabled" property of device

Currently of_i2c_register_devices() function registers all i2c devices,
independently from their status property in device tree. According to
"ePAPR 1.1" spec, device should only be registered if there is no
"status" property, or it has "ok" (or "okay") value (see
of_device_is_available()). In case of "platform devices",
of_platform_device_create_pdata() checks for "status" and ensures
that disabled devices are not populated. But such check for i2c buses
was missing until now. Fix it.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
---
--- linux.orig/drivers/of/of_i2c.c
+++ linux/drivers/of/of_i2c.c
@@ -29,7 +29,7 @@ void of_i2c_register_devices(struct i2c_
 
 	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
 
-	for_each_child_of_node(adap->dev.of_node, node) {
+	for_each_available_child_of_node(adap->dev.of_node, node) {
 		struct i2c_board_info info = {};
 		struct dev_archdata dev_ad = {};
 		const __be32 *addr;
