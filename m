From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v6 5/7] i2c: core: Move ACPI IRQ handling to probe time
Date: Fri, 21 Jun 2019 11:08:13 +0100
Message-ID: <20190621100815.12417-6-ckeepax@opensource.cirrus.com>
References: <20190621100815.12417-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621100815.12417-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

Bring the ACPI path in sync with the device tree path and handle all the
IRQ fetching at probe time. This leaves the only IRQ handling at device
registration time being that which is passed directly through the board
info as either a resource or an actual IRQ number.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v5:
 - Pass a struct device rather than acpi_device to i2c_acpi_get_irq.

Thanks,
Charles

 drivers/i2c/i2c-core-acpi.c | 7 +------
 drivers/i2c/i2c-core-base.c | 5 ++++-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 37bf80b35365f..aaca1e216be66 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -155,7 +155,7 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
  */
 int i2c_acpi_get_irq(struct device *dev)
 {
-	struct acpi_device *adev = container_of(dev, struct acpi_device, dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct list_head resource_list;
 	int irq = -ENOENT;
 	int ret;
@@ -207,11 +207,6 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 	if (adapter_handle)
 		*adapter_handle = lookup.adapter_handle;
 
-	/* Then fill IRQ number if any */
-	info->irq = i2c_acpi_get_irq(&adev->dev);
-	if (info->irq < 0)
-		return info->irq;
-
 	acpi_set_modalias(adev, dev_name(&adev->dev), info->type,
 			  sizeof(info->type));
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 8a303246d534b..34de732598533 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -327,7 +327,10 @@ static int i2c_device_probe(struct device *dev)
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
 		} else if (ACPI_COMPANION(dev)) {
-			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+			irq = i2c_acpi_get_irq(dev);
+
+			if (irq == -ENOENT)
+				irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
-- 
2.11.0
