From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 15/15] i2c: thunderx: Add smbus alert support
Date: Mon, 25 Apr 2016 16:33:44 +0200
Message-ID: <1461594824-7215-16-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Add smbus alert interrupt support.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-cavium.h        |  6 ++++++
 drivers/i2c/busses/i2c-thunderx-core.c | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
index ad57b03..749dffc 100644
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
@@ -120,6 +121,11 @@ struct octeon_i2c {
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
index 8fcd26c..e1a111d 100644
--- a/drivers/i2c/busses/i2c-thunderx-core.c
+++ b/drivers/i2c/busses/i2c-thunderx-core.c
@@ -9,9 +9,11 @@
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
@@ -106,6 +108,35 @@ static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
 	devm_clk_put(dev, clk);
 }
 
+static int thunder_i2c_smbus_setup(struct octeon_i2c *i2c,
+				   struct device_node *node)
+{
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+	u32 type;
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
 static void thunder_i2c_set_name(struct pci_dev *pdev, struct octeon_i2c *i2c,
 				 char *name)
 {
@@ -210,6 +241,9 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 		goto out_irq;
 	}
 
+	ret = thunder_i2c_smbus_setup(i2c, node);
+	if (ret < 0)
+		dev_info(dev, "Failed to setup smbus alert\n");
 	dev_info(i2c->dev, "probed\n");
 	return 0;
 
@@ -240,6 +274,7 @@ static void thunder_i2c_remove_pci(struct pci_dev *pdev)
 
 	dev = i2c->dev;
 	thunder_i2c_clock_disable(dev, i2c->clk);
+	thunder_i2c_smbus_remove(i2c);
 	i2c_del_adapter(&i2c->adap);
 	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
 	pci_disable_msix(pdev);
-- 
1.9.1
