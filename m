From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Mon, 12 Aug 2019 11:37:15 +0200
Message-ID: <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
References: <20190811043253.24938-1-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190811043253.24938-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

Thanks for your patch!

On Sun, Aug 11, 2019 at 6:33 AM Max Staudt <max@enpas.org> wrote:
> This is the i2c-icy driver for the ICY board for Amiga computers.
> It connects a PCF8584 I2C controller to the Zorro bus, providing I2C
> connectivity. The original documentation can be found on Aminet:
>
> https://aminet.net/package/docs/hard/icy
>
> Since the 2019 a1k.org community re-print of these PCBs sports an
> LTC2990 hwmon chip as an example use case, this driver autoprobes for
> that as well. If it is present, modprobing ltc2990 is sufficient.

What about the RTC? The schematics show both a ds1620 and pcf8583.

> IRQ support is currently not implemented, as i2c-algo-pcf is built for
> the ISA bus and a straight implementation of the same stack locks up a
> Zorro machine.
>
> Tested-by: Max Staudt <max@enpas.org>

This tag is usually implied for a driver author ;-)

> Signed-off-by: Max Staudt <max@enpas.org>

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-icy.c

> +/*
> + * Functions called by i2c-algo-pcf
> + */
> +static void icy_pcf_setbyte(void *data, int ctl, int val)

icy_pcf_setpcf(), to match the callback name?

> +{
> +       struct icy_i2c *i2c = (struct icy_i2c *)data;
> +
> +       u8 __iomem *address = ctl ? i2c->reg_s1 : i2c->reg_s0;
> +
> +       iowrite8(val, address);

As this is on a Zorro bus, z_writeb()?

> +}
> +
> +static int icy_pcf_getbyte(void *data, int ctl)

icy_pcf_getpcf(), to match the callback name?


> +{
> +       struct icy_i2c *i2c = (struct icy_i2c *)data;
> +
> +       u8 __iomem *address = ctl ? i2c->reg_s1 : i2c->reg_s0;
> +       int val = ioread8(address);

z_readb()

> +
> +       return val;
> +}

> +static int icy_probe(struct zorro_dev *z,
> +                        const struct zorro_device_id *ent)
> +{
> +       struct icy_i2c *i2c;
> +       struct i2c_algo_pcf_data *algo_data;
> +
> +
> +       i2c = devm_kzalloc(&z->dev, sizeof(*i2c), GFP_KERNEL);
> +       if (!i2c)
> +               return -ENOMEM;
> +
> +       algo_data = devm_kzalloc(&z->dev, sizeof(*algo_data), GFP_KERNEL);
> +       if (!algo_data)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(&z->dev, i2c);
> +       i2c->adapter.dev.parent = &z->dev;
> +       i2c->adapter.owner = THIS_MODULE;
> +       i2c->adapter.class = I2C_CLASS_DEPRECATED;
> +       /* i2c->adapter.algo assigned by i2c_pcf_add_bus() */
> +       i2c->adapter.algo_data = algo_data;
> +       strlcpy(i2c->adapter.name, "ICY I2C Zorro adapter",
> +               sizeof(i2c->adapter.name));
> +
> +       if (!devm_request_mem_region(&z->dev,
> +                                    z->resource.start,
> +                                    4, i2c->adapter.name))

zorro_request_device()?
Ah, there's no devm_*() variant yet. OK.

> +               return -ENXIO;
> +
> +       /* Driver private data */
> +       i2c->reg_s0 = ZTWO_VADDR(z->resource.start);
> +       i2c->reg_s1 = ZTWO_VADDR(z->resource.start + 2);
> +
> +       algo_data->data = (void *)i2c;
> +       algo_data->setpcf     = icy_pcf_setbyte;
> +       algo_data->getpcf     = icy_pcf_getbyte;
> +       algo_data->getown     = icy_pcf_getown;
> +       algo_data->getclock   = icy_pcf_getclock;
> +       algo_data->waitforpin = icy_pcf_waitforpin;
> +
> +       if (i2c_pcf_add_bus(&i2c->adapter)) {
> +               dev_err(&z->dev, "i2c_pcf_add_bus() failed\n");
> +               return -ENXIO;
> +       }
> +
> +       dev_info(&z->dev, "ICY I2C controller at %#x, IRQ not implemented\n",
> +                z->resource.start);
> +
> +       /*
> +        * The 2019 a1k.org PCBs have an LTC2990 at 0x4c, so start
> +        * it automatically once ltc2990 is modprobed.
> +        *
> +        * in0 is the voltage of the internal 5V power supply.
> +        * temp1 is the temperature inside the chip.
> +        *
> +        * Configuration 0x18 enables all sensors on this PCB:
> +        *  # modprobe i2c-dev
> +        *  # i2cset 0 0x4c 1 0x18

What's the reason for the i2cset command?

> +        *  # modprobe ltc2990
> +        * in1 will be the voltage of the 5V rail, divided by 2.
> +        * in2 will be the voltage of the 12V rail, divided by 4.
> +        * temp3 will be measured using a PCB loop next the chip.
> +        */
> +       i2c->client_ltc2990 = i2c_new_probed_device(&i2c->adapter,
> +                                                   &icy_ltc2990_info,
> +                                                   icy_ltc2990_addresses,
> +                                                   NULL);
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
