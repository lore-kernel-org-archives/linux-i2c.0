From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c: core: helper function to detect slave mode
Date: Thu,  5 Jan 2017 17:24:14 +0000
Message-ID: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This function has the purpose of mode detection by checking the
device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
Currently only checks using OF functions (ACPI slave not supported yet).

Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
Due to the need of checking if the I2C slave address is our own (in 
other words: if we are the I2C slave) I created a helper function 
(proposed to me by @Andy) to enable that check. 
Currently (because I am not able to test it using ACPI) it only 
supports devicetree declarations.

 drivers/i2c/i2c-core.c | 19 +++++++++++++++++++
 include/linux/i2c.h    |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3de95a29024c..48e705b23c59 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3691,6 +3691,25 @@ int i2c_slave_unregister(struct i2c_client *client)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+
+int i2c_slave_mode_detect(struct device *dev)
+{
+	struct device_node *child;
+	u32 reg;
+
+	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
+		for_each_child_of_node(dev->of_node, child) {
+			of_property_read_u32(child, "reg", &reg);
+			if (reg & I2C_OWN_SLAVE_ADDRESS)
+				return 1;
+		}
+	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
+		dev_dbg(dev, "ACPI slave is not supported yet\n");
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_slave_mode_detect);
+
 #endif
 
 MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b2109c522dec..53cf99569af5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -282,6 +282,7 @@ enum i2c_slave_event {
 
 extern int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
 extern int i2c_slave_unregister(struct i2c_client *client);
+extern int i2c_slave_mode_detect(struct device *dev);
 
 static inline int i2c_slave_event(struct i2c_client *client,
 				  enum i2c_slave_event event, u8 *val)
-- 
2.11.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
