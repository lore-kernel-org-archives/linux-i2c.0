From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/4] i2c/busses/i2c-icy: Add LTC2990 present on 2019
 board revision
Date: Tue, 13 Aug 2019 09:03:10 +0200
Message-ID: <CAMuHMdX3NtKwxb6BJzJR1qLs5vC9zhU3d+cdrrHx4B9r1opkvQ@mail.gmail.com>
References: <20190812235237.21797-1-max@enpas.org> <20190812235237.21797-2-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812235237.21797-2-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

On Tue, Aug 13, 2019 at 1:53 AM Max Staudt <max@enpas.org> wrote:
> Since the 2019 a1k.org community re-print of these PCBs sports an
> LTC2990 hwmon chip as an example use case, let this driver autoprobe
> for that as well. If it is present, modprobing ltc2990 is sufficient.
>
> Signed-off-by: Max Staudt <max@enpas.org>

Thanks for your patch!

> --- a/drivers/i2c/busses/i2c-icy.c
> +++ b/drivers/i2c/busses/i2c-icy.c
> @@ -160,6 +180,8 @@ static void icy_remove(struct zorro_dev *z)
>  {
>         struct icy_i2c *i2c = dev_get_drvdata(&z->dev);
>
> +       i2c_unregister_device(i2c->client_ltc2990);

Is this needed?
In my understanding, i2c_del_adapter() below takes care of that.

Apart from that, this looks good to me.

> +
>         i2c_del_adapter(&i2c->adapter);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
