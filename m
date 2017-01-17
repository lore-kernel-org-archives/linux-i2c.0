From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH v4 5/5] i2c: mux: pca954x: Add irq_mask_en to delay
 enabling irqs
Date: Tue, 17 Jan 2017 16:07:26 +0800
Message-ID: <d9c4e6fb-88f5-f6b1-bbcb-291997f0d591@electromag.com.au>
References: <1484536275-75995-1-git-send-email-preid@electromag.com.au>
 <1484536275-75995-6-git-send-email-preid@electromag.com.au>
 <b2e0ba39-2a1b-9c67-082d-d7d043ecc220@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b2e0ba39-2a1b-9c67-082d-d7d043ecc220-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 16/01/2017 20:08, Peter Rosin wrote:

>> @@ -280,9 +294,12 @@ static void pca954x_irq_unmask(struct irq_data *idata)
>>
>>  	spin_lock_irqsave(&data->lock, flags);
>>
>> -	if (!data->irq_mask)
>> +	if (!data->irq_mask_enable && !data->irq_mask)
>>  		enable_irq(data->client->irq);
>>  	data->irq_mask |= BIT(pos);
>> +	if (data->irq_mask_enable &&
>> +		(data->irq_mask & data->irq_mask) == data->irq_mask_enable)
>
> Hmm, I see that some apparently incompetent person :-) already acked this,
> but the (data->irq_mask & data->irq_mask) part doesn't make sense at all.
>
>> +		enable_irq(data->client->irq);
>>
>
> Hmm2, if you have a problematic device (like the ltc1760) on mux segment 0
> and sane devices on other segments I'd be inclined to specify irq-mask-enable
> as 0x1. But then this is possible:
>
> 1. ltc1760 registers its irq
> 2. enable_irq(data->client->irq) is called because irq_mask_enable is "fulfilled"
> 3. a sane irq register an irq on some other segment
> 4. enable_irq(...) is called again (which the code appears to try to avoid)
>
> As I read the code, there will be problems with specifying irq-mask-enable
> whenever there are more than one irq-client on a mux segment.
>
> So, I'm removing my ack until the above is resolved...
>

G'day Peter,

Yes that is obviously wrong.
I think I've got it right this time in v5.
Also implemented your suggest on the array for the dt binding.
But stuck with the bitfield implementation for the moment.
Hopefully that's ok.

-- 
Regards
Phil Reid

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
