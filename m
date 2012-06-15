From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
Date: Fri, 15 Jun 2012 12:43:57 +0100
Message-ID: <4FDB1FFD.7040204@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org> <1339428307-3850-10-git-send-email-lee.jones@linaro.org> <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com> <4FD6F0E8.5040606@linaro.org> <CACRpkdYxiT-0x4aetMxB2x8SkB+Mmy8rk8uSzgU_anemSayhMw@mail.gmail.com> <4FD83AAD.2010701@linaro.org> <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw@mail.gmail.com> <4FD88761.9050703@linaro.org> <20120614183636.GB30185@sirena.org.uk> <4FDA341C.8010501@linaro.org> <20120615103233.GA19046@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120615103233.GA19046-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 15/06/12 11:32, Russell King - ARM Linux wrote:
> On Thu, Jun 14, 2012 at 07:57:32PM +0100, Lee Jones wrote:
>> On 14/06/12 19:36, Mark Brown wrote:
>>> On Wed, Jun 13, 2012 at 01:28:17PM +0100, Lee Jones wrote:
>>>
>>>> Device Tree. However, we have just as much control by keeping them
>>>> in separate structs in the C file and selecting the right one usin=
g
>>>> the compatible sting.
>>>
>>> You're not understanding Linus' point.  The compatible string isn't
>>> useful here because properties like the maximum clock rate of the b=
us
>>> depend on the board design, not the silicon.  The controller may be
>>> perfectly happy to run at a given rate but other devices on the bus=
 or
>>> the electrical engineering of the PCB itself may restrict this furt=
her.
>>
>> And you're not understanding mine. ;)
>>
>> You can have multiple compatible strings for a single driver. Which =
one
>> you reference from the Device Tree will dictate which group of setti=
ngs
>> are used, including variation of clock rates.
>
> However, if you list these settings separately, rather than selecting=
 them
> based on a compatible string, it means when other board designs come =
along,
> you don't have to modify the kernel code to provide yet another compa=
tible
> to settings translation in the code - you can keep all that informati=
on
> entirely within DT with no kernel code mods.
>
> I thought that was partly the point of DT...

Right. See my most recent emails on the subject. :)

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
