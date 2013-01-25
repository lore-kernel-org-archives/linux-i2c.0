From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V9 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 25 Jan 2013 10:15:12 +0100
Message-ID: <20130125091512.GE5684@pengutronix.de>
References: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 04:06:37PM +0530, Viresh Kumar wrote:
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
> Reviewed-by: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Most number of versions for any patchset i submitted :)
>=20
> V8->V9:
> - removed skip_sda_polling variable
> - simplified/fixed i2c_generic_recovery() routine
> - added new routine i2c_recover_bus()
> - added gpio_is_valid() checks over scl and sda gpios
> - code is rearranged at places (based on Wolfram's comments)
>=20
>  drivers/i2c/i2c-core.c | 155 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c.h    |  39 +++++++++++++
>  2 files changed, 194 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index e388590..8076e52 100644
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
> @@ -109,6 +111,127 @@ static int i2c_device_uevent(struct device *dev, st=
ruct kobj_uevent_env *env)
>  #define i2c_device_uevent	NULL
>  #endif	/* CONFIG_HOTPLUG */
> =20
> +/* i2c bus recovery routines */
> +#define RECOVERY_CLK_CNT	9
> +#define DEFAULT_CLK_RATE	100	/* KHz */

RECOVERY_CLK_RATE

> +/* 10^6/KHz for delay in ns */
> +unsigned long clk_delay =3D DIV_ROUND_UP(1000000, DEFAULT_CLK_RATE * 2);

Since all inputs are constant values, the result will be a constant as
well. We might even get rid of this variable altogether.

> +
> +static int get_scl_gpio_value(struct i2c_adapter *adap)
> +{
> +	return gpio_get_value(adap->bus_recovery_info->scl_gpio);
> +}
> +
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
> +	ret =3D gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
> +			GPIOF_OUT_INIT_HIGH, "i2c-scl");
> +	if (ret) {
> +		dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
> +		return ret;
> +	}
> +
> +	if (bri->get_sda) {
> +		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
> +			/* work without sda polling */
> +			dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
> +					bri->sda_gpio);
> +			bri->get_sda =3D NULL;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +	if (bri->get_sda)
> +		gpio_free(bri->sda_gpio);
> +
> +	gpio_free(bri->scl_gpio);
> +}
> +
> +static int i2c_generic_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	int i =3D 0, val =3D 1, ret =3D 0;
> +
> +	if (bri->prepare_recovery)
> +		bri->prepare_recovery(bri);
> +
> +	/*
> +	 * By this time SCL is high, as we need to give 9 falling-rising edges
> +	 */
> +	while (i++ < RECOVERY_CLK_CNT * 2) {
> +		/* SCL shouldn't be low here */
> +		if (val && !bri->get_scl(adap)) {
> +			dev_err(&adap->dev, "SCL is stuck Low exit recovery\n");

s/Low/low/

> +			ret =3D -EBUSY;
> +			goto unprepare;
> +		}
> +
> +		val =3D !val;
> +		bri->set_scl(adap, val);
> +		ndelay(clk_delay);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (bri->get_sda && val)
> +			if (bri->get_sda(adap))
> +				break;

if (val && bri->get_sda && bri->get_sda(adap)
	break;

Didn't we agree to move the SDA check before the SCL setting?

> +	}
> +
> +unprepare:
> +	if (bri->unprepare_recovery)
> +		bri->unprepare_recovery(bri);
> +
> +	return ret;
> +}
> +
> +int i2c_generic_scl_recovery(struct i2c_adapter *adap)
> +{
> +	adap->bus_recovery_info->set_scl(adap, 1);
> +	return i2c_generic_recovery(adap);
> +}
> +
> +int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
> +{
> +	int ret;
> +
> +	ret =3D i2c_get_gpios_for_recovery(adap);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D i2c_generic_recovery(adap);
> +	i2c_put_gpios_for_recovery(adap);
> +
> +	return ret;
> +}
> +
> +int i2c_recover_bus(struct i2c_adapter *adap)
> +{
> +	if (!adap->bus_recovery_info)
> +		return -EOPNOTSUPP;
> +
> +	dev_dbg(&adap->dev, "try i2c bus recovery\n");

s/try/trying/

> +	return adap->bus_recovery_info->recover_bus(adap);
> +}
> +
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client =3D i2c_verify_client(dev);
> @@ -902,6 +1025,38 @@ static int i2c_register_adapter(struct i2c_adapter =
*adap)
>  			 "Failed to create compatibility class link\n");
>  #endif
> =20
> +	/* bus recovery specific initialization */
> +	if (adap->bus_recovery_info) {
> +		struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +		if (!bri->recover_bus) {
> +			dev_err(&adap->dev, "Invalid recover_bus(), skip recovery\n");

s/Invalid/No/
s/skip/not using/
The latter for all later occurences, too.

> +			adap->bus_recovery_info =3D NULL;
> +			goto exit_recovery;
> +		}
> +
> +		/* GPIO recovery */
> +		if (bri->recover_bus =3D=3D i2c_generic_gpio_recovery) {
> +			if (!gpio_is_valid(bri->scl_gpio)) {
> +				dev_err(&adap->dev, "Invalid scl gpio, skip recovery\n");
> +				adap->bus_recovery_info =3D NULL;
> +				goto exit_recovery;
> +			}
> +
> +			if (gpio_is_valid(bri->sda_gpio))
> +				bri->get_sda =3D get_sda_gpio_value;
> +			else
> +				bri->get_sda =3D NULL;
> +
> +			bri->get_scl =3D get_scl_gpio_value;
> +			bri->set_scl =3D set_scl_gpio_value;
> +		} else if (!bri->set_scl) {
> +			dev_warn(&adap->dev,
> +					"set_scl() is must for scl recovery\n");

What about get_scl. You don't check here, but you don't check when you
use it above.

> +		}
> +	}
> +
> +exit_recovery:
>  	/* create pre-declared device nodes */
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index d0c4db7..da9358b 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -370,6 +370,43 @@ struct i2c_algorithm {
>  	u32 (*functionality) (struct i2c_adapter *);
>  };
> =20
> +/**
> + * struct i2c_bus_recovery_info - I2C bus recovery information
> + * @recover_bus: Recover routine. Either pass driver's recover_bus() rou=
tine, or
> + *	i2c_generic_scl_recovery() or i2c_generic_gpio_recovery().
> + * @get_scl: This gets current value of scl line. Mandatory for generic =
SCL
> + *      recovery. Used internally for generic GPIO recovery.
> + * @set_scl: This sets/clears scl line. Mandatory for generic SCL recove=
ry. Used
> + *      internally for generic GPIO recovery.
> + * @get_sda: This gets current value of sda line. Optional for generic S=
CL
> + *      recovery. Used internally, if sda_gpio !=3D -1, for generic GPIO=
 recovery.

s/!=3D -1/is a valid GPIO/

> + * @prepare_recovery: This will be called before starting recovery. Plat=
form may
> + *	configure padmux here for sda/scl line or something else they want.
> + * @unprepare_recovery: This will be called after completing recovery. P=
latform
> + *	may configure padmux here for sda/scl line or something else they wan=
t.
> + * @scl_gpio: gpio number of the scl line. Only required for GPIO recove=
ry.
> + * @sda_gpio: gpio number of the sda line. Only required for GPIO recove=
ry.
> + */
> +struct i2c_bus_recovery_info {
> +	int (*recover_bus)(struct i2c_adapter *);
> +
> +	int (*get_scl)(struct i2c_adapter *);
> +	void (*set_scl)(struct i2c_adapter *, int val);
> +	int (*get_sda)(struct i2c_adapter *);
> +
> +	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
> +	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
> +
> +	/* gpio recovery */
> +	unsigned scl_gpio;
> +	unsigned sda_gpio;
> +};
> +
> +/* Generic recovery routines */
> +int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
> +int i2c_generic_scl_recovery(struct i2c_adapter *adap);
> +int i2c_recover_bus(struct i2c_adapter *adap);
> +
>  /*
>   * i2c_adapter is the structure used to identify a physical i2c bus along
>   * with the access algorithms necessary to access it.
> @@ -393,6 +430,8 @@ struct i2c_adapter {
> =20
>  	struct mutex userspace_clients_lock;
>  	struct list_head userspace_clients;
> +
> +	struct i2c_bus_recovery_info *bus_recovery_info;
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlECTSAACgkQD27XaX1/VRs21ACfW4TjGfn9LIcqW6QIFSCJBz/T
SWkAnjaVM3QqFIhLN9ZlhU0gUsiob538
=pXWw
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
