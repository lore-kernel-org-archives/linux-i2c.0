From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 1/3] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Tue, 20 Aug 2019 11:08:00 +0200
Message-ID: <CAMuHMdU=18qtZi7N8+i9cJbKVL+pOB-wttnRRu_mOcMNymF_3w@mail.gmail.com>
References: <20190819121618.16557-1-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819121618.16557-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 19, 2019 at 2:17 PM Max Staudt <max@enpas.org> wrote:
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
> v5: usleep_range() instead of udelay()
>     Style
>
> v3: Fixed %pa format string
>     Dropped adapter class.
>     Clarified licence.
>     Removed clock parameter.
>
> v2: Matched function names to callbacks from i2c-algo-pcf
>     Used z_readb()/z_writeb()
>     Removed BROKEN_ON_SMP in Kconfig
>     Moved LTC2990 to a separate commit
>
> Signed-off-by: Max Staudt <max@enpas.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-icy.c

> +static int icy_pcf_getpcf(void *data, int ctl)
> +{
> +       struct icy_i2c *i2c = (struct icy_i2c *)data;
> +
> +       u8 __iomem *address = ctl ? i2c->reg_s1 : i2c->reg_s0;
> +       int val = z_readb(address);
> +
> +       return val;

return z_readb(address);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
