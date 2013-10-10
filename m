From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/3] i2c: attach/detach I2C client device to the ACPI power domain
Date: Thu, 10 Oct 2013 13:28:47 +0300
Message-ID: <1381400928-2689-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381400928-2689-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381400928-2689-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Lv Zheng <lv.zheng@intel.com>

If the I2C client device is enumerated from ACPI namespace it might have
ACPI methods that needs to be called in order to transition the device to
different power states (such as _PSx).

Implement this for I2C client devices by checking if the device has an ACPI
handle and if that's the case, attach it to the ACPI power domain. In
addition we make sure that the device is fully powered when its ->probe()
function gets called.

For non-ACPI devices this patch is a no-op.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 29d3f04..03a8ae6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -254,10 +254,12 @@ static int i2c_device_probe(struct device *dev)
 					client->flags & I2C_CLIENT_WAKE);
 	dev_dbg(dev, "probe\n");
 
+	acpi_dev_pm_attach(&client->dev, true);
 	status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status) {
 		client->driver = NULL;
 		i2c_set_clientdata(client, NULL);
+		acpi_dev_pm_detach(&client->dev, true);
 	}
 	return status;
 }
@@ -283,6 +285,7 @@ static int i2c_device_remove(struct device *dev)
 		client->driver = NULL;
 		i2c_set_clientdata(client, NULL);
 	}
+	acpi_dev_pm_detach(&client->dev, true);
 	return status;
 }
 
@@ -1111,8 +1114,10 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
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
