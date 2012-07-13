From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/8 v2] i2c: i2c-bfin-twi: Tighten condition when failing
 I2C transfer if MEN bit is reset unexpectedly.
Date: Fri, 13 Jul 2012 08:31:59 +0200
Message-ID: <20120713063159.GB32184@pengutronix.de>
References: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
 <1339575767-22985-4-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1339575767-22985-4-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 04:22:43PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> In order to mark I2C transfer fail when MEN bit in I2C controller is rese=
t unexpeced

"unexpected"

> in MCOMP interrupt, interrupt status bits XMTSERV or RCVSERV should be ch=
ecked.
>=20
> Master Transfer Complete (MCOMP).
> [1] The initiated master transfer has completed. In the absence of a
> repeat start, the bus has been released.
> [0] The completion of a transfer has not been detected.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-b=
fin-twi.c
> index a5ab454..2e59bbd 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -201,7 +201,8 @@ static void bfin_twi_handle_interrupt(struct bfin_twi=
_iface *iface,
>  		return;
>  	}
>  	if (twi_int_status & MCOMP) {
> -		if ((read_MASTER_CTL(iface) & MEN) =3D=3D 0 &&
> +		if (twi_int_status & (XMTSERV|RCVSERV) &&

Spaces around operators.

I fixed both for you.

> +			(read_MASTER_CTL(iface) & MEN) =3D=3D 0 &&
>  			(iface->cur_mode =3D=3D TWI_I2C_MODE_REPEAT ||
>  			iface->cur_mode =3D=3D TWI_I2C_MODE_COMBINED)) {
>  			iface->result =3D -1;
> --=20
> 1.7.0.4
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk//wN8ACgkQD27XaX1/VRtG/QCgkPW+AfSq2miKlblG4rpsmA77
VywAn1u86FeADKcPxob9tA+JfXi9k/uG
=Jy/t
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
