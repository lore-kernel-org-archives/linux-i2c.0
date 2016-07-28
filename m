From: Phil Reid <preid@electromag.com.au>
Subject: Re: [RFC PATCH 1/1] i2c: i2c-mux-pca954x: Add interrupt controller
 support.
Date: Thu, 28 Jul 2016 10:44:38 +0800
Message-ID: <4ce345bd-c618-eff8-a68e-632dd99e8239@electromag.com.au>
References: <1469588756-70579-1-git-send-email-preid@electromag.com.au>
 <1469588756-70579-2-git-send-email-preid@electromag.com.au>
 <e96c68d6-7905-7bee-2173-b66d29e9969b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:44901 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758919AbcG1Cop (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Jul 2016 22:44:45 -0400
In-Reply-To: <e96c68d6-7905-7bee-2173-b66d29e9969b@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

G'day Peter,

Thanks for the feedback.
+linux-kernel@vger.kernel.org

On 27/07/2016 13:32, Peter Rosin wrote:
> On 2016-07-27 05:05, Phil Reid wrote:
>> The pca9543 can aggregate multiple interrupts from each i2c bus.
>> However it provides no ability to mask interrupts on each channel.
>> So if one bus is asserting interrupts than it will continuously
>> trigger the interrupts until another driver clears it. As a
>> workaround don't enable interrupts until both irqs have been unmasked.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>  drivers/i2c/muxes/i2c-mux-pca954x.c | 116 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> index 284e342..9ff2540 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> @@ -45,9 +45,14 @@
>>  #include <linux/of.h>
>>  #include <linux/pm.h>
>>  #include <linux/slab.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/interrupt.h>
>
> Please keep the includes sorted.
>
>>  #define PCA954X_MAX_NCHANS 8
>>
>> +#define PCA9543_IRQ_OFFSET 4
>
> PCA9544 and PCA9545 also support interrupts, and they look similar.
> It would be preferable if the changes accommodated the other chips
> supported by the driver. They all look similar, and the irq bits
> looks like they are always in the same place, but I think I would
> like this offset to go into the chip_desc struct all the same.
> At the very least the define should be renamed PCA954X_IRQ_OFFSET.

No problem. I was intending to clean things up for that but the interrupt masking
was raising concerns with the whole patch.

>
>> +
>>  enum pca_type {
>>  	pca_9540,
>>  	pca_9542,
>> @@ -67,6 +72,8 @@ struct pca954x {
>>  	struct i2c_client *client;
>>  	bool idle_reset;
>>  	struct gpio_desc *gpio;
>> +	struct irq_domain *irq_domain;
>> +	unsigned int irq_mask;
>>  };
>>
>>  struct chip_desc {
>> @@ -194,6 +201,110 @@ static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
>>  	return pca954x_reg_write(muxc->parent, client, data->last_chan);
>>  }
>>
>> +static irqreturn_t pca954x_irq_handler(int irq, void *devid)
>> +{
>> +	struct pca954x *data = i2c_mux_priv(devid);
>> +	struct i2c_client *client = data->client;
>> +	int i, ret, child_irq;
>> +	unsigned int nhandled = 0;
>> +
>> +	ret = i2c_smbus_read_byte(client);
>> +	if (ret < 0)
>> +		return IRQ_NONE;
>> +
>> +	for (i = 0; i < 2; i++) {
>
> Please use nchans instead of 2 here.
>
>> +		if (ret & BIT(PCA9543_IRQ_OFFSET+i)) {
>> +			child_irq = irq_find_mapping(data->irq_domain, i);
>> +			handle_nested_irq(child_irq);
>> +			nhandled++;
>> +		}
>> +	}
>> +
>> +	return (nhandled > 0) ? IRQ_HANDLED : IRQ_NONE;
>> +}
>> +
>> +static void pca954x_irq_mask(struct irq_data *idata)
>> +{
>> +	struct i2c_mux_core *muxc = irq_data_get_irq_chip_data(idata);
>> +	struct pca954x *data = i2c_mux_priv(muxc);
>> +	unsigned int pos = idata->hwirq;
>> +
>> +	data->irq_mask &= ~BIT(pos);
>> +	if ((data->irq_mask & 0x3) != 0)
>
> The 0x3 mask should probably also go into struct chip_desc, then a non-
> empty value in this field could be used as trigger for initing the irq
> stuff.
>
>> +		disable_irq(data->client->irq);
>> +}
>> +
>> +static void pca954x_irq_unmask(struct irq_data *idata)
>> +{
>> +	struct i2c_mux_core *muxc = irq_data_get_irq_chip_data(idata);
>> +	struct pca954x *data = i2c_mux_priv(muxc);
>> +	unsigned int pos = idata->hwirq;
>> +
>> +	data->irq_mask |= ~BIT(pos);
>> +	if ((data->irq_mask & 0x3) == 0x3)
>
> This is what you mentioned in the commit message, but I don't get it.
> Please explain further, and also think about how the same problem
> could be handled should there be 4 incoming irq lines as in pca9544
> and pca9545.

Yes this is the tricky point.

Consider this:

Host - pca954x + Dev1
                \ Dev2

In my case devs are ltc1760 that generate SMBALERT's (active low irq) which
are not maskable in the device. There is nothing that can be configured in the
device to prevent them assert an irq.

If just considering them as shared interrupts, ie pca954x is not an irq ctlr, just a wired and.
On boot Dev1 is registered and enable shared irq. If Dev2 is asserting SMBALERT
this results in irq being continuously triggered, trigger Dev1 irq handler which
can't clear the irq because it's being asserted by Dev2.

My system eventually boots but spends alot of time looping in the irq for dev1
until dev2 gets registered.



The same problem occurs with the pca954x driver present, unless I disable the irq
until both slaves have unmasked the irq. This is not a good generic solution as the
system may be used with only one irq active.

It's really a deficiency in the hardware design but I'm not sure I'll get that fixed.
Or I may be missing something obvious to deal with this situation

>
>> +		enable_irq(data->client->irq);
>> +}
>> +
>> +static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct irq_chip pca954x_irq_chip = {
>> +	.name			= "i2c-mux-pca954x",
>> +	.irq_mask = pca954x_irq_mask,
>> +	.irq_unmask = pca954x_irq_unmask,
>> +	.irq_set_type = pca954x_irq_set_type,
>> +};
>> +
>> +static int pca953x_irq_domain_map(struct irq_domain *h, unsigned int irq,
>> +				 irq_hw_number_t hwirq)
>
> This function should be named pca954x_irq_domain_map.
>
>> +{
>> +	struct i2c_mux_core *muxc = h->host_data;
>> +
>> +	irq_set_chip_data(irq, muxc);
>> +	irq_set_chip_and_handler(irq, &pca954x_irq_chip, handle_level_irq);
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops pca953x_irq_domain_ops = {
>
> This constant should be named pca954x_irq_domain_ops.
>
>> +	.map	= pca953x_irq_domain_map,
>> +	.xlate	= irq_domain_xlate_twocell,
>> +};
>> +
>> +static int pca953x_irq_setup(struct i2c_mux_core *muxc)
>
> This function should be named pca954x_irq_setup.
>
>> +{
>> +	struct pca954x *data = i2c_mux_priv(muxc);
>> +	struct i2c_client *client = data->client;
>> +	int i, ret;
>> +	int irq = client->irq;
>> +
>> +	if ((data->type != pca_9543) && (irq != -1))
>> +		return 0;
>
> So here, please use the new irq mask value (0x3) that I proposed
> above, instead of the explicitly check for pca9543.
>
>> +	ret = devm_request_threaded_irq(&client->dev, irq, NULL,
>> +					pca954x_irq_handler,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
>> +					   IRQF_SHARED,
>> +					dev_name(&client->dev), muxc);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to request irq %d %d\n",
>> +			client->irq, ret);
>> +		return ret;
>> +	}
>> +
>> +	disable_irq(irq);
>> +
>> +	data->irq_domain = irq_domain_add_simple(client->dev.of_node,
>> +						 2, 0, &pca953x_irq_domain_ops,
>> +						 muxc);
>> +
>> +	for (i = 0; i < 2; i++)
>
> nchans instead of 2, two instances I guess? I know very little about kernel
> interrupt handling and can't really say anything about if your code interfacing
> the irq subsystem is good to go...

I've add linux-kernel@vger.kernel.org to see if anyone else to offer suggestions.

>
>> +		irq_set_parent(irq_find_mapping(data->irq_domain, i), irq);
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * I2C init/probing/exit functions
>>   */
>> @@ -274,6 +385,10 @@ static int pca954x_probe(struct i2c_client *client,
>>  		}
>>  	}
>>
>> +	ret = pca953x_irq_setup(muxc);
>> +	if (ret)
>> +		goto irq_setup_failed;
>> +
>>  	dev_info(&client->dev,
>>  		 "registered %d multiplexed busses for I2C %s %s\n",
>>  		 num, chips[data->type].muxtype == pca954x_ismux
>> @@ -281,6 +396,7 @@ static int pca954x_probe(struct i2c_client *client,
>>
>>  	return 0;
>>
>> +irq_setup_failed:
>>  virt_reg_failed:
>>  	i2c_mux_del_adapters(muxc);
>>  	return ret;
>>
>



-- 
Regards
Phil Reid
