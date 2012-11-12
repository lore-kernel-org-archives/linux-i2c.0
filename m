From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2 v3] i2c: nomadik: adopt pinctrl support
Date: Mon, 12 Nov 2012 18:03:49 +0100
Message-ID: <20121112170349.GB15159@pengutronix.de>
References: <1349866959-10686-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1349866959-10686-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 10, 2012 at 01:02:39PM +0200, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>=20
> Amend the I2C nomadik pin controller to optionally take a pin control
> handle and set the state of the pins to:
>=20
> - "default" on boot, resume and before performing an i2c transfer
> - "idle" after initial default, after resume default, and after each
>    i2c xfer
> - "sleep" on suspend()
>=20
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle, and for runtime cases inbetween
> I2C transfers.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

One minor issue I'd fix myself...

> ---
> ChangeLog v2->v3:
> - Rebase on top of the patch from Philippe/Ulf.

=2E.. if this was really true which I am unsure.

> ChangeLog v1->v2:
> - We used only two states initially: default and sleep. It turns
>   out you can save some energy when idling (between transfers)
>   and even more when suspending on our platform, so grab all
>   three states and use them as applicable.
> ---
>  drivers/i2c/busses/i2c-nomadik.c | 101 +++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 101 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index 3eeae52..d50b16a 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/i2c-nomadik.h>
> +#include <linux/pinctrl/consumer.h>
> =20
>  #define DRIVER_NAME "nmk-i2c"
> =20
> @@ -145,6 +146,10 @@ struct i2c_nmk_client {
>   * @stop: stop condition.
>   * @xfer_complete: acknowledge completion for a I2C message.
>   * @result: controller propogated result.
> + * @pinctrl: pinctrl handle.
> + * @pins_default: default state for the pins.
> + * @pins_idle: idle state for the pins.
> + * @pins_sleep: sleep state for the pins.
>   * @busy: Busy doing transfer.
>   */
>  struct nmk_i2c_dev {
> @@ -158,6 +163,11 @@ struct nmk_i2c_dev {
>  	int				stop;
>  	struct completion		xfer_complete;
>  	int				result;
> +	/* Three pin states - default, idle & sleep */
> +	struct pinctrl			*pinctrl;
> +	struct pinctrl_state		*pins_default;
> +	struct pinctrl_state		*pins_idle;
> +	struct pinctrl_state		*pins_sleep;
>  	bool				busy;
>  };
> =20
> @@ -648,6 +658,15 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  		goto out_clk;
>  	}
> =20
> +	/* Optionaly enable pins to be muxed in and configured */
> +	if (!IS_ERR(dev->pins_default)) {
> +		status =3D pinctrl_select_state(dev->pinctrl,
> +				dev->pins_default);
> +		if (status)
> +			dev_err(&dev->adev->dev,
> +				"could not set default pins\n");

I am not too strict on the 80 char limit, so if it is just a little
over, you can keep it one line. I don't mind here...

> +	}
> +
>  	status =3D init_hw(dev);
>  	if (status)
>  		goto out;
> @@ -675,6 +694,15 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  out:
>  	clk_disable_unprepare(dev->clk);
>  out_clk:
> +	/* Optionally let pins go into idle state */
> +	if (!IS_ERR(dev->pins_idle)) {
> +		status =3D pinctrl_select_state(dev->pinctrl,
> +				dev->pins_idle);
> +		if (status)
> +			dev_err(&dev->adev->dev,
> +				"could not set pins to idle state\n");

=2E.. and here ...

> +	}
> +
>  	pm_runtime_put_sync(&dev->adev->dev);
> =20
>  	dev->busy =3D false;
> @@ -869,15 +897,44 @@ static int nmk_i2c_suspend(struct device *dev)
>  {
>  	struct amba_device *adev =3D to_amba_device(dev);
>  	struct nmk_i2c_dev *nmk_i2c =3D amba_get_drvdata(adev);
> +	int ret;
> =20
>  	if (nmk_i2c->busy)
>  		return -EBUSY;
> =20
> +	if (!IS_ERR(nmk_i2c->pins_sleep)) {
> +		ret =3D pinctrl_select_state(nmk_i2c->pinctrl,
> +				nmk_i2c->pins_sleep);
> +		if (ret)
> +			dev_err(dev,
> +				"could not set pins to sleep state\n");

=2E.. but I'd think here one line is the better choice.

> +	}
> +
>  	return 0;
>  }
> =20
>  static int nmk_i2c_resume(struct device *dev)
>  {
> +	struct amba_device *adev =3D to_amba_device(dev);
> +	struct nmk_i2c_dev *nmk_i2c =3D amba_get_drvdata(adev);
> +	int ret;
> +
> +	/* First go to the default state */
> +	if (!IS_ERR(nmk_i2c->pins_default)) {
> +		ret =3D pinctrl_select_state(nmk_i2c->pinctrl,
> +				nmk_i2c->pins_default);
> +		if (ret)
> +			dev_err(dev,
> +				"could not set pins to default state\n");

ditto

> +	}
> +	/* Then let's idle the pins until the next transfer happens */
> +	if (!IS_ERR(nmk_i2c->pins_idle)) {
> +		ret =3D pinctrl_select_state(nmk_i2c->pinctrl,
> +				nmk_i2c->pins_idle);
> +		if (ret)
> +			dev_err(dev,
> +				"could not set pins to idle state\n");

ditto

> +	}
>  	return 0;
>  }
>  #else
> @@ -941,6 +998,40 @@ static int nmk_i2c_probe(struct amba_device *adev, c=
onst struct amba_id *id)
>  	dev->adev =3D adev;
>  	amba_set_drvdata(adev, dev);
> =20
> +	dev->pinctrl =3D devm_pinctrl_get(&adev->dev);
> +	if (IS_ERR(dev->pinctrl)) {
> +		ret =3D PTR_ERR(dev->pinctrl);
> +		goto err_pinctrl;
> +	}
> +
> +	dev->pins_default =3D pinctrl_lookup_state(dev->pinctrl,
> +						 PINCTRL_STATE_DEFAULT);
> +	if (IS_ERR(dev->pins_default))
> +		dev_err(&adev->dev, "could not get default pinstate\n");
> +	else {
> +		ret =3D pinctrl_select_state(dev->pinctrl,
> +					   dev->pins_default);
> +		if (ret)
> +			dev_dbg(&adev->dev, "could not set default pinstate\n");
> +	}
> +
> +	dev->pins_idle =3D pinctrl_lookup_state(dev->pinctrl,
> +					      PINCTRL_STATE_IDLE);
> +	if (IS_ERR(dev->pins_idle))
> +		dev_dbg(&adev->dev, "could not get idle pinstate\n");
> +	else {
> +		/* If possible, let's go to idle until the first transfer */
> +		ret =3D pinctrl_select_state(dev->pinctrl,
> +					   dev->pins_idle);
> +		if (ret)
> +			dev_dbg(&adev->dev, "could not set idle pinstate\n");
> +	}
> +
> +	dev->pins_sleep =3D pinctrl_lookup_state(dev->pinctrl,
> +					       PINCTRL_STATE_SLEEP);
> +	if (IS_ERR(dev->pins_sleep))
> +		dev_dbg(&adev->dev, "could not get sleep pinstate\n");
> +
>  	dev->virtbase =3D ioremap(adev->res.start, resource_size(&adev->res));
>  	if (!dev->virtbase) {
>  		ret =3D -ENOMEM;
> @@ -964,6 +1055,12 @@ static int nmk_i2c_probe(struct amba_device *adev, =
const struct amba_id *id)
>  		goto err_no_clk;
>  	}
> =20
> +	ret =3D clk_prepare(dev->clk);
> +	if (ret) {
> +		dev_err(&adev->dev, "can't prepare clock\n");
> +		goto err_prep_clk;
> +	}
> +

And here I am not sure if the rebasing worked. I don't think you want
the clock handling here. If you do, it is a seperate patch.

>  	adap =3D &dev->adap;
>  	adap->dev.parent =3D &adev->dev;
>  	adap->owner	=3D THIS_MODULE;
> @@ -999,6 +1096,8 @@ static int nmk_i2c_probe(struct amba_device *adev, c=
onst struct amba_id *id)
>  	return 0;
> =20
>   err_add_adap:
> +	clk_unprepare(dev->clk);
> + err_prep_clk:
>  	clk_put(dev->clk);
>   err_no_clk:
>  	free_irq(dev->irq, dev);
> @@ -1007,6 +1106,7 @@ static int nmk_i2c_probe(struct amba_device *adev, =
const struct amba_id *id)
>   err_no_ioremap:
>  	amba_set_drvdata(adev, NULL);
>  	kfree(dev);
> + err_pinctrl:
>   err_no_mem:
> =20
>  	return ret;
> @@ -1027,6 +1127,7 @@ static int nmk_i2c_remove(struct amba_device *adev)
>  	iounmap(dev->virtbase);
>  	if (res)
>  		release_mem_region(res->start, resource_size(res));
> +	clk_unprepare(dev->clk);
>  	clk_put(dev->clk);
>  	pm_runtime_disable(&adev->dev);
>  	amba_set_drvdata(adev, NULL);
> --=20
> 1.7.11.3
>=20

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlChK/UACgkQD27XaX1/VRuUgwCdGd/e+RbbbuzslNKz6RnQ4dXL
fQQAoKcp9uO4KSgzH6bTzoQlu8pj9zpk
=cqdt
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
