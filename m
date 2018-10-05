From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Call i2c_dw_clk_rate() only when
 calculating timings
Date: Fri, 5 Oct 2018 13:41:27 +0200
Message-ID: <20181005114127.GA5433@kunai>
References: <20181001114905.13766-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181001114905.13766-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 02:49:05PM +0300, Jarkko Nikula wrote:
> There are platforms which don't provide input clock rate but provide
> I2C timing parameters. Commit 3bd4f277274b ("i2c: designware: Call
> i2c_dw_clk_rate() only once in i2c_dw_init_master()") causes needless
> warning during probe on those platforms since i2c_dw_clk_rate(), which
> causes the warning when input clock is unknown, is called even when
> there is no need to calculate timing parameters.
>=20
> Fixes: 3bd4f277274b ("i2c: designware: Call i2c_dw_clk_rate() only once i=
n i2c_dw_init_master()")
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: <stable@vger.kernel.org> # 4.19
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3TeMACgkQFA3kzBSg
Kbb6gQ/+OgoQZpeJohRjQLD7j5u/23/sWJIeggO/bToa+Lgm+RLlNhLfLOyr1X0P
PIqdv0aLVJ4f8EOOkEwxrSEyv3K7AIdbC5gdH4UltJeKnrvz+220y9kB69+WNTpr
T7F3SYFiQ9iaNmZ1g11qr8iNwLKdvHSTjL7zB1MgQkh33dr1pXtHYb/xHQzIa7em
1tppQ+q0cDqtgYxk8o/9rTn/Vh2BMfFV9X5x9vSIxxyAeqL8cLn2X2KNFNNH6lo5
b0YzUik3lZvKl4RO9x98Hwmuvn3p6N7mAlkRnaDNd9ejHA4V4MHL8bKPPwEzZEkN
h4U0BhrXDlNKhpRhJY1WwXgxj2YbScQZmaOF1sJsp+5Uq+EveWh5mLALZq5u1pKU
bPPjFEoldTIzTHplU3atHtPYg2+YUvYNSELX5oBvNtB8r+dTZx8fzisZEsqafkIT
xZEG4QT4eRC55RvBlcVVxoyFSPEF1+GTNwhZ2OI3Vzhvz0d+siJWMNZYCOwtP87q
/joKYlVep5XU5NTLewou0f9dCZ2WzHt0Q06nK55nw5GO/TOQoOg85YSM7vI86zwZ
CIWeoAuZAQ+bbt/QRPdTiaXKxexrLp1WMKI9KUI3nz1iBVl/OD4GuT7TnnEXnG5w
9wyxaxNAimiJAaUiYx1SvqkbhO6MFIgbuA7ftJgo/71sAMmwICE=
=dv+k
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
