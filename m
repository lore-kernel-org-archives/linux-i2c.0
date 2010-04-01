From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c-gpio: move initialization code
	subsys_initcall()
Date: Thu, 1 Apr 2010 15:49:18 +0200
Message-ID: <20100401134917.GF24265@pengutronix.de>
References: <1270129399-30365-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1270129399-30365-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2010 at 03:43:19PM +0200, Marek Szyprowski wrote:
> GPIO driven I2C bus can be used for controlling the PMIC chip. The example
> of such configuration is Samsung Aquila board.
>=20
> This patch moves initialization code subsys_initcall() to ensure that the=
 i2c
> bus is available early so the regulators can be quicly probed and availab=
le for

Minor: quickly

> other devices on their probe() call.
>=20
> Such solution has been proposed by Mark Brown to fix the problem of the
> regulators not beeing available on the peripheral device probe():
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011971.h=
tml
>=20
> CC: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Yup, a number of drivers do this:

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku0pF0ACgkQD27XaX1/VRtuIgCgqpE5VfT1BCm9ExeSZ9Ka/ka+
+8MAoLUgtidMdy4yLm1oNWLF5Hyt4iOZ
=T43g
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
