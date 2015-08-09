From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: viperboard: clean up inconsistent indenting
Date: Sun, 9 Aug 2015 17:29:45 +0200
Message-ID: <20150809152944.GB2367@katana>
References: <1437134483-18286-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437134483-18286-1-git-send-email-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2015 at 01:01:23PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>=20
> Minor clean up of indenting, no functional change
>=20
> Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> ---

Applied to for-next, thanks!

>  drivers/i2c/busses/i2c-viperboard.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c=
-viperboard.c
> index 47e88ad..30cce15 100644
> --- a/drivers/i2c/busses/i2c-viperboard.c
> +++ b/drivers/i2c/busses/i2c-viperboard.c
> @@ -391,11 +391,12 @@ static int vprbrd_i2c_probe(struct platform_device =
*pdev)
>  			VPRBRD_USB_REQUEST_I2C_FREQ, VPRBRD_USB_TYPE_OUT,
>  			0x0000, 0x0000, &vb_i2c->bus_freq_param, 1,
>  			VPRBRD_USB_TIMEOUT_MS);
> -	    if (ret !=3D 1) {
> -		dev_err(&pdev->dev,
> -			"failure setting i2c_bus_freq to %d\n", i2c_bus_freq);
> -		return -EIO;
> -	    }
> +		if (ret !=3D 1) {
> +			dev_err(&pdev->dev,
> +				"failure setting i2c_bus_freq to %d\n",

Squashed those two lines into one, though.

> +				i2c_bus_freq);
> +			return -EIO;
> +		}
>  	} else {
>  		dev_err(&pdev->dev,
>  			"invalid i2c_bus_freq setting:%d\n", i2c_bus_freq);
> --=20
> 2.1.4
>=20

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVx3HoAAoJEBQN5MwUoCm2TmYP/A0CgSSS5+qPQ0X7GgpKtUKD
nU6AAKukJcKJcJB1Hk4cMCCyeIy5JyoxTRBmM2tnV1YXK+u549KvL09ApE2I0QIq
cye/ymeZ0Pu/+Oxj2sDQF9yxVl1AmgO3kDQzTmyhNCraDna1Af4pmUHNhrNvRfy2
Z1Ao6J3cEpU6pyjh+vaf4XigIRsWrQwmEZVrby6WCSdKxGILEzQsA/FKE9TF4B3i
ev8J3jGG/6R+0vqaN9O3Tzl2gda3dYQ9qlaGRNuBX72WSBsJvivTzuIJOD+UNC4h
Qk89PxGOOttr0j1Maw57Ki2jjOgo43ci5vbjvJQRryE3xwyq0CSNiAh+NisvrW4D
HX4pzH0kzm0PMW8hXgsL73OIScJQgDUVlCI0oQDk15uhBXXKknhh4MMhzbgxXRXT
1AvztLGjf15iL+Wka0EODfC3XUvLHH3wAWlU1woF4X2XVe+gmPbmTxgNX8WK1aCU
AKKau0ECAkT4/QGnQfjK1xvfCrzyIUrcpl/+BUBz3rg7DOMl4w74A87N+n1kBrKa
Ulfp1YAKaRp4qHqEvK0UyIfTvL8XxuwCnomF5090lNoVsnm3pcNVn0AxaCoTPj1x
0gmzRBamucKAzF/4bbjN5LbWY9GRVUeOPwrNmbo5o8wlVNe4qIAQMCO7NQnrpiyI
4ZjIE84V/xDtMLQ1vU5C
=AT2S
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
