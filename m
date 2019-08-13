From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Tue, 13 Aug 2019 09:08:42 +0200
Message-ID: <CAMuHMdWCm9peP9P5_6KBC63cMHXiC3p1oycb0DvKqEd8G4Nx6g@mail.gmail.com>
References: <20190812235237.21797-1-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812235237.21797-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

On Tue, Aug 13, 2019 at 1:53 AM Max Staudt <max@enpas.org> wrote:
> This is the i2c-icy driver for the ICY board for Amiga computers.
> It connects a PCF8584 I2C controller to the Zorro bus, providing I2C
> connectivity. The original documentation can be found on Aminet:
>
> https://aminet.net/package/docs/hard/icy
>
> IRQ support is currently not implemented, as i2c-algo-pcf is built for
> the ISA bus and a straight implementation of the same stack locks up a
> Zorro machine.
>
> v2: Matched function names to callbacks from i2c-algo-pcf
>     Used z_readb()/z_writeb()
>     Removed BROKEN_ON_SMP in Kconfig
>     Moved LTC2990 to a separate commit
>
> Signed-off-by: Max Staudt <max@enpas.org>

Thanks for the update!

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-icy.c
> @@ -0,0 +1,189 @@

> +       dev_info(&z->dev, "ICY I2C controller at %#x, IRQ not implemented\n",
> +                z->resource.start);

z->resource.start has type phys_addr_t, so you should pas a reference, and
use %pa to print it.
Alternatively, you can print the full resource using %pR.
See Documentation/core-api/printk-formats.rst

> +
> +       return 0;
> +}

The rest looks fine to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
