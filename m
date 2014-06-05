From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is enabled
Date: Thu, 05 Jun 2014 12:11:21 +0800
Message-ID: <538FEDE9.4010603@linaro.org>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org> <1401883796-17841-2-git-send-email-lee.jones@linaro.org> <3061297.feg5DGUjIt@vostro.rjw.lan> <20140604125137.GA18171@lee--X1> <1AE640813FDE7649BE1B193DEA596E880262042C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880262042C-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2014-6-5 9:14, Zheng, Lv wrote:
> Hi, Lee
> 
>> From: Lee Jones [mailto:lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org]
>> Sent: Wednesday, June 04, 2014 8:52 PM
>> To: Rafael J. Wysocki
>>
>> On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
>>
>>> On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
>>>> Any drivers which support ACPI and Device Tree probing need to include
>>>> both respective header files.  Without this patch, if a driver is being
>>>> used on a platform which does not support ACPI and subsequently does not
>>>> have the config option enabled, but includes linux/acpi.h the build
>>>> breaks with:
>>>>
>>>>   In file included from ../include/acpi/platform/acenv.h:150:0,
>>>>                    from ../include/acpi/acpi.h:56,
>>>>                    from ../include/linux/match.h:2,
>>>>                    from ../drivers/i2c/i2c-core.c:43:
>>>>   ../include/acpi/platform/aclinux.h:73:23:
>>>>    fatal error: asm/acenv.h: No such file or directory
>>>>    #include <asm/acenv.h>
>>>>                        ^
> 
> Note that:
> In our tree:
> <asm/acenv.h> is only included by <acpi/acpi.h>.
> And <acpi/acpi.h> is only included by
> 1. <linux/acpi.h> when CONFIG_ACPI enabled
> 2. <linux/sfi_acpi.h> - this is x86 specific, we'll clean it up by implementing stubs for all ACPI external interfaces.
> So there is no case we need to exclude <asm/acenv.h> when CONFIG_ACPI is not enabled.
> 
> I cannot find linux/match.h here.
> If <linux/match.h> want to include ACPI features, it shouldn't include <acpi/acpi.h>, but should include <linux/acpi.h>.
> Please refer to:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8b48463f
> And stop including <acpi/acpi.h> directly in any cases.

Ah, I agree, please ignore my previous email,
sorry for the noise.

Since it is very important to include <linux/acpi.h> but not <acpi/acpi.h>,
can we document it somewhere as the guidance? Then people will not
make such mistake :)

Thanks
Hanjun
