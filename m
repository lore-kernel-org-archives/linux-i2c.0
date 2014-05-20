From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Patch V3 3/5] ACPI/Thermal: Use acpi_bus_attach_private_data() to attach private data
Date: Tue, 20 May 2014 20:59:22 +0800
Message-ID: <1400590764-11108-4-git-send-email-tianyu.lan@intel.com>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400590764-11108-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Use acpi_bus_attach_private_data() to attach private data
instead of acpi_attach_data().

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/thermal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c1e31a4..ae195fd 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -925,13 +925,10 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (result)
 		return result;
 
-	status = acpi_attach_data(tz->device->handle,
-				  acpi_bus_private_data_handler,
-				  tz->thermal_zone);
-	if (ACPI_FAILURE(status)) {
-		pr_err(PREFIX "Error attaching device data\n");
+	status =  acpi_bus_attach_private_data(tz->device->handle,
+					       tz->thermal_zone);
+	if (ACPI_FAILURE(status))
 		return -ENODEV;
-	}
 
 	tz->tz_enabled = 1;
 
@@ -946,7 +943,7 @@ static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
-	acpi_detach_data(tz->device->handle, acpi_bus_private_data_handler);
+	acpi_bus_detach_private_data(tz->device->handle);
 }
 
 
-- 
1.8.3.1
