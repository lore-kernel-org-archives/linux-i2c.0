From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: correctly setup speed for non devicetree
Date: Sun, 16 Sep 2012 10:15:25 +0200
Message-ID: <20120916081525.GA4367@pengutronix.de>
References: <1347118732-4896-1-git-send-email-w.sang@pengutronix.de>
 <201209152009.44320.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201209152009.44320.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Commit cd4f2d4 (i2c: mxs: Set I2C timing registers for mxs-i2c) only
> > covered the case for devicetree and made platform_data based boards
> > bail out with -EINVAL. Correctly support the latter one, too.
>=20
> MXS is now DT only, so this patch is pointless.

This is not true for 3.5.

> Rather make it depend on CONFIG_OF=20

I wanted to avoid ifdeffery.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBVip0ACgkQD27XaX1/VRsV0QCeJHpWRg7u0Knj/Lt7dIFmFjgG
IWAAoItfHjqXuJ6b5EFI6EEJrImUvCRR
=VmD1
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
