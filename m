From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv3] I2C: MV64XXX: Add Device Tree support
Date: Fri, 20 Jul 2012 12:35:13 +0200
Message-ID: <20120720103513.GA5971@pengutronix.de>
References: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
 <1342430205-13702-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2818843050426346909=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1342430205-13702-2-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: sebastian.hesselbarth@googlemail.com, linux-i2c@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-i2c@vger.kernel.org


--===============2818843050426346909==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Jul 16, 2012 at 11:16:45AM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Rather than
> pass the N & M factors in DT, use the more standard clock-frequency
> property. Calculate N & M at run time. In order to do this, we need to

Thanks.

> know tclk. So the driver uses clk_get() etc in order to get the clock
> and clk_get_rate() to determine the tclk rate. Not all platforms
> however have CLK, so some #ifdefery is needed to ensure the driver
> still compiles when CLK is not available.
>=20
> Also extend the kirkwood DT support to supply the needed properties. A
> default clock-frequency is 400KHz, which some platforms might need to
> override to 100KHz if they have devices which do not support fast
> mode.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Has Sebastian acked THIS patch? Didn't saw such a mail? If it was a
previous patch which he acked, I'd like it to be resent, since the
divider calculation is new.

> ---
> v2: Removed duplicate interrupt in DT.
> v3: Use clock-frequency property, instead of explicit n & m baud factors.
>=20
> i2c fix.
> ---
>  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   21 +++-
>  arch/arm/boot/dts/kirkwood.dtsi                    |   11 ++
>  arch/arm/mach-kirkwood/board-dt.c                  |    2 +
>  arch/arm/mach-kirkwood/common.c                    |    2 +
>  arch/arm/plat-orion/common.c                       |    1 +
>  drivers/i2c/busses/i2c-mv64xxx.c                   |  107 ++++++++++++++=
+++++-

As said in another mail, please split up arch/arm and i2c-stuff.

>  6 files changed, 138 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documen=
tation/devicetree/bindings/i2c/mrvl-i2c.txt
> index b891ee2..885f340 100644
> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> @@ -1,4 +1,4 @@
> -* I2C
> +* Marvell MMP I2C controller
> =20
>  Required properties :
> =20
> @@ -32,3 +32,22 @@ Examples:
>  		interrupts =3D <58>;
>  	};
> =20
> +* Marvell MV64XXX I2C controller
> +
> +Required properties :
> +
> + - reg             : Offset and length of the register set for the device
> + - compatible      : Should be "marvell,mv64xxx-i2c"
> + - interrupts      : Te interrupt number
> + - clock-frequency : Desired I2C bus clock frequency in Hz.
> + - timeout-ms      : How long to wait for a transaction to complete

If you don't really need "timeout-ms", I'd ask you to drop it. I haven't
made up my mind how to handle those timeouts yet. They should be
per-slave and not per-bus, but the core cannot handle this yet. And even
though I am tempted to accept a per-bus-timeout, getting the binding
right is not something we can come up with before the next merge window.
I am suspecting a default value could do for now?

