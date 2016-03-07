From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v3 14/14] i2c-thunderx: Add smbus support
Date: Mon,  7 Mar 2016 16:10:57 +0100
Message-ID: <d4614b98f53d082605a9e35d25084d4a97438b34.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34165 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbcCGPLa (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 10:11:30 -0500
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Add smbus alert interrupt support.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-cavium.h        |  5 +++++
 drivers/i2c/busses/i2c-thunderx-core.c | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
index 739a4d3..5b66cd5 100644
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
@@ -110,6 +111,10 @@ struct octeon_i2c {
 #if IS_ENABLED(CONFIG_I2C_THUNDERX)
 	struct msix_entry i2c_msix;
 #endif
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+	struct i2c_smbus_alert_setup alert_data;
+	struct i2c_client *ara;
+#endif
 };
 
 static inline void writeqflush(u64 val, void __iomem *addr)
diff --git a/drivers/i2c/busses/i2c-thunderx-core.c b/drivers/i2c/busses/i2c-thunderx-core.c
index 8748d93..d50b5ec 100644
--- a/drivers/i2c/busses/i2c-thunderx-core.c
+++ b/drivers/i2c/busses/i2c-thunderx-core.c
@@ -9,10 +9,12 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/of_irq.h>
 
 #include "i2c-cavium.h"
 
@@ -107,6 +109,35 @@ static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
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
@@ -205,6 +236,9 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 		goto out_irq;
 	}
 
+	ret = thunder_i2c_smbus_setup(i2c, node);
+	if (ret < 0)
+		dev_err(dev, "Failed to setup smbus alert\n");
 	dev_info(i2c->dev, "probed\n");
 	return 0;
 
@@ -235,6 +269,7 @@ static void thunder_i2c_remove_pci(struct pci_dev *pdev)
 
 	dev = i2c->dev;
 	thunder_i2c_clock_disable(dev, i2c->clk);
+	thunder_i2c_smbus_remove(i2c);
 	i2c_del_adapter(&i2c->adap);
 	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
 	pci_disable_msix(pdev);
-- 
1.9.1
