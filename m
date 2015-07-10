From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c
 master mode reset
Date: Fri, 10 Jul 2015 18:08:43 +0530
Message-ID: <559FBCD3.4050402@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org> <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org> <20150710081148.GB1528@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150710081148.GB1528@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Friday 10 July 2015 01:41 PM, Wolfram Sang wrote:
> On Tue, Jul 07, 2015 at 12:54:46AM +0530, Vaibhav Hiremath wrote:
>> Normally i2c controller works as master, so slave addr is not needed, or it
>> will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
>> the same i2c address with controller.
>
> Just to make sure: Does it? As I read the code, slave interrupts are
> enabled later only when slave mode is selected? Is that a HW bug? And if
> so, can't the code just be moved into this #ifdef block later?
>

Yes we could, infact I thought about it;
but I would break recommended sequence here.

As per spec, it only says,

The SocC writes this register before it enable TWSI operations.

I decided not to break the existing sequence and just fix the code, as
I do can not validate slave mode of operation functionally. I do not
have slave mode setup with me.

Thanks,
Vaibhav

>>
>> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-pxa.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index f4ac8c5..023e59f 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -459,7 +459,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>   	writel(I2C_ISR_INIT, _ISR(i2c));
>>   	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>>
>> -	if (i2c->reg_isar)
>> +	if (i2c->reg_isar && IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
>>   		writel(i2c->slave_addr, _ISAR(i2c));
>>
>>   	/* set control register values */
>> --
>> 1.9.1
>>
