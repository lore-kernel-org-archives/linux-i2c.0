From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] blackfin/acvilon: Fix timeout usage for I2C
Date: Mon, 10 May 2010 04:36:39 +0200
Message-ID: <20100510023639.GA25544@pengutronix.de>
References: <1270389856-32003-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1270389856-32003-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Valentin Yakovenkov <yakovenkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 04, 2010 at 04:04:16PM +0200, Wolfram Sang wrote:
> The timeout value is in jiffies, so it should be using HZ, not a plain
> number. As '10000' is ambiguous, 1HZ is used as conservative default.
>=20
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> Cc: Valentin Yakovenkov <yakovenkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/blackfin/mach-bf561/boards/acvilon.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/ma=
ch-bf561/boards/acvilon.c
> index 5163e2c..bfcfa86 100644
> --- a/arch/blackfin/mach-bf561/boards/acvilon.c
> +++ b/arch/blackfin/mach-bf561/boards/acvilon.c
> @@ -44,6 +44,7 @@
>  #include <linux/spi/flash.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/jiffies.h>
>  #include <linux/i2c-pca-platform.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> @@ -112,7 +113,7 @@ static struct resource bfin_i2c_pca_resources[] =3D {
>  struct i2c_pca9564_pf_platform_data pca9564_platform_data =3D {
>  	.gpio =3D -1,
>  	.i2c_clock_speed =3D 330000,
> -	.timeout =3D 10000
> +	.timeout =3D HZ,
>  };
> =20
>  /* PCA9564 I2C Bus driver */

Ping.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvncTcACgkQD27XaX1/VRupDwCggZzcz+9VT0Baj08YoTdqiykb
2l4AnAiRh35bsceAJlQ+EhRN7Rcn7oJ1
=UiUg
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
