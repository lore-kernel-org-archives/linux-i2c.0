From: Ruslan Babayev <ruslan@babayev.com>
Subject: [PATCH net-next 1/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
Date: Sun,  5 May 2019 15:05:22 -0700
Message-ID: <20190505220524.37266-2-ruslan@babayev.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

This allows drivers to lookup i2c adapters on ACPI based systems similar to
of_get_i2c_adapter_by_node() with DT based systems.

Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
Cc: xe-linux-external@cisco.com
---
 drivers/i2c/i2c-core-acpi.c | 3 ++-
 include/linux/i2c.h         | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 272800692088..964687534754 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -337,7 +337,7 @@ static int i2c_acpi_find_match_device(struct device *dev, void *data)
 	return ACPI_COMPANION(dev) == data;
 }
 
-static struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
+struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 {
 	struct device *dev;
 
@@ -345,6 +345,7 @@ static struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 			      i2c_acpi_find_match_adapter);
 	return dev ? i2c_verify_adapter(dev) : NULL;
 }
+EXPORT_SYMBOL_GPL(i2c_acpi_find_adapter_by_handle);
 
 static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 383510b4f083..24859a26f167 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -33,6 +33,7 @@
 #include <linux/rtmutex.h>
 #include <linux/irqdomain.h>		/* for Host Notify IRQ */
 #include <linux/of.h>		/* for struct device_node */
+#include <linux/acpi.h>		/* for acpi_handle */
 #include <linux/swab.h>		/* for swab16 */
 #include <uapi/linux/i2c.h>
 
@@ -977,6 +978,7 @@ bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 u32 i2c_acpi_find_bus_speed(struct device *dev);
 struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 				       struct i2c_board_info *info);
+struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
 #else
 static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 					     struct acpi_resource_i2c_serialbus **i2c)
@@ -992,6 +994,10 @@ static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
 {
 	return NULL;
 }
+struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
+{
+	return NULL;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* _LINUX_I2C_H */
-- 
2.17.1
