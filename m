From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v10 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed
Date: Fri,  2 Jun 2017 18:29:49 -0700
Message-ID: <20170603012952.2192-3-brendanhiggins@google.com>
References: <20170603012952.2192-1-brendanhiggins@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170603012952.2192-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, ryan_chen@aspeedtech.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-i2c@vger.kernel.org

The Aspeed 24XX/25XX chips share a single hardware interrupt across 14
separate I2C busses. This adds a dummy irqchip which maps the single
hardware interrupt to software interrupts for each of the busses.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Added in v6:
  - Pulled "aspeed_i2c_controller" out into a interrupt controller since that is
    what it actually does.
Changes for v7:
  - Renamed irq domain for consistency
Changes for v8:
  - None
Changes for v9:
  - None
Changes for v10:
  - Unallocate resources on init failure
  - Changed formatting of a function call
---
 drivers/irqchip/Makefile            |   2 +-
 drivers/irqchip/irq-aspeed-i2c-ic.c | 115 ++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-aspeed-i2c-ic.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b64c59b838a0..e067f9839b33 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -73,6 +73,6 @@ obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
-obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
+obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
new file mode 100644
index 000000000000..815b88dd18f2
--- /dev/null
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -0,0 +1,115 @@
+/*
+ *  Aspeed 24XX/25XX I2C Interrupt Controller.
+ *
+ *  Copyright (C) 2012-2017 ASPEED Technology Inc.
+ *  Copyright 2017 IBM Corporation
+ *  Copyright 2017 Google, Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+
+
+#define ASPEED_I2C_IC_NUM_BUS 14
+
+struct aspeed_i2c_ic {
+	void __iomem		*base;
+	int			parent_irq;
+	struct irq_domain	*irq_domain;
+};
+
+/*
+ * The aspeed chip provides a single hardware interrupt for all of the I2C
+ * busses, so we use a dummy interrupt chip to translate this single interrupt
+ * into multiple interrupts, each associated with a single I2C bus.
+ */
+static void aspeed_i2c_ic_irq_handler(struct irq_desc *desc)
+{
+	struct aspeed_i2c_ic *i2c_ic = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long bit, status;
+	unsigned int bus_irq;
+
+	chained_irq_enter(chip, desc);
+	status = readl(i2c_ic->base);
+	for_each_set_bit(bit, &status, ASPEED_I2C_IC_NUM_BUS) {
+		bus_irq = irq_find_mapping(i2c_ic->irq_domain, bit);
+		generic_handle_irq(bus_irq);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+/*
+ * Set simple handler and mark IRQ as valid. Nothing interesting to do here
+ * since we are using a dummy interrupt chip.
+ */
+static int aspeed_i2c_ic_map_irq_domain(struct irq_domain *domain,
+					unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_i2c_ic_irq_domain_ops = {
+	.map = aspeed_i2c_ic_map_irq_domain,
+};
+
+static int __init aspeed_i2c_ic_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	struct aspeed_i2c_ic *i2c_ic;
+	int ret = 0;
+
+	i2c_ic = kzalloc(sizeof(*i2c_ic), GFP_KERNEL);
+	if (!i2c_ic)
+		return -ENOMEM;
+
+	i2c_ic->base = of_iomap(node, 0);
+	if (IS_ERR(i2c_ic->base)) {
+		ret = PTR_ERR(i2c_ic->base);
+		goto err_free_ic;
+	}
+
+	i2c_ic->parent_irq = irq_of_parse_and_map(node, 0);
+	if (i2c_ic->parent_irq < 0) {
+		ret = i2c_ic->parent_irq;
+		goto err_iounmap;
+	}
+
+	i2c_ic->irq_domain = irq_domain_add_linear(node, ASPEED_I2C_IC_NUM_BUS,
+						   &aspeed_i2c_ic_irq_domain_ops,
+						   NULL);
+	if (!i2c_ic->irq_domain) {
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	i2c_ic->irq_domain->name = "aspeed-i2c-domain";
+
+	irq_set_chained_handler_and_data(i2c_ic->parent_irq,
+					 aspeed_i2c_ic_irq_handler, i2c_ic);
+
+	pr_info("i2c controller registered, irq %d\n", i2c_ic->parent_irq);
+
+	return 0;
+
+err_iounmap:
+	iounmap(i2c_ic->base);
+err_free_ic:
+	kfree(i2c_ic);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ast2400_i2c_ic, "aspeed,ast2400-i2c-ic", aspeed_i2c_ic_of_init);
+IRQCHIP_DECLARE(ast2500_i2c_ic, "aspeed,ast2500-i2c-ic", aspeed_i2c_ic_of_init);
-- 
2.13.0.506.g27d5fe0cd-goog
