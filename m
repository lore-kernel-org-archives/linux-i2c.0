From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: convert drivers/i2c/* to use module_i2c_driver()
Date: Mon, 13 Feb 2012 23:26:43 +0100
Message-ID: <20120213222643.GA22686@pengutronix.de>
References: <1329123903.13995.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329123903.13995.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Michael Lawnick <ml.lawnick@gmx.de>, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2012 at 05:05:03PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/i2c/* to use the
> module_i2c_driver() macro which makes the code smaller and a bit simpler.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Michael Lawnick <ml.lawnick@gmx.de>
> Cc: Ben Dooks <ben-linux@fluff.org>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk85jiMACgkQD27XaX1/VRuU+QCeKVXTJ7UtqsXQT6tvFfq/mHf5
aXsAoJApLZz1ibr1QfqcKoHpSKwb89v3
=jNIw
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
