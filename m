From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [i2c-tools][PATCH] honor CROSS_COMPILE
Date: Sat, 8 Jan 2011 20:23:45 +0100
Message-ID: <20110108192345.GB4045@pengutronix.de>
References: <1294426874-24973-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294426874-24973-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Honor CROSS_COMPILE for builds. useful for folks using
> building for platforms like ARM using cross compiler
> toolchain. CC could be reused as well, but usage of
> CROSS_COMPILE seems more similar to what we have
> for u-boot, kernel etc..

Then again, the vast majority of userspace-projects do not use CROSS_COMPIL=
E.
Build systems like ptxdist and buildroot have done fine with overriding CC =
so
far. I don't see much gain in that addition.

But thanks for the contribution anyway :)

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0oucEACgkQD27XaX1/VRsnqgCgv15hAP8ZB27bCBoTP2amgwPx
2u0AnRj+AElliN2pBiI7M9PkH8JW4gcY
=Px8+
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
