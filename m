From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 0/4] AT91: replace old i2c-at91.c TWI driver
Date: Wed, 12 Sep 2012 09:59:01 +0200
Message-ID: <505040C5.4090703@atmel.com>
References: <cover.1346225321.git.n.voss@weinmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1346225321.git.n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, adrian.yanes-uOixanVlb7U@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/29/2012 09:28 AM, Nikolaus Voss :
> The old driver has two main deficencies:
> i)  No repeated start (Sr) condiction is possible, this makes it unusable
>     e.g. for most SMBus transfers.
> ii) I/O was done with polling/busy waiting what caused over-/underruns
>     even at light system loads and clock speeds.
> 
> The new driver overcomes these deficencies and in addition allows for
> more than one TWI interface.
> 
> A remaining limitation is the fact, that only one repeated start is
> possible (two concatenated messages). This limitation is imposed by
> the hardware. However, this should not be a problem as all common
> i2c-client communication does not rely on more than one repeated start.
> 
> Changes since v11:
> - corrected wrong id_entry on sam9261 twi gpio pdev

Hi Wolfram,

Despite the patch revision written in the subject, it is actually the
real v12 patch series from Nikolaus.
BTW, I suspect that you were not in copy...

In addition to the "Tested-By" tag by Ludovic, you can add my:

Reviewed-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>


> Nikolaus Voss (4):
>   drivers/i2c/busses/i2c-at91.c: remove old polling driver
>   Replace clk_lookup.con_id with clk_lookup.dev_id entries for twi clk
>   drivers/i2c/busses/i2c-at91.c: add new driver
>   G45 TWI: remove open drain setting for twi function gpios
> 
>  arch/arm/mach-at91/at91rm9200.c            |    1 +
>  arch/arm/mach-at91/at91rm9200_devices.c    |    9 +
>  arch/arm/mach-at91/at91sam9260.c           |    1 +
>  arch/arm/mach-at91/at91sam9261.c           |    1 +
>  arch/arm/mach-at91/at91sam9261_devices.c   |    9 +
>  arch/arm/mach-at91/at91sam9263.c           |    1 +
>  arch/arm/mach-at91/at91sam9g45.c           |    2 +
>  arch/arm/mach-at91/at91sam9g45_devices.c   |    6 -
>  arch/arm/mach-at91/at91sam9rl.c            |    2 +
>  arch/arm/mach-at91/at91sam9x5.c            |    3 +
>  arch/arm/mach-at91/include/mach/at91_twi.h |   68 ----
>  drivers/i2c/busses/Kconfig                 |   11 +-
>  drivers/i2c/busses/i2c-at91.c              |  591 ++++++++++++++++++----------
>  13 files changed, 418 insertions(+), 287 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_twi.h
> 


-- 
Nicolas Ferre
