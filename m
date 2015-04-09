From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] i2c: Add acpi support to enumerate i2c mux clients
Date: Thu,  9 Apr 2015 12:15:42 -0700
Message-ID: <b57c66fc1b7e790bd8c3e525faf65ce46cd91f23.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1428546834.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
In-Reply-To: <cover.1428546834.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
References: <cover.1428546834.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Added support to enumerate i2c mux clients via ACPI.

Currently we don't have any fixed way for enumerating
mux clients via acpi. This patch adds support to scan
for all client i2c devices under the mux device in DSDT
table and enumerate them in order.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c |  3 ++-
 drivers/i2c/i2c-mux.c  | 26 ++++++++++++++++++++++++++
 include/linux/i2c.h    |  5 +++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index edf274c..94f76e3 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -118,7 +118,7 @@ static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
-static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
+acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 				       void *data, void **return_value)
 {
 	struct i2c_adapter *adapter = data;
@@ -155,6 +155,7 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 
 	return AE_OK;
 }
+EXPORT_SYMBOL_GPL(acpi_i2c_add_device);
 
 /**
  * acpi_i2c_register_devices - enumerate I2C slave devices behind adapter
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 593f7ca..32cf7a2 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -100,6 +100,29 @@ static unsigned int i2c_mux_parent_classes(struct i2c_adapter *parent)
 	return class;
 }
 
+#ifdef CONFIG_ACPI
+static void acpi_i2c_mux_register_devices(struct i2c_adapter *adap,
+					  struct device *mux_dev)
+{
+	acpi_handle handle;
+	acpi_status status;
+
+	handle = ACPI_HANDLE(mux_dev);
+	if (!handle)
+		return;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+				     acpi_i2c_add_device, NULL,
+				     adap, NULL);
+
+	if (ACPI_FAILURE(status))
+		dev_warn(mux_dev, "mux adapter slave enumeration fails\n");
+}
+#else /* !CONFIG_ACPI */
+static inline void acpi_i2c_mux_register_devices(struct i2c_adapter *adap,
+						 struct device *mux_dev) { }
+#endif /* CONFIG_ACPI */
+
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 				struct device *mux_dev,
 				void *mux_priv, u32 force_nr, u32 chan_id,
@@ -193,6 +216,9 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
+	/* scan for mux clients */
+	acpi_i2c_mux_register_devices(&priv->adap, mux_dev);
+
 	return &priv->adap;
 }
 EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f17da50..67b1412 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -33,6 +33,7 @@
 #include <linux/of.h>		/* for struct device_node */
 #include <linux/swab.h>		/* for swab16 */
 #include <uapi/linux/i2c.h>
+#include <linux/acpi.h>
 
 extern struct bus_type i2c_bus_type;
 extern struct device_type i2c_adapter_type;
@@ -608,4 +609,8 @@ static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node
 }
 #endif /* CONFIG_OF */
 
+#ifdef CONFIG_ACPI
+extern acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
+				       void *data, void **return_value);
+#endif /* CONFIG_ACPI */
 #endif /* _LINUX_I2C_H */
-- 
1.9.1
