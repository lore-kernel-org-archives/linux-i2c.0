From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] TSL2550: extended mode bugfix
Date: Wed, 5 Aug 2009 18:00:06 +0200
Message-ID: <20090805160006.GC3148@pengutronix.de>
References: <4A79A055.1010602@valueteam.com> <20090805171452.592a2bbd@hyperion.delvare> <4A79AAF5.9000702@valueteam.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A79AAF5.9000702-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> About the name of 'operating_mode' field, I think it can be changed in =
=20
> 'extended_mode' as Wolfram Sang has suggested.
> What do you think about it?

Nope, because it is exported to userspace via sysfs, this is not possible.
There may be already software depending on this name. And to have internally
one name and externally another won't help reducing the confusion :) Having=
 an
extra comment as Jean suggested is the way to go.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp5rIYACgkQD27XaX1/VRuaNgCePgosN7O/yYPooO2Q/JCFuHQu
BU8AoLA7g0FNHsmcuWcC6833HTDSmfq6
=Kp0T
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
