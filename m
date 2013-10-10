From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Thu, 10 Oct 2013 17:17:49 +0300
Message-ID: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

There is a minor fault about ACPI enumerated I2C devices with their modalias
attribute. Now modalias is set by device instance not by hardware ID.
For example "i2c:INTABCD:00", "i2c:INTABCD:01" etc.

This means each device instance gets different modalias which does match
with generated modules.alias. Currently this is not problem as matching can
happen also with "acpi:INTABCD" modalias.

Fix this by using ACPI hardware ID.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Generated on top of v3.12-rc4-29-g0e7a3ed.
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 29d3f04..6dd0c53 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1111,7 +1111,7 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	if (ret < 0 || !info.addr)
 		return AE_OK;
 
-	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
+	strlcpy(info.type, acpi_device_hid(adev), sizeof(info.type));
 	if (!i2c_new_device(adapter, &info)) {
 		dev_err(&adapter->dev,
 			"failed to add I2C device %s from ACPI\n",
-- 
1.8.4.rc3

