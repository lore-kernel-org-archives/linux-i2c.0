From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for v4.15
Date: Fri, 19 Jan 2018 15:29:37 +0100
Message-ID: <20180119142933.jp2iwm36h4wbis3n@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="etlegradtorl3aol"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--etlegradtorl3aol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two bugfixes for the I2C core: Lixing Wang fixed a refcounting
problem with DT nodes. Jeremy Compostella fixed a buffer overflow
possibility when using a 'don't use' ioctl interface directly.

Please pull.

Thanks,

   Wolfram


The following changes since commit a8750ddca918032d6349adbf9a4b6555e7db20da:

  Linux 4.15-rc8 (2018-01-14 15:32:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to 89c6efa61f5709327ecfa24bff18e57a4e80c7fa:

  i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA (2018-01-17 15:35:21 +0100)

----------------------------------------------------------------
Jeremy Compostella (1):
      i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

Lixin Wang (1):
      i2c: core: decrease reference count of device node in i2c_unregister_device


with much appreciated quality assurance from
----------------------------------------------------------------
Wolfram Sang (1):
      (Test) i2c: core: decrease reference count of device node in i2c_unregister_device

 drivers/i2c/i2c-core-base.c  |  6 +++++-
 drivers/i2c/i2c-core-smbus.c | 13 +++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

--etlegradtorl3aol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpiAMkACgkQFA3kzBSg
KbbrRRAAk7av583KL2lFfObBM+9/uctq0nfEU752kTxXVSRKEyNozF6eIwnz6RSR
fC35oi6aOdED2n0VpxGSGPPC6ABCYo4/sGkj/Hqe14u+ZViui6FqluOhjJBsLUHx
F3CIRpOkZ8IynEQ+ydtAGWexyWiN9oy86vCmh5LZE5M0HECRsy2T8wjirdum+QM6
zwNPDKt7B9mNCaH6jhzXXKewVDnmtUpCF+QynTQfFVcOxbo+5vJUAJLpXqRWJLYo
Nir608Hqaiq7bnhlsKEQqUHi/IurIKDM+hnQMB+glwgTWRo/w9JMI+SdqBeP3Jp4
2gIy7frQfm+Mp0RAUkT+Zq+/+Bm599BMgZ4DpkIoVbKisU55ndBuaYO4ZT22yzz2
ZJpu+QQh6X2fJIlQHaeiEkWDUsS8+gjA6OK4zevXHJMMqGOtysoDoa7Bst9YmMxd
dwkMiCADXcsx5R21oS4zk/sMOqBmA2n8ixBMPagV4S5v5pRYG0JuXy6TxYh0IuUu
6zDsMwVwJLYnfqnK7w3qs4VZ0pJQXv7KwVdFPwX3vcLEbriGDyU3xkNHq8fl+LAp
bP/x7Lf4AGQsWtYJFYed+h39AZsozjEMzHrD/nJ3d3bf/IyQUyZ+jIHVmruRRLxS
MEZq8yphrg1lalhty2MU4UKix2gLlPBJJ79bi1QEdYriwkqqSL0=
=tY+U
-----END PGP SIGNATURE-----

--etlegradtorl3aol--
