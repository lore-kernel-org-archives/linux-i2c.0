From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 1/1] i2c: i2c-mux-pca954x: Add interrupt controller
 support.
Date: Fri, 29 Jul 2016 07:48:32 +0200
Message-ID: <b9f67d9d-6d22-6bc8-16f6-e65ea2e853a0@axentia.se>
References: <1469588756-70579-1-git-send-email-preid@electromag.com.au>
 <1469588756-70579-2-git-send-email-preid@electromag.com.au>
 <e96c68d6-7905-7bee-2173-b66d29e9969b@axentia.se>
 <4ce345bd-c618-eff8-a68e-632dd99e8239@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0123.outbound.protection.outlook.com ([104.47.2.123]:45533
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750752AbcG2Fsn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jul 2016 01:48:43 -0400
In-Reply-To: <4ce345bd-c618-eff8-a68e-632dd99e8239@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016-07-28 04:44, Phil Reid wrote:
> G'day Peter,
> 
> Thanks for the feedback.
> +linux-kernel@vger.kernel.org
> 
> On 27/07/2016 13:32, Peter Rosin wrote:
>> On 2016-07-27 05:05, Phil Reid wrote:
>>> +static void pca954x_irq_mask(struct irq_data *idata)
>>> +{
>>> +	struct i2c_mux_core *muxc = irq_data_get_irq_chip_data(idata);
>>> +	struct pca954x *data = i2c_mux_priv(muxc);
>>> +	unsigned int pos = idata->hwirq;
>>> +
>>> +	data->irq_mask &= ~BIT(pos);
>>> +	if ((data->irq_mask & 0x3) != 0)
>>
>> The 0x3 mask should probably also go into struct chip_desc, then a non-
>> empty value in this field could be used as trigger for initing the irq
>> stuff.

Ok, this comment just shows that I was not getting it. Please ignore it.
Some other (new) thing in chip_desc is needed to trigger irq init for the
chips that have irq support.

>>> +		disable_irq(data->client->irq);
>>> +}
>>> +
>>> +static void pca954x_irq_unmask(struct irq_data *idata)
>>> +{
>>> +	struct i2c_mux_core *muxc = irq_data_get_irq_chip_data(idata);
>>> +	struct pca954x *data = i2c_mux_priv(muxc);
>>> +	unsigned int pos = idata->hwirq;
>>> +
>>> +	data->irq_mask |= ~BIT(pos);
>>> +	if ((data->irq_mask & 0x3) == 0x3)
>>
>> This is what you mentioned in the commit message, but I don't get it.
>> Please explain further, and also think about how the same problem
>> could be handled should there be 4 incoming irq lines as in pca9544
>> and pca9545.
> 
> Yes this is the tricky point.
> 
> Consider this:
> 
> Host - pca954x + Dev1
>                 \ Dev2
> 
> In my case devs are ltc1760 that generate SMBALERT's (active low irq) which
> are not maskable in the device. There is nothing that can be configured in the
> device to prevent them assert an irq.
> 
> If just considering them as shared interrupts, ie pca954x is not an irq ctlr, just a wired and.
> On boot Dev1 is registered and enable shared irq. If Dev2 is asserting SMBALERT
> this results in irq being continuously triggered, trigger Dev1 irq handler which
> can't clear the irq because it's being asserted by Dev2.
> 
> My system eventually boots but spends alot of time looping in the irq for dev1
> until dev2 gets registered.
> 
> 
> 
> The same problem occurs with the pca954x driver present, unless I disable the irq
> until both slaves have unmasked the irq. This is not a good generic solution as the
> system may be used with only one irq active.
> 
> It's really a deficiency in the hardware design but I'm not sure I'll get that fixed.
> Or I may be missing something obvious to deal with this situation

Ok, I think I get the problem, but I too am at a loss and see no elegant solution.
One sad thing about your workaround is that it is not working at all unless there
is an irq user on all mux child segments that unmasks the corresponding irq. Right?

I think the default should be that the driver assumes sane HW, i.e. the irq inputs
are not asserted unless some driver is able to clear them. You can then add an
option to keep irqs disabled when the mask "is wrong". As a bonus, I think this
"is wrong" test should be configurable so that you specify a bitmask of irqs that
all has to be unmasked for the irq to be enabled (and use that instead of the 0x3
in the pca954x_irq_mask/pca954x_irq_unmask functions). That makes the workaround
more flexible.

Cheers,
Peter
