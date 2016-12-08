From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] misc: eeprom: implement compatible DT probing
Date: Thu,  8 Dec 2016 18:47:59 +0100
Message-ID: <1481219279-6982-1-git-send-email-linus.walleij@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The compatible string for an EEPROM in the device tree is currently
completely ignored by the kernel, simply stated it will not make the
corresponding AT24 EEPROM driver probe properly. It is instead still
relying on the DT node name to be set to one of the I2C device IDs
which works due to a side effect in the I2C DT parsing code.

Fix this up by making the DT probe mechanism a bit more elaborate:
actually match on the compatible strings defined in the device
tree bindings in Documentation/devicetree/bindings/eeprom/eeprom.txt:
map these to the corresponding I2C IDs by name and look up the
magic flags from the I2C ID before proceeding, also make the DT
compatible string take precedence.

Keep the second DT parsing callback that sets up per-chip flags as
this needs to happen after mangling the magic flags passed from the
I2C ID table.

All vendor compatible strings listed in the binding document are
added to the driver.

After this it is possible to name the device tree node for the EEPROM
whatever you actually like to call it, and the probing will be done
from the compatible string.

Before this patch, the following device tree node does not probe,
which might be considered a bug:

eeprom@52 {
	compatible = "atmel,at24c128";
	reg = <0x52>;
	pagesize = <64>;
};

After this patch, the driver probes fine from this node.

As checkpatch is complaining about the vendor "catalyst" not
existing in the vendor prefixes, despite being mentioned in the
EEPROM DT binding document, we add this as part of this patch so
that checkpatch is happy.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/misc/eeprom/at24.c                         | 82 ++++++++++++++++++----
 2 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f0a48ea78659..40bdf9aa590c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -47,6 +47,7 @@ brcm	Broadcom Corporation
 buffalo	Buffalo, Inc.
 calxeda	Calxeda
 capella	Capella Microsystems, Inc
+catalyst	Catalyst Semiconductor Inc.
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
 ceva	Ceva, Inc.
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 051b14766ef9..246b15539d45 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
@@ -563,23 +564,70 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 }
 
 #ifdef CONFIG_OF
-static void at24_get_ofdata(struct i2c_client *client,
-			    struct at24_platform_data *chip)
+static void at24_get_of_magic(struct device *dev,
+			      kernel_ulong_t *magic)
 {
-	const __be32 *val;
-	struct device_node *node = client->dev.of_node;
-
-	if (node) {
-		if (of_get_property(node, "read-only", NULL))
-			chip->flags |= AT24_FLAG_READONLY;
-		val = of_get_property(node, "pagesize", NULL);
-		if (val)
-			chip->page_size = be32_to_cpup(val);
+	const char *name;
+	const struct i2c_device_id *id;
+	int i;
+
+	name = of_device_get_match_data(dev);
+	if (!name)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(at24_ids); i++) {
+		id = &at24_ids[i];
+		if (!strcmp(id->name, name)) {
+			*magic = id->driver_data;
+			break;
+		}
 	}
+	if (i == ARRAY_SIZE(at24_ids))
+		return;
+
+	dev_dbg(dev, "DT match for %s -> %s\n", name, id->name);
+}
+
+static void at24_get_of_chipdata(struct device_node *np,
+				 struct at24_platform_data *chip)
+{
+	u32 val;
+	int ret;
+
+	if (of_property_read_bool(np, "read-only"))
+		chip->flags |= AT24_FLAG_READONLY;
+
+	ret = of_property_read_u32(np, "pagesize", &val);
+	if (!ret)
+		chip->page_size = val;
 }
+
+static const struct of_device_id at24_of_match[] = {
+	{ .compatible = "atmel,at24c00", .data = "24c00" },
+	{ .compatible = "atmel,at24c01", .data = "24c01" },
+	{ .compatible = "atmel,at24c02", .data = "24c02" },
+	{ .compatible = "atmel,at24c04", .data = "24c04" },
+	{ .compatible = "atmel,at24c08", .data = "24c08" },
+	{ .compatible = "atmel,at24c16", .data = "24c16" },
+	{ .compatible = "atmel,at24c32", .data = "24c32" },
+	{ .compatible = "atmel,at24c64", .data = "24c64" },
+	{ .compatible = "atmel,at24c128", .data = "24c128" },
+	{ .compatible = "atmel,at24c256", .data = "24c256" },
+	{ .compatible = "atmel,at24c512", .data = "24c512" },
+	{ .compatible = "atmel,at24c1024", .data = "24c1024" },
+	{ .compatible = "catalyst,24c32", .data = "24c32" },
+	{ .compatible = "ramtron,24c64", .data = "24c64" },
+	{ .compatible = "renesas,r1ex24002", .data = "24c02" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, at24_of_match);
+
 #else
-static void at24_get_ofdata(struct i2c_client *client,
-			    struct at24_platform_data *chip)
+static void at24_get_of_magic(struct device *dev,
+			      kernel_ulong_t *magic)
+{ }
+static void at24_get_of_chipdata(struct device_node *np,
+				 struct at24_platform_data *chip)
 { }
 #endif /* CONFIG_OF */
 
@@ -598,7 +646,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
 	} else {
-		if (id) {
+		if (client->dev.of_node) {
+			/* Get chipdata if OF is present */
+			at24_get_of_magic(&client->dev, &magic);
+		} else if (id) {
 			magic = id->driver_data;
 		} else {
 			const struct acpi_device_id *aid;
@@ -621,7 +672,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		chip.page_size = 1;
 
 		/* update chipdata if OF is present */
-		at24_get_ofdata(client, &chip);
+		at24_get_of_chipdata(client->dev.of_node, &chip);
 
 		chip.setup = NULL;
 		chip.context = NULL;
@@ -822,6 +873,7 @@ static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
+		.of_match_table = of_match_ptr(at24_of_match),
 	},
 	.probe = at24_probe,
 	.remove = at24_remove,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
