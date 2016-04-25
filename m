From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 13/15] i2c: thunderx: Add i2c driver for ThunderX SOC
Date: Mon, 25 Apr 2016 16:33:42 +0200
Message-ID: <1461594824-7215-14-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34310 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbcDYOeK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Apr 2016 10:34:10 -0400
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

The ThunderX SOC uses the same i2c block as the Octeon SOC.
The main difference is that on ThunderX the device is a PCI device
so device probing is done via PCI, interrupts are MSIX and the
clock is taken from device tree.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/Kconfig             |  10 ++
 drivers/i2c/busses/Makefile            |   2 +
 drivers/i2c/busses/i2c-cavium.h        |  16 +-
 drivers/i2c/busses/i2c-thunderx-core.c | 267 +++++++++++++++++++++++++++++++++
 4 files changed, 292 insertions(+), 3 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index faa8e68..92d23de 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -953,6 +953,16 @@ config I2C_OCTEON
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-octeon.
 
+config I2C_THUNDERX
+	tristate "Cavium ThunderX I2C bus support"
+	depends on 64BIT && PCI && !CAVIUM_OCTEON_SOC
+	help
+	  Say yes if you want to support the I2C serial bus on Cavium
+	  ThunderX SOC.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-thunderx.
+
 config I2C_XILINX
 	tristate "Xilinx I2C Controller"
 	depends on HAS_IOMEM
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 282f781..a32ff14 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -93,6 +93,8 @@ obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_WMT)		+= i2c-wmt.o
 i2c-octeon-objs := i2c-cavium.o i2c-octeon-core.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
+i2c-thunderx-objs := i2c-cavium.o i2c-thunderx-core.o
+obj-$(CONFIG_I2C_THUNDERX)	+= i2c-thunderx.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
 obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
index 81c6a81..33c7e1f 100644
--- a/drivers/i2c/busses/i2c-cavium.h
+++ b/drivers/i2c/busses/i2c-cavium.h
@@ -8,9 +8,15 @@
 #include <linux/pci.h>
 
 /* Register offsets */
-#define SW_TWSI			0x00
-#define TWSI_INT		0x10
-#define SW_TWSI_EXT		0x18
+#if IS_ENABLED(CONFIG_I2C_THUNDERX)
+	#define SW_TWSI			0x1000
+	#define TWSI_INT		0x1010
+	#define SW_TWSI_EXT		0x1018
+#else
+	#define SW_TWSI			0x00
+	#define TWSI_INT		0x10
+	#define SW_TWSI_EXT		0x18
+#endif
 
 /* Controller command patterns */
 #define SW_TWSI_V		BIT_ULL(63)	/* Valid bit */
