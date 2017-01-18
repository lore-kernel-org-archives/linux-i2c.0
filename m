From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v5 5/5] i2c: mux: pca954x: Add irq-mask-enable to delay
 enabling irqs
Date: Wed, 18 Jan 2017 13:19:19 +0100
Message-ID: <312e32e9-a828-d692-895b-4042729e5417@axentia.se>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
 <1484640029-22870-6-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484640029-22870-6-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-01-17 09:00, Phil Reid wrote:
> Unfortunately some hardware device will assert their irq line immediately
> on power on and provide no mechanism to mask the irq. As the i2c muxes
> provide no method to mask irq line this provides a work around by keeping
> the parent irq masked until enough device drivers have loaded to service
> all pending interrupts.
> 
> For example the the ltc1760 assert its SMBALERT irq immediately on power
> on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
> device is registered irq are enabled and fire continuously as the second
> device driver has not yet loaded. Setting this parameter to <1 1> will
> delay the irq being enabled until both devices are ready.
> 
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index f55da88..012b2ef 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -76,6 +76,19 @@ struct chip_desc {
>  	} muxtype;
>  };
>  
> +/*
> + * irq_mask_enable: Provides a mechanism to work around hardware that asserts
> + * their irq immediately on power on. It allows the enabling of the irq to be
> + * delayed until the corresponding bits in the the irq_mask are set thru
> + * irq_unmask.
> + * For example the ltc1760 assert its SMBALERT irq immediately on power on.
> + * With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
> + * device is registered irq are enabled and fire continuously as the second
> + * device driver has not yet loaded. Setting this parameter to 0x3 while
> + * delay the irq being enabled until both devices are ready.
> + * This workaround will not work if two devices share an interrupt on the
> + * same bus segment.

It will also not work if something shares the interrupt with the pca954x mux,
on the parent side of the mux, so to speak. Then that other driver may
potentially enable the irq "behind the back" of the pca954x driver.

> + */
>  struct pca954x {
>  	const struct chip_desc *chip;
>  
> @@ -84,7 +97,9 @@ struct pca954x {
>  	struct i2c_client *client;
>  
>  	struct irq_domain *irq;
> +	unsigned int irq_mask_enable;
>  	unsigned int irq_mask;
> +	bool irq_enabled;
>  	spinlock_t lock;
>  };
>  
> @@ -266,8 +281,10 @@ static void pca954x_irq_mask(struct irq_data *idata)
>  	spin_lock_irqsave(&data->lock, flags);
>  
>  	data->irq_mask &= ~BIT(pos);
> -	if (!data->irq_mask)
> +	if (data->irq_enabled && !data->irq_mask) {
>  		disable_irq(data->client->irq);
> +		data->irq_enabled = false;
> +	}

When irq_mask_enable is non-zero, I think the parent irq should be masked
when the first irq from the set in irq_mask_enable is masked. For symmetry.

Like so (untested):

	if (data->irq_enabled) {
		if (!data->irq_mask ||
			(data->irq_mask & mask_enable) != mask_enable) {
			disable_irq(data->client->irq);
			data->irq_enabled = false;
		}
	}

Hmm, this whole thing is fiddly and while it solves your problem it doesn't
allow for solving the more general problem when there are "problematic"
devices mixed with other devices. At least, I don't see it. And the
limitations we are walking into with tracking number of enables etc suggests
that we are attacking this at the wrong level. Maybe you should try to work
around the hw limitations not in the pca954x driver, but in the irq core?

I.e. have the irq core check, for each irq, for a property that specifies
the depth at which each irq should be unmasked. This new property should
probably be located in the interrupt-controller node? Then the code can
unmask interrupts when the depth hits this mark, instead of always unmasking
the interrupt when the depth changes from zero to one. You are then adding
the workaround at a level where there is enough information to fix the
more general problem. I think?

But, once again, I'm no irq expert and would desperately like a second
opinion on this stuff...

>  
>  	spin_unlock_irqrestore(&data->lock, flags);
>  }
> @@ -275,14 +292,18 @@ static void pca954x_irq_mask(struct irq_data *idata)
>  static void pca954x_irq_unmask(struct irq_data *idata)
>  {
>  	struct pca954x *data = irq_data_get_irq_chip_data(idata);
> +	unsigned int mask_enable = data->irq_mask_enable;
>  	unsigned int pos = idata->hwirq;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&data->lock, flags);
>  
> -	if (!data->irq_mask)
> -		enable_irq(data->client->irq);
>  	data->irq_mask |= BIT(pos);
> +	if (!data->irq_enabled
> +	    && (data->irq_mask & mask_enable) == mask_enable) {

I think the coding standard says that the && should be at the end of the
first line. Didn't checkpatch complain?

Cheers,
peda

> +		enable_irq(data->client->irq);
> +		data->irq_enabled = true;
> +	}
>  
>  	spin_unlock_irqrestore(&data->lock, flags);
>  }
> @@ -305,6 +326,7 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>  {
>  	struct pca954x *data = i2c_mux_priv(muxc);
>  	struct i2c_client *client = data->client;
> +	u32 irq_mask_enable[PCA954X_MAX_NCHANS] = { 0 };
>  	int c, err, irq;
>  
>  	if (!data->chip->has_irq || client->irq <= 0)
> @@ -312,6 +334,9 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>  
>  	spin_lock_init(&data->lock);
>  
> +	of_property_read_u32_array(client->dev.of_node, "nxp,irq-mask-enable",
> +		irq_mask_enable, data->chip->nchans);
> +
>  	data->irq = irq_domain_add_linear(client->dev.of_node,
>  					  data->chip->nchans,
>  					  &irq_domain_simple_ops, data);
> @@ -319,6 +344,8 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>  		return -ENODEV;
>  
>  	for (c = 0; c < data->chip->nchans; c++) {
> +		data->irq_mask_enable |= irq_mask_enable[c] ? BIT(c) : 0;
> +		WARN_ON(irq_mask_enable[c] > 1);
>  		irq = irq_create_mapping(data->irq, c);
>  		irq_set_chip_data(irq, data);
>  		irq_set_chip_and_handler(irq, &pca954x_irq_chip,
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
