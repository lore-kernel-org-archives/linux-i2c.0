From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Thu, 11 Mar 2010 12:23:21 +0100
Message-ID: <20100311112321.GA28805@pengutronix.de>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de> <20100311085835.34c6cd51@hyperion.delvare> <20100311080347.GB16219@pengutronix.de> <20100311115426.6440837c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100311115426.6440837c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > I presume the at25 driver needs the same fix?
> >=20
> > Yes, sent it to the SPI-list sperately. I wasn't sure if a patch series=
 would
> > ease or complicate things.
>=20
> Fine with me, as long as it get fixed.

I am currently using my newly acquired coccinelle-fu to find further driver=
s in
need of such a fix :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuY0qkACgkQD27XaX1/VRtXpgCfeWS0TWwYYYngVhVx+ZUhiB9B
r+4Ani0BsyQXKyu+tkgjzQNJsHTnwt4u
=Ja7M
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
