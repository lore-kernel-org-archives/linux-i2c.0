From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.18
Date: Fri, 29 Jun 2018 17:13:55 +0200
Message-ID: <20180629151351.i3ogf77awxzuw4sl@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uo7xj3nczsno75al"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--uo7xj3nczsno75al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

this pull request contains:

* a revert because of bugzilla #200045 (and some documentation about it)
* another regression fix in the i2c-gpio driver
* a leak fix for the i2c core

Please pull.

Thanks,

   Wolfram


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to 12b731dd46d9ee646318e6e9dc587314a3908a46:

  i2c: gpio: initialize SCL to HIGH again (2018-06-29 08:23:12 +0200)

----------------------------------------------------------------
Peter Rosin (1):
      i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers

Wolfram Sang (3):
      Revert "i2c: algo-bit: init the bus to a known state"
      i2c: algos: bit: mention our experience about initial states
      i2c: gpio: initialize SCL to HIGH again


with much appreciated quality assurance from
----------------------------------------------------------------
Geert Uytterhoeven (1):
      (Test) i2c: gpio: initialize SCL to HIGH again

Linus Walleij (1):
      (Rev.) i2c: gpio: initialize SCL to HIGH again

Sergey Larin (1):
      (Test) Revert "i2c: algo-bit: init the bus to a known state"

 drivers/i2c/algos/i2c-algo-bit.c |  8 ++++----
 drivers/i2c/busses/i2c-gpio.c    |  4 ++--
 drivers/i2c/i2c-core-smbus.c     | 14 +++++++++-----
 3 files changed, 15 insertions(+), 11 deletions(-)

--uo7xj3nczsno75al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls2TKsACgkQFA3kzBSg
KbYR+BAAsG76e3uN3kSy7IeRbnVRM7Uly7K+DrWLVmDQxigYg2InPgPDq3sj70iU
phsL3dMPJwP/ww4vtsOpv8/9/1c9jiqGYQcSqCv7UZrLGwmEkvTJ8BGkN0jkVO5m
qxENbo890nLwvh+il8Zid5JYzP0ceZ5H329pMyLItcBEG7mUHWU6YM6WyumxHxeZ
TEyWf2FRfTIcwWgCuz1NuIuW+sm0HBbzQkKP/XIpPgG+JgNQaa6j57Q1tfb35V19
VRy/41mHWEfyh6npSLTWRE5uoclg3N6nRee6HGPEeqoKLYKvMdcSy7RDYSfLiQ/O
4GuXeq2OPCcdSIl9NIO+Wy0NaFBvz2iDU2/qbSZopsuyPLdifcMd1rJO/VuApJxU
P0HRB/sHnmZUmb8ic+YZMRnz8G5shtqPc5pudVfNVGvBVrA4s1DpVNfzR1k1NwBa
xJsgZqIC61IwlTO+pNsCqpO+jQ7lge6cjCWZ2mo+JdLYk1TL1vzakDQ4S2apPeGl
p2hWVIIwetuU3R5TxVrb8hj9h9USYzHZ2PG0/OMkqsUEJVMaX8GVp1CLdf5SmzTr
+55hMBGj+fWoIhD6deywUnT0kqdMAzKnXaR1v9i3GIBNXgQImoAnRvRJmSMLIzMC
fZTwB+6b5UtdPugrAHVWiZbe//4Q/dESq6i4yeryrMqDFriY8CE=
=JMu1
-----END PGP SIGNATURE-----

--uo7xj3nczsno75al--
