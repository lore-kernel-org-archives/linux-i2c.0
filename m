From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/15] ARM: ux500: CONFIG: Compile in support for leds-gpio
Date: Thu, 10 May 2012 13:25:48 +0200
Message-ID: <CACRpkdaqh7ewHezwTHJ2NRwhVduPi2Ur6N_i8R+_Ynk7HS6pwg@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
	<1336155805-18554-5-git-send-email-lee.jones@linaro.org>
	<CACRpkdbv780oUaDL1-m4kj5iRr5=1U6QhE975Z4gNADoTNk8YA@mail.gmail.com>
	<4FAA45B5.2030000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FAA45B5.2030000-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 9, 2012 at 12:23 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote=
:
> On 09/05/12 09:49, Linus Walleij wrote:
>> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> =A0w=
rote:
>>
>>> Code exists in the mop500 board file (used for HREF and
>>> Snowball) to initialise Snowball's user LED via the
>>> leds-gpio driver. However, the driver isn't currently
>>> built when using the default configuration file. This
>>> patch aims to change that behavior.
>>>
>>> Signed-off-by: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> (...)
>>>
>>> +CONFIG_LEDS_GPIO=3Dy
>>> =A0CONFIG_RTC_CLASS=3Dy
>>> =A0CONFIG_RTC_DRV_AB8500=3Dy
>>> =A0CONFIG_RTC_DRV_PL031=3Dy
>>
>>
>> Why not just edit arch/arm/mach-ux500/Kconfig like this:
>>
>> config MACH_SNOWBALL
>> =A0 =A0 =A0 =A0 bool "U8500 Snowball platform"
>> =A0 =A0 =A0 =A0 select MACH_MOP500
>> + =A0 =A0 =A0 =A0select LEDS_GPIO
>
>
> I can do that. Is it not useful for any of the other platforms?

Thanks and oo, the others have dedicated LED controllers and does not u=
se
GPIO for this.

Yours,
Linus Walleij
