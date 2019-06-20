From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v5 4/7] i2c: core: Make i2c_acpi_get_irq available to the rest of the I2C core
Date: Thu, 20 Jun 2019 14:34:17 +0100
Message-ID: <20190620133420.4632-5-ckeepax@opensource.cirrus.com>
References: <20190620133420.4632-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190620133420.4632-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

In preparation for more refactoring make i2c_acpi_get_irq available
outside i2c-core-acpi.c.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v4:
 - Leave i2c_acpi_get_irq accepting an acpi_device, this should
   avoid the NULL pointer issue we had with i2c_acpi_find_client_by_adev

Thanks,
Charles

 drivers/i2c/i2c-core-acpi.c | 10 +++++++++-
 drivers/i2c/i2c-core.h      |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 7d4d66ba752d4..0ddfcca6091e1 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -144,7 +144,15 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
 	return 1; /* No need to add resource to the list */
 }
 
-static int i2c_acpi_get_irq(struct acpi_device *adev)
+/**
+ * i2c_acpi_get_irq - get device IRQ number from ACPI
+ * @client: Pointer to the I2C client device
+ *
+ * Find the IRQ number used by a specific client device.
+ *
+ * Return: The IRQ number or an error code.
+ */
+int i2c_acpi_get_irq(struct acpi_device *adev)
 {
 	struct list_head resource_list;
 	int irq = -ENOENT;
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 2a3b28bf826b1..4fbe0a0bcc4c4 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -58,11 +58,15 @@ static inline int __i2c_check_suspended(struct i2c_adapter *adap)
 	return 0;
 }
 
+struct acpi_device;
+
 #ifdef CONFIG_ACPI
 const struct acpi_device_id *
 i2c_acpi_match_device(const struct acpi_device_id *matches,
 		      struct i2c_client *client);
 void i2c_acpi_register_devices(struct i2c_adapter *adap);
+
+int i2c_acpi_get_irq(struct acpi_device *adev);
 #else /* CONFIG_ACPI */
 static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
 static inline const struct acpi_device_id *
@@ -71,6 +75,11 @@ i2c_acpi_match_device(const struct acpi_device_id *matches,
 {
 	return NULL;
 }
+
+static inline int i2c_acpi_get_irq(struct acpi_device *adev)
+{
+	return 0;
+}
 #endif /* CONFIG_ACPI */
 extern struct notifier_block i2c_acpi_notifier;
 
-- 
2.11.0
