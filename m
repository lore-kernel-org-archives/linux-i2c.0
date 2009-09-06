From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Removing duplicate drivers from chips?
Date: Sun, 6 Sep 2009 22:55:26 +0200
Message-ID: <20090906205526.GA8434@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

I am thinking about cleaning up the 'chips'-directory further by removing t=
he
duplicate pca/pcf-drivers. Those are marked as deprecated for more than a y=
ear
now. Remembering the defconfig-discussion when we moved out the eeprom driv=
ers,
I think it is best to not touch the defconfigs but inform the arch-maintain=
ers
about the removal of these drivers, so they can handle whatever is necessar=
y.
Are you okay with this approach or do you think we should keep the drivers a
little longer?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqkIb4ACgkQD27XaX1/VRvaFgCfUG8PyPZgXIcGQKB1GFxYFQEz
I64AoJu9XxeW6XbbqR5K4rF5qaaRLxpX
=Xj58
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
