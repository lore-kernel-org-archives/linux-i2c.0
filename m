From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/5] i2c: acpi: Factor out getting the IRQ from ACPI
Date: Mon, 20 May 2019 09:49:32 +0100
Message-ID: <20190520084936.10590-2-ckeepax@opensource.cirrus.com>
References: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

In preparation for future refactoring factor out the fetch of the IRQ
into its own helper function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/i2c/i2c-core-acpi.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 2728006920888..c3ac3ea184317 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -137,13 +137,35 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 	return 0;
 }
 
+static int i2c_acpi_get_irq(struct acpi_device *adev, int *irq)
+{
+	struct list_head resource_list;
+	struct resource_entry *entry;
+	int ret;
+
+	INIT_LIST_HEAD(&resource_list);
+
+	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (ret < 0)
+		return -EINVAL;
+
+	resource_list_for_each_entry(entry, &resource_list) {
+		if (resource_type(entry->res) == IORESOURCE_IRQ) {
+			*irq = entry->res->start;
+			break;
+		}
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	return 0;
+}
+
 static int i2c_acpi_get_info(struct acpi_device *adev,
 			     struct i2c_board_info *info,
 			     struct i2c_adapter *adapter,
 			     acpi_handle *adapter_handle)
 {
-	struct list_head resource_list;
-	struct resource_entry *entry;
 	struct i2c_acpi_lookup lookup;
 	int ret;
 
@@ -175,19 +197,7 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 		*adapter_handle = lookup.adapter_handle;
 
 	/* Then fill IRQ number if any */
-	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-	if (ret < 0)
-		return -EINVAL;
-
-	resource_list_for_each_entry(entry, &resource_list) {
-		if (resource_type(entry->res) == IORESOURCE_IRQ) {
-			info->irq = entry->res->start;
-			break;
-		}
-	}
-
-	acpi_dev_free_resource_list(&resource_list);
+	i2c_acpi_get_irq(adev, &info->irq);
 
 	acpi_set_modalias(adev, dev_name(&adev->dev), info->type,
 			  sizeof(info->type));
-- 
2.11.0
