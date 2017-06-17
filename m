From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: add sc18is600 driver
Date: Sat, 17 Jun 2017 21:13:32 +0300
Message-ID: <CAHp75VexRjTZ+kbrPvD=RWy+_OBSnKAYj1-TX8aO5QgyOsn7nA@mail.gmail.com>
References: <20170613154748.7018-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170613154748.7018-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 13, 2017 at 6:47 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> This adds an I=C2=B2C master driver for SPI -> I=C2=B2C bus bridge chips.
> It currently supports NXP's SC18IS600 and SC18IS601, as well as
> Silicon Labs' CP2120. The driver was only tested on SC18IS600.

> +static void sc18is600_setup_clock_frequency(struct sc18is600dev *dev)
> +{
> +       int reg =3D DIV_ROUND_UP(dev->clock_base, dev->i2c_clock_frequenc=
y);
> +

> +       if (reg < 5)
> +               reg =3D 5;
> +       if (reg > 255)
> +               reg =3D 255;

clamp_t()

> +
> +       dev_dbg(&dev->spi->dev, "i2c clock frequency: %08x", reg);
> +       regmap_write(dev->regmap, SC18IS600_REG_I2C_CLOCK, reg);
> +}

> +static void sc18is600_setup_timeout(struct sc18is600dev *dev,
> +                                   bool enable, int timeout_ms)
> +{
> +       int timeout =3D DIV_ROUND_UP(timeout_ms * dev->chip->timeout_base=
, 10000);
> +       u8 reg;
> +

> +       if (timeout <=3D 0)
> +               timeout =3D 1;
> +       if (timeout > 255)
> +               timeout =3D 255;

Ditto.

> +
> +       reg =3D (timeout & 0x7F) << 1;
> +       reg |=3D (!!enable);

Redundant parens.
Might be one line.

> +
> +       dev_dbg(&dev->spi->dev, "i2c timeout: %08x", reg);
> +       regmap_write(dev->regmap, SC18IS600_REG_I2C_TIMEOUT, reg);
> +}


> +static int sc18is600_xfer(struct i2c_adapter *adapter,
> +                         struct i2c_msg *msgs, int num)
> +{

> +       if (num =3D=3D 1 && read_operations =3D=3D 1)
> +               err =3D sc18is600_read(dev, &msgs[0]);
> +       else if (num =3D=3D 1)
> +               err =3D sc18is600_write(dev, &msgs[0]);
> +       else if (num =3D=3D 2 && read_operations =3D=3D 1)
> +               err =3D sc18is600_read_after_write(dev, &msgs[0], &msgs[1=
]);
> +       else if (num =3D=3D 2)
> +               err =3D sc18is600_write_after_write(dev, &msgs[0], &msgs[=
1]);
> +       else
> +               return -EOPNOTSUPP;

It will look better
if (x =3D=3D 1) {
 if (y)
 else
} else if (x =3D=3D 2) {
 if (y)
 else
}

> +       switch (dev->state) {
> +       case SC18IS600_STAT_OK:
> +               break;
> +       case SC18IS600_STAT_NAK_ADDR:
> +               return -EIO;
> +       case SC18IS600_STAT_NAK_DATA:
> +               return -EREMOTEIO;
> +       case SC18IS600_STAT_SIZE:
> +               return -EINVAL;

> +       case SC18IS600_STAT_TIMEOUT:
> +               return -ETIMEDOUT;
> +       case SC18IS600_STAT_TIMEOUT2:
> +               return -ETIMEDOUT;
> +       case SC18IS600_STAT_BLOCKED:
> +               return -ETIMEDOUT;

You may use
case X:
case Y:
 return Z;

> +       default:
> +       case SC18IS600_STAT_BUSY:
> +               dev_err(&dev->spi->dev, "device hangup detected, reset!")=
;
> +               sc18is600_reset(dev);
> +               return -EAGAIN;
> +       }

> +static int sc18is600_probe(struct spi_device *spi)
> +{
> +       const struct of_device_id *of_id;
> +       struct sc18is600dev *dev;
> +       int err;
> +

> +       of_id =3D of_match_device(sc18is600_of_match, &spi->dev);
> +       if (!of_id)
> +               return -ENODEV;

of_device_get_match_data() ?


> +       dev =3D devm_kzalloc(&spi->dev, sizeof(*dev), GFP_KERNEL);
> +       if (dev =3D=3D NULL)

if (!dev)

...and better to use s600dev or alike to avoid confusion.

> +               return -ENOMEM;

> +       snprintf(dev->adapter.name, sizeof(dev->adapter.name),

> +                "SC18IS600 at SPI %02d device %02d",

Isn't too much for adapter name?
I don't remember if it's part of ABI, in that case it's even worse.

> +                spi->master->bus_num, spi->chip_select);

> +       if (!dev->chip->clock_base) {
> +               dev->clk =3D devm_clk_get(&spi->dev, "clkin");
> +               if (IS_ERR(dev->clk)) {
> +                       err =3D PTR_ERR(dev->clk);
> +                       dev_err(&spi->dev, "could not acquire vdd: %d\n",=
 err);

vdd-> Vdd ?

> +                       return err;
> +               }
> +

> +               clk_prepare_enable(dev->clk);

This might fail.

> +               dev->clock_base =3D clk_get_rate(dev->clk) / 4;

Magic.

> +       } else {
> +               dev->clock_base =3D dev->chip->clock_base;
> +       }

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
