From: Jan Glauber <jglauber@cavium.com>
Subject: [RFC PATCH 2/2] i2c: thunderx: Add smbus support
Date: Wed, 24 Feb 2016 15:13:25 +0100
Message-ID: <245c238f1cd959c2c9a8d77a4ce4b12c4f19fc74.1456322816.git.jglauber@cavium.com>
References: <cover.1456322816.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456322816.git.jglauber@cavium.com>
In-Reply-To: <cover.1456322816.git.jglauber@cavium.com>
References: <cover.1456322816.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Add smbus alert interrupt support.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/i2c/busses/i2c-cavium.h        |  4 ++++
 drivers/i2c/busses/i2c-thunderx-core.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
index db80c0f..8357997 100644
--- a/drivers/i2c/busses/i2c-cavium.h
+++ b/drivers/i2c/busses/i2c-cavium.h
@@ -119,6 +119,10 @@ struct octeon_i2c {
 #ifdef CONFIG_ARCH_THUNDER
 	struct msix_entry       i2c_msix;
 #endif
+#ifdef CONFIG_I2C_SMBUS
+	struct i2c_smbus_alert_setup alert_data;
+	struct i2c_client	*ara;
+#endif
 };
 
 static inline void writeqflush(u64 val, void __iomem *addr)
diff --git a/drivers/i2c/busses/i2c-thunderx-core.c b/drivers/i2c/busses/i2c-thunderx-core.c
index 0a95891..396c8bc 100644
--- a/drivers/i2c/busses/i2c-thunderx-core.c
+++ b/drivers/i2c/busses/i2c-thunderx-core.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -104,6 +105,34 @@ static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
 	devm_clk_put(dev, clk);
 }
 
+static void thunder_i2c_smbus_setup(struct octeon_i2c *i2c,
+				   struct device_node *node)
+{
+#ifdef CONFIG_I2C_SMBUS
+	u32 type;
+
+	i2c->alert_data.irq = irq_of_parse_and_map(node, 0);
+	if (!i2c->alert_data.irq)
+		return;
+
+	type = irqd_get_trigger_type(irq_get_irq_data(i2c->alert_data.irq));
+	i2c->alert_data.alert_edge_triggered =
+		(type & IRQ_TYPE_LEVEL_MASK) ? 1 : 0;
+
+	i2c->ara = i2c_setup_smbus_alert(&i2c->adap, &i2c->alert_data);
+	if (!i2c->ara)
+		dev_err(dev, "Failed to setup smbalert\n");
+#endif
+}
+
+static void thunder_i2c_smbus_remove(struct octeon_i2c *i2c)
+{
+#ifdef CONFIG_I2C_SMBUS
+	if (i2c->ara)
+		i2c_unregister_device(i2c->ara);
+#endif
+}
+
 static void thunder_i2c_set_name(struct pci_dev *pdev, struct octeon_i2c *i2c,
 				 char *name)
 {
@@ -202,6 +231,7 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 		goto out_irq;
 	}
 
+	thunder_i2c_smbus_setup(i2c, node);
 	dev_info(i2c->dev, "probed\n");
 	return 0;
 
@@ -232,6 +262,7 @@ static void thunder_i2c_remove_pci(struct pci_dev *pdev)
 
 	dev = i2c->dev;
 	thunder_i2c_clock_disable(dev, i2c->clk);
+	thunder_i2c_smbus_remove(i2c);
 	i2c_del_adapter(&i2c->adap);
 	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
 	pci_disable_msix(pdev);
-- 
1.9.1
