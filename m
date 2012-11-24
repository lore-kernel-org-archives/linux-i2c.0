From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V6 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Sat, 24 Nov 2012 21:59:31 +0100
Message-ID: <20121124205931.GB3210@pengutronix.de>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2012 at 04:34:53PM +0530, Viresh Kumar wrote:
> Add i2c bus recovery infrastructure to i2c adapters as specified in the i=
2c
> protocol Rev. 03 section 3.1.16 titled "Bus clear".
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
> This doesn't support multi-master recovery for now.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

As mentioned before, I still have issues with the API and have most
comments to that for now.

> ---
> V5->V6:
> - Removed sda_gpio_flags
> - Make scl_gpio_flags as GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH by default
> - update bri->set_scl and bri->get_sda for gpio recovery case in i2c core
> - Guaranteed to generate 9 falling-rising edges for bus recovery
>=20
> V4->V5:
> - section name corrected to 3.1.16
> - merged gpio and non-gpio recovery routines to remove code redundancy
> - Changed types of gpio and gpio-flags to unsigned and unsigned long
> - Checking return value of get_gpio() now
> - using DIV_ROUND_UP for calculating delay, to get more correct value
>=20
>  drivers/i2c/i2c-core.c | 156 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c.h    |  55 +++++++++++++++++
>  2 files changed, 211 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a7edf98..e78033b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -27,7 +27,9 @@
> =20
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
> +#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -104,6 +106,111 @@ static int i2c_device_uevent(struct device *dev, st=
ruct kobj_uevent_env *env)
>  #define i2c_device_uevent	NULL
>  #endif	/* CONFIG_HOTPLUG */
> =20
> +/* i2c bus recovery routines */
> +static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
> +{
> +	gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
> +}
> +
> +static int get_sda_gpio_value(struct i2c_adapter *adap)
> +{
> +	return gpio_get_value(adap->bus_recovery_info->sda_gpio);
> +}
> +
> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	struct device *dev =3D &adap->dev;
> +	int ret =3D 0;
> +
> +	if (bri->get_gpio) {
> +		ret =3D bri->get_gpio(bri->scl_gpio);
> +		if (ret) {
> +			dev_warn(dev, "scl get_gpio: %d\n", bri->scl_gpio);

This warning is probably not very helpful to a user.

> +			return ret;
> +		}
> +	}
> +
> +	ret =3D gpio_request_one(bri->scl_gpio, bri->scl_gpio_flags, "i2c-scl");
> +	if (ret) {
> +		dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
> +		goto scl_put_gpio;
> +	}
> +
> +	if (!bri->skip_sda_polling) {
> +		if (bri->get_gpio)
> +			ret =3D bri->get_gpio(bri->sda_gpio);
> +
> +		if (unlikely(ret ||

Since the unlikely() are not in hot-paths, you probably better skip
them.

> +			gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda"))) {
> +			/* work without sda polling */
> +			dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
> +					bri->sda_gpio);
> +			bri->skip_sda_polling =3D true;
> +			if (!ret && bri->put_gpio)
> +				bri->put_gpio(bri->sda_gpio);
> +
> +			ret =3D 0;
> +		}
> +	}
> +
> +scl_put_gpio:
> +	if (bri->put_gpio)
> +		bri->put_gpio(bri->scl_gpio);
> +
> +	return ret;
> +}
> +
> +static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +	gpio_free(bri->scl_gpio);
> +
> +	if (!bri->skip_sda_polling) {
> +		gpio_free(bri->sda_gpio);
> +
> +		if (bri->put_gpio)
> +			bri->put_gpio(bri->sda_gpio);
> +	}
> +}
> +
> +static int i2c_recover_bus(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	unsigned long delay =3D 1000000;

What is this magic value?

> +	int i, ret, val =3D 0;
> +
> +	if (bri->is_gpio_recovery) {
> +		ret =3D i2c_get_gpios_for_recovery(adap);
> +		if (ret)
> +			return ret;
> +	} else {
> +		bri->set_scl(adap, 1);
> +	}
> +
> +	/*
> +	 * By this time SCL is high, as we need to give 9 falling-rising edges
> +	 */
> +
> +	delay =3D DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
> +
> +	for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
> +		bri->set_scl(adap, val);
> +		ndelay(delay);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (!bri->skip_sda_polling && val)
> +			if (unlikely(bri->get_sda(adap)))
> +				break;
> +	}
> +
> +	if (bri->is_gpio_recovery)
> +		i2c_put_gpios_for_recovery(adap);
> +
> +	return 0;
> +}
> +
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client =3D i2c_verify_client(dev);
> @@ -896,6 +1003,55 @@ static int i2c_register_adapter(struct i2c_adapter =
*adap)
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
> +			bri->recover_bus =3D i2c_recover_bus;
> +
> +			if (bri->is_gpio_recovery) {
> +				if (!bri->scl_gpio_flags)
> +					bri->scl_gpio_flags =3D GPIOF_OPEN_DRAIN;
> +
> +				/* We always start by making GPIO HIGH */
> +				bri->scl_gpio_flags |=3D GPIOF_OUT_INIT_HIGH;
> +
> +				bri->set_scl =3D set_scl_gpio_value;
> +				bri->get_sda =3D get_sda_gpio_value;
> +				dev_info(&adap->dev,
> +					"registered for gpio bus recovery\n");
> +			} else if (bri->set_scl) {
> +				if (!bri->skip_sda_polling && !bri->get_sda) {
> +					dev_warn(&adap->dev,
> +						"!get_sda. skip sda polling\n");
> +					bri->skip_sda_polling =3D true;
> +				}
> +
> +				dev_info(&adap->dev,
> +					"registered for scl bus recovery\n");
> +			} else {
> +				dev_warn(&adap->dev,
> +					"doesn't have valid recovery type\n");
> +			}
> +		}
> +	}
> +
> +exit_recovery:
>  	/* create pre-declared device nodes */
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 5970266..13eeb2e 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -370,6 +370,58 @@ struct i2c_algorithm {
>  	u32 (*functionality) (struct i2c_adapter *);
>  };
> =20
> +/**
> + * struct i2c_bus_recovery_info - I2c bus recovery information
> + * @recover_bus: Recover routine. Either pass driver's recover_bus() rou=
tine, or
> + *	pass it NULL to use generic ones, i.e. gpio or scl based.

What about having those options?

NULL or custom_pointer or i2c_generic_scl_recovery or i2c_generic_gpio_reco=
very

where i2c_generic_gpio_recovery is probably:

	get_gpios_for_recovery
	i2c_generic_scl_recovery
	put_gpios_for_recovery

and i2c_generic_scl_recovery is basically your current
i2c_generic_recovery. That makes it easier to add other generic routines
if that should ever become necessary.


> + * @skip_sda_polling: if true, bus recovery will not poll sda line to ch=
eck if
> + *	it became high or not. Only required if recover_bus =3D=3D NULL.

Does a user really need to set this?

> + * @is_gpio_recovery: true, select gpio type else scl type. Only require=
d if
> + *	recover_bus =3D=3D NULL.

This could be dropped in favor of i2c_generic_*_recovery in recover_bus

> + * @clock_rate_khz: clock rate of dummy clock in khz. Required for both =
gpio and
> + *	scl type recovery.

Does a user really need this? We could probably use something close to
100kHz always?

> + * @clock_cnt: count of max clocks to be generated. Required for both gp=
io and
> + *	scl type recovery.

Don't think this should be something else than 9. If so, it should be
increased generally in the core and not inside some platform data.

> + * @set_scl: controller specific routine, if is_gpio_recovery =3D=3D fal=
se.
> + *       set_scl_gpio_value otherwise
> + * @get_sda: controller specific routine, if is_gpio_recovery =3D=3D fal=
se.
> + *       get_sda_gpio_value otherwise

Basically OK, documentation should be more user-centric not
implementation centric :)

> + * @get_gpio: called before recover_bus() to get padmux configured for s=
cl line.
> + *	as gpio. Only required if is_gpio_recovery =3D=3D true. Return 0 on s=
uccess.
> + * @put_gpio: called after recover_bus() to get padmux configured for sc=
l line
> + *	as scl. Only required if is_gpio_recovery =3D=3D true.

I wonder if it makes sense to have those more generic like
prepare_recovery and unprepare_recovery?

> + * @scl_gpio: gpio number of the scl line. Only required if is_gpio_reco=
very =3D=3D
> + *	true.
> + * @sda_gpio: gpio number of the sda line. Only required if is_gpio_reco=
very =3D=3D
> + *	true and skip_sda_polling =3D=3D false.

OK.

> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. If passed as =
0,
> + *      (GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH) is used instead. Otherw=
ise, it
> + *      is ORRED with GPIOF_OUT_INIT_HIGH.

Is this needed? I'd say we drop it until somebody with a need can add
something like this.

> + *      These is no need of sda_gpio_flags, as we always read it in inpu=
t mode.
> + */
> +struct i2c_bus_recovery_info {
> +	int (*recover_bus)(struct i2c_adapter *);
> +	bool skip_sda_polling;
> +	bool is_gpio_recovery;
> +	u32 clock_rate_khz;
> +	u8 clock_cnt;
> +
> +	/*
> +	 * Fn pointers for recovery, will point either to:
> +	 * - set_scl_gpio_value and get_sda_gpio_value for gpio recovery
> +	 * - Controller specific routines, otherwise
> +	 */
> +	void (*set_scl)(struct i2c_adapter *, int val);
> +	int (*get_sda)(struct i2c_adapter *);
> +
> +	/* gpio recovery */
> +	int (*get_gpio)(unsigned gpio);
> +	void (*put_gpio)(unsigned gpio);
> +	unsigned scl_gpio;
> +	unsigned sda_gpio;
> +	unsigned long scl_gpio_flags;
> +};
> +
>  /*
>   * i2c_adapter is the structure used to identify a physical i2c bus along
>   * with the access algorithms necessary to access it.
> @@ -393,6 +445,9 @@ struct i2c_adapter {
> =20
>  	struct mutex userspace_clients_lock;
>  	struct list_head userspace_clients;
> +
> +	/* Pass valid pointer if recovery infrastructure is required */

This comment can be left out.

> +	struct i2c_bus_recovery_info *bus_recovery_info;
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> =20
> --=20
> 1.7.12.rc2.18.g61b472e
>=20
>=20

See also the next mail...


--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCxNTMACgkQD27XaX1/VRvDtwCfR1b4rmXSgjBxlwrWtdHd5nxO
eRUAn3e2eKWLOT65mprRXnUxUqirtun+
=fVoq
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
