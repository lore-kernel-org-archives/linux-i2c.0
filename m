From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 17/24] regulator: fix dangling pointers
Date: Tue, 30 Mar 2010 14:47:54 +0200
Message-ID: <20100330124754.GL29472@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-18-git-send-email-w.sang@pengutronix.de> <1269287350.3754.22.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FnOKg9Ah4tDwTfQS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1269287350.3754.22.camel@odin>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-i2c@vger.kernel.org


--FnOKg9Ah4tDwTfQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2010 at 07:49:10PM +0000, Liam Girdwood wrote:
> On Sat, 2010-03-20 at 15:12 +0100, Wolfram Sang wrote:
> > Fix I2C-drivers which missed setting clientdata to NULL before freeing =
the
> > structure it points to. Also fix drivers which do this _after_ the stru=
cture
> > was freed already.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >=20
>=20
> Applied.

Thanks. An update will be needed though. But we will take care of it!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FnOKg9Ah4tDwTfQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkux8voACgkQD27XaX1/VRvqzQCgoo9UfUUrP+Y5X9g0wL4yyTj7
5K8AnAn1KMgqMK1J+UnjLi2fj9X4siZB
=qMhL
-----END PGP SIGNATURE-----

--FnOKg9Ah4tDwTfQS--
