From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 21/28] drivers: Introduce bus_find_device_by_acpi_dev() helper
Date: Fri, 14 Jun 2019 18:54:16 +0100
Message-ID: <1560534863-15115-22-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, suzuki.poulose@arm.com, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-i2c@vger.kernel.org

Add a wrapper to bus_find_device() to search for a device
by the ACPI COMPANION device, reusing the generic match function.
Also convert the existing users to make use of the new helper.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/i2c/i2c-core-acpi.c |  8 +-------
 drivers/spi/spi.c           |  8 +-------
 include/linux/device.h      | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8af35f11..7c6435c 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -328,11 +328,6 @@ static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
 	return ACPI_HANDLE(dev) == (acpi_handle)data;
 }
 
-static int i2c_acpi_find_match_device(struct device *dev, const void *data)
-{
-	return ACPI_COMPANION(dev) == data;
-}
-
 static struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 {
 	struct device *dev;
@@ -346,8 +341,7 @@ static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, adev,
-			      i2c_acpi_find_match_device);
+	dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
 	return dev ? i2c_verify_client(dev) : NULL;
 }
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cc4d83e..8737d69 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3627,11 +3627,6 @@ static int spi_acpi_controller_match(struct device *dev, const void *data)
 	return ACPI_COMPANION(dev->parent) == data;
 }
 
-static int spi_acpi_device_match(struct device *dev, const void *data)
-{
-	return ACPI_COMPANION(dev) == data;
-}
-
 static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
 {
 	struct device *dev;
@@ -3651,8 +3646,7 @@ static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&spi_bus_type, NULL, adev, spi_acpi_device_match);
-
+	dev = bus_find_device_by_acpi_dev(&spi_bus_type, adev);
 	return dev ? to_spi_device(dev) : NULL;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 1c137ab..6768e2b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -235,6 +235,28 @@ bus_find_next_device(struct bus_type *bus,struct device *cur)
 	return bus_find_device(bus, cur, NULL, device_match_any);
 }
 
+#ifdef CONFIG_ACPI
+struct acpi_device;
+
+/**
+ * bus_find_device_by_acpi_dev : device iterator for locating a particular device
+ * matching the ACPI COMPANION device.
+ * @bus: bus type
+ * @adev: ACPI COMPANION device to match.
+ */
+static inline struct device *
+bus_find_device_by_acpi_dev(struct bus_type *bus, const struct acpi_device *adev)
+{
+	return bus_find_device(bus, NULL, adev, device_match_acpi_dev);
+}
+#else
+static inline struct device *
+bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
+{
+	return NULL;
+}
+#endif
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4
