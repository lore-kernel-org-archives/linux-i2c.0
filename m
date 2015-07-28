From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: img-scb: use DIV_ROUND_UP to round divisor values
Date: Tue, 28 Jul 2015 11:45:14 +0100
Message-ID: <55B75D3A.40101@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-4-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ExRcOA16P7sFA2cw1b26PblNd4oN1g8WM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437997641-32575-4-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Stable kernel (v3.19+)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--ExRcOA16P7sFA2cw1b26PblNd4oN1g8WM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:47, Sifan Naeem wrote:
> Using % can be slow depending on the architecture.
>=20
> Using DIV_ROUND_UP is nicer and more efficient way to do it.
>=20
> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driv=
er")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Cc: Stable kernel (v3.19+) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Cheers
James

> ---
>  drivers/i2c/busses/i2c-img-scb.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 0368d91..b4f59e1 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -1179,9 +1179,7 @@ static int img_i2c_init(struct img_i2c *i2c)
>  		int_bitrate++;
> =20
>  	/* Setup TCKH value */
> -	tckh =3D timing.tckh / clk_period;
> -	if (timing.tckh % clk_period)
> -		tckh++;
> +	tckh =3D DIV_ROUND_UP(timing.tckh, clk_period);
> =20
>  	if (tckh > 0)
>  		data =3D tckh - 1;
> @@ -1201,9 +1199,7 @@ static int img_i2c_init(struct img_i2c *i2c)
>  	img_i2c_writel(i2c, SCB_TIME_TCKL_REG, data);
> =20
>  	/* Setup TSDH value */
> -	tsdh =3D timing.tsdh / clk_period;
> -	if (timing.tsdh % clk_period)
> -		tsdh++;
> +	tsdh =3D DIV_ROUND_UP(timing.tsdh, clk_period);
> =20
>  	if (tsdh > 1)
>  		data =3D tsdh - 1;
>=20


--ExRcOA16P7sFA2cw1b26PblNd4oN1g8WM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVt11BAAoJEGwLaZPeOHZ6eq8QAIOSqe7axJWgvsDlOpt+xxYE
lZVoHdnSFGRGjI6E7KY7xB9HVI4tkFklTIXCQ7MR01qK5VZreW28Ho+EfwSbb9y7
AMR1sfYcB9E5Y2FUUiH7jRqHphOaloqNSrD1TqCELbX/+tNuW1aLOAQE4X45Xx4/
3UYsVMvtR6oWQeiQoW91sRnEV+silvwNp1Oj3mp1tBVamgdS0uw1vS6sy5cDXBPK
BplU8S4RGg2PnoXBHmjFac9uVgBoP08SD4Goe+oChJY/BFnZM3uzZWRp/Sk3cduT
sc8zmJqftjSsUsi3PAC+ZSNnfbBCxlBBIGW1vJk4Duz/mCsgt/qlPTpc8atGmeUh
DTLoJyqCK0PoiVbYNlzz08vldlzvNDr+Jkj/C2IUXXJB8sKxPCqyzd1L+ubVAZwc
7sqD6z97Ze+PQafaqtQ/XAUnSpfqpYrGhpjEMhYaCOlNG0CFXwq0KKfZVouYmRfW
6ra7woyb3/XhKVnwwsepwI/A/zThETswbUQJVjoWwF/heIHc760wM4k3EwfK+OxE
A07F/t3NgcRWxVlhscKzkne6zKwL0UruH3TguF4GNFn+UsrY6PUIAqKToPwQ3ng5
YTFhShsCPCUr3isr3/kzF8DX1WtOAIPkrQmprn7bw9W66+3PiMyi6u4myElxu87Q
oXkgVGgDKsk70suOsMj1
=eNcj
-----END PGP SIGNATURE-----

--ExRcOA16P7sFA2cw1b26PblNd4oN1g8WM--
