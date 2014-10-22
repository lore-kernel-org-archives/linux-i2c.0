From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] i2c: Add generic support passing secondary devices addresses
Date: Wed, 22 Oct 2014 17:30:47 +0200
Message-ID: <1413991848-28495-1-git-send-email-jean-michel.hautbois@vodalys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some I2C devices have multiple addresses assigned, for example each address
corresponding to a different internal register map page of the device.
So far drivers which need support for this have handled this with a driver
specific and non-generic implementation, e.g. passing the additional address
via platform data.

This patch provides a new helper function called i2c_new_secondary_device()
which is intended to provide a generic way to get the secondary address
as well as instantiate a struct i2c_client for the secondary address.

The function expects a pointer to the primary i2c_client, a name
for the secondary address and an optional default address. The name is used
as a handle to specify which secondary address to get.

The default address is used as a fallback in case no secondary address
was explicitly specified. In case no secondary address and no default
address were specified the function returns NULL.

For now the function only supports look-up of the secondary address
from devicetree, but it can be extended in the future
to for example support board files and/or ACPI.

Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  8 ++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2f90ac6..fd3b07c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1166,6 +1166,46 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
+/**
+ * i2c_new_secondary_device - Helper to get the instantiated secondary address
+ * @client: Handle to the primary client
+ * @name: Handle to specify which secondary address to get
+ * @default_addr: Used as a fallback if no secondary address was specified
+ * Context: can sleep
+ *
+ * This returns an I2C client bound to the "dummy" driver based on DT parsing.
+ *
+ * This returns the new i2c client, which should be saved for later use with
+ * i2c_unregister_device(); or NULL to indicate an error.
+ */
+struct i2c_client *i2c_new_secondary_device(struct i2c_client *client,
+						const char *name,
+						u16 default_addr)
+{
+	int i;
+	u32 addr;
+	struct device_node *np;
+
+	np = client->dev.of_node;
+
+	if (np) {
+		i = of_property_match_string(np, "reg-names", name);
+		if (i >= 0)
+			of_property_read_u32_index(np, "reg", i, &addr);
+		else if (default_addr != 0)
+			addr = default_addr;
+		else
+			addr = NULL;
+	} else {
+		addr = default_addr;
+	}
+
+	dev_dbg(&client->adapter->dev, "Address for %s : 0x%x\n", name, addr);
+	return i2c_new_dummy(client->adapter, addr);
+}
+EXPORT_SYMBOL_GPL(i2c_new_secondary_device);
+
+
 /* ------------------------------------------------------------------------- */
 
 /* I2C bus adapters -- one roots each I2C or SMBUS segment */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b556e0a..8629287 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -322,6 +322,14 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
 extern struct i2c_client *
 i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
+/* Helper function providing a generic way to get the secondary address
+ * as well as a client handle to this extra address.
+ */
+extern struct i2c_client *
+i2c_new_secondary_device(struct i2c_client *client,
+				const char *name,
+				u16 default_addr);
+
 extern void i2c_unregister_device(struct i2c_client *);
 #endif /* I2C */
 
-- 
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
