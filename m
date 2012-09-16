From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH -next] [media] altera-stapl should depend on HAS_IOPORT
Date: Sun, 16 Sep 2012 21:00:00 +0200
Message-ID: <CAMuHMdXObD5jEKT6BHkZJ6Y-PcW+pD7bO5nkNq0=9V-5e3MNTg@mail.gmail.com>
References: <1347787283-11994-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347787283-11994-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Igor M. Liplianin" <liplianin-SoTE/FI7wRI@public.gmane.org>, Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, user-mode-linux-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 16, 2012 at 11:21 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On s390:
>
> drivers/misc/altera-stapl/altera-lpt.c: In function 'byteblaster_write':
> drivers/misc/altera-stapl/altera-lpt.c:34:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
> drivers/misc/altera-stapl/altera-lpt.c: In function 'byteblaster_read':
> drivers/misc/altera-stapl/altera-lpt.c:40:2: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[6]: *** [drivers/misc/altera-stapl/altera-lpt.o] Error 1
>
> Before commit 3969d54acd70be70e1b2a72184cba5415bf326c2 ("i2c: Make I2C
> available on UML"), this was hidden because I2C depended on HAS_IOMEM, which
> is a superset of HAS_IOPORT.
>
> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Apparently Arnd sent out a patch to fix this while the driver was
still in staging:
http://lkml.indiana.edu/hypermail/linux/kernel/1107.0/00432.html

> --
> http://kisskb.ellerman.id.au/kisskb/buildresult/7194502/
> http://kisskb.ellerman.id.au/kisskb/buildresult/7194476/
> ---
>  drivers/misc/altera-stapl/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/misc/altera-stapl/Kconfig b/drivers/misc/altera-stapl/Kconfig
> index 7f01d8e..c7e4c77 100644
> --- a/drivers/misc/altera-stapl/Kconfig
> +++ b/drivers/misc/altera-stapl/Kconfig
> @@ -2,7 +2,7 @@ comment "Altera FPGA firmware download module"
>
>  config ALTERA_STAPL
>         tristate "Altera FPGA firmware download module"
> -       depends on I2C
> +       depends on I2C && HAS_IOPORT
>         default n
>         help
>           An Altera FPGA module. Say Y when you want to support this tool.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
