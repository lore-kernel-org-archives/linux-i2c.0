From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/15] ARM: ux500: PRCMU related configuration and layout
 corrections for Device Tree
Date: Wed, 09 May 2012 11:27:39 +0100
Message-ID: <4FAA469B.2030200@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-9-git-send-email-lee.jones@linaro.org> <CACRpkdanU4eWhRobxzBV1mcU5T6QLCrWfBAczRFtn6gguhRNng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdanU4eWhRobxzBV1mcU5T6QLCrWfBAczRFtn6gguhRNng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/05/12 09:53, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wrot=
e:
>
>> Apply db8500 related PRCMU Device Tree settings and clean up some fo=
rmatting
>> errors. We also remove one of the PRCMU assigned IRQs, as it is curr=
ently not
>> used.
>>
>> Signed-off-by: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> (...)
>> -                       interrupts =3D<46 47>;
>> +                       interrupts =3D<0 47 0x4>;
>
> Sorry I don't get it, why is two values in decimal and one in hex?
>
> Please choose one and stick to it...

Because the one on the end is a mask.

<[PPI|SPI] [IRQ Number] [Configuration mask]>


--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
