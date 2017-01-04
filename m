From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH 5/5] i2c: mux: pca954x: Add irq_mask_en to delay enabling
 irqs
Date: Wed, 4 Jan 2017 15:21:14 +0100
Message-ID: <2bc78ee3-be23-40b8-54ca-90bb2cc05a47@axentia.se>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
 <1483522197-38819-6-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483522197-38819-6-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-01-04 10:29, Phil Reid wrote:
> Unfortunately some hardware device will assert their irq line immediately
> on power on and provide no mechanism to mask the irq. As the i2c muxes
> provide no method to mask irq line this provides a work around by keeping
> the parent irq masked until enough device drivers have loaded to service
> all pending interrupts.
> 
> For example the the ltc1760 assert its SMBALERT irq immediately on power
> on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
> device is registered irq are enabled and fire continuously as the second
> device driver has not yet loaded. Setting this parameter to 0x3 while
> delay the irq being enabled until both devices are ready.

I think this also needs a comment in the code, including a description
of the limitations. If the interrupt is shared between two devices on
the same bus, you would have the exact same problem and this workaround
would be no good...

Overall, this series fixes the issues I had with the patch from half
a year ago or so. Thanks!

With nitpicks fixed,
Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

Cheers,
peda

> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index f2dba7c..16269e7 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -83,6 +83,7 @@ struct pca954x {
>  
>  	struct irq_domain *irq;
>  	unsigned int irq_mask;
> +	unsigned int irq_mask_en;

Spell it out: irq_mask_enable

>  };
>  
>  /* Provide specs for the PCA954x types we know about */
> @@ -251,9 +252,12 @@ static void pca954x_irq_unmask(struct irq_data *idata)
>  	struct pca954x *data = irq_data_get_irq_chip_data(idata);
>  	unsigned int pos = idata->hwirq;
>  
> -	if (!data->irq_mask)
> +	if (!data->irq_mask_en && !data->irq_mask)
>  		enable_irq(data->client->irq);
>  	data->irq_mask |= BIT(pos);
> +	if (data->irq_mask_en &&
> +		(data->irq_mask & data->irq_mask) == data->irq_mask_en)
> +		enable_irq(data->client->irq);
>  }
>  
>  static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
> @@ -369,6 +373,9 @@ static int pca954x_probe(struct i2c_client *client,
>  	idle_disconnect_dt = of_node &&
>  		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
>  
> +	of_property_read_u32(of_node, "i2c-mux-irq-mask-en",

"nxp,irq-mask-enable"

> +			     &data->irq_mask_en);
> +
>  	ret = pca953x_irq_setup(muxc);
>  	if (ret)
>  		goto irq_setup_failed;
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
