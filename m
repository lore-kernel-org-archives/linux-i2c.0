From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Fri, 12 Mar 2010 08:12:33 +0100
Message-ID: <20100312071233.GD10684@pengutronix.de>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de> <20100311085835.34c6cd51@hyperion.delvare> <20100311080347.GB16219@pengutronix.de> <20100311115426.6440837c@hyperion.delvare> <20100311112321.GA28805@pengutronix.de> <20100311155753.25fc9a5c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100311155753.25fc9a5c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> A quick grep suggests that only 3 drivers need care:
> arch/mips/txx9/generic/setup.c
> drivers/misc/eeprom/at24.c
> drivers/misc/eeprom/at25.c
>=20
> I'm curious if coccinelle will find more...

See kernel-janitors:

drivers/base/firmware_class.c
drivers/rtc/rtc-ds1742.c

needed a fix, too. At least those, I am not 100% sure I found all of them.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuZ6WEACgkQD27XaX1/VRs0JwCcCfaCw30uOJfu7GYrBWbEw8/M
eLcAnjUsEV9q9066TBxe7/fcMY45rux5
=9/Oj
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
