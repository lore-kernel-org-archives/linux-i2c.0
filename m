From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v2] i2c: core: helper function to detect slave mode
Date: Fri,  6 Jan 2017 18:14:18 +0000
Message-ID: <9ada747bd53bb5005a82f913412262b34b6e96b8.1483725370.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52953 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbdAFSO7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Jan 2017 13:14:59 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

This function has the purpose of mode detection by checking the
device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
Currently only checks using OF functions (ACPI slave not supported yet).

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes V1->V2:
- Kernel doc added to i2c-core. (@Andy)
- Moved the definitions to the OF branch. (@Andy)
- Changed the return type from int to bool. (@Rob)

 drivers/i2c/i2c-core.c | 28 ++++++++++++++++++++++++++++
 include/linux/i2c.h    |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3de95a29024c..937605e65976 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3691,6 +3691,34 @@ int i2c_slave_unregister(struct i2c_client *client)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+
+/**
+ * i2c_slave_mode_detect - detect operation mode
+ * @dev:  The device owning the bus
+ *
+ * This checks the device nodes for a I2C slave by checking the address
+ * used.
+ *
+ * Returns true if a I2C slave is detected, otherwise returns false.
+ */
+bool i2c_slave_mode_detect(struct device *dev)
+{
+	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
+		struct device_node *child;
+		u32 reg;
+
+		for_each_child_of_node(dev->of_node, child) {
+			of_property_read_u32(child, "reg", &reg);
+			if (reg & I2C_OWN_SLAVE_ADDRESS)
+				return true;
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
index b2109c522dec..bfc3e0cee57e 100644
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
