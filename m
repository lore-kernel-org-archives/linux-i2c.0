From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
	support to the pca9539 GPIO driver
Date: Wed, 30 Jan 2008 20:52:03 -0800
Message-ID: <200801302052.04336.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<Pine.LNX.4.64.0801301732550.6547@axis700.grange>
	<f17812d70801301731n62597f12kc151d01c320e3dec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70801301731n62597f12kc151d01c320e3dec-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 30 January 2008, eric miao wrote:
> I like this patch, overall looks ok. See my comments below.

I basically like it, but I'd still like to see some changes.  :)

I'd split this patch into two parts (feature addition, and renaming),
and use simpler chip type handling.  Re that latter, in 2.6.26 there
will be an i2c_device_id struct:

  struct i2c_device_id {
        char name[I2C_NAME_SIZE];
        kernel_ulong_t driver_data;=A0=A0=A0=A0=A0/* Data private to the dr=
iver */
  };

A little planning done now will make it easy to use that scheme.
First, don't add a type field to the platform_data; that's what
the i2c_client.name is for.  Then just map those strings to the
number of GPIOs (eventually just use driver_data), and everything
else follows from there.


> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -27,15 +27,15 @@ config DEBUG_GPIO
> >
> >  comment "I2C GPIO expanders:"
> >
> > -config GPIO_PCA9539
> > -       tristate "PCA9539 16-bit I/O port"
> > +config GPIO_PCA953X
> > +       tristate "PCA953X I/O port"

"Ports"

> >         depends on I2C
> >         help
> > -         Say yes here to support the PCA9539 16-bit I/O port. These
> > -         parts are made by NXP and TI.
> > +         Say yes here to support PCA9539 16-bit and PCA9536 4-bit I/O =
ports.

This should IMO list the '38 (8-bit) and '37 (4-bit) parts too.
Same register layout as the '36 (4-bit).  Otherwise the "x" seems
misleading...


> > diff --git a/drivers/gpio/pca9539.c b/drivers/gpio/pca953x.c
> > similarity index 67%
> > rename from drivers/gpio/pca9539.c
> > rename to drivers/gpio/pca953x.c

I'd prefer to see the new feature and the renaming be separate patches.


> > -#define NR_PCA9539_GPIOS       16
> > +struct pca953x_desc {
> > +       unsigned int gpios;
> > +       unsigned int input;
> > +       unsigned int output;
> > +       unsigned int invert;
> > +       unsigned int direction;
> > +};
> =

> I guess the register address can be inferred either from the number
> of GPIOs or a single member field of "shift" may be sufficient.

Yes, inferring that would be simpler.  The number of GPIOs is a
function of the particular chip, and register offsets are 0/1/2/3
except for the 16-GPIO part where they're twice that.

What I'd do is save those four offsets directly in pca953x_chip,
initialized near when gpio_chip.ngpio is set up and with no need
for a separate "desc" type or table.  Eventually there'd be:

	struct i2c_device_id chips [] =3D {
		{ "pca9536", 4, },
		{ "pca9537", 4, },
		{ "pca9538", 8, },
		{ "pca9539", 16, },
	};
	MODULE_DEVICE_TABLE(i2c, chips);

Meanwhile, the equivalent of that table can come from a few strcmp()
tests in the probe() logic -- like what you already have, except
not using a "desc" type.


> > -static int pca9539_init_gpio(struct pca9539_chip *chip)
> > +static int pca953x_init_gpio(struct pca953x_chip *chip)
> >  {
> >         struct gpio_chip *gc;
> >
> >         gc =3D &chip->gpio_chip;
> >
> > -       gc->direction_input  =3D pca9539_gpio_direction_input;
> > -       gc->direction_output =3D pca9539_gpio_direction_output;
> > -       gc->get =3D pca9539_gpio_get_value;
> > -       gc->set =3D pca9539_gpio_set_value;
> > +       gc->direction_input  =3D pca953x_gpio_direction_input;
> > +       gc->direction_output =3D pca953x_gpio_direction_output;
> > +       gc->get =3D pca953x_gpio_get_value;
> > +       gc->set =3D pca953x_gpio_set_value;
> >
> >         gc->base =3D chip->gpio_start;
> > -       gc->ngpio =3D NR_PCA9539_GPIOS;
> > -       gc->label =3D "pca9539";
> > +       gc->ngpio =3D chip->desc->gpios;

I'd expect "desc" to vanish, and ngpio to be an input to this function
(see below).  Then ngpio could be used to choose the values to stuff
into chip->{input,output,invert,direction} register offsets.


> > +       gc->label =3D "pca953x";

Why not just set gc->label to be chip->client->name?

Might as well have /sys/kernel/debug/gpio output be
that little bit more useful.  And save the space that
would otherwise be wasted by that string.  :)


> >
> >         return gpiochip_add(gc);
> >  }
> >
> > -static int __devinit pca9539_probe(struct i2c_client *client)
> > +static int __devinit pca953x_probe(struct i2c_client *client)
> >  {
> > -       struct pca9539_platform_data *pdata;
> > -       struct pca9539_chip *chip;
> > +       struct pca953x_platform_data *pdata;
> > +       struct pca953x_chip *chip;
> >         int ret;
> > +       int variant;
> >
> >         pdata =3D client->dev.platform_data;
> >         if (pdata =3D=3D NULL)
> >                 return -ENODEV;
> >
> > -       chip =3D kzalloc(sizeof(struct pca9539_chip), GFP_KERNEL);
> > +       if (!strcmp("pca9539", pdata->name))

Use client->name instead; there's no need to change pdata.


> > +               variant =3D PCA9539;
> > +       else if (!strcmp("pca9536", pdata->name))
> > +               variant =3D PCA9536;
> > +       else
> > +               return -ENODEV;
> > +
> =

> I prefer integer here more than string, for simplicity and efficiency.

Actually I'd use strings right now, and not change pdata at all.  But
compare client->name, using that to figure out how many GPIOs.

When, later, an i2c_device_id is passed in, the driver can get the
number of GPIOs handed to it directly ... and won't need to worry
about that ENODEV case.



> > --- a/include/asm-generic/gpio.h
> > +++ b/include/asm-generic/gpio.h
> > @@ -16,6 +16,10 @@
> >  #define ARCH_NR_GPIOS          256
> >  #endif
> >
> > +#ifndef NO_GPIO
> > +#define NO_GPIO                        ((unsigned int)-1)
> > +#endif
> > +
> =

> I don't understand this.

Me either; *ANY* negative number is invalid as a GPIO number,
not just "-1"...


> > --- a/include/linux/i2c/pca9539.h
> > +++ b/include/linux/i2c/pca953x.h
> > @@ -1,9 +1,12 @@
> > -/* platform data for the PCA9539 16-bit I/O expander driver */
> > +/* platform data for the PCA953x I/O expander driver */
> >
> > -struct pca9539_platform_data {
> > +struct pca953x_platform_data {
> >         /* number of the first GPIO */
> >         unsigned        gpio_base;
> >
> > +       /* chip variant. Currently supported "pca9536" and "pca9539" */
> > +       const char      *name;
> > +

That's not needed; i2c_client.name should identify the chip.

> >         /* initial polarity inversion setting */
> >         uint16_t        invert;
> >
> > =


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
