From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/12] i2c: pxa: Add support for pxa910/988 & new configuration
 features
Date: Sat, 30 May 2015 02:03:29 +0530
Message-ID: <5568CD19.6070202@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org> <874mmvyvzw.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874mmvyvzw.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Saturday 30 May 2015 01:52 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
>> @@ -167,6 +184,8 @@ struct pxa_i2c {
>>   #define _ICR(i2c)	((i2c)->reg_icr)
>>   #define _ISR(i2c)	((i2c)->reg_isr)
>>   #define _ISAR(i2c)	((i2c)->reg_isar)
>> +#define _ILCR(i2c)	((i2c)->reg_ilcr)
>> +#define _IWCR(i2c)	((i2c)->reg_iwcr)
>>
>>   /*
>>    * I2C Slave mode address
>> @@ -467,11 +486,16 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>   	if (i2c->reg_isar)
>>   		writel(i2c->slave_addr, _ISAR(i2c));
>>   #endif
>> -
> Not in this patch.

my bad, missed it.
Will fix it in next version.

>
>>   	/* set control register values */
>>   	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
>>   	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
>>
>> +	if (i2c->ilcr)
>> +		writel(i2c->ilcr, _ILCR(i2c));
>> +	if (i2c->iwcr)
>> +		writel(i2c->iwcr, _IWCR(i2c));
>> +	udelay(2);
> This is a magical 2us. Where does it come from ?
>

I am afraid it is random number picked, required since we are
configuring mode/speed related bit-fields.

Thanks,
Vaibhav
