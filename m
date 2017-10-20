From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.14
Date: Fri, 20 Oct 2017 06:37:03 +0200
Message-ID: <20171020043658.jtapubuetvpfkbld@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2o6nj6qmi7b72pws"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org


--2o6nj6qmi7b72pws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are a couple of bugfixes for I2C drivers. Because the changes for
the piix4 driver are larger than usual, the patches have been in
linux-next for more than a week with no reports coming in. The rest is
usual stuff.

Please pull.

Thanks,

   Wolfram


The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 883b3b6567bfc8b5da7b3f0cec80513af111d2f5:

  i2c: omap: Fix error handling for clk_get() (2017-10-18 00:19:26 +0200)

----------------------------------------------------------------
Clemens Gruber (1):
      i2c: imx: fix misleading bus recovery debug message

Guenter Roeck (1):
      i2c: piix4: Fix SMBus port selection for AMD Family 17h chips

Pontus Andersson (1):
      i2c: ismt: Separate I2C block read from SMBus block read

Ricardo Ribalda Delgado (1):
      i2c: piix4: Disable completely the IMC during SMBUS_BLOCK_DATA

Tony Lindgren (1):
      i2c: omap: Fix error handling for clk_get()

Wei Jinhua (1):
      i2c: imx: use IRQF_SHARED mode to request IRQ


with much appreciated quality assurance from
----------------------------------------------------------------
Jean Delvare (2):
      (Rev.) i2c: piix4: Disable completely the IMC during SMBUS_BLOCK_DATA
      (Rev.) i2c: piix4: Fix SMBus port selection for AMD Family 17h chips

Jiang Biao (1):
      (Rev.) i2c: imx: use IRQF_SHARED mode to request IRQ

Stephen Douthit (1):
      (Test) i2c: ismt: Separate I2C block read from SMBus block read

 drivers/i2c/busses/i2c-imx.c   |   4 +-
 drivers/i2c/busses/i2c-ismt.c  |   5 +-
 drivers/i2c/busses/i2c-omap.c  |  14 ++++
 drivers/i2c/busses/i2c-piix4.c | 162 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 172 insertions(+), 13 deletions(-)

--2o6nj6qmi7b72pws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnpfWYACgkQFA3kzBSg
KbZ9JQ/9GGrBRkRUz3q6v6LNul3xBuEYEwXM2akZywY/iBNzARO74s5kbLSk5JUz
2ph5STMxtH0uO5AcnPO9LNqm0X9qWipJnRA4bzBOHOe9APYYGaXgVihoFBkaZkLq
W9fxlctKH5XCU4ETJneEjswn2M5itYd562ciQQFNMISueJkPJiM1b5Usre/WPLZ5
XJDLgPONsU/EKQg8a3cdyH2vMjHK7iiYgVQQwsGUYhCUVpfCge1zXn8OoyyT2uon
9QrmK0k4/gYZ3AR6pobXxjYJJGgWKFYS6PQnsWuUcH3xeLOhmSu1tYm8FKuWaPXZ
p1W1MdDZsEbT/T3Ljk1JmLqPbUCBcRH2JeB6NrBv1q/EOHt0Q3uIxyNCBaeNj8xV
EWGVVOJYygDjdzM29w1DQtReo7F1r3CwuZYQZMLsul/Xn4ws2zXc2VjX2PsX4KF6
x2HyI0muREbTwOoIDpayIUqoa1p3eZdj/eH95esqcaLZNtB2DFopWoGgJajQ/gtl
tFOB8mxbdMz3pBWq/Uik6ysggCxUsUS+Q5DyZsY/prfSgIfXZbnJzjYuO+iiJZ3d
Qm0gDoxGAZ798JjkCBooF9lCZRf1Z4G3v0Qt4FAaKoy3cU5EGJZnMIbMQBiXl5Vn
yG5LDLSH8zgvOixMEHmvnKVnbR/2Fcnan2DI//yJ0Qxuo6y90qk=
=gR8W
-----END PGP SIGNATURE-----

--2o6nj6qmi7b72pws--
