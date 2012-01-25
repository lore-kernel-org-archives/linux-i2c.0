From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Documentation: EEPROM: add kernel side usage
 description
Date: Wed, 25 Jan 2012 15:28:47 +0100
Message-ID: <20120125142847.GA8852@pengutronix.de>
References: <4F1FE390.6040903@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F1FE390.6040903-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2012 at 12:12:16PM +0100, Yegor Yefremov wrote:
> add EEPROM usage instructions and example for kernel side.
> dm644x-evm was taken as example.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Good idea, only this file describes eeprom.c not at24.c. eeprom.c is
deprecated. I'd suggest to add the usage example for macc to the at24
source code, after the comment I pointed you to.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8gEZ8ACgkQD27XaX1/VRsL9ACfcGJhWftZ74rzt4f9a+pK9Jx8
X+4AoLvee5zpErQZ0xLGRJGGlF8baMUN
=dl9X
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
