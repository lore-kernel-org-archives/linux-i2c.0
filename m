From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: mux: pca954x: Add interrupt controller
 support
Date: Fri, 13 Jan 2017 23:43:30 +0800
Message-ID: <1284b1c8-bb90-fbd9-53a2-0c36f2597b29@electromag.com.au>
References: <1483952576-5308-1-git-send-email-preid@electromag.com.au>
 <1483952576-5308-4-git-send-email-preid@electromag.com.au>
 <383ee3cb-b452-259f-486f-682ea9526708@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <383ee3cb-b452-259f-486f-682ea9526708-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 13/01/2017 17:11, Peter Rosin wrote:
> On 2017-01-09 10:02, Phil Reid wrote:
>> Various muxes can aggregate multiple interrupts from each i2c bus.
>> All of the muxes with interrupt support combine the active low irq lines
>> using an internal 'and' function and generate a combined active low
>> output. The muxes do provide the ability to read a control register to
>> determine which irq is active. By making the mux an irq controller isr
>> latency can potentially be reduced by reading the status register and
>> then only calling the registered isr on that bus segment.
>>
>> As there is no irq masking on the mux irq are disabled until irq_unmask is
>> called at least once.
>>
>
> I had a second reading of this patch. I'm still no master-of-irqs, though.
> Anyway, I have some questions below. I guess it mostly shows that I don't
> really know what I'm talking about here...
I'm no expert either...

