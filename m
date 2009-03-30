From: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Mon, 30 Mar 2009 12:03:32 +0300
Message-ID: <49D08AE4.1090102@gmail.com>
References: <49C89E13.7040801@gmail.com> <20090324094215.GA3471@pengutronix.de> <49C8ABE5.40408@gmail.com> <20090325092625.GA3029@pengutronix.de> <49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de> <Pine.LNX.4.64.0903282207480.9903@axis700.grange> <d7f267fd0903300048p7caee6e0ne63916b986b132b@mail.gmail.com> <Pine.LNX.4.64.0903301124040.4455@axis700.grange> <20090330095147.GP7861@pengutronix.de> <Pine.LNX.4.64.0903301156060.4455@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0903301156060.4455-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Mon, 30 Mar 2009, Sascha Hauer wrote:
>
>   
>> On Mon, Mar 30, 2009 at 11:26:31AM +0200, Guennadi Liakhovetski wrote:
>>     
>>> Well, I have been able to get your driver to at least pass the 
>>> initialisation with mt9t031 (other parts are missing yet for a complete 
>>> test). For that I used this silly patch:
>>>
>>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>>> index 3296380..46e1033 100644
>>> --- a/drivers/i2c/busses/i2c-imx.c
>>> +++ b/drivers/i2c/busses/i2c-imx.c
>>> @@ -371,6 +371,8 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>>>  	if (result)
>>>  		goto fail0;
>>>  
>>> +	msleep(2);
>>> +
>>>  	/* Start I2C transfer */
>>>  	i2c_imx_start(i2c_imx);
>>>
>>> As you understand, this cannot be the final fix. We have to understand why 
>>> a delay is needed there and how long it actually has to be...
>>>  
>>>       
>> Have you checked the value of disable_delay in Darius' driver or tried to
>> increase it?
>>     
>
> Why? That variable is addreccing a problem on a completely different 
> hardware:
>
> 	/*
> 	 * There dummy delay is calculated.
> 	 * It should be about one I2C clock period long.
> 	 * This delay is used in I2C bus disable function
> 	 * to fix chip hardware bug.
> 	 */
>
> and is used on a different path - during controller disable.
>   

Freescale datasheet don't specifies any timing requirement when 
disabling I2C module.
If I disable it immediately after generating STOP signal, it's not 
generated.
When one clock delay is used, problem is solved. So I guess it is 
hardware bug.
Strange, why your driver works without that.

>   
>> BTW I just realized that the handling of disable_delay in Darius' driver
>> is wrong. This should be a per device variable.
>>     
>
> Indeed.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
>
>   
