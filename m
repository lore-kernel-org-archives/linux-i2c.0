From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 7/7] i2c: img-scb: verify support for requested bit
 rate
Date: Wed, 19 Aug 2015 22:17:50 +0100
Message-ID: <20150819211750.GD8443@jhogan-linux.le.imgtec.org>
References: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
 <1439567424-8094-8-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439567424-8094-8-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 04:50:24PM +0100, Sifan Naeem wrote:
> The requested bit rate can be outside the range supported by the driver.
> The maximum bit rate this driver supports at the moment is 400Khz.
>=20
> If the requested bit rate is larger than the maximum supported by the
> driver, set the bitrate to the maximum supported before bitrate_khz is
> calculated.
>=20
> Maximum speed supported by the driver can be increased to 1Mhz by
> adding support for "fast plus mode" in the future.
>=20
> Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I=
2C SCB driver")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
> index 6c21a7bd9a66..c16caaccc363 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -1138,9 +1138,6 @@ static int img_i2c_init(struct img_i2c *i2c)
>  	/* Fencing enabled by default. */
>  	i2c->need_wr_rd_fence =3D true;
> =20
> -	bitrate_khz =3D i2c->bitrate / 1000;
> -	clk_khz =3D clk_get_rate(i2c->scb_clk) / 1000;
> -
>  	/* Determine what mode we're in from the bitrate */
>  	timing =3D timings[0];
>  	for (i =3D 0; i < ARRAY_SIZE(timings); i++) {
> @@ -1149,6 +1146,17 @@ static int img_i2c_init(struct img_i2c *i2c)
>  			break;
>  		}
>  	}
> +	if (i2c->bitrate > timings[ARRAY_SIZE(timings) - 1].max_bitrate) {
> +		dev_warn(i2c->adap.dev.parent,
> +			 "requested bitrate (%d) is higher than the max bitrate supported (%d=
)\n",

Technically both i2c->bitrate and timings[].max_bitrate are unsigned, so
%u would be more correct for both.

Otherwise:
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Wolfram: are you happy to fix the %u thing when applying it, or would
you prefer me to submit a fixed patch (Sifan is off for a few weeks I
believe).

(Still need to look at the other changes...)

Cheers
James

> +			 i2c->bitrate,
> +			 timings[ARRAY_SIZE(timings) - 1].max_bitrate);
> +		timing =3D timings[ARRAY_SIZE(timings) - 1];
> +		i2c->bitrate =3D timing.max_bitrate;
> +	}
> +
> +	bitrate_khz =3D i2c->bitrate / 1000;
> +	clk_khz =3D clk_get_rate(i2c->scb_clk) / 1000;
> =20
>  	/* Find the prescale that would give us that inc (approx delay =3D 0) */
>  	prescale =3D SCB_OPT_INC * clk_khz / (256 * 16 * bitrate_khz);
> --=20
> 1.7.9.5
>=20

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV1PJ+AAoJEGwLaZPeOHZ6kRcP/i/X1Mk8XDkW3l0C+9y2LcB9
tFNxj369jkcMr7pjf//GVXjHJvx/ihOMFDGxqpjRJJ4rt9zViwz3gyu1xfbuJ/Ba
Cs/2zzXWeJF6S8ZeT/lrpYXNXyamgu5HJa9EN5eePtl9agIaKzJSufSvrKi/tdDE
uhuvXOdVw3jNemg2pwQoW8K1ZeRCsa5cSZExUFnFiquc1r+Kavtp2CsUCXR1zfby
AEwVpUyKu8PrU4Yp2GUWpDQIHdCahnkH2r1Y06YJaN4gIKzyebtMb/55w2li+BiX
nnagsmR8Tr8fFXz+zAIn3xsZ2ojdY1WEMsT0Pq1XUAswIYkL1AH6gwqqMYjDGvkd
1HbcMK0nSfGrPjy6Mi75KG6WkPgA15Ul4fejHQNiv5GpbIg3kqT28VwnOy6dfdOv
8kBgX2taOjpaUxBBuqnltZUDLeZeA64rjYPi+jNzzA8PHpJHXcJBWNTx/NHFDV1i
8X2fm++YTvFbEnd118QkD9fZCXoQGOqMSMqKKcQalXhvq64zu+hypqVscZe5+vti
VvUXcfKPBW2QbfVq5W0wAU+N2+fa6cUp5fQ4HNpbW6617/JNOVHAl0WBz1XGcEvB
L68yGcbzuzXtx1Ku9SxOkv7YSRvqfU8j7O+ThCGZOe7szXhPXOHVe/90GKZkNvL+
l8eo4XRwgme46oDEh4ST
=WQH/
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
