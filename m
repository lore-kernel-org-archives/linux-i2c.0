From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v3] i2c: core: helper function to detect slave mode
Date: Tue, 17 Jan 2017 14:33:00 +0000
Message-ID: <58edd25a0fbe50b6d5abef14b7e46c63a1e06830.1484663257.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vz@mleia.com
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

This function has the purpose of mode detection by checking the
device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
Currently only checks using OF functions (ACPI slave not supported yet).

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes V2->V3: (@Vladimir)
- Bug Fix: «of_node_put(child)» added.

 drivers/i2c/i2c-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 583e95042a21..30aa7b50b5bc 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3690,6 +3690,36 @@ int i2c_slave_unregister(struct i2c_client *client)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+
+/**
+ * i2c_slave_mode_detect - detect operation mode
+ * @dev:  The device owning the bus
+ *
+ * This checks the device nodes for an I2C slave by checking the address
+ * used.
+ *
+ * Returns true if an I2C slave is detected, otherwise returns false.
+ */
+bool i2c_slave_mode_detect(struct device *dev)
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
+EXPORT_SYMBOL_GPL(i2c_slave_mode_detect);
+
 #endif
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 4b45ec46161f..2e72e157826c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -282,6 +282,7 @@ enum i2c_slave_event {
 
 extern int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
 extern int i2c_slave_unregister(struct i2c_client *client);
+extern bool i2c_slave_mode_detect(struct device *dev);
 
 static inline int i2c_slave_event(struct i2c_client *client,
 				  enum i2c_slave_event event, u8 *val)
-- 
2.11.0
