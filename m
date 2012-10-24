From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
Date: Wed, 24 Oct 2012 10:37:57 +0200
Message-ID: <5087A8E5.8050103@free-electrons.com>
References: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com><1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com> <87liexrmoz.fsf@thor.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87liexrmoz.fsf-1Ae4nN3xCbAluPl5bxqUMw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Le 23/10/2012 21:51, Peter Korsgaard a =E9crit :
>>>>>> "MR" =3D=3D Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wri=
tes:
>=20
> Hi Maxime,
>=20
> I'm fine with the idea, but a few comments:
>=20
>=20
> MR> Allow the i2c-mux-gpio to be used by a device tree enabled device=
=2E The
> MR> bindings are inspired by the one found in the i2c-mux-pinctrl dri=
ver.
>=20
> MR> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> MR> ---
> MR>  .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 ++++++=
++++
> MR>  drivers/i2c/muxes/i2c-mux-gpio.c                   |  169 ++++++=
+++++++++-----
> MR>  2 files changed, 211 insertions(+), 39 deletions(-)
> MR>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux=
-gpio.txt
>=20
> MR> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.t=
xt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
> MR> new file mode 100644
> MR> index 0000000..335fc4e
> MR> --- /dev/null
> MR> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
> MR> @@ -0,0 +1,81 @@
> MR> +GPIO-based I2C Bus Mux
> MR> +
> MR> +This binding describes an I2C bus multiplexer that uses GPIOs to
> MR> +route the I2C signals.
> MR> +
> MR> +                                  +-----+  +-----+
> MR> +                                  | dev |  | dev |
> MR> +    +------------+                +-----+  +-----+
> MR> +    | SoC        |                   |        |
> MR> +    |            |          /--------+--------+
> MR> +    |   +------+ |  +------+    child bus A, on GPIO value set t=
o 0
> MR> +    |   | I2C  |-|--| Mux  |
> MR> +    |   +------+ |  +--+---+    child bus B, on GPIO value set t=
o 1
> MR> +    |            |     |    \----------+--------+--------+
> MR> +    |   +------+ |     |               |        |        |
> MR> +    |   | GPIO |-|-----+            +-----+  +-----+  +-----+
> MR> +    |   +------+ |                  | dev |  | dev |  | dev |
> MR> +    +------------+                  +-----+  +-----+  +-----+
> MR> +
> MR> +Required properties:
> MR> +- compatible: i2c-mux-gpio
> MR> +- i2c-parent: The phandle of the I2C bus that this multiplexer's=
 master-side
> MR> +  port is connected to.
> MR> +- mux-gpios: list of gpios to use to control the muxer
>=20
> s/to use to/used to/
>=20
>=20
> MR> +* Standard I2C mux properties. See mux.txt in this directory.
> MR> +* I2C child bus nodes. See mux.txt in this directory.
> MR> +
> MR> +Optional properties:
> MR> +- idle-state: value to set to the muxer when idle. When no value=
 is
>=20
> How about 'bitmask defining mux state when idle' instead?

Since the array documented as using the bitmasks in the platform_data
and described as an array of bitmasks is called "values", and the file
mux.txt talks about "numbers" to put into reg, won't this be confusing
to have three names for the exact same thing?

> MR> +  given, it defaults to the last value used.
> MR> +
> MR> +For each i2c child node, an I2C child bus will be created. They =
will
> MR> +be numbered based on the reg property of each node.
>=20
> As far as I can see they are dynamically assigned numbers in the orde=
r
> they are listed in the dt.

Ah, yes.

> MR> +
> MR> +Whenever an access is made to a device on a child bus, the value=
 set
> MR> +in the revelant node's reg property will be output using the lis=
t of
> MR> +GPIOs, the first in the list holding the most-significant value.
>=20
> Isn't it the other way around, E.G. first gpio in mux-gpios controlle=
d
> by LSB of reg property, next gpio by lsb+1,  ..?

True indeed.

> MR> +
> MR> +If an idle state is defined, using the idle-state (optional) pro=
perty,
> MR> +whenever an access is not being made to a device on a child bus,=
 the
> MR> +idle value will be programmed into the GPIOs.
>=20
> s/idle value will be programmed into the GPIOS/GPIOS set according to
> the idle value bitmask/

Once again, I'm really not fond of the term "bitmask".

[..]

> MR> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes=
/i2c-mux-gpio.c
> MR> index 566a675..7ebef01 100644
> MR> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> MR> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> MR> @@ -16,11 +16,13 @@
> MR>  #include <linux/module.h>
> MR>  #include <linux/slab.h>
> MR>  #include <linux/gpio.h>
> MR> +#include <linux/of_i2c.h>
> MR> +#include <linux/of_gpio.h>
> =20
> MR>  struct gpiomux {
> MR>  	struct i2c_adapter *parent;
> MR>  	struct i2c_adapter **adap; /* child busses */
> MR> -	struct i2c_mux_gpio_platform_data data;
> MR> +	struct i2c_mux_gpio_platform_data *data;
>=20
>=20
> Why this change? I don't see why it is needed and the patch would be =
a
> lot easier to review without all the s/.data/->data/ noise.

Ah yes, since mux is already allocated using kcalloc, we don't need to
do it for data as well. I will remove it.

Thanks,
Maxime




--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