>
>> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
>> ---
>>  drivers/i2c/muxes/i2c-mux-pca954x.c | 127 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 125 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> index bbf088e..84fc767 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> @@ -41,14 +41,19 @@
>>  #include <linux/i2c.h>
>>  #include <linux/i2c-mux.h>
>>  #include <linux/i2c/pca954x.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>>  #include <linux/pm.h>
>>  #include <linux/slab.h>
>>
>>  #define PCA954X_MAX_NCHANS 8
>>
>> +#define PCA954X_IRQ_OFFSET 4
>> +
>>  enum pca_type {
>>  	pca_9540,
>>  	pca_9542,
>> @@ -63,6 +68,7 @@ enum pca_type {
>>  struct chip_desc {
>>  	u8 nchans;
>>  	u8 enable;	/* used for muxes only */
>> +	u8 has_irq;
>>  	enum muxtype {
>>  		pca954x_ismux = 0,
>>  		pca954x_isswi
>> @@ -75,6 +81,9 @@ struct pca954x {
>>  	u8 last_chan;		/* last register value */
>>  	u8 deselect;
>>  	struct i2c_client *client;
>> +
>> +	struct irq_domain *irq;
>> +	unsigned int irq_mask;
>>  };
>>
>>  /* Provide specs for the PCA954x types we know about */
>> @@ -87,19 +96,23 @@ struct pca954x {
>>  	[pca_9542] = {
>>  		.nchans = 2,
>>  		.enable = 0x4,
>> +		.has_irq = 1,
>>  		.muxtype = pca954x_ismux,
>>  	},
>>  	[pca_9543] = {
>>  		.nchans = 2,
>> +		.has_irq = 1,
>>  		.muxtype = pca954x_isswi,
>>  	},
>>  	[pca_9544] = {
>>  		.nchans = 4,
>>  		.enable = 0x4,
>> +		.has_irq = 1,
>>  		.muxtype = pca954x_ismux,
>>  	},
>>  	[pca_9545] = {
>>  		.nchans = 4,
>> +		.has_irq = 1,
>>  		.muxtype = pca954x_isswi,
>>  	},
>>  	[pca_9547] = {
>> @@ -222,6 +235,102 @@ static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
>>  	return pca954x_reg_write(muxc->parent, client, data->last_chan);
>>  }
>>
>> +static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct pca954x *data = dev_id;
>> +	unsigned int child_irq;
>> +	int ret, i, handled;
>> +
>> +	ret = i2c_smbus_read_byte(data->client);
>> +	if (ret < 0)
>> +		return IRQ_NONE;
>> +
>> +	for (i = 0; i < data->chip->nchans; i++) {
>> +		if (ret & BIT(PCA954X_IRQ_OFFSET + i)) {
>> +			child_irq = irq_linear_revmap(data->irq, i);
>> +			handle_nested_irq(child_irq);
>> +			handled++;
>> +		}
>> +	}
>> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>> +}
>> +
>> +static void pca954x_irq_mask(struct irq_data *idata)
>> +{
>> +	struct pca954x *data = irq_data_get_irq_chip_data(idata);
>> +	unsigned int pos = idata->hwirq;
>> +
>> +	data->irq_mask &= ~BIT(pos);
>> +	if (!data->irq_mask)
>> +		disable_irq(data->client->irq);
>> +}
>> +
>> +static void pca954x_irq_unmask(struct irq_data *idata)
>> +{
>> +	struct pca954x *data = irq_data_get_irq_chip_data(idata);
>> +	unsigned int pos = idata->hwirq;
>> +
>> +	if (!data->irq_mask)
>> +		enable_irq(data->client->irq);
>> +	data->irq_mask |= BIT(pos);
>> +}
>
> I assume the irq core makes sure that .irq_mask and .irq_unmask may not
> be called concurrently?
I also wasn't 100% sure about this myself.
Looking again at other drivers and the core irq code I'm still not sure.
But I think on review a lock of some kind is needed.
I think a spin_lock_irqsave would do it.
Will test next week and post a new version.

>
>> +
>> +static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
>> +{
>> +	if ((type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_LOW)
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
>> +static struct irq_chip pca954x_irq_chip = {
>> +	.name = "i2c-mux-pca954x",
>> +	.irq_mask = pca954x_irq_mask,
>> +	.irq_unmask = pca954x_irq_unmask,
>> +	.irq_set_type = pca954x_irq_set_type,
>> +};
>> +
>> +static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>> +{
>> +	struct pca954x *data = i2c_mux_priv(muxc);
>> +	struct i2c_client *client = data->client;
>> +	int c, err, irq;
>> +
>> +	if (!data->chip->has_irq || client->irq <= 0)
>> +		return 0;
>
> I assume "client->irq <= 0" means that users not specifying any interrupts
> continue to behave as they use to, right?
>
> BTW, what does client->irq == 0 represent?

This one I'm fairly confident on. Initially I had "client->irq < 0"
Which caused problems with an i2c mux that doesn't have irq's defined in the dt.

This commit seems to confirm that.
commit dab472eb931b ("i2c / ACPI: Use 0 to indicate that device does not have interrupt assigned")

And various patches converting to "<= 0" checks.
eg:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/364630.html

>
>
>
>> +
>> +	data->irq = irq_domain_add_linear(client->dev.of_node,
>> +					  data->chip->nchans,
>> +					  &irq_domain_simple_ops, data);
>> +	if (!data->irq)
>> +		return -ENODEV;
>> +
>> +	for (c = 0; c < data->chip->nchans; c++) {
>> +		irq = irq_create_mapping(data->irq, c);
>> +		irq_set_chip_data(irq, data);
>> +		irq_set_chip_and_handler(irq, &pca954x_irq_chip,
>> +			handle_simple_irq);
>> +	}
>> +
>> +	err = devm_request_threaded_irq(&client->dev, data->client->irq, NULL,
>> +					pca954x_irq_handler,
>> +					IRQF_ONESHOT | IRQF_SHARED,
>> +					"pca954x", data);
>> +	if (err)
>> +		goto err_req_irq;
>> +
>> +	disable_irq(data->client->irq);
>> +
>> +	return 0;
>> +err_req_irq:
>> +	for (c = 0; c < data->chip->nchans; c++) {
>> +		irq = irq_find_mapping(data->irq, c);
>> +		irq_dispose_mapping(irq);
>> +	}
>> +	irq_domain_remove(data->irq);
>> +
>> +	return err;
>> +}
>> +
>>  /*
>>   * I2C init/probing/exit functions
>>   */
>> @@ -286,6 +395,10 @@ static int pca954x_probe(struct i2c_client *client,
>>  	idle_disconnect_dt = of_node &&
>>  		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
>>
>> +	ret = pca954x_irq_setup(muxc);
>> +	if (ret)
>> +		goto fail_del_adapters;
>> +
>>  	/* Now create an adapter for each channel */
>>  	for (num = 0; num < data->chip->nchans; num++) {
>>  		bool idle_disconnect_pd = false;
>> @@ -311,7 +424,7 @@ static int pca954x_probe(struct i2c_client *client,
>>  			dev_err(&client->dev,
>>  				"failed to register multiplexed adapter"
>>  				" %d as bus %d\n", num, force);
>> -			goto virt_reg_failed;
>> +			goto fail_del_adapters;
>>  		}
>>  	}
>>
>> @@ -322,7 +435,7 @@ static int pca954x_probe(struct i2c_client *client,
>>
>>  	return 0;
>>
>> -virt_reg_failed:
>> +fail_del_adapters:
>>  	i2c_mux_del_adapters(muxc);
>>  	return ret;
>>  }
>> @@ -330,6 +443,16 @@ static int pca954x_probe(struct i2c_client *client,
>>  static int pca954x_remove(struct i2c_client *client)
>>  {
>>  	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
>> +	struct pca954x *data = i2c_mux_priv(muxc);
>> +	int c, irq;
>> +
>> +	if (data->irq) {
>> +		for (c = 0; c < data->chip->nchans; c++) {
>> +			irq = irq_find_mapping(data->irq, c);
>> +			irq_dispose_mapping(irq);
>> +		}
>> +		irq_domain_remove(data->irq);
>> +	}
>>
>>  	i2c_mux_del_adapters(muxc);
>>  	return 0;
>>
>
>
>


-- 
Regards
Phil Reid


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