@@ -94,6 +100,7 @@
 struct octeon_i2c {
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
+	struct clk *clk;
 	int irq;
 	int hlc_irq;		/* For cn7890 only */
 	u32 twsi_freq;
@@ -109,6 +116,9 @@ struct octeon_i2c {
 	void (*hlc_int_disable)(struct octeon_i2c *);
 	atomic_t int_enable_cnt;
 	atomic_t hlc_int_enable_cnt;
+#if IS_ENABLED(CONFIG_I2C_THUNDERX)
+	struct msix_entry i2c_msix;
+#endif
 };
 
 static inline void octeon_i2c_writeq_flush(u64 val, void __iomem *addr)
diff --git a/drivers/i2c/busses/i2c-thunderx-core.c b/drivers/i2c/busses/i2c-thunderx-core.c
new file mode 100644
index 0000000..656b405
--- /dev/null
+++ b/drivers/i2c/busses/i2c-thunderx-core.c
@@ -0,0 +1,267 @@
+/*
+ * Cavium ThunderX i2c driver.
+ *
+ * Copyright (C) 2015,2016 Cavium Inc.
+ * Authors: Fred Martin <fmartin@caviumnetworks.com>
+ *	    Jan Glauber <jglauber@cavium.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "i2c-cavium.h"
+
+#define DRV_NAME "i2c-thunderx"
+
+#define PCI_CFG_REG_BAR_NUM		0
+#define PCI_DEVICE_ID_THUNDER_TWSI	0xa012
+
+#define TWSI_DFL_RATE			100000
+#define SYS_FREQ_DEFAULT		800000000
+
+#define TWSI_INT_ENA_W1C		0x1028
+#define TWSI_INT_ENA_W1S		0x1030
+
+/*
+ * Enable the CORE interrupt.
+ * The interrupt will be asserted when there is non-STAT_IDLE state in the
+ * SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void thunder_i2c_int_enable(struct octeon_i2c *i2c)
+{
+	octeon_i2c_writeq_flush(TWSI_INT_CORE_INT,
+				i2c->twsi_base + TWSI_INT_ENA_W1S);
+}
+
+/*
+ * Disable the CORE interrupt.
+ */
+static void thunder_i2c_int_disable(struct octeon_i2c *i2c)
+{
+	octeon_i2c_writeq_flush(TWSI_INT_CORE_INT,
+				i2c->twsi_base + TWSI_INT_ENA_W1C);
+}
+
+static void thunder_i2c_hlc_int_enable(struct octeon_i2c *i2c)
+{
+	octeon_i2c_writeq_flush(TWSI_INT_ST_INT | TWSI_INT_TS_INT,
+				i2c->twsi_base + TWSI_INT_ENA_W1S);
+}
+
+static void thunder_i2c_hlc_int_disable(struct octeon_i2c *i2c)
+{
+	octeon_i2c_writeq_flush(TWSI_INT_ST_INT | TWSI_INT_TS_INT,
+				i2c->twsi_base + TWSI_INT_ENA_W1C);
+}
+
+static u32 thunderx_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
+	       I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_SMBUS_BLOCK_PROC_CALL;
+}
+
+static const struct i2c_algorithm thunderx_i2c_algo = {
+	.master_xfer = octeon_i2c_xfer,
+	.functionality = thunderx_i2c_functionality,
+};
+
+static struct i2c_adapter thunderx_i2c_ops = {
+	.owner	= THIS_MODULE,
+	.name	= "ThunderX adapter",
+	.algo	= &thunderx_i2c_algo,
+};
+
+static void thunder_i2c_clock_enable(struct device *dev, struct octeon_i2c *i2c)
+{
+	int ret;
+
+	i2c->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(i2c->clk)) {
+		i2c->clk = NULL;
+		goto skip;
+	}
+
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		goto skip;
+	i2c->sys_freq = clk_get_rate(i2c->clk);
+
+skip:
+	if (!i2c->sys_freq)
+		i2c->sys_freq = SYS_FREQ_DEFAULT;
+
+	dev_info(dev, "Set system clock to %u\n", i2c->sys_freq);
+}
+
+static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
+{
+	if (!clk)
+		return;
+	clk_disable_unprepare(clk);
+	devm_clk_put(dev, clk);
+}
+
+static void thunder_i2c_set_name(struct pci_dev *pdev, struct octeon_i2c *i2c,
+				 char *name)
+{
+	u8 i2c_bus_id, soc_node;
+	resource_size_t start;
+
+	start = pci_resource_start(pdev, PCI_CFG_REG_BAR_NUM);
+	soc_node = (start >> 44) & 0x3;
+	i2c_bus_id = (start >> 24) & 0x7;
+	snprintf(name, 10, "i2c%d", soc_node * 6 + i2c_bus_id);
+
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "thunderx-i2c-%d.%d",
+		 soc_node, i2c_bus_id);
+}
+
+static int thunder_i2c_probe_pci(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = NULL;
+	struct octeon_i2c *i2c;
+	char i2c_name[10];
+	int ret = 0;
+
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	i2c->dev = dev;
+	pci_set_drvdata(pdev, i2c);
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto out_free_i2c;
+	}
+
+	ret = pci_request_regions(pdev, DRV_NAME);
+	if (ret) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", ret);
+		goto out_disable_device;
+	}
+
+	i2c->twsi_base = pci_ioremap_bar(pdev, PCI_CFG_REG_BAR_NUM);
+	if (!i2c->twsi_base) {
+		dev_err(dev, "Cannot map CSR memory space\n");
+		ret = -EINVAL;
+		goto out_release_regions;
+	}
+
+	thunder_i2c_clock_enable(dev, i2c);
+
+	thunder_i2c_set_name(pdev, i2c, i2c_name);
+	node = of_find_node_by_name(NULL, i2c_name);
+	if (!node || of_property_read_u32(node, "clock-frequency",
+	    &i2c->twsi_freq))
+		i2c->twsi_freq = TWSI_DFL_RATE;
+
+	init_waitqueue_head(&i2c->queue);
+
+	i2c->int_enable = thunder_i2c_int_enable;
+	i2c->int_disable = thunder_i2c_int_disable;
+	i2c->hlc_int_enable = thunder_i2c_hlc_int_enable;
+	i2c->hlc_int_disable = thunder_i2c_hlc_int_disable;
+
+	ret = pci_enable_msix(pdev, &i2c->i2c_msix, 1);
+	if (ret) {
+		dev_err(dev, "Unable to enable MSI-X\n");
+		goto out_unmap;
+	}
+
+	ret = devm_request_irq(dev, i2c->i2c_msix.vector, octeon_i2c_isr, 0,
+			       DRV_NAME, i2c);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach i2c interrupt\n");
+		goto out_msix;
+	}
+
+	ret = octeon_i2c_init_lowlevel(i2c);
+	if (ret) {
+		dev_err(dev, "Init low level failed\n");
+		goto out_msix;
+	}
+
+	octeon_i2c_set_clock(i2c);
+
+	i2c->adap = thunderx_i2c_ops;
+	i2c->adap.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	i2c->adap.timeout = msecs_to_jiffies(5);
+	i2c->adap.retries = 5;
+	i2c->adap.bus_recovery_info = &octeon_i2c_recovery_info;
+	i2c->adap.dev.parent = dev;
+	i2c->adap.dev.of_node = pdev->dev.of_node;
+	i2c_set_adapdata(&i2c->adap, i2c);
+
+	ret = i2c_add_adapter(&i2c->adap);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add i2c adapter\n");
+		goto out_irq;
+	}
+
+	dev_info(i2c->dev, "probed\n");
+	return 0;
+
+out_irq:
+	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
+out_msix:
+	pci_disable_msix(pdev);
+out_unmap:
+	iounmap(i2c->twsi_base);
+	thunder_i2c_clock_disable(dev, i2c->clk);
+out_release_regions:
+	pci_release_regions(pdev);
+out_disable_device:
+	pci_disable_device(pdev);
+out_free_i2c:
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, i2c);
+	return ret;
+}
+
+static void thunder_i2c_remove_pci(struct pci_dev *pdev)
+{
+	struct octeon_i2c *i2c = pci_get_drvdata(pdev);
+	struct device *dev;
+
+	if (!i2c)
+		return;
+
+	dev = i2c->dev;
+	thunder_i2c_clock_disable(dev, i2c->clk);
+	i2c_del_adapter(&i2c->adap);
+	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
+	pci_disable_msix(pdev);
+	iounmap(i2c->twsi_base);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, i2c);
+}
+
+static const struct pci_device_id thunder_i2c_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDER_TWSI) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, thunder_i2c_pci_id_table);
+
+static struct pci_driver thunder_i2c_pci_driver = {
+	.name		= DRV_NAME,
+	.id_table	= thunder_i2c_pci_id_table,
+	.probe		= thunder_i2c_probe_pci,
+	.remove		= thunder_i2c_remove_pci,
+};
+
+module_pci_driver(thunder_i2c_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fred Martin <fmartin@caviumnetworks.com>");
+MODULE_DESCRIPTION("I2C-Bus adapter for Cavium ThunderX SOC");
-- 
1.9.1
