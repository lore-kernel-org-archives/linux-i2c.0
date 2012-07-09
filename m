From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c-s3c2410: Convert to devm_request_and_ioremap()
Date: Mon, 9 Jul 2012 15:52:29 +0200
Message-ID: <20120709135229.GL1296@pengutronix.de>
References: <1340888138-32710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RD6GsZsdEJvsf78O"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1340888138-32710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--RD6GsZsdEJvsf78O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2012 at 01:55:38PM +0100, Mark Brown wrote:
> A small code saving and less error handling to worry about.
>=20
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

What about devm for the clocks, too?


Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RD6GsZsdEJvsf78O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/64h0ACgkQD27XaX1/VRsXTgCfVXW0XlddjyS5YVoXQ4EgQdQ5
QPsAoKzteXWy14/kYTD0YRUlctpg9mKB
=WwKg
-----END PGP SIGNATURE-----

--RD6GsZsdEJvsf78O--
