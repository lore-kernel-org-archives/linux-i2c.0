From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
	MAX7320-7327 I2C Port Expanders
Date: Fri, 11 Jul 2008 14:25:00 -0700
Message-ID: <200807111425.00961.david-b@pacbell.net>
References: <4875A893.3090402@gmail.com>
	<f17812d70807110239q6c175f5cn70db966681ae387d@mail.gmail.com>
	<f17812d70807110248y7fab3328q59ea41084c491df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807110248y7fab3328q59ea41084c491df-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 11 July 2008, eric miao wrote:
> patch updated:
> =

> >From 18d910f69c5408340661326f1ad1bcbb2c5bc6f6 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Date: Thu, 10 Jul 2008 13:37:59 +0800
> Subject: [PATCH] gpio: max732x: add support for MAX7319, MAX7320-7327
> I2C Port Expanders
> =

> Signed-off-by: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/gpio/Kconfig        |   22 +++
>  drivers/gpio/Makefile       |    1 +
>  drivers/gpio/max732x.c      |  361 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c/max732x.h |   19 +++
>  4 files changed, 403 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpio/max732x.c
>  create mode 100644 include/linux/i2c/max732x.h
> =

> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -61,6 +61,28 @@ config GPIO_PCF857X
>  	  This driver provides an in-kernel interface to those GPIOs using
>  	  platform-neutral GPIO calls.
> =

> +config GPIO_MAX732X
> +	tristate "MAX7319, MAX7320-7327 8/16-bit I2C Port Expanders"

"MAX" should still precede "PCF" in the Kconfig.
As it says:  put drivers in the right section,
and in alphabetical order.


> --- /dev/null
> +++ b/drivers/gpio/max732x.c
> @@ -0,0 +1,361 @@
> ...
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/max732x.h>
> +
> +#include <asm/gpio.h>

For consistency, make that <linux/gpio.h> and put it up above.
I like to see blank lines delineating groups, like <linux/*>
and <linux/i2c/*>, too.


> + * Within each group of ports, there are five known combinations of
> + * I/O ports: 4I4O, 4P4O, 8I, 8P, 8O, see the definitions below for
> + * the detailed organization of these ports.

Quirky little buggers, they are!!


> + * NOTE: MAX7328/MAX7329, however, resembles much closer to PCF8574,
> + * they are not supported by this driver.

In fact the data sheet for those parts says they're second sources
for those PCF chips.  Feel free to submit a patch updating Kconfig
and the pcf857x driver accordingly ... :)


> +static int max732x_gpio_get_value(struct gpio_chip *gc, unsigned off)
> +{
> +	struct max732x_chip *chip;
> +	uint8_t reg_val;
> +	int ret;
> +
> +	chip =3D container_of(gc, struct max732x_chip, gpio_chip);
> +
> +	ret =3D max732x_read(chip, is_group_a(chip, off), &reg_val);
> +	if (ret < 0)
> +		return 0;
> +
> +	return (reg_val & (1u << (off & 0x7))) ? 1 : 0;

Simpler:  "reg_val & (the_mask)".  The values here are
zero/nonzero, not zero/one/undefined.


> +static void max732x_gpio_set_value(struct gpio_chip *gc, unsigned off, i=
nt val)
> +{ =

> +=A0=A0=A0=A0=A0=A0=A0struct max732x_chip *chip;
> +=A0=A0=A0=A0=A0=A0=A0uint8_t reg_out, mask =3D 1u << (off & 0x7);
> +=A0=A0=A0=A0=A0=A0=A0int ret;
> +
> +=A0=A0=A0=A0=A0=A0=A0chip =3D container_of(gc, struct max732x_chip, gpio=
_chip);
> +
> +=A0=A0=A0=A0=A0=A0=A0reg_out =3D (off > 7) ? chip->reg_out[1] : chip->re=
g_out[0];
> +=A0=A0=A0=A0=A0=A0=A0reg_out =3D (val) ? reg_out | mask : reg_out & ~mas=
k;

You should have some kind of locking to protect chip->reg_out[].
Hmm, I notice the pcf857x driver doesn't ... sigh.

I can't quite see a way around a mutex or rwlock.  The set_bit()
clear_bit() calls would atomic, but you need the assignment to be
atomic at the I2C chip, not just on the host side.


> +
> +=A0=A0=A0=A0=A0=A0=A0ret =3D max732x_write(chip, is_group_a(chip, off), =
reg_out);
> +=A0=A0=A0=A0=A0=A0=A0if (ret < 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* update the shadow register then */
> +=A0=A0=A0=A0=A0=A0=A0if (off > 7)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0chip->reg_out[1] =3D reg_ou=
t;
> +=A0=A0=A0=A0=A0=A0=A0else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0chip->reg_out[0] =3D reg_ou=
t;
> +}

Notice how two tasks setting direction for different GPIOs will
both feel free to clobber the cached chip->reg_out[] value ...


> +
> +	if ((mask & chip->dir_input) =3D=3D 0)
> +		pr_warning("%s: port %d is output only\n", __func__, off);

First problem:  if it's an output-only signal, you should return a
negative errno to anyone trying to use it as an input.  (Likewise
for the converse, trying to set an output-only pin as an input.)
EACCES would seem appropriate; it's what open(2) returns when you
try to write a read-only file, and these modes can't be written.

Seocnd:  you shouldn't use pr_*() calls when there's a relevant
driver model node.  Of course, in this case once you properly
return a fault code, this merits at most a dev_dbg() call, since
the caller can be expected to handle such errors somehow.


> +static int __devinit max732x_probe(struct i2c_client *client,
> +				   const struct i2c_device_id *id)
> +{
> +	struct max732x_platform_data *pdata;
> +	struct max732x_chip *chip;
> +	int ret;
> +
> +	pdata =3D client->dev.platform_data;
> +	if (pdata =3D=3D NULL)
> +		return -ENODEV;
> +
> +	chip =3D kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
> +	if (chip =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	chip->client[0] =3D client;
> +
> +	switch (client->addr & 0x70) {
> +	case 0x60:
> +		chip->client[1] =3D i2c_new_dummy(client->adapter,
> +					(client->addr & 0x0f) | 0x50);
> +		chip->client_group_a =3D chip->client[0];
> +		chip->client_group_b =3D chip->client[1];
> +		break;
> +	case 0x50:
> +		chip->client[1] =3D i2c_new_dummy(client->adapter,
> +					(client->addr & 0x0f) | 0x60);
> +		chip->client_group_a =3D chip->client[1];
> +		chip->client_group_b =3D chip->client[0];
> +		break;

Why not just insist the 0x5x address be registered/probed?  This
extra stuff is needless and confusing.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
