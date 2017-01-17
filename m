From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 5/5] i2c: mux: pca954x: Add irq-mask-enable to delay enabling irqs
Date: Tue, 17 Jan 2017 16:00:29 +0800
Message-ID: <1484640029-22870-6-git-send-email-preid@electromag.com.au>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:51869 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750949AbdAQIAj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Jan 2017 03:00:39 -0500
In-Reply-To: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: peda@axentia.se, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

Unfortunately some hardware device will assert their irq line immediately
on power on and provide no mechanism to mask the irq. As the i2c muxes
provide no method to mask irq line this provides a work around by keeping
the parent irq masked until enough device drivers have loaded to service
all pending interrupts.

For example the the ltc1760 assert its SMBALERT irq immediately on power
on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
device is registered irq are enabled and fire continuously as the second
device driver has not yet loaded. Setting this parameter to <1 1> will
delay the irq being enabled until both devices are ready.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index f55da88..012b2ef 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -76,6 +76,19 @@ struct chip_desc {
 	} muxtype;
 };
 
+/*
+ * irq_mask_enable: Provides a mechanism to work around hardware that asserts
+ * their irq immediately on power on. It allows the enabling of the irq to be
+ * delayed until the corresponding bits in the the irq_mask are set thru
+ * irq_unmask.
+ * For example the ltc1760 assert its SMBALERT irq immediately on power on.
+ * With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
+ * device is registered irq are enabled and fire continuously as the second
+ * device driver has not yet loaded. Setting this parameter to 0x3 while
+ * delay the irq being enabled until both devices are ready.
+ * This workaround will not work if two devices share an interrupt on the
+ * same bus segment.
+ */
 struct pca954x {
 	const struct chip_desc *chip;
 
@@ -84,7 +97,9 @@ struct pca954x {
 	struct i2c_client *client;
 
 	struct irq_domain *irq;
+	unsigned int irq_mask_enable;
 	unsigned int irq_mask;
+	bool irq_enabled;
 	spinlock_t lock;
 };
 
@@ -266,8 +281,10 @@ static void pca954x_irq_mask(struct irq_data *idata)
 	spin_lock_irqsave(&data->lock, flags);
 
 	data->irq_mask &= ~BIT(pos);
-	if (!data->irq_mask)
+	if (data->irq_enabled && !data->irq_mask) {
 		disable_irq(data->client->irq);
+		data->irq_enabled = false;
+	}
 
 	spin_unlock_irqrestore(&data->lock, flags);
 }
@@ -275,14 +292,18 @@ static void pca954x_irq_mask(struct irq_data *idata)
 static void pca954x_irq_unmask(struct irq_data *idata)
 {
 	struct pca954x *data = irq_data_get_irq_chip_data(idata);
+	unsigned int mask_enable = data->irq_mask_enable;
 	unsigned int pos = idata->hwirq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	if (!data->irq_mask)
-		enable_irq(data->client->irq);
 	data->irq_mask |= BIT(pos);
+	if (!data->irq_enabled
+	    && (data->irq_mask & mask_enable) == mask_enable) {
+		enable_irq(data->client->irq);
+		data->irq_enabled = true;
+	}
 
 	spin_unlock_irqrestore(&data->lock, flags);
 }
@@ -305,6 +326,7 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 {
 	struct pca954x *data = i2c_mux_priv(muxc);
 	struct i2c_client *client = data->client;
+	u32 irq_mask_enable[PCA954X_MAX_NCHANS] = { 0 };
 	int c, err, irq;
 
 	if (!data->chip->has_irq || client->irq <= 0)
@@ -312,6 +334,9 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 
 	spin_lock_init(&data->lock);
 
+	of_property_read_u32_array(client->dev.of_node, "nxp,irq-mask-enable",
+		irq_mask_enable, data->chip->nchans);
+
 	data->irq = irq_domain_add_linear(client->dev.of_node,
 					  data->chip->nchans,
 					  &irq_domain_simple_ops, data);
@@ -319,6 +344,8 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 		return -ENODEV;
 
 	for (c = 0; c < data->chip->nchans; c++) {
+		data->irq_mask_enable |= irq_mask_enable[c] ? BIT(c) : 0;
+		WARN_ON(irq_mask_enable[c] > 1);
 		irq = irq_create_mapping(data->irq, c);
 		irq_set_chip_data(irq, data);
 		irq_set_chip_and_handler(irq, &pca954x_irq_chip,
-- 
1.8.3.1
