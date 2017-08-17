From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] i2c: davinci: Add PM Runtime Support
Date: Thu, 17 Aug 2017 18:24:27 +0200
Message-ID: <20170817162427.izbfsa7xatjxb2aw@ninjato>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-3-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v6falnp5xon4yufw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816221715.15027-3-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com, vigneshr@ti.com, Kevin Hilman <khilman@baylibre.com>
List-Id: linux-i2c@vger.kernel.org


--v6falnp5xon4yufw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 05:17:14PM -0500, Franklin S Cooper Jr wrote:
> 66AK2G has I2C instances that are not apart of the ALWAYS_ON power domain
> like other Keystone 2 SoCs and OMAPL138. Therefore, pm_runtime
> is required to insure the power domain used by the specific I2C instance =
is
> properly turned on along with its functional clock.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

I'd need a review from the driver maintainers here. Which are Sekhar
Nori and Kevin Hilman(?) according to MAINTAINERS. Is that still
correct?

> ---
> Version 2 changes:
> Move initial calls to pm runtime autosuspend before pm_runtime_enable
>=20
>  drivers/i2c/busses/i2c-davinci.c | 62 ++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 54 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-da=
vinci.c
> index b8c4353..6b1930d 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -36,6 +36,7 @@
>  #include <linux/gpio.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_data/i2c-davinci.h>
> +#include <linux/pm_runtime.h>
> =20
>  /* ----- global defines ----------------------------------------------- =
*/
> =20
> @@ -122,6 +123,9 @@
>  /* set the SDA GPIO low */
>  #define DAVINCI_I2C_DCLR_PDCLR1	BIT(1)
> =20
> +/* timeout for pm runtime autosuspend */
> +#define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
> +
>  struct davinci_i2c_dev {
>  	struct device           *dev;
>  	void __iomem		*base;
> @@ -541,10 +545,17 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
> =20
>  	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
> =20
> +	ret =3D pm_runtime_get_sync(dev->dev);
> +	if (ret < 0) {
> +		dev_err(dev->dev, "Failed to runtime_get device: %d\n", ret);
> +		pm_runtime_put_noidle(dev->dev);
> +		return ret;
> +	}
> +
>  	ret =3D i2c_davinci_wait_bus_not_busy(dev);
>  	if (ret < 0) {
>  		dev_warn(dev->dev, "timeout waiting for bus ready\n");
> -		return ret;
> +		goto out;
>  	}
> =20
>  	for (i =3D 0; i < num; i++) {
> @@ -552,14 +563,19 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
>  		dev_dbg(dev->dev, "%s [%d/%d] ret: %d\n", __func__, i + 1, num,
>  			ret);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
>  	}
> =20
> +	ret =3D num;
>  #ifdef CONFIG_CPU_FREQ
>  	complete(&dev->xfr_complete);
>  #endif
> =20
> -	return num;
> +out:
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
> +	return ret;
>  }
> =20
>  static u32 i2c_davinci_func(struct i2c_adapter *adap)
> @@ -599,6 +615,9 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void=
 *dev_id)
