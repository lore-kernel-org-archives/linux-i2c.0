From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 09/10] gpio: Add a driver for Cadence I3C GPIO expander
Date: Thu, 26 Apr 2018 10:44:26 +0200
Message-ID: <CACRpkdY_7mi8GPiopZ9Yg4Y0-AV_SriZe=1yN5is6eH6FUm6Qg@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com> <20180330074751.25987-10-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330074751.25987-10-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 30, 2018 at 9:47 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> Add a driver for Cadence I3C GPIO expander.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

This is pretty much OK, and I don't want to raise the bar
even higher for you to get this code into the kernel, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

The following is an observation for future improvement:

> +static int cdns_i3c_gpio_read_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
> +                                 u8 *val)
> +{
> +       struct i3c_priv_xfer xfers[] = {
> +               {
> +                       .len = sizeof(reg),
> +                       .data.out = &reg,
> +               },
> +               {
> +                       .rnw = true,
> +                       .len = sizeof(*val),
> +                       .data.in = val,
> +               },
> +       };
> +
> +       return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> +                                       ARRAY_SIZE(xfers));
> +}
> +
> +static int cdns_i3c_gpio_write_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
> +                                  u8 val)
> +{
> +       struct i3c_priv_xfer xfers[] = {
> +               {
> +                       .len = sizeof(reg),
> +                       .data.out = &reg,
> +               },
> +               {
> +                       .len = sizeof(val),
> +                       .data.out = &val,
> +               },
> +       };
> +
> +       return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> +                                       ARRAY_SIZE(xfers));
> +}

This is starting to resemble
drivers/base/regmap/regmap-i2c.c

Maybe we should very quickly add regmap-i3c.c as this
infrastructre has had a great positive effect on may kernel
subsystems.

> +static int cdns_i3c_gpio_get_direction(struct gpio_chip *g, unsigned offset)
> +{
> +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> +
> +       return gpioc->dir & BIT(offset);

I would:

return !!(gpioc->dir & BIT(offset));

So you clamp it to bit 0.

Yours,
Linus Walleij
