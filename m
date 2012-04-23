From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 23 Apr 2012 14:56:31 +0200
Message-ID: <20120423125630.GG19192@pengutronix.de>
References: <cover.1330669025.git.viresh.kumar@st.com>
 <3d25a5406975dbab9d21bfe406e5f779480da17f.1330669025.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3d25a5406975dbab9d21bfe406e5f779480da17f.1330669025.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2012 at 11:53:42AM +0530, Viresh Kumar wrote:
> Add i2c bus recovery infrastructure to i2c adapters as specified in the i=
2c
> protocol Rev. 03 section 3.16 titled "Bus clear".
>=20
> http://www.nxp.com/documents/user_manual/UM10204.pdf
>=20
> Sometimes during operation i2c bus hangs and we need to give dummy clocks=
 to
> slave device to start the transfer again. Now we may have capability in t=
he bus
> controller to generate these clocks or platform may have gpio pins which =
can be
> toggled to generate dummy clocks. This patch supports both.
>=20
> This patch also adds in generic bus recovery routines gpio or scl line ba=
sed
> which can be used by bus controller. In addition controller driver may pr=
ovide
> its own version of the bus recovery routine.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>

Finally, a review \o/

There are some comments regarding the code, but the most important thing
is to get the interface right.

Jean, I don't think this is embedded only, so an additional view might
be helpful here.

Linus, can you have a look wearing your pinmux/pinctrl hat? This
functionality may need to switch SDA/SCL pins to GPIOs so they can be
manually clocked. I'd think this is a prime example for pinmux, but am
unsure if we should rely on it only. Is it enforced for active
platforms?

> ---
>  drivers/i2c/i2c-core.c |  125 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c.h    |   52 ++++++++++++++++++++
>  2 files changed, 177 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index e9c1893..5cd5f83 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -26,7 +26,9 @@
> =20
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
> +#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -103,6 +105,88 @@ static int i2c_device_uevent(struct device *dev, str=
uct kobj_uevent_env *env)
>  #define i2c_device_uevent	NULL
>  #endif	/* CONFIG_HOTPLUG */
> =20
> +/* i2c bus recovery routines */
> +static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;

I think something alike 'recov_info' is more readable than 'bri'.

> +	unsigned long delay =3D 1000000;

udelay?

> +	int i, ret, val =3D 1;
> +
> +	if (bri->get_gpio)
> +		bri->get_gpio(bri->scl_gpio);
> +
> +	ret =3D gpio_request_one(bri->scl_gpio, bri->scl_gpio_flags, "i2c-scl");
> +	if (ret < 0) {
> +		dev_warn(&adap->dev, "gpio request fail: %d\n", bri->scl_gpio);
> +		return ret;
> +	}
> +
> +	if (!bri->skip_sda_polling) {
> +		if (bri->get_gpio)
> +			bri->get_gpio(bri->sda_gpio);
> +
> +		ret =3D gpio_request_one(bri->sda_gpio, bri->sda_gpio_flags,
> +				"i2c-sda");
> +		if (ret < 0) {
> +			/* work without sda polling */
> +			dev_warn(&adap->dev,
> +				"sda_gpio request fail: %d. Skip sda polling\n",
> +				bri->scl_gpio);
> +			bri->skip_sda_polling =3D true;
> +			if (bri->put_gpio)
> +				bri->put_gpio(bri->sda_gpio);
> +		}
> +	}
> +
> +	delay /=3D bri->clock_rate_khz * 2;
> +
> +	for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
> +		ndelay(delay);
> +		gpio_set_value(bri->scl_gpio, val);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (!bri->skip_sda_polling && val)
> +			if (gpio_get_value(bri->sda_gpio))
> +				break;
> +	}
> +
> +	gpio_free(bri->scl_gpio);
> +
> +	if (bri->put_gpio)
> +		bri->put_gpio(bri->scl_gpio);
> +
> +	if (!bri->skip_sda_polling) {
> +		gpio_free(bri->sda_gpio);
> +
> +		if (bri->put_gpio)
> +			bri->put_gpio(bri->sda_gpio);
> +	}
> +
> +	return 0;
> +}
> +
> +static int i2c_scl_recover_bus(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	int i, val =3D 0;
> +	unsigned long delay =3D 1000000;
> +
> +	delay /=3D bri->clock_rate_khz * 2;
> +
> +	for (i =3D 0; i < bri->clock_cnt * 2; i++,
> +			val =3D !val) {
> +		bri->set_scl(adap, val);
> +		ndelay(delay);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (!bri->skip_sda_polling && val)
> +			if (bri->get_sda(adap))
> +				break;
> +	}
> +
> +	return 0;
> +}

We have two recover bus functions here. I think it would be better to
have only one. set_scl and get_sda can be mapped to helper functions
doing needed gpio-calls during init. Something like this pseudo-code:

	if (!bri->set_scl && we_have_a_scl_gpio)
		set_scl =3D i2c_set_scl_via_gpio()

