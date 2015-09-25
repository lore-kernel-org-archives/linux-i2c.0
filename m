From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] watchdog: iTCO_wdt: Fix unmet dependency in select
Date: Fri, 25 Sep 2015 07:45:57 -0700
Message-ID: <56055E25.6060506@roeck-us.net>
References: <20150925101045.06062b59@endymion.delvare>
 <56054C2E.9010703@roeck-us.net> <1443189749.4919.2.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443189749.4919.2.camel-H7Kp9ZFCxt/N0uC3ymp8PA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Fleming <matt.fleming-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 09/25/2015 07:02 AM, Jean Delvare wrote:
> Hi Guenter,
>
> Le Friday 25 September 2015 =C3=A0 06:29 -0700, Guenter Roeck a =C3=A9=
crit :
>> On 09/25/2015 01:10 AM, Jean Delvare wrote:
>>> ITCO_WDT selects I2C_I801 but does not select its dependencies (I2C=
=2E)
>>> This can result in link-time failures:
>>>
>>> drivers/built-in.o: In function `i801_remove':
>>> i2c-i801.c:(.text+0x1a6126): undefined reference to `i2c_del_adapte=
r'
>>> drivers/built-in.o: In function `dmi_check_onboard_devices':
>>> i2c-i801.c:(.text+0x1a7531): undefined reference to `i2c_new_device=
'
>>> drivers/built-in.o: In function `i801_probe':
>>> i2c-i801.c:(.text+0x1a7aa8): undefined reference to `i2c_add_adapte=
r'
>>> i2c-i801.c:(.text+0x1a7e14): undefined reference to `i2c_new_device=
'
>>>
>>> So we must select I2C as well.
>>>
>>> Reported-by: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
>>> Fixes: 2a7a0e9bf7 ("watchdog: iTCO_wdt: Add support for TCO on Inte=
l Sunrisepoint")
>>> Cc: Matt Fleming <matt.fleming-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
>>> ---
>>>    drivers/watchdog/Kconfig |    2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- linux-4.3-rc2.orig/drivers/watchdog/Kconfig	2015-09-24 11:43:29=
=2E959432358 +0200
>>> +++ linux-4.3-rc2/drivers/watchdog/Kconfig	2015-09-25 09:56:20.5188=
40112 +0200
>>> @@ -818,6 +818,7 @@ config ITCO_WDT
>>>    	depends on (X86 || IA64) && PCI
>>>    	select WATCHDOG_CORE
>>>    	select LPC_ICH if !EXPERT
>>> +	select I2C if !EXPERT
>>>    	select I2C_I801 if !EXPERT
>>>    	---help---
>>>    	  Hardware driver for the intel TCO timer based watchdog device=
s.
>>>
>>>
>>
>> I had fixed the problem differently, similar to other drivers.
>>
>> http://patchwork.roeck-us.net/patch/239/
>
> 404 Not Found?
>

Interesting. WFM. Maybe I don't publish it to the outside world.
Here is a different link:

https://lkml.org/lkml/2015/9/11/343

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
