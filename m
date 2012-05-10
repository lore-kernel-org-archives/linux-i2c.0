From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core driver
Date: Thu, 10 May 2012 14:27:45 +0200
Message-ID: <CACRpkdaiGUoK+TaPaObBbTQH0BgPFXr2F2PTHO5GsUE0Prc32w@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
	<1336155805-18554-12-git-send-email-lee.jones@linaro.org>
	<CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
	<20120510102657.GD3190@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120510102657.GD3190-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Mattias WALLIN <mattias.wallin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 10, 2012 at 12:26 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Wed, May 09, 2012 at 11:02:27AM +0200, Linus Walleij wrote:

>> Shouldn't this be (av8500->irq_base =3D=3D NO_IRQ) now that we're tr=
anisitioning to
>> use 0 as NO_IRQ?
>
> No it shouldn't. =A0We want new drivers to be rejecting on explicitly=
 zero
> IRQ numbers and not using NO_IRQ at all. =A0We want to get rid of NO_=
IRQ
> entirely.

Yes of course, it's strange how I can go astray sometimes ..
(!av8500->irq_base) it is.

Thanks Russell,
Linus Walleij
