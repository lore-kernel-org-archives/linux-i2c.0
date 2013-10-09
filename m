From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/9] i2c: i2c-imx: replace platform_driver_probe to
 support deferred probing
Date: Wed, 9 Oct 2013 09:34:23 +0200
Message-ID: <20131009073423.GS10079@pengutronix.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
 <1381264542-29396-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381264542-29396-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 08, 2013 at 10:35:34PM +0200, Wolfram Sang wrote:
> Subsystems like pinctrl and gpio rightfully make use of deferred prob=
ing at
> core level. Now, deferred drivers won't be retried if they don't have=
 a .probe
> function specified in the driver struct. Fix this driver to have that=
, so the
> devices it supports won't get lost in a deferred probe.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks
Uwe

> ---
>  drivers/i2c/busses/i2c-imx.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index ccf4665..1d7efa3 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -365,7 +365,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i=
2c_imx)
>  	clk_disable_unprepare(i2c_imx->clk);
>  }
> =20
> -static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> +static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  							unsigned int rate)
>  {
>  	struct imx_i2c_clk_pair *i2c_clk_div =3D i2c_imx->hwdata->clk_div;
> @@ -589,7 +589,7 @@ static struct i2c_algorithm i2c_imx_algo =3D {
>  	.functionality	=3D i2c_imx_func,
>  };
> =20
> -static int __init i2c_imx_probe(struct platform_device *pdev)
> +static int i2c_imx_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id =3D of_match_device(i2c_imx_dt_ids=
,
>  							   &pdev->dev);
> @@ -697,7 +697,7 @@ static int __init i2c_imx_probe(struct platform_d=
evice *pdev)
>  	return 0;   /* Return OK */
>  }
> =20
> -static int __exit i2c_imx_remove(struct platform_device *pdev)
> +static int i2c_imx_remove(struct platform_device *pdev)
>  {
>  	struct imx_i2c_struct *i2c_imx =3D platform_get_drvdata(pdev);
> =20
> @@ -715,7 +715,8 @@ static int __exit i2c_imx_remove(struct platform_=
device *pdev)
>  }
> =20
>  static struct platform_driver i2c_imx_driver =3D {
> -	.remove		=3D __exit_p(i2c_imx_remove),
> +	.probe =3D i2c_imx_probe,
> +	.remove =3D i2c_imx_remove,
>  	.driver	=3D {
>  		.name	=3D DRIVER_NAME,
>  		.owner	=3D THIS_MODULE,
> @@ -726,7 +727,7 @@ static struct platform_driver i2c_imx_driver =3D =
{
> =20
>  static int __init i2c_adap_imx_init(void)
>  {
> -	return platform_driver_probe(&i2c_imx_driver, i2c_imx_probe);
> +	return platform_driver_register(&i2c_imx_driver);
>  }
>  subsys_initcall(i2c_adap_imx_init);
> =20
> --=20
> 1.8.4.rc3
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
