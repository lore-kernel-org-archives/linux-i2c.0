From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.19
Date: Sat, 6 Oct 2018 22:37:38 +0200
Message-ID: <20181006203728.ijfuod6p3ocwy3sk@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="exehsgcp3xa2xsl4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--exehsgcp3xa2xsl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greg,

I2C has three driver bugfixes and a fix for a typo for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 9ce7610e6d201e3923c0b2f454f2e1d54f5da49e:

  i2c: designware: Call i2c_dw_clk_rate() only when calculating timings (2018-10-05 13:40:05 +0200)

----------------------------------------------------------------
Colin Ian King (1):
      i2c: i2c-isch: fix spelling mistake "unitialized" -> "uninitialized"

Edgar Cherkasov (1):
      i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Jarkko Nikula (1):
      i2c: designware: Call i2c_dw_clk_rate() only when calculating timings

Stephen Boyd (1):
      i2c: i2c-qcom-geni: Properly handle DMA safe buffers


with much appreciated quality assurance from
----------------------------------------------------------------
Ard Biesheuvel (1):
      (Test) i2c: designware: Call i2c_dw_clk_rate() only when calculating timings

Douglas Anderson (1):
      (Rev.) i2c: i2c-qcom-geni: Properly handle DMA safe buffers

Jean Delvare (1):
      (Rev.) i2c: i2c-isch: fix spelling mistake "unitialized" -> "uninitialized"

 drivers/i2c/busses/i2c-designware-master.c |  4 +++-
 drivers/i2c/busses/i2c-isch.c              |  2 +-
 drivers/i2c/busses/i2c-qcom-geni.c         | 22 ++++++++++++++++++----
 drivers/i2c/busses/i2c-scmi.c              |  1 +
 4 files changed, 23 insertions(+), 6 deletions(-)

--exehsgcp3xa2xsl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu5HQQACgkQFA3kzBSg
KbYNPQ/+LfftRiDvXuXJBNgSUWTZbQ8ppO7qCBq9rCbw5pBm+gRodWpLrQBkrf+S
oRhVIbIiEhP4oNqfw30fhHEKK4LO4jfpNl3mtu6RkrOJ476DK2BTwP2WzO7pzrjO
CdpiNqX0QbJY+IH8G437YcS3BjNdyF0H48u6rWO/YvlOErpAv+pBoSVyZHS/Ht8Q
skG3xlVzHNXv+V9aJ1GJz5b3jV2hWkiVeZnA3PUoie21IVhdo+0e63SH9IEW0OAB
3pUDO5fp8ZaP+AUTwf/MWu/zFfrxOFBg1aiNz1c37aY18Ok5whvlQMgbnJFNmR3D
8ykifqbbuwxxxp3OhxUCoiQjdngA1um6FGjg6ogwZ/QpdZe7nvHnLPjXf32Z9hB9
1YH4IJ3adTUKNnl+JiQTdcUBEDtRfOSf4ilRnKisTAKHbPhOcTFacbS7ZY2DWTrF
SrwJmcnGav/jXQ6jcyn9aDVWKBBuaTn9xnhK2M1vA+aikBq7zRbNaHuZLPrgO9eg
XH8FTMHhb+UGVBuKHd/5fE8AppiuR0XaoRYACqBWPdpcLSGpizR1IkZjDt+r/ZQi
NRQzfIGT5l3yyuNzEe5IzFR5Xn5zWtEam9eDA3MFMrpd0b9ExJ4I1P6JRU4NwUsc
O2xYKMV2WFimMrL8XSdVNDZwKyKwcyIjRzHqh3AMMFEpjUplH30=
=9h/P
-----END PGP SIGNATURE-----

--exehsgcp3xa2xsl4--
