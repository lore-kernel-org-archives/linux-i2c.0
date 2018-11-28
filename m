From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 05/15] i2c: acpi: Return error pointers from i2c_acpi_new_device()
Date: Wed, 28 Nov 2018 13:45:25 +0200
Message-ID: <20181128114535.80223-6-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

The caller would like to know the reason why the i2c_acpi_new_device() fails.
For example, if adapter is not available, it might be in the future and we
would like to re-probe the clients again. But at the same time we would like to
bail out if the error seems unrecoverable, such as invalid argument supplied.
To achieve this, return error pointer in some cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 32affd3fa8bd..689c0c467e97 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -386,20 +386,22 @@ struct notifier_block i2c_acpi_notifier = {
  *
  * Also see i2c_new_device, which this function calls to create the i2c-client.
  *
- * Returns a pointer to the new i2c-client, or NULL if the adapter is not found.
+ * Returns a pointer to the new i2c-client, or error pointer in case of failure.
+ * Specifically, -EPROBE_DEFER is returned if the adapter is not found.
  */
 struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 				       struct i2c_board_info *info)
 {
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
@@ -408,16 +410,23 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 
 	ret = acpi_dev_get_resources(adev, &resource_list,
 				     i2c_acpi_fill_info, &lookup);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (ret < 0 || !info->addr)
-		return NULL;
+	if (!info->addr)
+		return ERR_PTR(-EADDRNOTAVAIL);
 
 	adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
 	if (!adapter)
-		return NULL;
+		return ERR_PTR(-EPROBE_DEFER);
+
+	client = i2c_new_device(adapter, info);
+	if (!client)
+		return ERR_PTR(-ENODEV);
 
-	return i2c_new_device(adapter, info);
+	return client;
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
 
-- 
2.19.2
