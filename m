From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/12] i2c: pxa: No need to set slave addr for i2c master
 mode reset
Date: Sat, 30 May 2015 00:55:41 +0530
Message-ID: <5568BD35.5020404@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-3-git-send-email-vaibhav.hiremath@linaro.org> <87d21jyyua.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87d21jyyua.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Saturday 30 May 2015 12:51 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index f4ac8c5..d4c798a 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -459,8 +459,10 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>   	writel(I2C_ISR_INIT, _ISR(i2c));
>>   	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>>
>> +#ifdef CONFIG_I2C_PXA_SLAVE
>>   	if (i2c->reg_isar)
>>   		writel(i2c->slave_addr, _ISAR(i2c));
>> +#endif
> I'd rather have :
>    	if (i2c->reg_isar && IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
>    		writel(i2c->slave_addr, _ISAR(i2c));
>

Ok,
Will fix it in next version.

Thanks,
Vaibhav
