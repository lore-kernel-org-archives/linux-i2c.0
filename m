From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v10 1/6] i2c: designware: Cleaning and comment style
 fixes.
Date: Fri, 9 Jun 2017 08:57:42 +0100
Message-ID: <c6048839-9d16-8f71-809b-82b9ab35390b@synopsys.com>
References: <cover.1496942505.git.lolivei@synopsys.com>
 <4fb5f66dafc24e3213aaa8fc93fa12fecb6d6aa1.1496942505.git.lolivei@synopsys.com>
 <5bc3077b-2e4c-eb27-bca1-b7cbfc2dec01@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5bc3077b-2e4c-eb27-bca1-b7cbfc2dec01-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09-Jun-17 6:12, Peter Rosin wrote:
> On 2017-06-08 19:36, Luis Oliveira wrote:
>> complicated to review. The work here won't bring any additional work to
>> backported fixes because is just style and reordering.
> 
> I challenge that. If there is an old bug that existed before this patch
> that is fixed in the future after this patch has been applied, it might
> very well be hard_er_ to backport that fix to a point before this patch
> has been applied. So, what do you mean?
> 
Yes, that's true. But it will not be that hard since it's mostly style
(comments, format, return variables, misspelled words).
For my humble point of view the code looks better after this patch is applied.
So if It's more easy to read it should be more easy to fix also if needed.

>> @@ -984,12 +984,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>>  	}
>>  
>>  	i2c_dw_disable_int(dev);
>> -	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, irq_flags,
>> +	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, irq_flags,
>>  			     dev_name(dev->dev), dev);
> 
> Two extra spaces needed to align with the opening bracket.
> 
Thank you, you are right.

> Cheers,
> peda
> 

Cheers,
Luis
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
