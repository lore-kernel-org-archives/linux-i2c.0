From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/3] i2c: attach/detach I2C client device to the ACPI power domain
Date: Wed,  9 Oct 2013 17:04:20 +0300
Message-ID: <1381327461-10562-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381327461-10562-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

If the I2C client device is enumerated from ACPI namespace it might have
ACPI methods that needs to be called in order to transition the device to
different power states (such as _PSx).

Implement this for I2C client devices by checking if the device has an ACPI
handle and if that's the case, attach it to the ACPI power domain. In
addition we make sure that the device is fully powered when its ->probe()
function gets called.

For non-ACPI devices this patch is a no-op.

Signed-off-by: Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 29d3f04..f25dee3 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -254,10 +254,16 @@ static int i2c_device_probe(struct device *dev)
 					client->flags & I2C_CLIENT_WAKE);
 	dev_dbg(dev, "probe\n");
 
+	if (ACPI_HANDLE(&client->dev))
+		acpi_dev_pm_attach(&client->dev, true);
+
 	status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status) {
 		client->driver = NULL;
 		i2c_set_clientdata(client, NULL);
+
+		if (ACPI_HANDLE(&client->dev))
+			acpi_dev_pm_detach(&client->dev, true);
 	}
 	return status;
 }
@@ -283,6 +289,8 @@ static int i2c_device_remove(struct device *dev)
 		client->driver = NULL;
 		i2c_set_clientdata(client, NULL);
 	}
+	if (ACPI_HANDLE(&client->dev))
+		acpi_dev_pm_detach(&client->dev, true);
 	return status;
 }
 
@@ -1111,8 +1119,10 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	if (ret < 0 || !info.addr)
 		return AE_OK;
 
+	adev->power.flags.ignore_parent = true;
 	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
 	if (!i2c_new_device(adapter, &info)) {
+		adev->power.flags.ignore_parent = false;
 		dev_err(&adapter->dev,
 			"failed to add I2C device %s from ACPI\n",
 			dev_name(&adev->dev));
-- 
1.8.4.rc3
