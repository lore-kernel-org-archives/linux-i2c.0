From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/8 v2] i2c: i2c-bfin-twi: Illegal i2c bus lock upon
 certain transfer scenarios.
Date: Fri, 13 Jul 2012 08:31:11 +0200
Message-ID: <20120713063111.GA32184@pengutronix.de>
References: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-i2c@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 04:22:40PM +0800, Sonic Zhang wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> For transfer counts > 255 bytes i2c-bfin-twi sets the data
> transfer counter DCNT to 0xFF indicating unlimited transfers.
> It then uses a flag iface->manual_stop to manually issue the STOP
> condition, once the required amount of bytes are received.
>=20
> We found that on I2C receive operation issuing the STOP condition
> together with a FULL RCV FIFO (2bytes) will cause SDA and SCL be
> constantly driven low.
>=20
> Temporary workaround until further investigation:
> Discard the RCV FIFO before issuing the STOP condition.
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

All 8 patches applied to next, thanks.

If you want to make my life easier, please state what changed from V1 to
V2. I had to look it up manually which costs time and doesn't make the
patchset look like a low-hanging fruit.

> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-b=
fin-twi.c
> index cdb59e5..33031f0 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -131,6 +131,10 @@ static void bfin_twi_handle_interrupt(struct bfin_tw=
i_iface *iface,
>  			iface->transPtr++;
>  			iface->readNum--;
>  		} else if (iface->manual_stop) {
> +			/* Temporary workaround to avoid possible bus stall -
> +			 * Flush FIFO before issuing the STOP condition
> +			 */
> +			read_RCV_DATA16(iface);
>  			write_MASTER_CTL(iface,
>  				read_MASTER_CTL(iface) | STOP);
>  		} else if (iface->cur_mode =3D=3D TWI_I2C_MODE_REPEAT &&
> --=20
> 1.7.0.4
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk//wK8ACgkQD27XaX1/VRs9vwCfckUN7xf8NhWLVFAKEfAeHu+7
eXAAnj+EK2TXSCGjR8oJyXKEmv+IyE6l
=sMck
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
