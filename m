From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Thu, 04 Dec 2008 09:47:38 +0200
Message-ID: <49378B1A.7030909@gmail.com>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812030917440.4717@axis700.grange> <gh5vf4$e02$1@ger.gmane.org> <Pine.LNX.4.64.0812032158150.7961@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0812032158150.7961-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Wed, 3 Dec 2008, Darius wrote:
>
>   
>> Guennadi Liakhovetski wrote:
>>     
>>>> +
>>>> +static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
>>>> +{
>>>> +	int result;
>>>> +
>>>> +	result = wait_event_interruptible_timeout(i2c_imx->queue,
>>>> +		i2c_imx->i2csr & I2SR_IIF, I2C_IMX_TIME_TRX * HZ);
>>>>         
>>> 5s is much too long!
>>>       
>> how much? 600us?
>>     
>
> mxc uses 1 jiffie.
>
>   
>>>> +	/* write slave address */
>>>> +	writeb(msgs->addr, i2c_imx->base + IMX_I2C_I2DR);
>>>>         
>>> This is wrong! You have to double the address before writing to the
>>> register.
>>>       
>> strange! there are I2c board data in my MXLADS code:
>>
>> struct i2c_board_info __initdata mx1ads_i2c_devices[] = {
>> 	{
>> 		I2C_BOARD_INFO("ov7xxx", 0x42),
>> 		.platform_data = &iclink[0],
>> 	}, {
>> 		I2C_BOARD_INFO("mt9v111", 0x90),
>> 		.platform_data = &iclink[0],
>> 	}
>> }
>>
>> slave addresses are exactly 0x42 and 0x90 (from datasheets).
>> my driver works with these devices with address not doubled.
>> I saw this in other I2C drivers, but If I double address in my driver, it
>> works wrong.
>> I tested this with oscilloscope - now it works ok, with all devices I have
>> tryed.
>>     
>
> As Mark explained - Linux uses i2c addresses without the read/write bit, 
> i.e., shifted one bit right.
>   

This means I should use shifted address in platform data?
For example: OV7670 image sensor has slave address 0x42 for write, and 
0x43 for read operations.
This is hardware slave address, to which device responds.
But I should use 0x21 in platform data, because it must be doubled in 
adapter driver?
If I use original 0x42 address, after doubling it will be 0x108, to 
which device does not respond...

>   
>>>> +module_param(clkfreq, uint, S_IRUGO);
>>>> +MODULE_PARM_DESC(clkfreq, "desired IMX I2C Clock Rate in Hz");
>>>>         
>>> Making clkfreq a module parameter you force the same frequency on all i2c
>>> busses. On my i.MX31 system 2 busses are internal and one goes to a
>>> connector, to which a camera is connected. This third bus can only handle a
>>> lower frequency, which, however, doesn't mean we also have to throttle the
>>> other two busses. Can we put this into platform data?
>>>       
>> We can do that, but now there is possibility to change bitrate when re-loading
>> module.
>> What is better?
>>     
>
> But is it really necessary to be able to override this at load-time? At 
> least not as one single parameter. If you absolutely need this 
> possibility, maybe an array of frequencies? But then you don't know how 
> many busses you are going to have. Having an array of 8 ints will probably 
> be enough for a while:-)
>   

No it's not necessary. I will leave this setting only in platform data 
and default value if platform data is not provided.

>   
>>>> +struct imxi2c_platform_data {
>>>> +	int (*init)(struct device *dev);
>>>> +	int (*exit)(struct device *dev);
>>>>         
>>> What are you going to use .exit() for? Is it really needed? Even if it is,
>>> it can easily return void I guess?
>>>       
>> .init is used to request and setup gpio pins, .exit used to free gpio.
>> yes, .exit can return void - I will fix it.
>>     
>
> You mean in your .init() you not only configure iomux pins for i2c, you 
> also gpio_request(pin_to_gpio(), "i2c")? Now that I think about this, 
> maybe this is indeed correct, and then you gpio_free() in .exit()... Is 
> this what you mean?
>   

yes, you're right.

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
>
>   
