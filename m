From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.20
Date: Sat, 10 Nov 2018 12:20:41 +0100
Message-ID: <20181110112036.GA5905@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has one bugfix (qcom-geni driver), one arch enablement (i2c-omap driver, no
code change), and a new driver (nvidia-gpu) this time.

I hope the rc1 rule still applies for this new driver. It consists of the I2C
master part and UCSI client part which has the needed ack from Heikki.

Please pull.

Thanks,

   Wolfram


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 247c554a14aa16ca08f4ed4d9eb39a2389f69d1d:

  usb: typec: ucsi: add support for Cypress CCGx (2018-11-09 18:49:59 +0100)

----------------------------------------------------------------
Ajay Gupta (2):
      i2c: add i2c bus driver for NVIDIA GPU
      usb: typec: ucsi: add support for Cypress CCGx

Stephen Boyd (1):
      i2c: qcom-geni: Fix runtime PM mismatch with child devices

Vignesh R (3):
      dt-bindings: i2c: omap: Add new compatible for AM654 SoCs
      i2c: omap: Enable for ARCH_K3
      MAINTAINERS: Add entry for i2c-omap driver

Wolfram Sang (1):
      i2c: nvidia-gpu: make pm_ops static


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: add i2c bus driver for NVIDIA GPU

Douglas Anderson (1):
      (Rev.) i2c: qcom-geni: Fix runtime PM mismatch with child devices

Grygorii Strashko (2):
      (Rev.) i2c: omap: Enable for ARCH_K3
      (Rev.) dt-bindings: i2c: omap: Add new compatible for AM654 SoCs

Rob Herring (1):
      (Rev.) dt-bindings: i2c: omap: Add new compatible for AM654 SoCs

 Documentation/devicetree/bindings/i2c/i2c-omap.txt |   8 +-
 Documentation/i2c/busses/i2c-nvidia-gpu            |  18 +
 MAINTAINERS                                        |  15 +
 drivers/i2c/busses/Kconfig                         |  11 +-
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-nvidia-gpu.c                | 368 +++++++++++++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c                 |  15 +-
 drivers/usb/typec/ucsi/Kconfig                     |  10 +
 drivers/usb/typec/ucsi/Makefile                    |   2 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  | 307 +++++++++++++++++
 10 files changed, 745 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/i2c/busses/i2c-nvidia-gpu
 create mode 100644 drivers/i2c/busses/i2c-nvidia-gpu.c
 create mode 100644 drivers/usb/typec/ucsi/ucsi_ccg.c

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvmvwAACgkQFA3kzBSg
KbYW1w/+OZKsNr3qmYdCHcyNTG4twwzimklzcqzZkdeYqvVtYUEBuxUpyU45eusT
rCjhU56scbWK9nNj4uDYM+qMf652FhWwfQWFUBLlM66r9doAlU6RJJCkop2Lg/XN
P/CgDcagYSoW2/OC7M3LbCHKOuka8sSl0ouoCCMskMRjnCSBf0w1G3v/X9HSFDUz
Mem/j8OxZ72DXZa1dEaiXJgI3pMuhltGuqWjjeOIxtqohtBJAUycjiPnJslyJuMJ
BZbp3SMfgI2ryClSlH9NS4q4M5Y7KhPzf+QJiTPn4MKuZirc0Jny0m2DSouu7PGu
9fxB8zk7ptA7dn4G0VawQfT9aXWcw3v3rMq5S6GqhKRB4SZeE2QC+b50h2w1pGLN
nitCNBCsruJ3LZ1M5LQOikWsqyfB+UF1QAorA0l+pst8PQyPx9O1LaGGC1BrYyO4
UC4tyxhIZ5kDEIA1INm29FjknxhmYIVdjINYewfJwB/uTc4jasy8Jip1YThw3tTU
StzBtxHNd7nK7K6qNLBaL5/0gqRR8/3KcHgXCKVjO3DSoTX4aLcIp3g4uaVbNuad
DBtxYLZko19IN0MTJJfEaKiiwEf3nXXyuMY28fRy10/9ziaNT0P5gq7VjGNBV56m
6JTD2/3n6ifYLi47tIuZH2qAetp1R4K25CuFknfLz4UhsuyCsjU=
=vHqA
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
