From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: change the id to let the i2c device work
Date: Fri, 12 Oct 2012 12:57:34 +0800
Message-ID: <5077A33E.4080801@atmel.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com> <20121012044042.GI11726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121012044042.GI11726-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

On 10/12/2012 12:40, Mark Brown wrote:
> On Fri, Oct 12, 2012 at 10:34:18AM +0800, Bo Shen wrote:
>> As the old method will use platform device id, change the id to
>> let the i2c device work
>
> What are "the old method" and new method?  You're not explaining why
> this is needed...

Maybe use the 'legacy method' will be better (I am not sure). Now, the 
Linux kernel is transferring to device tree which doesn't use platform 
device id. So, change the id to let the legacy code work.

May you understand.

>
>>   static struct platform_device at91sam9260_twi_device = {
>>   	.name			= "i2c-gpio",
>> -	.id			= -1,
>> +	.id			= 0,
>>   	.dev.platform_data	= &pdata,
>
> This looks like a regression, if there's only one of a given type of
> device in the system it should have no numeric ID in the display name so
> having -1 is appropriate.
>