> +
> +Examples:
> +
> +	i2c@11000 {
> +		compatible =3D "marvell,mv64xxx-i2c";
> +		reg =3D <0x11000 0x20>;
> +		interrupts =3D <29>;
> +		clock-frequency =3D <100000>;
> +		timeout-ms =3D <1000>;
> +	};
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood=
=2Edtsi
> index a3350fd..bc57d81 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -82,5 +82,16 @@
>  			/* set partition map and/or chip-delay in board dts */
>  			status =3D "disabled";
>  		};
> +
> +		i2c@11000 {
> +			compatible =3D "marvell,mv64xxx-i2c";
> +			reg =3D <0x11000 0x20>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <29>;
> +			clock-frequency =3D <400000>;
> +			timeout-ms =3D <1000>;
> +			status =3D "disable";
> +		};
>  	};
>  };
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/b=
oard-dt.c
> index 8f8da5d..24c8fdd 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -28,6 +28,8 @@ static struct of_device_id kirkwood_dt_match_table[] __=
initdata =3D {
> =20
>  struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata =3D {
>  	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> +	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
> +		       NULL),
>  	{},
>  };
> =20
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/com=
mon.c
> index f261cd2..078d9c6 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -17,6 +17,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/clk-provider.h>
>  #include <linux/spinlock.h>
> +#include <linux/mv643xx_i2c.h>
>  #include <net/dsa.h>
>  #include <asm/page.h>
>  #include <asm/timex.h>
> @@ -241,6 +242,7 @@ void __init kirkwood_clk_init(void)
>  	orion_clkdev_add("0", "pcie", pex0);
>  	orion_clkdev_add("1", "pcie", pex1);
>  	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
> +	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", runit);
>  }
> =20
>  /***********************************************************************=
******
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index c179378..d245a87 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -47,6 +47,7 @@ void __init orion_clkdev_init(struct clk *tclk)
>  	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".2", tclk);
>  	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".3", tclk);
>  	orion_clkdev_add(NULL, "orion_wdt", tclk);
> +	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", tclk);
>  }
> =20
>  /* Fill in the resources structure and link it into the platform
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 4f44a33..e97246b 100644
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
> @@ -98,6 +103,7 @@ struct mv64xxx_i2c_data {
>  	int			rc;
>  	u32			freq_m;
>  	u32			freq_n;
> +	struct clk              *clk;
>  	wait_queue_head_t	waitq;
>  	spinlock_t		lock;
>  	struct i2c_msg		*msg;
> @@ -521,6 +527,36 @@ mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_=
data)
>  	drv_data->reg_base_p =3D 0;
>  }
> =20
> +#ifdef CONFIG_OF

Hooray, we have one big CONFIG_OF block, so we could move other stuff
here? See below.

> +static int __devinit
> +calc_freq(const int tclk, const int n, const int m)
> +{
> +	return tclk / (10 * (m + 1) * (2 << n));
> +}
> +
> +static bool __devinit
> +find_baud_factors(const int req_freq, const int tclk, int *best_n, int *=
best_m)
> +{
> +	int freq, delta, best_delta =3D INT_MAX;
> +	int m, n;
> +
> +	for (n =3D 0; n <=3D 7; n++)
> +		for (m =3D 0; m <=3D 15; m++) {
> +			freq =3D calc_freq(tclk, n, m);
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
> +#endif
>  static int __devinit
>  mv64xxx_i2c_probe(struct platform_device *pd)
>  {
> @@ -528,7 +564,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  	struct mv64xxx_i2c_pdata	*pdata =3D pd->dev.platform_data;
>  	int	rc;
> =20
> -	if ((pd->id !=3D 0) || !pdata)
> +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id !=3D 0)))
>  		return -ENODEV;

(extra points if you rebase your patch on top of this patch
d61a9095155e832287552a9e565b8756ee293c46 from my next tree:
git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-next)

> =20
>  	drv_data =3D kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> @@ -546,19 +582,64 @@ mv64xxx_i2c_probe(struct platform_device *pd)
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

Call this code only when CONFIG_OF?

> +#endif
> +	if (pdata) {
> +		drv_data->freq_m =3D pdata->freq_m;
> +		drv_data->freq_n =3D pdata->freq_n;
> +		drv_data->irq =3D platform_get_irq(pd, 0);
> +	}
> +#ifdef CONFIG_OF
> +	if (pd->dev.of_node) {

Move this stuff into a seperate function and put it into the big
CONFIG_OF block? That should make the code a lot more readable?

> +		int bus_freq;
> +		int tclk;
> +		/* CLK is mandatory when using DT to describe the i2c
> +		 * bus. We need to know tclk in order to calculate bus
> +		 * clock factors. */
> +#if defined(CONFIG_HAVE_CLK)
> +		if (IS_ERR(drv_data->clk)) {
> +			rc =3D -ENODEV;
> +			goto exit_unmap_regs;
> +		}
> +		tclk =3D clk_get_rate(drv_data->clk);
> +		of_property_read_u32(pd->dev.of_node, "clock-frequency",
> +				     &bus_freq);
> +		if (!find_baud_factors(bus_freq, tclk,
> +				       &drv_data->freq_n, &drv_data->freq_m)) {
> +			rc =3D -EINVAL;
> +			goto exit_unmap_regs;
> +		}
> +		drv_data->irq =3D irq_of_parse_and_map(pd->dev.of_node, 0);
> +#else
> +		/* Have OF but no CLK */
> +		rc =3D -ENODEV;
> +		goto exit_unmap_regs;
> +#endif
> +	}
> +#endif
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
> +	if (pd->dev.of_node)
> +		drv_data->adapter.timeout =3D msecs_to_jiffies(
> +			of_property_read_u32(pd->dev.of_node, "timeout-ms",
> +					     &drv_data->freq_n));
> +	else
> +		drv_data->adapter.timeout =3D msecs_to_jiffies(pdata->timeout);

This should also go into the new function.

>  	drv_data->adapter.nr =3D pd->id;
> +	drv_data->adapter.dev.of_node =3D pd->dev.of_node;
>  	platform_set_drvdata(pd, drv_data);
>  	i2c_set_adapdata(&drv_data->adapter, drv_data);
> =20
> @@ -577,6 +658,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  		goto exit_free_irq;
>  	}
> =20
> +	of_i2c_register_devices(&drv_data->adapter);
> +
>  	return 0;
> =20
>  	exit_free_irq:
> @@ -597,17 +680,31 @@ mv64xxx_i2c_remove(struct platform_device *dev)
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
> =20
> --=20
> 1.7.10
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAJNGEACgkQD27XaX1/VRuoNQCcCFKAGlnf49cdRE/UQqZ5XO7G
fQwAoL8MxMt/Po6wYqjU28qJZV4QKSZH
=Ugzv
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


--===============2818843050426346909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2818843050426346909==--
