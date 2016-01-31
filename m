From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: [PATCH v2] i2c: Add generic support passing secondary devices addresses
Date: Sun, 31 Jan 2016 16:33:00 +0100
Message-ID: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33192 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218AbcAaPdP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 31 Jan 2016 10:33:15 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, wsa@the-dreams.de, laurent.pinchart@ideasonboard.com, lars@metafoo.de, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>

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

Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
---
v2: adding some DT bindings documentation (more than one year later...)

 Documentation/devicetree/bindings/i2c/i2c.txt |  7 +++++
 drivers/i2c/i2c-core.c                        | 42 +++++++++++++++++++++++++++
 include/linux/i2c.h                           |  5 ++++
 3 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index c8d977e..f31b2ad 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -62,6 +62,13 @@ wants to support one of the below features, it should adapt the bindings below.
 - wakeup-source
 	device can be used as a wakeup source.
 
+- reg
+	I2C slave addresses
+
+- reg-names
+	Names of map programmable addresses.
+	It can contain any map needing another address than default one.
+
 Binding may contain optional "interrupts" property, describing interrupts
 used by the device. I2C core will assign "irq" interrupt (or the very first
 interrupt if not using interrupt names) as primary interrupt for the slave.
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ffe715d..da49fab 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1158,6 +1158,48 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
+/**
+ * i2c_new_secondary_device - Helper to get the instantiated secondary address
+ * and create the associated device
+ * @client: Handle to the primary client
+ * @name: Handle to specify which secondary address to get
+ * @default_addr: Used as a fallback if no secondary address was specified
+ * Context: can sleep
+ *
+ * I2C clients can be composed of multiple I2C slaves bound together in a single
+ * component. The I2C client driver then binds to the master I2C slave and needs
+ * to create I2C dummy clients to communicate with all the other slaves.
+ *
+ * This function creates and returns an I2C dummy client whose I2C address is
+ * retrieved from the platform firmware based on the given slave name. If no
+ * address is specified by the firmware default_addr is used.
+ *
+ * On DT-based platforms the address is retrieved from the "reg" property entry
+ * cell whose "reg-names" value matches the slave name.
+ *
+ * This returns the new i2c client, which should be saved for later use with
+ * i2c_unregister_device(); or NULL to indicate an error.
+ */
+struct i2c_client *i2c_new_secondary_device(struct i2c_client *client,
+						const char *name,
+						u16 default_addr)
+{
+	struct device_node *np = client->dev.of_node;
+	u32 addr = default_addr;
+	int i;
+
+	if (np) {
+		i = of_property_match_string(np, "reg-names", name);
+		if (i >= 0)
+			of_property_read_u32_index(np, "reg", i, &addr);
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
index 200cf13b..9c90735 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -349,6 +349,11 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
 extern struct i2c_client *
 i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
+extern struct i2c_client *
+i2c_new_secondary_device(struct i2c_client *client,
+				const char *name,
+				u16 default_addr);
+
 extern void i2c_unregister_device(struct i2c_client *);
 #endif /* I2C */
 
-- 
2.7.0
