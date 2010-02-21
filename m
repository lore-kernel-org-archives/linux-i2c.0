From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Remove clientdata before kfree?
Date: Sun, 21 Feb 2010 11:20:34 +0100
Message-ID: <20100221102034.GD25833@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

I am teaching myself coccinelle at the moment and created a semantic patch
which detects missing 'i2c_set_clientdata(client, NULL)' before freeing the
used data-structure. There are a number of drivers missing that.

While doing this, it is also trivial to change a few drivers to FIRST use
i2c_set_clientdata() and THEN kfree (those few are doing it the other way
around). I think it is cleaner this way, but probably doesn't matter much in
reality. So, should I do this transformation or rather drop it (which is al=
so
trivial ;)).

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuBCPIACgkQD27XaX1/VRtrDwCgprNqw2CPTr9Ce8Cgw2bipWwy
BxQAoKPLi41keXoI6UABKUUciIIGvtFa
=f6hF
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
