From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4] i2c: core: helper function to detect slave mode
Date: Thu, 26 Jan 2017 17:45:32 +0000
Message-ID: <c63cd48f7ae24747187f593b27b1b86ae361c436.1485452304.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This function has the purpose of mode detection by checking the
device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
Currently only checks using OF functions (ACPI slave not supported yet).

Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Suggested-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes V3->V4: (@Wolfram)
- Rename of the function
- Reword of the function description

 drivers/i2c/i2c-core.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 583e95042a21..408de741fec5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3690,6 +3690,39 @@ int i2c_slave_unregister(struct i2c_client *client)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+
+/**
+ * i2c_detect_slave_mode - detect operation mode
+ * @dev: The device owning the bus
+ *
+ * This checks the device nodes for an I2C slave by checking the address
+ * used in the reg property. If the address match the I2C_OWN_SLAVE_ADDRESS
+ * flag this means the device is configured to act as a I2C slave and it will
+ * be listening at that address.
+ *
+ * Returns true if an I2C own slave address is detected, otherwise returns
+ * false.
+ */
+bool i2c_detect_slave_mode(struct device *dev)
+{
+	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
+		struct device_node *child;
+		u32 reg;
+
+		for_each_child_of_node(dev->of_node, child) {
+			of_property_read_u32(child, "reg", &reg);
+			if (reg & I2C_OWN_SLAVE_ADDRESS) {
+				of_node_put(child);
+				return true;
+			}
+		}
+	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
+		dev_dbg(dev, "ACPI slave is not supported yet\n");
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(i2c_detect_slave_mode);
+
 #endif
 
 MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 4b45ec46161f..f0ba4bac7452 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -282,6 +282,7 @@ enum i2c_slave_event {
 
 extern int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
 extern int i2c_slave_unregister(struct i2c_client *client);
+extern bool i2c_detect_slave_mode(struct device *dev);
 
 static inline int i2c_slave_event(struct i2c_client *client,
 				  enum i2c_slave_event event, u8 *val)
-- 
2.11.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
