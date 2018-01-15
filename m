From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 07/12] i2c: rk3x: account for const type of
 of_device_id.data
Date: Mon, 15 Jan 2018 19:24:56 +0100
Message-ID: <20180115182456.zkx2ehdlxzrc2scu@ninjato>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="emwm4gsssaxoraj4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40978 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeAOSY6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 13:24:58 -0500
Content-Disposition: inline
In-Reply-To: <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--emwm4gsssaxoraj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 02:28:03PM +0100, Julia Lawall wrote:
> This driver creates a number of const structures that it stores in
> the data field of an of_device_id array.
>=20
> The data field of an of_device_id structure has type const void *, so
> there is no need for a const-discarding cast when putting const values
> into such a structure.
>=20
> Furthermore, adding const to the declaration of the location that
> receives a const value from such a field ensures that the compiler
> will continue to check that the value is not modified.  The
> const-discarding cast on the extraction from the data field is thus
> no longer needed.
>=20
> Done using Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Heiko, you okay with the patch?

>=20
> ---
>  drivers/i2c/busses/i2c-rk3x.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff -u -p a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -194,7 +194,7 @@ struct rk3x_i2c_soc_data {
>  struct rk3x_i2c {
>  	struct i2c_adapter adap;
>  	struct device *dev;
> -	struct rk3x_i2c_soc_data *soc_data;
> +	const struct rk3x_i2c_soc_data *soc_data;
> =20
>  	/* Hardware resources */
>  	void __iomem *regs;
> @@ -1164,27 +1164,27 @@ static const struct rk3x_i2c_soc_data rk
>  static const struct of_device_id rk3x_i2c_match[] =3D {
>  	{
>  		.compatible =3D "rockchip,rv1108-i2c",
> -		.data =3D (void *)&rv1108_soc_data
> +		.data =3D &rv1108_soc_data
>  	},
>  	{
>  		.compatible =3D "rockchip,rk3066-i2c",
> -		.data =3D (void *)&rk3066_soc_data
> +		.data =3D &rk3066_soc_data
>  	},
>  	{
>  		.compatible =3D "rockchip,rk3188-i2c",
> -		.data =3D (void *)&rk3188_soc_data
> +		.data =3D &rk3188_soc_data
>  	},
>  	{
>  		.compatible =3D "rockchip,rk3228-i2c",
> -		.data =3D (void *)&rk3228_soc_data
> +		.data =3D &rk3228_soc_data
>  	},
>  	{
>  		.compatible =3D "rockchip,rk3288-i2c",
> -		.data =3D (void *)&rk3288_soc_data
> +		.data =3D &rk3288_soc_data
>  	},
>  	{
>  		.compatible =3D "rockchip,rk3399-i2c",
> -		.data =3D (void *)&rk3399_soc_data
> +		.data =3D &rk3399_soc_data
>  	},
>  	{},
>  };
> @@ -1207,7 +1207,7 @@ static int rk3x_i2c_probe(struct platfor
>  		return -ENOMEM;
> =20
>  	match =3D of_match_node(rk3x_i2c_match, np);
> -	i2c->soc_data =3D (struct rk3x_i2c_soc_data *)match->data;
> +	i2c->soc_data =3D match->data;
> =20
>  	/* use common interface to get I2C timing properties */
>  	i2c_parse_fw_timings(&pdev->dev, &i2c->t, true);
>=20

--emwm4gsssaxoraj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc8fgACgkQFA3kzBSg
KbZhJxAAoy2fQHMfVVvlwVplaox+UGqMx/gpuWRW1MwhXiSz/e01BWeWyM0bCKgt
IYRsphQkJaRKU+92K/wHtRgNNDZLfRnzkinbNMFBH62PXls6Qo7i0gqB08xBxUsp
vbpVwPxDTvJ36lelY5rcK2/ysrRIx5j097GIcLAv6f0EIgiei34OPBw9rYSIkT1n
C1nNXc734fCwfaIGxqGiaseZsg97l0rqJ7vKmFtve0XRU9kCNQG7vQ4eNhI6y4n0
h3JkjZyuAtDEybMP5omMZqx6GwGmnJKtbNzHpcPvrMxN2KZ2clmzeWuK6rlF52Wo
b7KHBLrC7OGdzUJrZvUY9QKA/tcxoI1ipyXHG60K6sACtLJSBNcoMn9jK/I6kS2Y
obeaXrqtHZE4gfrOY5/QwPcAdGmXMrE4aoAfz0sJUqSXYMb5sc7tk6pcCjxU0gLl
m6p4cclaVmEBNxsBd/r8CRKWJL/sJH+KGd5LKtVLKi9X3jdjBbBcbkGDxVb8rkZJ
XAh2TMu5PFnwLOZwR00/CQDKQvN34msfFgs65ISQ9DwtSZ08hiNYqhA95N4BfimF
5IZ0GKpcbg7MwFV8AK31qUagg0YCVQDQOVQS/qwPoJoId9S46syjGsJX6Lt8DdSC
tFKe38lR3GeH1mNZtjeKoMPwvDLISFME1NGGUrmf24VLL8D5Rjc=
=RPfk
-----END PGP SIGNATURE-----

--emwm4gsssaxoraj4--
