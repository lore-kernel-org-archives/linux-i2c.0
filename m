From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V6 2/2] i2c/designware: Provide i2c bus recovery support
Date: Sat, 24 Nov 2012 22:03:14 +0100
Message-ID: <20121124210314.GC3210@pengutronix.de>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
 <6262d3a8e87858d938362c4aa44caf40938f2be9.1349348405.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6262d3a8e87858d938362c4aa44caf40938f2be9.1349348405.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2012 at 04:34:54PM +0530, Viresh Kumar wrote:
> Add bus recovery support for designware_i2c controller. It uses generic g=
pio
> based i2c_gpio_recover_bus() routine.
>=20
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> V5->V6:
> - removed sda_gpio_flags
>=20
>  drivers/i2c/busses/i2c-designware-core.c    |  7 ++++-
>  drivers/i2c/busses/i2c-designware-platdrv.c | 38 ++++++++++++++++++++++--
>  include/linux/i2c/i2c-designware.h          | 46 +++++++++++++++++++++++=
++++++
>  3 files changed, 88 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/i2c/i2c-designware.h
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busse=
s/i2c-designware-core.c
> index cbba7db..9b7c9bf 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -538,7 +538,12 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg=
 msgs[], int num)
>  	ret =3D wait_for_completion_interruptible_timeout(&dev->cmd_complete, H=
Z);
>  	if (ret =3D=3D 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -		i2c_dw_init(dev);
> +		if (adap->bus_recovery_info &&
> +				adap->bus_recovery_info->recover_bus) {
> +			dev_dbg(dev->dev, "try i2c bus recovery\n");
> +			adap->bus_recovery_info->recover_bus(adap);
> +		}
> +

This should be in the core?

>  		ret =3D -ETIMEDOUT;
>  		goto done;
>  	} else if (ret < 0)
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 0506fef..afa0df9 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -29,6 +29,7 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c/i2c-designware.h>
>  #include <linux/clk.h>
>  #include <linux/errno.h>
>  #include <linux/sched.h>
> @@ -45,6 +46,7 @@ static struct i2c_algorithm i2c_dw_algo =3D {
>  	.master_xfer	=3D i2c_dw_xfer,
>  	.functionality	=3D i2c_dw_func,
>  };
> +
>  static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
>  {
>  	return clk_get_rate(dev->clk)/1000;
> @@ -55,6 +57,8 @@ static int __devinit dw_i2c_probe(struct platform_devic=
e *pdev)
>  	struct dw_i2c_dev *dev;
>  	struct i2c_adapter *adap;
>  	struct resource *mem, *ioarea;
> +	struct i2c_dw_pdata *pdata;
> +	struct i2c_bus_recovery_info *recovery_info =3D NULL;
>  	int irq, r;
> =20
>  	/* NOTE: driver uses the static register mapping */
> @@ -141,17 +145,45 @@ static int __devinit dw_i2c_probe(struct platform_d=
evice *pdev)
>  	adap->dev.parent =3D &pdev->dev;
>  	adap->dev.of_node =3D pdev->dev.of_node;
> =20
> +	/* Bus recovery support */
> +	pdata =3D dev_get_platdata(&pdev->dev);
> +	if (pdata) {
> +		recovery_info =3D kzalloc(sizeof(*recovery_info), GFP_KERNEL);
> +		if (!recovery_info) {
> +			adap->bus_recovery_info =3D NULL;
> +			dev_err(&pdev->dev,
> +				"failure to allocate memory for bus recovery\n");
> +			goto skip_recovery;
> +		}
> +
> +		recovery_info->is_gpio_recovery =3D true;
> +		recovery_info->get_gpio =3D pdata->get_gpio;
> +		recovery_info->put_gpio =3D pdata->put_gpio;
> +		recovery_info->scl_gpio =3D pdata->scl_gpio;
> +		recovery_info->scl_gpio_flags =3D pdata->scl_gpio_flags;
> +		recovery_info->clock_rate_khz =3D clk_get_rate(dev->clk) / 1000;

It is probably easier to define the whole bri structure in the platform
and simply pass it on here? Hmm, now devicetree also comes to my mind.
Will think about that a little, too, but main implementation should be
left for someone needing that.

> +
> +		if (!pdata->skip_sda_polling)
> +			recovery_info->sda_gpio =3D pdata->sda_gpio;
> +
> +		adap->bus_recovery_info =3D recovery_info;
> +	} else {
> +		adap->bus_recovery_info =3D NULL;
> +	}
> +
> +skip_recovery:
>  	adap->nr =3D pdev->id;
>  	r =3D i2c_add_numbered_adapter(adap);
>  	if (r) {
>  		dev_err(&pdev->dev, "failure adding adapter\n");
> -		goto err_free_irq;
> +		goto err_free_recovery_info;
>  	}
>  	of_i2c_register_devices(adap);
> =20
>  	return 0;
> =20
> -err_free_irq:
> +err_free_recovery_info:
> +	kfree(recovery_info);
>  	free_irq(dev->irq, dev);
>  err_iounmap:
>  	iounmap(dev->base);
> @@ -174,6 +206,8 @@ static int __devexit dw_i2c_remove(struct platform_de=
vice *pdev)
>  	struct dw_i2c_dev *dev =3D platform_get_drvdata(pdev);
>  	struct resource *mem;
> =20
> +	kfree(dev->adapter.bus_recovery_info);
> +
>  	platform_set_drvdata(pdev, NULL);
>  	i2c_del_adapter(&dev->adapter);
>  	put_device(&pdev->dev);
> diff --git a/include/linux/i2c/i2c-designware.h b/include/linux/i2c/i2c-d=
esignware.h
> new file mode 100644
> index 0000000..522dec0
> --- /dev/null
> +++ b/include/linux/i2c/i2c-designware.h
> @@ -0,0 +1,46 @@
> +/*
> + * Synopsys DesignWare I2C adapter driver's platform data
> + *
> + * Copyright (C) 2012 ST Microelectronics.
> + * Author: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#ifndef I2C_DESIGNWARE_H
> +#define I2C_DESIGNWARE_H
> +
> +#include <linux/platform_device.h>
> +
> +/*
> + * struct i2c_dw_pdata - Designware I2c platform data
> + * @scl_gpio: gpio number of the scl line.
> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
> + *	GPIOF_OUT_INIT_LOW.
> + * @get_gpio: called before recover_bus() to get padmux configured for s=
cl line
> + *	as gpio. Only required if is_gpio_recovery =3D=3D true
> + * @put_gpio: called after recover_bus() to get padmux configured for sc=
l line
> + *	as scl. Only required if is_gpio_recovery =3D=3D true
> + * @skip_sda_polling: if true, bus recovery will not poll sda line to ch=
eck if
> + *	it became high or not. Below are required only if this is false.
> + * @sda_gpio: gpio number of the sda line.
> + */
> +struct i2c_dw_pdata {
> +	int scl_gpio;
> +	int scl_gpio_flags;
> +	int (*get_gpio)(unsigned gpio);
> +	void (*put_gpio)(unsigned gpio);
> +
> +	/* sda polling specific */
> +	bool skip_sda_polling;
> +	int sda_gpio;
> +};
> +
> +#endif /* I2C_DESIGNWARE_H */
> --=20
> 1.7.12.rc2.18.g61b472e
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCxNhIACgkQD27XaX1/VRu7qQCeO1WLpCPF2uakbF1I09mZiCi6
CH8AoJOYCW+xN1bZdwgo/ldzlDy6eYGF
=Eqdt
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
