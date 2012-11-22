From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-s3c2410: Remove recently introduced performance
 overheads
Date: Thu, 22 Nov 2012 22:35:03 +0100
Message-ID: <20121122213503.GB14851@pengutronix.de>
References: <1353471131-23975-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353471131-23975-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2012 at 01:12:11PM +0900, Mark Brown wrote:
> The changes in "i2c-s3c2410: use exponential back off while polling for
> bus idle" remove the initial busy wait for I2C transfers to complete and
> replace it with usleep_range() calls which will schedule.
>=20
> Since for older SoCs I2C transfers would usually complete within an
> extremely small number of CPU cycles there is a win from not having to
> schedule.  This happens because on the older SoCs the cores run at a
> smaller multiple of the speeds that the I2C bus is operating at; on more
> modern SoCs the busy wait is less likely to be effective.
>=20
> Fix the issue by restoring the busy wait, reducing the number of spins
> from 20 to 3 which covers the overwhelming majority of I2C transfers on
> the SoCs where the busy wait is effective.
>=20
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

Applied to for-next, thanks everyone!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCumocACgkQD27XaX1/VRucbQCfW94/BZA9rNGIg1KTpqF3iR0z
BZAAn06DF+VwwvNmQ2+cyclSZL3D5DZR
=c7eK
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
