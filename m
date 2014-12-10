From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: mach-bcm: Enable I2C support for iProc
Date: Tue, 9 Dec 2014 18:24:48 -0800
Message-ID: <5487AEF0.5010404@broadcom.com>
References: <Ray Jui <rjui@broadcom.com> <1418177893-22094-1-git-send-email-rjui@broadcom.com> <1418177893-22094-4-git-send-email-rjui@broadcom.com> <5487ADE5.4070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5487ADE5.4070705-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 12/9/2014 6:20 PM, Florian Fainelli wrote:
> On 09/12/14 18:18, Ray Jui wrote:
>> Enable I2C driver support for Broadcom iProc family of SoCs by
>> selecting I2C_BCM_IPROC
>>
>> Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>   arch/arm/mach-bcm/Kconfig |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index aaeec78..86ee90b 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
>>   	select ARCH_REQUIRE_GPIOLIB
>>   	select ARM_AMBA
>>   	select PINCTRL
>> +	select I2C_BCM_IPROC
>
> One way to avoid having to modify mach-bcm/Kconfig would be to have your
> i2c driver Kconfig do this:
>
> default ARCH_BCM_IPROC
>
> would that work?
>
Yes. So in which case it is better to select a driver from the 
architecture specific Kconfig?

>>   	help
>>   	  This enables support for systems based on Broadcom IPROC architected SoCs.
>>   	  The IPROC complex contains one or more ARM CPUs along with common
>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
