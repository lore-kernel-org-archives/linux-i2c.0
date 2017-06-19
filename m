From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 2/6] i2c: designware: refactoring of the
 i2c-designware
Date: Mon, 19 Jun 2017 18:26:55 +0200
Message-ID: <20170619162655.rozamu2lggyqla77@ninjato>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <c5ffa634c81e79ea6a447f7156b76562d76d9eff.1497025304.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gfd2eqtagrhmktf7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c5ffa634c81e79ea6a447f7156b76562d76d9eff.1497025304.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org


--gfd2eqtagrhmktf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 11:43:22AM +0100, Luis Oliveira wrote:
> - Factor out all _master() part of code from i2c-designware-core
>   and i2c-designware-platdrv to separate functions.
> - Standardize all code related with MASTER mode.
> - I have to take off DW_IC_INTR_TX_EMPTY from DW_IC_INTR_DEFAULT_MASK
>   because it is master specific.
>=20
> The purpose of this is to prepare the controller to have is I2C MASTER
> flow in a separate driver. To do this first all the
> functions/definitions related to the MASTER flow were identified.
>=20
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--gfd2eqtagrhmktf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH+08ACgkQFA3kzBSg
KbYfhxAApIdd8mSQGqFPhsujKlFP2F7vsGwmNF9w21ibobFKHPZfeSSBq1I1j8cq
1yCfLk1Konl5n0UjC8VCX7QSayAXs1m59oAgu/903B130lAKerCkk9l0B1vNjHsH
iiyTo4xgKuCsvxcTpUQHkzOr6hdKAs+ZOL6g6kHC5Wrk4Xjx3qmI8RDt2SGIm1hq
qY0hdIVGOMV9Gehof4zYxzy+tbO1OEQl5gRBTF2j4g6JUmAs/m2a6TYEMOben+zn
qgB+eMWZzLXS4S1BkFF1M1gCTn/tujyPcjokVJVS4xyLeQU+KHE7x090lcnH+aqN
SyLsn7cNx1m66CmEhVOJ5uBdHYQf3kYo7vsC0nkgMeQs7/Z4xP6icWiAstIKt8yd
z+ecLiPqgOV+zfWiChav3TvcCFFbuasHssfUFP7EXjWBOGI0L2BLMCwyirn7gNBd
aRHCLVDOzEASk1H5hXpv89w5QTr7QdSWHQ441bMRENzA7sxNuVpUtJdAXQT3Hev+
A0ZJIaNzOMyv9AEC4NW5LIiy6E7mohhSF6ADEk75CDSsuZxFhyqr6NHdXv3UUZ5o
cjJwC1MwCzYAEGZ1Y8Nkmo3wBYiGZ2mwSGG1gQ2tcfqXQ5ru1p8ppUOKO9sfTaHK
P1HbnPPzSTlVTkvv4Gf4LI0vsP5m0jZ2KRWv4973vQtD55nAR+E=
=rrDf
-----END PGP SIGNATURE-----

--gfd2eqtagrhmktf7--
