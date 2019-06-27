From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v8 2/6] i2c: acpi: Use available IRQ helper functions
Date: Thu, 27 Jun 2019 10:24:07 +0100
Message-ID: <20190627092411.26123-3-ckeepax@opensource.cirrus.com>
References: <20190627092411.26123-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627092411.26123-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

Use the available IRQ helper functions, most of the functions have
additional helpful side affects like configuring the trigger type of the
IRQ.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v7:
 - Leave call to acpi_dev_free_resource_list

Thanks,
Charles

 drivers/i2c/i2c-core-acpi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index f1d648962b223..1820f18a4e5f9 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -133,13 +133,23 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 	return 0;
 }
 
+static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
+{
+	int *irq = data;
+	struct resource r;
+
+	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
+		*irq = i2c_dev_irq_from_resources(&r, 1);
+
+	return 1; /* No need to add resource to the list */
+}
+
 static int i2c_acpi_get_info(struct acpi_device *adev,
 			     struct i2c_board_info *info,
 			     struct i2c_adapter *adapter,
 			     acpi_handle *adapter_handle)
 {
 	struct list_head resource_list;
-	struct resource_entry *entry;
 	struct i2c_acpi_lookup lookup;
 	int ret;
 
@@ -172,17 +182,11 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 
 	/* Then fill IRQ number if any */
 	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     i2c_acpi_add_resource, &info->irq);
 	if (ret < 0)
 		return -EINVAL;
 
-	resource_list_for_each_entry(entry, &resource_list) {
-		if (resource_type(entry->res) == IORESOURCE_IRQ) {
-			info->irq = entry->res->start;
-			break;
-		}
-	}
-
 	acpi_dev_free_resource_list(&resource_list);
 
 	acpi_set_modalias(adev, dev_name(&adev->dev), info->type,
-- 
2.11.0
