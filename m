From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/6] i2c-xiic:  Fix a possible NULL pointer access
Date: Sat, 18 Aug 2012 12:17:52 +0200
Message-ID: <20120818101752.GE24812@pengutronix.de>
References: <1344519467-14295-1-git-send-email-shubhrajyoti@ti.com>
 <1344519467-14295-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344519467-14295-3-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 07:07:43PM +0530, Shubhrajyoti D wrote:
> platform_get_resource uses pdev so move the function
> platform_set_drvdata(pdev, NULL) after the get_resource.

This descriptions sounds as you'd assume pdev is set to NULL here?
Careful, platform_set_drvdata() does not clear pdev, but driver_data of
pdev->dev!

So, I guess the rest of this series is bogus?

It would be worth checking if other drivers have the same pattern as the
omap driver where the fix was valid for other reasons. Are you
interested in doing that (perfectly fine to say no).

Regards,

   Wolfram

>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
> untested
>=20
>  drivers/i2c/busses/i2c-xiic.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 641d0e5..a28479a 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -784,8 +784,6 @@ static int __devexit xiic_i2c_remove(struct platform_=
device* pdev)
> =20
>  	xiic_deinit(i2c);
> =20
> -	platform_set_drvdata(pdev, NULL);
> -
>  	free_irq(platform_get_irq(pdev, 0), i2c);
> =20
>  	iounmap(i2c->base);
> @@ -795,6 +793,7 @@ static int __devexit xiic_i2c_remove(struct platform_=
device* pdev)
>  		release_mem_region(res->start, resource_size(res));
> =20
>  	kfree(i2c);
> +	platform_set_drvdata(pdev, NULL);
> =20
>  	return 0;
>  }
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAva9AACgkQD27XaX1/VRt3awCfSYgxber0vxj4seQAgkA0Swcv
6DwAoIXG39eqRt9763Ulb3xAj4M3304W
=yitC
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
