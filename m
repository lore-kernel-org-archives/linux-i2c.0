From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 3/5] i2c: core: Move ACPI IRQ handling to probe time
Date: Mon, 20 May 2019 09:49:34 +0100
Message-ID: <20190520084936.10590-4-ckeepax@opensource.cirrus.com>
References: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

Bring the ACPI path in sync with the device tree path and handle all the
IRQ fetching at probe time. This leaves the only IRQ handling at device
registration time being that which is passed directly through the board
info as either a resource or an actual IRQ number.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/i2c/i2c-core-acpi.c | 6 ++----
 drivers/i2c/i2c-core-base.c | 6 +++++-
 drivers/i2c/i2c-core.h      | 7 +++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 764cd10420a74..e332760bf9ebc 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -148,8 +148,9 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
 	return 1; /* No need to add resource to the list */
 }
 
-static int i2c_acpi_get_irq(struct acpi_device *adev, int *irq)
+int i2c_acpi_get_irq(struct i2c_client *client, int *irq)
 {
+	struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);
 	struct list_head resource_list;
 	int ret;
 
@@ -201,9 +202,6 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 	if (adapter_handle)
 		*adapter_handle = lookup.adapter_handle;
 
-	/* Then fill IRQ number if any */
-	i2c_acpi_get_irq(adev, &info->irq);
-
 	acpi_set_modalias(adev, dev_name(&adev->dev), info->type,
 			  sizeof(info->type));
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 84bf11b25a120..c1afa17a76bfc 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -335,7 +335,11 @@ static int i2c_device_probe(struct device *dev)
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
 		} else if (ACPI_COMPANION(dev)) {
-			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+			i2c_acpi_get_irq(client, &irq);
+
+			if (irq == -ENOENT)
+				irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev),
+							    0);
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 8f3a08dc73a25..6bec145ab7d74 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -72,6 +72,8 @@ const struct acpi_device_id *
 i2c_acpi_match_device(const struct acpi_device_id *matches,
 		      struct i2c_client *client);
 void i2c_acpi_register_devices(struct i2c_adapter *adap);
+
+int i2c_acpi_get_irq(struct i2c_client *client, int *irq);
 #else /* CONFIG_ACPI */
 static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
 static inline const struct acpi_device_id *
@@ -80,6 +82,11 @@ i2c_acpi_match_device(const struct acpi_device_id *matches,
 {
 	return NULL;
 }
+
+static inline int i2c_acpi_get_irq(struct i2c_client *client, int *irq)
+{
+	return 0;
+}
 #endif /* CONFIG_ACPI */
 extern struct notifier_block i2c_acpi_notifier;
 
-- 
2.11.0
