From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 6/8] i2c:i2c-bfin-twi: include twi head file
Date: Mon, 11 Jun 2012 18:34:43 +0200
Message-ID: <20120611163443.GF3887@pengutronix.de>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
 <1337152826-9850-6-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1337152826-9850-6-git-send-email-sonic.zhang@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sonic.zhang@analog.com
Cc: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Bob Liu <lliubbo@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2012 at 03:20:24PM +0800, sonic.zhang@analog.com wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>=20
> TWI bit mask macros are moved to twi head file.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> Signed-off-by: Bob Liu <lliubbo@gmail.com>

Please state the dependency if any, or the commit if already merged.

> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-b=
fin-twi.c
> index 594bbb1..d7e8fba 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -25,6 +25,7 @@
>  #include <asm/blackfin.h>
>  #include <asm/portmux.h>
>  #include <asm/irq.h>
> +#include <asm/bfin_twi.h>
> =20
>  /* SMBus mode*/
>  #define TWI_I2C_MODE_STANDARD		1
> --=20
> 1.7.0.4
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/WHiMACgkQD27XaX1/VRsDdACfZt4o60hraEosUnwF1KtGolWf
U2sAoLX2Qh/EuyeKSJjXo3FSuytm6478
=D82f
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
