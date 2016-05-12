From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v9 4/8] i2c: thunderx: Add SMBUS alert support
Date: Thu, 12 May 2016 14:22:12 +0200
Message-ID: <1463055736-20025-5-git-send-email-jglauber@cavium.com>
References: <1463055736-20025-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463055736-20025-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Add SMBUS alert interrupt support. For now only device tree is
supported for specifying the alert. In case of ACPI an error
is returned.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-cavium.h        |  6 ++++
 drivers/i2c/busses/i2c-thunderx-core.c | 51 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
index 33c7e1f..9c128c1 100644
--- a/drivers/i2c/busses/i2c-cavium.h
+++ b/drivers/i2c/busses/i2c-cavium.h
@@ -3,6 +3,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -119,6 +120,11 @@ struct octeon_i2c {
 #if IS_ENABLED(CONFIG_I2C_THUNDERX)
 	struct msix_entry i2c_msix;
 #endif
+
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+	struct i2c_smbus_alert_setup alert_data;
+	struct i2c_client *ara;
+#endif
 };
 
 static inline void octeon_i2c_writeq_flush(u64 val, void __iomem *addr)
diff --git a/drivers/i2c/busses/i2c-thunderx-core.c b/drivers/i2c/busses/i2c-thunderx-core.c
index dbde48c..bc178be 100644
--- a/drivers/i2c/busses/i2c-thunderx-core.c
+++ b/drivers/i2c/busses/i2c-thunderx-core.c
@@ -10,9 +10,11 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_irq.h>
 #include <linux/pci.h>
 
 #include "i2c-cavium.h"
@@ -106,6 +108,51 @@ static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
 	devm_clk_put(dev, clk);
 }
 
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+static int thunder_i2c_smbus_setup_of(struct octeon_i2c *i2c,
+				      struct device_node *node)
+{
+	u32 type;
+
+	if (!node)
+		return -EINVAL;
+
+	i2c->alert_data.irq = irq_of_parse_and_map(node, 0);
+	if (!i2c->alert_data.irq)
+		return -EINVAL;
+
+	type = irqd_get_trigger_type(irq_get_irq_data(i2c->alert_data.irq));
+	i2c->alert_data.alert_edge_triggered =
+		(type & IRQ_TYPE_LEVEL_MASK) ? 1 : 0;
+
+	i2c->ara = i2c_setup_smbus_alert(&i2c->adap, &i2c->alert_data);
+	if (!i2c->ara)
+		return -ENODEV;
+	return 0;
+}
+#endif
+
+static int thunder_i2c_smbus_setup(struct octeon_i2c *i2c,
+				   struct device_node *node)
+{
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+	/* TODO: ACPI support */
+	if (!acpi_disabled)
+		return -EOPNOTSUPP;
+
+	return thunder_i2c_smbus_setup_of(i2c, node);
+#endif
+	return 0;
+}
+
+static void thunder_i2c_smbus_remove(struct octeon_i2c *i2c)
+{
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+	if (i2c->ara)
+		i2c_unregister_device(i2c->ara);
+#endif
+}
+
 static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
 {
@@ -189,6 +236,9 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 		goto out_irq;
 	}
 
+	ret = thunder_i2c_smbus_setup(i2c, pdev->dev.of_node);
+	if (ret < 0)
+		dev_info(dev, "SMBUS alert not active on this bus\n");
 	dev_info(i2c->dev, "probed\n");
 	return 0;
 
@@ -219,6 +269,7 @@ static void thunder_i2c_remove_pci(struct pci_dev *pdev)
 
 	dev = i2c->dev;
 	thunder_i2c_clock_disable(dev, i2c->clk);
+	thunder_i2c_smbus_remove(i2c);
 	i2c_del_adapter(&i2c->adap);
 	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
 	pci_disable_msix(pdev);
-- 
1.9.1
