From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v5 3/7] i2c: acpi: Factor out getting the IRQ from ACPI
Date: Thu, 20 Jun 2019 14:34:16 +0100
Message-ID: <20190620133420.4632-4-ckeepax@opensource.cirrus.com>
References: <20190620133420.4632-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190620133420.4632-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

In preparation for future refactoring factor out the fetch of the IRQ
into its own helper function.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v4.

Thanks,
Charles

 drivers/i2c/i2c-core-acpi.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 47d5b1c5ec9e0..7d4d66ba752d4 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -144,14 +144,30 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
 	return 1; /* No need to add resource to the list */
 }
 
+static int i2c_acpi_get_irq(struct acpi_device *adev)
+{
+	struct list_head resource_list;
+	int irq = -ENOENT;
+	int ret;
+
+	INIT_LIST_HEAD(&resource_list);
+
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     i2c_acpi_add_resource, &irq);
+	if (ret < 0)
+		return -EINVAL;
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	return irq;
+}
+
 static int i2c_acpi_get_info(struct acpi_device *adev,
 			     struct i2c_board_info *info,
 			     struct i2c_adapter *adapter,
 			     acpi_handle *adapter_handle)
 {
-	struct list_head resource_list;
 	struct i2c_acpi_lookup lookup;
-	int irq = -ENOENT;
 	int ret;
 
 	memset(&lookup, 0, sizeof(lookup));
@@ -182,16 +198,9 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 		*adapter_handle = lookup.adapter_handle;
 
 	/* Then fill IRQ number if any */
-	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list,
-				     i2c_acpi_add_resource, &irq);
-	if (ret < 0)
-		return -EINVAL;
-
-	if (irq > 0)
-		info->irq = irq;
-
-	acpi_dev_free_resource_list(&resource_list);
+	ret = i2c_acpi_get_irq(adev);
+	if (ret > 0)
+		info->irq = ret;
 
 	acpi_set_modalias(adev, dev_name(&adev->dev), info->type,
 			  sizeof(info->type));
-- 
2.11.0
