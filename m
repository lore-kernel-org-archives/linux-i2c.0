From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: Fix pointer type passed to of_match_node()
Date: Mon, 11 Jun 2012 20:29:25 +0200
Message-ID: <20120611182925.GJ3887@pengutronix.de>
References: <1338370985-6950-1-git-send-email-k.lewandowsk@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338370985-6950-1-git-send-email-k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2012 at 11:43:05AM +0200, Karol Lewandowski wrote:
> This commit fixes warning introduced in 27452498a ("i2c-s3c2410: Rework
> device type handling"):
>=20
>   drivers/i2c/busses/i2c-s3c2410.c: In function 's3c24xx_get_device_quirk=
s':
>   drivers/i2c/busses/i2c-s3c2410.c:125: warning: passing argument 1 of 'o=
f_match_node' from incompatible pointer type
>   include/linux/of.h:245: note: expected 'const struct of_device_id *' bu=
t argument is of type 'const struct of_device_id (*)[4]'
>=20
> Signed-off-by: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Ah, now I understand why my build-test didn't spot the warning.
What config can I use to test CONFIG_OF with s3c?

> ---
>  drivers/i2c/busses/i2c-s3c2410.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3=
c2410.c
> index fa0b134..286e596 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -122,7 +122,7 @@ static inline unsigned int s3c24xx_get_device_quirks(=
struct platform_device *pde
>  {
>  	if (pdev->dev.of_node) {
>  		const struct of_device_id *match;
> -		match =3D of_match_node(&s3c24xx_i2c_match, pdev->dev.of_node);
> +		match =3D of_match_node(s3c24xx_i2c_match, pdev->dev.of_node);
>  		return (unsigned int)match->data;
>  	}
> =20
> --=20
> 1.7.10
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/WOQUACgkQD27XaX1/VRtvNACgmVRyz9ma0H9gCE28UEwaRxMx
it8An015MCnUc+aeSPA+u8ucROqRrJ0O
=eIgS
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
