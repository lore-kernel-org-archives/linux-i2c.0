From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/3] i2c: davinci: Add PM Runtime Support
Date: Tue, 22 Aug 2017 10:52:39 +0530
Message-ID: <bd204f3b-8bfd-9015-18cc-dd915c88b812@ti.com>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-3-fcooper@ti.com>
 <8207a684-f010-ca82-baae-db06665f098e@ti.com>
 <d06ef5c6-6501-eca6-2fa2-976d085091b2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d06ef5c6-6501-eca6-2fa2-976d085091b2-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 22 August 2017 06:47 AM, Franklin S Cooper Jr wrote:
> 
> 
> On 08/21/2017 04:05 AM, Sekhar Nori wrote:
>> On Thursday 17 August 2017 03:47 AM, Franklin S Cooper Jr wrote:
>>
>>> @@ -802,7 +821,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
>>>  	if (IS_ERR(dev->clk))
>>>  		return PTR_ERR(dev->clk);
>>> -	clk_prepare_enable(dev->clk);
>>>  
>>>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>  	dev->base = devm_ioremap_resource(&pdev->dev, mem);
>>> @@ -811,6 +829,18 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>>  		goto err_unuse_clocks;
>>
>> This goto is wrong now. There is no need to unwind the pm_runtime setup
>> on a devm_ioremap_resource() failure. You can just return error here.
> 
> Ok
>>
>>>  	}
>>>  
>>> +	pm_runtime_set_autosuspend_delay(dev->dev,
>>> +					 DAVINCI_I2C_PM_TIMEOUT);
>>> +	pm_runtime_use_autosuspend(dev->dev);
>>> +
>>> +	pm_runtime_enable(dev->dev);
>>> +
>>> +	r = pm_runtime_get_sync(dev->dev);
>>> +	if (r < 0) {
>>> +		dev_err(dev->dev, "failed to runtime_get device: %d\n", r);
>>> +		goto err_unuse_clocks;
>>> +	}
>>> +
>>>  	i2c_davinci_init(dev);
>>>  
>>>  	r = devm_request_irq(&pdev->dev, dev->irq, i2c_davinci_isr, 0,
>>> @@ -849,10 +879,16 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>>  	if (r)
>>>  		goto err_unuse_clocks;
>>>  
>>> +	pm_runtime_mark_last_busy(dev->dev);
>>> +	pm_runtime_put_autosuspend(dev->dev);
>>> +
>>>  	return 0;
>>>  
>>>  err_unuse_clocks:
>>> -	clk_disable_unprepare(dev->clk);
>>> +	pm_runtime_dont_use_autosuspend(dev->dev);
>>> +	pm_runtime_put_sync(dev->dev);
>>> +	pm_runtime_disable(dev->dev);
>>> +
>>>  	dev->clk = NULL;
>>
>> This null setting of clk seems quite bogus and can be cleaned-up.
> 
> Do you mean that I should just remove this line?

Yes, and I noticed a similar line in at least one more place that can be
removed as well.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
