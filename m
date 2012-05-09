From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/15] ARM: ux500: CONFIG: Compile in support for leds-gpio
Date: Wed, 09 May 2012 11:23:49 +0100
Message-ID: <4FAA45B5.2030000@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-5-git-send-email-lee.jones@linaro.org> <CACRpkdbv780oUaDL1-m4kj5iRr5=1U6QhE975Z4gNADoTNk8YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdbv780oUaDL1-m4kj5iRr5=1U6QhE975Z4gNADoTNk8YA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/05/12 09:49, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wrot=
e:
>
>> Code exists in the mop500 board file (used for HREF and
>> Snowball) to initialise Snowball's user LED via the
>> leds-gpio driver. However, the driver isn't currently
>> built when using the default configuration file. This
>> patch aims to change that behavior.
>>
>> Signed-off-by: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> (...)
>> +CONFIG_LEDS_GPIO=3Dy
>>   CONFIG_RTC_CLASS=3Dy
>>   CONFIG_RTC_DRV_AB8500=3Dy
>>   CONFIG_RTC_DRV_PL031=3Dy
>
> Why not just edit arch/arm/mach-ux500/Kconfig like this:
>
> config MACH_SNOWBALL
>          bool "U8500 Snowball platform"
>          select MACH_MOP500
> +        select LEDS_GPIO

I can do that. Is it not useful for any of the other platforms?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
