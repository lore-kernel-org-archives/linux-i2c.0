From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/7] PM / I2C: Convert platform I2C drivers to PM
 handling based on struct dev_pm_ops
Date: Thu, 12 Jul 2012 12:09:01 +0200
Message-ID: <20120712100901.GE27520@pengutronix.de>
References: <201207112121.11046.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201207112121.11046.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-i2c@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Peter Korsgaard <jacmet@sunsite.dk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Vitaly Wool <vitalywool@gmail.com>, Colin Cross <ccross@android.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-i2c@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2012 at 09:21:10PM +0200, Rafael J. Wysocki wrote:
> Hi all,
>=20
> As per
>=20
> http://marc.info/?l=3Dlinux-kernel&m=3D133996733422413&w=3D4
>=20
> the following patches convert some platform I2C controller drivers to the=
 PM
> handling based on struct dev_pm_ops:
>=20
> [1/7] i2c-at91: Use struct dev_pm_ops for power management
> [2/7] i2c-bfin-twi: Use struct dev_pm_ops for power management
> [3/7] i2c-ocores: Use struct dev_pm_ops for power management
> [4/7] i2c-pnx: Use struct dev_pm_ops for power management
> [5/7] i2c-puv3: Use struct dev_pm_ops for power management
> [6/7] i2c-stu300: Use struct dev_pm_ops for power management
> [7/7] i2c-tegra: Use struct dev_pm_ops for power management
>=20
> I'd like to include them into my PM pull request for 3.6 if there are no
> objections.

The changes are fine by me. I'd like to pull them in via I2C, though,
since they are changing mostly drivers for which I have other patches in
the pile and I'd like to see the conflicts myself. Is that okay? They'd
be in linux-next tomorrow. Or is there a dependency I missed?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/+oj0ACgkQD27XaX1/VRsL0wCfYrwLFKykjVWnj5ywVdY6S4TC
9bsAn1YeLJzkwR9fmw5OvE2ZQrPiWuxH
=sxEu
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