> +
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client =3D i2c_verify_client(dev);
> @@ -861,6 +945,47 @@ static int i2c_register_adapter(struct i2c_adapter *=
adap)
>  			 "Failed to create compatibility class link\n");
>  #endif
> =20
> +	/* bus recovery specific initialization */
> +	if (adap->bus_recovery_info) {
> +		struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +		if (bri->recover_bus) {
> +			dev_info(&adap->dev,
> +				"registered for non-generic bus recovery\n");
> +		} else {
> +			/* Use generic recovery routines */
> +			if (!bri->clock_rate_khz) {
> +				dev_warn(&adap->dev,
> +					"doesn't have valid recovery clock rate\n");
> +				goto exit_recovery;
> +			}
> +
> +			/* Most controller need 9 clocks at max */
> +			if (!bri->clock_cnt)
> +				bri->clock_cnt =3D 9;
> +
> +			if (bri->is_gpio_recovery) {
> +				bri->recover_bus =3D i2c_gpio_recover_bus;
> +				dev_info(&adap->dev,
> +					"registered for gpio bus recovery\n");
> +			} else if (bri->set_scl) {
> +				if (!bri->skip_sda_polling && !bri->get_sda) {
> +					dev_warn(&adap->dev,
> +						"!get_sda. skip sda polling\n");
> +					bri->skip_sda_polling =3D true;
> +				}
> +
> +				bri->recover_bus =3D i2c_scl_recover_bus;
> +				dev_info(&adap->dev,
> +					"registered for scl bus recovery\n");
> +			} else {
> +				dev_warn(&adap->dev,
> +					"doesn't have valid recovery type\n");

Printouts here should probably be dev_dbg (if not left out), most users
won't care.

> +			}
> +		}
> +	}
> +
> +exit_recovery:
>  	/* create pre-declared device nodes */
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 8e25a91..1310d1a 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -365,6 +365,55 @@ struct i2c_algorithm {
>  	u32 (*functionality) (struct i2c_adapter *);
>  };
> =20

The description of the members is a good start. To be complete, I'd think
we need some higher level description in Documentation/i2c, too, with an
example how to set up.

> +/**
> + * struct i2c_bus_recovery_info - I2c bus recovery information
> + * @recover_bus: Recover routine. Either pass driver's recover_bus() rou=
tine, or
> + *	pass it NULL to use generic ones, i.e. gpio or scl based.
> + * @skip_sda_polling: if true, bus recovery will not poll sda line to ch=
eck if
> + *	it became high or not. Only required if recover_bus =3D=3D NULL.

Assume this when there is no get_sda() and/or SDA GPIO  defined?

> + * @is_gpio_recovery: true, select gpio type else scl type. Only require=
d if
> + *	recover_bus =3D=3D NULL.

Assume this when there is no GPIO defined (and no recover_bus)?

> + * @clock_rate_khz: clock rate of dummy clock in khz. Required for both =
gpio and
> + *	scl type recovery.

Hrmm, current bus speed should really be in i2c_adapter somewhen. Not
your problem, though (unless you want it to be :)) Jean, what do you
think?

> + * @clock_cnt: count of max clocks to be generated. Required for both gp=
io and
> + *	scl type recovery.

Why should that be different from 9 (as said in the docs)?

> + * @set_scl: controller specific scl configuration routine. Only require=
d if
> + *	is_gpio_recovery =3D=3D false
> + * @get_sda: controller specific sda read routine. Only required if
> + *	is_gpio_recovery =3D=3D false and skip_sda_polling =3D=3D false.
> + * @get_gpio: called before recover_bus() to get padmux configured for s=
cl line.
> + *	as gpio. Only required if is_gpio_recovery =3D=3D true.
> + * @put_gpio: called after recover_bus() to get padmux configured for sc=
l line
> + *	as scl. Only required if is_gpio_recovery =3D=3D true.

Can't we use the pinmux/pinctrl subsystem here? Not knowing too much
about it, CCing Linus.

> + * @scl_gpio: gpio number of the scl line. Only required if is_gpio_reco=
very =3D=3D
> + *	true.
> + * @sda_gpio: gpio number of the sda line. Only required if is_gpio_reco=
very =3D=3D
> + *	true and skip_sda_polling =3D=3D false.
> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
> + *	GPIOF_OUT_INIT_LOW.
> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
> + *	GPIOF_OUT_INIT_LOW.

For the last 4, I'd suggest to pass a struct gpio scl_sda_gpio_array[2]
or something.

> + */
> +struct i2c_bus_recovery_info {
> +	int (*recover_bus)(struct i2c_adapter *);
> +	bool skip_sda_polling;
> +	bool is_gpio_recovery;
> +	u32 clock_rate_khz;
> +	u8 clock_cnt;
> +
> +	/* scl/sda recovery */
> +	void (*set_scl)(struct i2c_adapter *, int val);
> +	int (*get_sda)(struct i2c_adapter *);
> +
> +	/* gpio recovery */
> +	int (*get_gpio)(unsigned gpio);
> +	int (*put_gpio)(unsigned gpio);
> +	u32 scl_gpio;
> +	u32 sda_gpio;
> +	u32 scl_gpio_flags;
> +	u32 sda_gpio_flags;
> +};
> +
>  /*
>   * i2c_adapter is the structure used to identify a physical i2c bus along
>   * with the access algorithms necessary to access it.
> @@ -388,6 +437,9 @@ struct i2c_adapter {
> =20
>  	struct mutex userspace_clients_lock;
>  	struct list_head userspace_clients;
> +
> +	/* Pass valid pointer if recovery infrastructure is required */
> +	struct i2c_bus_recovery_info *bus_recovery_info;
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> =20

I'd also think calling the recover function should be in the core and
not in all the drivers.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VUX4ACgkQD27XaX1/VRtiAwCgiW6q1KB20w6XpceSzSmS9FHf
GRQAn3bEKzH6GPxhQfqloBLSmXsPCCn0
=DfRD
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
