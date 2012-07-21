From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] I2C: MV64XYZ: Add Device Tree support
Date: Sat, 21 Jul 2012 14:55:47 +0200
Message-ID: <20120721125547.GA18592@pengutronix.de>
References: <1342803657-16611-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1342803657-16611-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 20, 2012 at 07:00:57PM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Rather than
> pass the N & M factors in DT, use the more standard clock-frequency
> property. Calculate N & M at run time. In order to do this, we need to
> know tclk. So the driver uses clk_get() etc in order to get the clock
> and clk_get_rate() to determine the tclk rate. Not all platforms
> however have CLK, so some #ifdefery is needed to ensure the driver
> still compiles when CLK is not available.
>=20
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
>=20
> - Replaced the timeout property in DT, with a hard coded 1 second.
> - Put all the OF code together.
> - Split the ARM parts from the driver itself.
> - Dropped Sebastian Hesselbarth Acked-by, since the changes are not trivi=
al.
> - Change MV64XXX to MV64XYZ in the Subject to try to get it past the list
>   spam filter.

:)

>=20
> This patch and the ARM counter part patch, plus all the DT changes to
> make us of it can be found in:
>=20
> git://github.com/lunn/linux.git v3.5-rc7-for-next-v5
>=20
> This patch is not yet rebased on i2c-embedded/for-next. I will do this
> once there is a general acceptance of this patch.
>=20
>  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   19 ++-
>  drivers/i2c/busses/i2c-mv64xxx.c                   |  135 ++++++++++++++=
+++++-
>  2 files changed, 148 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documen=
tation/devicetree/bindings/i2c/mrvl-i2c.txt
> index b891ee2..0f79450 100644
> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> @@ -1,4 +1,4 @@
> -* I2C
> +* Marvell MMP I2C controller
> =20
>  Required properties :
> =20
> @@ -32,3 +32,20 @@ Examples:
>  		interrupts =3D <58>;
>  	};
> =20
> +* Marvell MV64XXX I2C controller
> +
> +Required properties :
> +
> + - reg             : Offset and length of the register set for the device
> + - compatible      : Should be "marvell,mv64xxx-i2c"
> + - interrupts      : The interrupt number
> + - clock-frequency : Desired I2C bus clock frequency in Hz.
> +
> +Examples:
> +
> +	i2c@11000 {
> +		compatible =3D "marvell,mv64xxx-i2c";
> +		reg =3D <0x11000 0x20>;
> +		interrupts =3D <29>;
> +		clock-frequency =3D <100000>;
> +	};
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 4f44a33..e5449be 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -18,6 +18,11 @@
>  #include <linux/mv643xx_i2c.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_i2c.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> =20
>  /* Register defines */
>  #define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
> @@ -98,6 +103,9 @@ struct mv64xxx_i2c_data {
>  	int			rc;
>  	u32			freq_m;
>  	u32			freq_n;
> +#if defined(CONFIG_HAVE_CLK)
> +	struct clk              *clk;
> +#endif
>  	wait_queue_head_t	waitq;
>  	spinlock_t		lock;
>  	struct i2c_msg		*msg;
> @@ -521,6 +529,83 @@ mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_=
data)
>  	drv_data->reg_base_p =3D 0;
>  }
> =20
> +#ifdef CONFIG_OF
> +static int __devinit
> +mv64xxx_calc_freq(const int tclk, const int n, const int m)
> +{
> +	return tclk / (10 * (m + 1) * (2 << n));
> +}
> +
> +static bool __devinit
> +mv64xxx_find_baud_factors(const int req_freq, const int tclk, int *best_=
n,
> +			  int *best_m)
> +{
> +	int freq, delta, best_delta =3D INT_MAX;
> +	int m, n;
> +
> +	for (n =3D 0; n <=3D 7; n++)
> +		for (m =3D 0; m <=3D 15; m++) {
> +			freq =3D mv64xxx_calc_freq(tclk, n, m);
> +			delta =3D req_freq - freq;
> +			if (delta >=3D 0 && delta < best_delta) {
> +				*best_m =3D m;
> +				*best_n =3D n;
> +				best_delta =3D delta;
> +			}
> +			if (best_delta =3D=3D 0)
> +				return true;
> +		}
> +	if (best_delta =3D=3D INT_MAX)
> +		return false;
> +	return true;
> +}
> +
> +static int __devinit
> +mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
> +		  struct device_node *np)
> +{
> +	int bus_freq;
> +	int tclk;
> +	int rc =3D 0;
> +
> +	/* CLK is mandatory when using DT to describe the i2c bus. We
> +	 * need to know tclk in order to calculate bus clock
> +	 * factors.
> +	 */
> +#if !defined(CONFIG_HAVE_CLK)
> +	/* Have OF but no CLK */
> +	rc =3D -ENODEV;

return -ENODEV?

> +#else
> +	if (IS_ERR(drv_data->clk)) {
> +		rc =3D -ENODEV;
> +		goto out;
> +	}
> +	tclk =3D clk_get_rate(drv_data->clk);
> +	of_property_read_u32(np, "clock-frequency", &bus_freq);
> +	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
> +				       &drv_data->freq_n, &drv_data->freq_m)) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +	drv_data->irq =3D irq_of_parse_and_map(np, 0);
> +
> +	/* Its not yet defined how timeouts will be specified in device tree.
> +	 * So hard code the value to 1 second.
> +	 */
> +	drv_data->adapter.timeout =3D HZ;
> +out:
> +	return rc;
> +#endif
> +}
> +#else /* CONFIG_OF */
> +static int __devinit
> +mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
> +		  struct device_node *np)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_OF */
> +
>  static int __devinit
>  mv64xxx_i2c_probe(struct platform_device *pd)
>  {
> @@ -528,7 +613,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  	struct mv64xxx_i2c_pdata	*pdata =3D pd->dev.platform_data;
>  	int	rc;
> =20
> -	if ((pd->id !=3D 0) || !pdata)
> +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id !=3D 0)))
>  		return -ENODEV;
> =20
>  	drv_data =3D kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> @@ -546,19 +631,36 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  	init_waitqueue_head(&drv_data->waitq);
>  	spin_lock_init(&drv_data->lock);
> =20
> -	drv_data->freq_m =3D pdata->freq_m;
> -	drv_data->freq_n =3D pdata->freq_n;
> -	drv_data->irq =3D platform_get_irq(pd, 0);
> +#if defined(CONFIG_HAVE_CLK)
> +	/* Not all platforms have a clk */
> +	drv_data->clk =3D clk_get(&pd->dev, NULL);
> +	if (!IS_ERR(drv_data->clk)) {
> +		clk_prepare(drv_data->clk);
> +		clk_enable(drv_data->clk);
> +	}
> +#endif
> +	if (pdata) {
> +		drv_data->freq_m =3D pdata->freq_m;
> +		drv_data->freq_n =3D pdata->freq_n;
> +		drv_data->irq =3D platform_get_irq(pd, 0);
> +		drv_data->adapter.timeout =3D msecs_to_jiffies(pdata->timeout);
> +	}
> +	if (pd->dev.of_node) {

else if?

> +		rc =3D mv64xxx_of_config(drv_data, pd->dev.of_node);
> +		if (rc)
> +			goto exit_unmap_regs;
> +	}
>  	if (drv_data->irq < 0) {
>  		rc =3D -ENXIO;
>  		goto exit_unmap_regs;
>  	}
> +
>  	drv_data->adapter.dev.parent =3D &pd->dev;
>  	drv_data->adapter.algo =3D &mv64xxx_i2c_algo;
>  	drv_data->adapter.owner =3D THIS_MODULE;
>  	drv_data->adapter.class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
> -	drv_data->adapter.timeout =3D msecs_to_jiffies(pdata->timeout);
>  	drv_data->adapter.nr =3D pd->id;
> +	drv_data->adapter.dev.of_node =3D pd->dev.of_node;
>  	platform_set_drvdata(pd, drv_data);
>  	i2c_set_adapdata(&drv_data->adapter, drv_data);
> =20
> @@ -577,11 +679,20 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  		goto exit_free_irq;
>  	}
> =20
> +	of_i2c_register_devices(&drv_data->adapter);
> +
>  	return 0;
> =20
>  	exit_free_irq:
>  		free_irq(drv_data->irq, drv_data);
>  	exit_unmap_regs:
> +#if defined(CONFIG_HAVE_CLK)
> +	/* Not all platforms have a clk */
> +	if (!IS_ERR(drv_data->clk)) {
> +		clk_disable(drv_data->clk);
> +		clk_unprepare(drv_data->clk);
> +	}
> +#endif
>  		mv64xxx_i2c_unmap_regs(drv_data);
>  	exit_kfree:
>  		kfree(drv_data);
> @@ -597,17 +708,31 @@ mv64xxx_i2c_remove(struct platform_device *dev)
>  	rc =3D i2c_del_adapter(&drv_data->adapter);
>  	free_irq(drv_data->irq, drv_data);
>  	mv64xxx_i2c_unmap_regs(drv_data);
> +#if defined(CONFIG_HAVE_CLK)
> +	/* Not all platforms have a clk */
> +	if (!IS_ERR(drv_data->clk)) {
> +		clk_disable(drv_data->clk);
> +		clk_unprepare(drv_data->clk);
> +	}
> +#endif
>  	kfree(drv_data);
> =20
>  	return rc;
>  }
> =20
> +static const struct of_device_id mv64xxx_i2c_of_match_table[] __devinitd=
ata =3D {
> +	{ .compatible =3D "marvell,mv64xxx-i2c", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
> +
>  static struct platform_driver mv64xxx_i2c_driver =3D {
>  	.probe	=3D mv64xxx_i2c_probe,
>  	.remove	=3D __devexit_p(mv64xxx_i2c_remove),
>  	.driver	=3D {
>  		.owner	=3D THIS_MODULE,
>  		.name	=3D MV64XXX_I2C_CTLR_NAME,
> +		.of_match_table =3D of_match_ptr(mv64xxx_i2c_of_match_table),
>  	},
>  };

Rest looks good to me and it should be safe to rebase now.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAKptMACgkQD27XaX1/VRsvNwCgn3HM2F2PAwCCkK+yR9FMmVC/
hLQAnAgLFENUabU05Bx0kJiSsnvKYIrB
=EBBH
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
