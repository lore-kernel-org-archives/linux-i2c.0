From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 5/5] i2c: mux: pca954x: Add irq_mask_en to delay enabling irqs
Date: Wed,  4 Jan 2017 17:29:57 +0800
Message-ID: <1483522197-38819-6-git-send-email-preid@electromag.com.au>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:47748 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965410AbdADNn7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2017 08:43:59 -0500
In-Reply-To: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
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
device driver has not yet loaded. Setting this parameter to 0x3 while
delay the irq being enabled until both devices are ready.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index f2dba7c..16269e7 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -83,6 +83,7 @@ struct pca954x {
 
 	struct irq_domain *irq;
 	unsigned int irq_mask;
+	unsigned int irq_mask_en;
 };
 
 /* Provide specs for the PCA954x types we know about */
@@ -251,9 +252,12 @@ static void pca954x_irq_unmask(struct irq_data *idata)
 	struct pca954x *data = irq_data_get_irq_chip_data(idata);
 	unsigned int pos = idata->hwirq;
 
-	if (!data->irq_mask)
+	if (!data->irq_mask_en && !data->irq_mask)
 		enable_irq(data->client->irq);
 	data->irq_mask |= BIT(pos);
+	if (data->irq_mask_en &&
+		(data->irq_mask & data->irq_mask) == data->irq_mask_en)
+		enable_irq(data->client->irq);
 }
 
 static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
@@ -369,6 +373,9 @@ static int pca954x_probe(struct i2c_client *client,
 	idle_disconnect_dt = of_node &&
 		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
 
+	of_property_read_u32(of_node, "i2c-mux-irq-mask-en",
+			     &data->irq_mask_en);
+
 	ret = pca953x_irq_setup(muxc);
 	if (ret)
 		goto irq_setup_failed;
-- 
1.8.3.1