>  	int count =3D 0;
>  	u16 w;
> =20
> +	if (pm_runtime_suspended(dev->dev))
> +		return IRQ_NONE;
> +
>  	while ((stat =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG))) {
>  		dev_dbg(dev->dev, "%s: stat=3D0x%x\n", __func__, stat);
>  		if (count++ =3D=3D 100) {
> @@ -802,7 +821,6 @@ static int davinci_i2c_probe(struct platform_device *=
pdev)
>  	dev->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
> -	clk_prepare_enable(dev->clk);
> =20
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dev->base =3D devm_ioremap_resource(&pdev->dev, mem);
> @@ -811,6 +829,18 @@ static int davinci_i2c_probe(struct platform_device =
*pdev)
>  		goto err_unuse_clocks;
>  	}
> =20
> +	pm_runtime_set_autosuspend_delay(dev->dev,
> +					 DAVINCI_I2C_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev->dev);
> +
> +	pm_runtime_enable(dev->dev);
> +
> +	r =3D pm_runtime_get_sync(dev->dev);
> +	if (r < 0) {
> +		dev_err(dev->dev, "failed to runtime_get device: %d\n", r);
> +		goto err_unuse_clocks;
> +	}
> +
>  	i2c_davinci_init(dev);
> =20
>  	r =3D devm_request_irq(&pdev->dev, dev->irq, i2c_davinci_isr, 0,
> @@ -849,10 +879,16 @@ static int davinci_i2c_probe(struct platform_device=
 *pdev)
>  	if (r)
>  		goto err_unuse_clocks;
> =20
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
>  	return 0;
> =20
>  err_unuse_clocks:
> -	clk_disable_unprepare(dev->clk);
> +	pm_runtime_dont_use_autosuspend(dev->dev);
> +	pm_runtime_put_sync(dev->dev);
> +	pm_runtime_disable(dev->dev);
> +
>  	dev->clk =3D NULL;
>  	return r;
>  }
> @@ -860,16 +896,26 @@ static int davinci_i2c_probe(struct platform_device=
 *pdev)
>  static int davinci_i2c_remove(struct platform_device *pdev)
>  {
>  	struct davinci_i2c_dev *dev =3D platform_get_drvdata(pdev);
> +	int ret;
> =20
>  	i2c_davinci_cpufreq_deregister(dev);
> =20
>  	i2c_del_adapter(&dev->adapter);
> =20
> -	clk_disable_unprepare(dev->clk);
> +	ret =3D pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		return ret;
> +	}
> +
>  	dev->clk =3D NULL;
> =20
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
> =20
> +	pm_runtime_dont_use_autosuspend(dev->dev);
> +	pm_runtime_put_sync(dev->dev);
> +	pm_runtime_disable(dev->dev);
> +
>  	return 0;
>  }
> =20
> @@ -880,7 +926,6 @@ static int davinci_i2c_suspend(struct device *dev)
> =20
>  	/* put I2C into reset */
>  	davinci_i2c_reset_ctrl(i2c_dev, 0);
> -	clk_disable_unprepare(i2c_dev->clk);
> =20
>  	return 0;
>  }
> @@ -889,7 +934,6 @@ static int davinci_i2c_resume(struct device *dev)
>  {
>  	struct davinci_i2c_dev *i2c_dev =3D dev_get_drvdata(dev);
> =20
> -	clk_prepare_enable(i2c_dev->clk);
>  	/* take I2C out of reset */
>  	davinci_i2c_reset_ctrl(i2c_dev, 1);
> =20
> @@ -899,6 +943,8 @@ static int davinci_i2c_resume(struct device *dev)
>  static const struct dev_pm_ops davinci_i2c_pm =3D {
>  	.suspend        =3D davinci_i2c_suspend,
>  	.resume         =3D davinci_i2c_resume,
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				      pm_runtime_force_resume)
>  };
> =20
>  #define davinci_i2c_pm_ops (&davinci_i2c_pm)
> --=20
> 2.9.4.dirty
>=20

--v6falnp5xon4yufw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVwzsACgkQFA3kzBSg
Kbb9CQ//Y72v0aNDCIkWIqd7C8WNyDbLzizVFFXHR78MCUnXwXBzzgytbr5ef2EB
G55VS9j02cRbLRr7O9XpJdNBCcF4+L0y8fh/BbSQit+Ow5RGQ2ZvzWSsNMWj0+UP
eux+glYSZ5BL4bOlvqLzm6hX23Ko8bXGxGkG03Sy5g9WMuisr9gp1Irw6yD7DaBT
qWQ5yf2exQty7STHjx2i/VEKhZI+MMrNxVfjca6d4LIyxRn+ljKXIqx4lZhiu6S+
zbwMo0LgH7OCQej06x1G8MPWiTL/Jl4yk3Y3mmU3qJIcKAyy9vJcLp+BEjpVkWVl
DZaDG2ZZ5aqHQaolYvkHb/Fh3NN4wiLgS25sErcOBHBaiY+uXIKt3ZC6CzSjLLp9
8L+cPdqe+c5ykCjiogfUPKFNNAzrsPX3c5z4qkP3cnPVmV6tSIgn9BE3oWhxWNGT
TSzNYXIX1O8uLZJiVU0pw4RjnBIbYXjdleOYdlzQoMLf0ZLCelwOWHMeK41dva1y
nby9rA6Impyer8msOjlK0Zs9AfhD2UfsbU2aLGkg1R0sWA9bzhobx6CVrM4Dz1o6
PjwW+DFMY09/U9qhmjsmx7/8Oj+tkb+/D6jelEEE1yKzlGi5U9AdxWkFTVNCbzyY
oNg4yHbXTYK1rSpE2IoE7DyjPPPzDRKHPy8B7KbeMkjv1O0r8vQ=
=q6hc
-----END PGP SIGNATURE-----

--v6falnp5xon4yufw--
