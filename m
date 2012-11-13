From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: i2c-ocores: Use devm_request_and_ioremap()
Date: Tue, 13 Nov 2012 12:19:12 +0100
Message-ID: <20121113111912.GH23119@pengutronix.de>
References: <1344408872-1051-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344408872-1051-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2012 at 08:54:32AM +0200, Thierry Reding wrote:
> Replacing the devm_request_mem_region() and devm_ioremap_nocache() calls
> by a single call to devm_request_and_ioremap() simplifies the code.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Applied to for-next, thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCiLLAACgkQD27XaX1/VRuFNwCfXDSB8lTXZnfX4ylXOku7u1qW
k8gAn3UG0vIkAzG52PJjS1E49UtSrX7p
=horz
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--
