From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH -next] i2c: imx: add missing clk_disable_unprepare() on
 error path
Date: Fri, 20 Dec 2013 18:40:06 +0100
Message-ID: <20131220174006.GB9997@katana>
References: <CAPgLHd-zvCacvi5gN-PSqow5-NujhwtXa2RcnNQvorMmAEucrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-zvCacvi5gN-PSqow5-NujhwtXa2RcnNQvorMmAEucrw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2013 at 10:26:10PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Add the missing clk_disable_unprepare() before return in
> the error handling cases.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-imx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d0cfbb4..e62f3be 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -328,8 +328,10 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_=
imx)
>  	temp |=3D I2CR_MSTA;
>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>  	result =3D i2c_imx_bus_busy(i2c_imx, 1);
> -	if (result)
> +	if (result) {
> +		clk_disable_unprepare(i2c_imx->clk);
>  		return result;
> +	}
>  	i2c_imx->stopped =3D 0;

Nice catch, but that is not enough. The logic between i2x_imx_start and
*_stop is still broken. *_start may return with clocks enabled or not
while stop will unconditionally disables them.


> =20
>  	temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> @@ -654,7 +656,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  				pdev->name, i2c_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> -		return ret;
> +		goto err_out;
>  	}
> =20
>  	/* Init queue */
> @@ -680,7 +682,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	ret =3D i2c_add_numbered_adapter(&i2c_imx->adapter);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "registration failed\n");
> -		return ret;
> +		goto err_out;
>  	}
> =20
>  	/* Set up platform driver data */
> @@ -697,6 +699,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> =20
>  	return 0;   /* Return OK */
> +err_out:
> +	clk_disable_unprepare(i2c_imx->clk);
> +	return ret;

Why not just enabling the clocks around the small codeblock that needs
them?


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJStID2AAoJEBQN5MwUoCm24iUP/12TzwuLUt77EfuGlxf6MAkJ
Y+gNohbxI+smU8x+6QtiDXv1rgNFXTXIeF9Lzt/BaAnllGCtSDRVxcSq25HhLTp8
Q7yHJ9lm/6d0nlR+OoKOdf36anYbEDBUKjPXc1dksNchZSkNgIerMkglUlCsZi4e
BuVxanGhHBfLv3+riscY4LRqvuIIiCuk8OJlwdsFnLIjtng0BANlZroI8oAx6Ob7
k98HKupVF1rPuvG0/c1OFJTZfXS1OoattKDcseeszSw03YC5bJwl2gHfE2QyuNuY
R24+2amr8moIiW6lyhWSYqf1zeEnC0Imr493ZTLHhncDWDh2gQxgLOzWQUJE9wM2
wz9vxLUG7stD1qbCceJZC5oSAX2XsPFoML5xUT3du+zrdN0INnrC7VgoAnRHsS6u
ySkeh0Zt6B3A9k9hvYpEB5ASxvwIGyG+3CA3by5/3fD1ZPKMoyhlQexMUCnfc4RT
nhj5v6PbG/3GYqlRzkTobmAIVC7dKFThCOWIB7A1rp52tze7mYn3UvzxAu1xGr/F
xqvU28BqtFdYp8qIm7uaLXIaIpvA4CBgXPT/x9MY1wug3CVcBsXxoYAvqwsPA84m
4kreqNLWHbrOvgtvASb1vgrLsjvyBREo/iUCTqkjoCltYn4VGzVCr6xWvXlxpdoa
LlKsMaJF3rTRaosR/03u
=cqo5
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
