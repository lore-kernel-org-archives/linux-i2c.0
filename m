From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v4 5/5] i2c: mux: pca954x: Add irq_mask_en to delay enabling irqs
Date: Mon, 16 Jan 2017 11:11:15 +0800
Message-ID: <1484536275-75995-6-git-send-email-preid@electromag.com.au>
References: <1484536275-75995-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484536275-75995-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

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

Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index f55da88..66f7ed8 100644
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
 
@@ -84,6 +97,7 @@ struct pca954x {
 	struct i2c_client *client;
 
 	struct irq_domain *irq;
+	unsigned int irq_mask_enable;
 	unsigned int irq_mask;
 	spinlock_t lock;
 };
@@ -280,9 +294,12 @@ static void pca954x_irq_unmask(struct irq_data *idata)
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	if (!data->irq_mask)
+	if (!data->irq_mask_enable && !data->irq_mask)
 		enable_irq(data->client->irq);
 	data->irq_mask |= BIT(pos);
+	if (data->irq_mask_enable &&
+		(data->irq_mask & data->irq_mask) == data->irq_mask_enable)
+		enable_irq(data->client->irq);
 
 	spin_unlock_irqrestore(&data->lock, flags);
 }
@@ -409,6 +426,9 @@ static int pca954x_probe(struct i2c_client *client,
 	idle_disconnect_dt = of_node &&
 		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
 
+	of_property_read_u32(of_node, "nxp,irq-mask-enable",
+			     &data->irq_mask_enable);
+
 	ret = pca954x_irq_setup(muxc);
 	if (ret)
 		goto fail_del_adapters;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
