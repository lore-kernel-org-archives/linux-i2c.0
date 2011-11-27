From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: convert drivers/i2c/* to use
 module_platform_driver()
Date: Sun, 27 Nov 2011 09:48:48 +0100
Message-ID: <20111127084848.GA5263@pengutronix.de>
References: <1322374332.2226.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322374332.2226.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Jochen Friedrich <jochen@scram.de>, Peter Korsgaard <jacmet@sunsite.dk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Manuel Lauss <manuel.lauss@googlemail.com>, Barry Song <21cnbao@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Yong Zhang <yong.zhang0@gmail.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Grant Likely <grant.likely@secretlab.ca>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2011 at 02:12:12PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/i2c/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7R+XAACgkQD27XaX1/VRulvwCcDy+/N8L+uZkYG69/Qs/prIIW
etoAoIZjWZlaqpDc1lqLSrxVdkjyvvv0
=g860
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
