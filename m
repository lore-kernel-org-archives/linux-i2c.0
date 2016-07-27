From: Phil Reid <preid@electromag.com.au>
Subject: [RFC PATCH 1/1] i2c: i2c-mux-pca954x: Add interrupt controller support.
Date: Wed, 27 Jul 2016 11:05:56 +0800
Message-ID: <1469588756-70579-2-git-send-email-preid@electromag.com.au>
References: <1469588756-70579-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:51394 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751580AbcG0DO1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jul 2016 23:14:27 -0400
In-Reply-To: <1469588756-70579-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, linux-i2c@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

The pca9543 can aggregate multiple interrupts from each i2c bus.
However it provides no ability to mask interrupts on each channel.
So if one bus is asserting interrupts than it will continuously
trigger the interrupts until another driver clears it. As a
workaround don't enable interrupts until both irqs have been unmasked.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 116 ++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 284e342..9ff2540 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -45,9 +45,14 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
 
 #define PCA954X_MAX_NCHANS 8
 
+#define PCA9543_IRQ_OFFSET 4
+
 enum pca_type {
 	pca_9540,
 	pca_9542,
@@ -67,6 +72,8 @@ struct pca954x {
 	struct i2c_client *client;
 	bool idle_reset;
 	struct gpio_desc *gpio;
+	struct irq_domain *irq_domain;
+	unsigned int irq_mask;
 };
 
 struct chip_desc {
@@ -194,6 +201,110 @@ static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
 	return pca954x_reg_write(muxc->parent, client, data->last_chan);
 }
 
+static irqreturn_t pca954x_irq_handler(int irq, void *devid)
+{
+	struct pca954x *data = i2c_mux_priv(devid);
+	struct i2c_client *client = data->client;
+	int i, ret, child_irq;
+	unsigned int nhandled = 0;
+
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0)
+		return IRQ_NONE;
+
+	for (i = 0; i < 2; i++) {
+		if (ret & BIT(PCA9543_IRQ_OFFSET+i)) {
+			child_irq = irq_find_mapping(data->irq_domain, i);
+			handle_nested_irq(child_irq);
+			nhandled++;
+		}
+	}
+
+	return (nhandled > 0) ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static void pca954x_irq_mask(struct irq_data *idata)
+{
+	struct i2c_mux_core *muxc = irq_data_get_irq_chip_data(idata);
+	struct pca954x *data = i2c_mux_priv(muxc);
+	unsigned int pos = idata->hwirq;
+
+	data->irq_mask &= ~BIT(pos);
+	if ((data->irq_mask & 0x3) != 0)
+		disable_irq(data->client->irq);
+}
+
+static void pca954x_irq_unmask(struct irq_data *idata)
+{
+	struct i2c_mux_core *muxc = irq_data_get_irq_chip_data(idata);
+	struct pca954x *data = i2c_mux_priv(muxc);
+	unsigned int pos = idata->hwirq;
+
+	data->irq_mask |= ~BIT(pos);
+	if ((data->irq_mask & 0x3) == 0x3)
+		enable_irq(data->client->irq);
+}
+
+static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
+{
+	return 0;
+}
+
+static struct irq_chip pca954x_irq_chip = {
+	.name			= "i2c-mux-pca954x",
+	.irq_mask = pca954x_irq_mask,
+	.irq_unmask = pca954x_irq_unmask,
+	.irq_set_type = pca954x_irq_set_type,
+};
+
+static int pca953x_irq_domain_map(struct irq_domain *h, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	struct i2c_mux_core *muxc = h->host_data;
+
+	irq_set_chip_data(irq, muxc);
+	irq_set_chip_and_handler(irq, &pca954x_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops pca953x_irq_domain_ops = {
+	.map	= pca953x_irq_domain_map,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
+static int pca953x_irq_setup(struct i2c_mux_core *muxc)
+{
+	struct pca954x *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+	int i, ret;
+	int irq = client->irq;
+
+	if ((data->type != pca_9543) && (irq != -1))
+		return 0;
+
+	ret = devm_request_threaded_irq(&client->dev, irq, NULL,
+					pca954x_irq_handler,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
+					   IRQF_SHARED,
+					dev_name(&client->dev), muxc);
+	if (ret) {
+		dev_err(&client->dev, "failed to request irq %d %d\n",
+			client->irq, ret);
+		return ret;
+	}
+
+	disable_irq(irq);
+
+	data->irq_domain = irq_domain_add_simple(client->dev.of_node,
+						 2, 0, &pca953x_irq_domain_ops,
+						 muxc);
+
+	for (i = 0; i < 2; i++)
+		irq_set_parent(irq_find_mapping(data->irq_domain, i), irq);
+
+	return 0;
+}
+
 /*
  * I2C init/probing/exit functions
  */
@@ -274,6 +385,10 @@ static int pca954x_probe(struct i2c_client *client,
 		}
 	}
 
+	ret = pca953x_irq_setup(muxc);
+	if (ret)
+		goto irq_setup_failed;
+
 	dev_info(&client->dev,
 		 "registered %d multiplexed busses for I2C %s %s\n",
 		 num, chips[data->type].muxtype == pca954x_ismux
@@ -281,6 +396,7 @@ static int pca954x_probe(struct i2c_client *client,
 
 	return 0;
 
+irq_setup_failed:
 virt_reg_failed:
 	i2c_mux_del_adapters(muxc);
 	return ret;
-- 
1.8.3.1
