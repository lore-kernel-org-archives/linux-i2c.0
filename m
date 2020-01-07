From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 08/12] i2c: i2c-core-acpi: convert to use i2c_new_client_device()
Date: Tue,  7 Jan 2020 18:47:42 +0100
Message-ID: <20200107174748.9616-9-wsa+renesas@sang-engineering.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/i2c/i2c-core-acpi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 62a1c92ab803..8f3dbc97a057 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -225,7 +225,7 @@ static void i2c_acpi_register_device(struct i2c_adapter *adapter,
 	adev->power.flags.ignore_parent = true;
 	acpi_device_set_enumerated(adev);
 
-	if (!i2c_new_device(adapter, info)) {
+	if (IS_ERR(i2c_new_client_device(adapter, info))) {
 		adev->power.flags.ignore_parent = false;
 		dev_err(&adapter->dev,
 			"failed to add I2C device %s from ACPI\n",
@@ -451,7 +451,8 @@ struct notifier_block i2c_acpi_notifier = {
  * resources, in that case this function can be used to create an i2c-client
  * for other I2cSerialBus resources in the Current Resource Settings table.
  *
- * Also see i2c_new_device, which this function calls to create the i2c-client.
+ * Also see i2c_new_client_device, which this function calls to create the
+ * i2c-client.
  *
  * Returns a pointer to the new i2c-client, or error pointer in case of failure.
  * Specifically, -EPROBE_DEFER is returned if the adapter is not found.
@@ -461,7 +462,6 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 {
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
-	struct i2c_client *client;
 	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
@@ -489,11 +489,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 	if (!adapter)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	client = i2c_new_device(adapter, info);
-	if (!client)
-		return ERR_PTR(-ENODEV);
-
-	return client;
+	return i2c_new_client_device(adapter, info);
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
 
-- 
2.20.1
