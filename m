From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: correctly setup speed for non devicetree
Date: Sun, 16 Sep 2012 12:24:05 +0200
Message-ID: <20120916102405.GB933@pengutronix.de>
References: <1347118732-4896-1-git-send-email-w.sang@pengutronix.de>
 <201209152009.44320.marex@denx.de>
 <20120916081525.GA4367@pengutronix.de>
 <201209161205.42575.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201209161205.42575.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 16, 2012 at 12:05:42PM +0200, Marek Vasut wrote:
> Dear Wolfram Sang,
>=20
> > > > Commit cd4f2d4 (i2c: mxs: Set I2C timing registers for mxs-i2c) only
> > > > covered the case for devicetree and made platform_data based boards
> > > > bail out with -EINVAL. Correctly support the latter one, too.
> > >=20
> > > MXS is now DT only, so this patch is pointless.
> >=20
> > This is not true for 3.5.
>=20
> Did that patch made it into 3.5 ?

Yup.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBVqMUACgkQD27XaX1/VRvJJwCeJN24tT2J5cljw8NHW9ljGsHs
WjsAniPtrKLbZyGKpakuYblwMjqCDjSF
=AKLI
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
