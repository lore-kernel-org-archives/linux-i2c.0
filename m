From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: i2c-tools: Discussion points about future library
Date: Thu, 5 Apr 2012 10:04:06 +0200
Message-ID: <20120405080406.GA2510@pengutronix.de>
References: <20120404160113.2295c636@endymion.delvare>
 <20120404174158.GA19773@sirena.org.uk>
 <20120404212323.59053a1f@endymion.delvare>
 <4F7CA3D4.8000104@fold.natur.cuni.cz>
 <20120405094910.1dcc4779@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120405094910.1dcc4779-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >   I would also search for the header filenames and invent such names
> > which will not clash with any existing. Same for "-li2c" or
> > whatever will apear on the ld line.
>=20
> No, sorry. I'm not going to invent a fancy name to make sure it isn't
> clashing with something out there. If anyone wanted their code to
> become the standard Linux i2c library, they should have pushed it to
> major Linux distributions. Nobody did AFAICS.

+1

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk99UfYACgkQD27XaX1/VRtGWQCgzCcbm340ZxL4jxPsgOO5a0Bk
AjEAn2BNpljA5O9dYTyPhvjHKHBX1/cV
=VEKU
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
