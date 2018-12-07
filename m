From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.20
Date: Fri, 7 Dec 2018 14:08:52 +0100
Message-ID: <20181207130848.GA2661@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a set of driver bugfixes for the I2C subsystem.

Please pull.

Thanks,

   Wolfram


The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to ece27a337d42a3197935711997f2880f0957ed7e:

  i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode (2018-12-06 23:14:59 +0100)

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c: axxia: properly handle master timeout

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI device node

Masahiro Yamada (4):
      i2c: uniphier-f: fix timeout error after reading 8 bytes
      i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
      i2c: uniphier: fix violation of tLOW requirement for Fast-mode
      i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

Wolfram Sang (3):
      i2c: nvidia-gpu: adhere to I2C fault codes
      i2c: nvidia-gpu: limit reads also for combined messages
      i2c: rcar: check bus state before reinitializing


with much appreciated quality assurance from
----------------------------------------------------------------
Ajay Gupta (2):
      (Test) i2c: nvidia-gpu: limit reads also for combined messages
      (Test) i2c: nvidia-gpu: adhere to I2C fault codes

Alexander Sverdlin (1):
      (Rev.) i2c: axxia: properly handle master timeout

 drivers/i2c/busses/i2c-axxia.c      | 40 +++++++++++++++++++++---------
 drivers/i2c/busses/i2c-nvidia-gpu.c |  7 +++---
 drivers/i2c/busses/i2c-rcar.c       |  9 ++++---
 drivers/i2c/busses/i2c-scmi.c       | 10 +++++---
 drivers/i2c/busses/i2c-uniphier-f.c | 49 +++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-uniphier.c   |  8 +++++-
 6 files changed, 93 insertions(+), 30 deletions(-)

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwKcNsACgkQFA3kzBSg
KbZd4g/+K83Z6ZNIGbaMlGp7tKZ9ayTWeEvmv2JhaHK3SpxgZ2nO1K9eoiU9MFqK
u2ZDLz/BYw/6DGDy0KRH1lvoY3mVFBkUjEEJw/8b71WUBSrbkdwWZlLylegNQh8Y
MwEabGFaVxylntmyrnjBKrqWuqYIBcKcnyJDZHWldgzoLF35loR1dO8dIfjDLW3H
M/rK5GmP+a2L1IRuk6awewilF2NGiiCIXFj08s8hyepxJzrDmKYFXcguuRC4yuGH
lZtJtzZ05w1gVXbDrVw9N4N7ghmbSXtlyFxO1/V+dyhecxbh+FB+zNthyaveLcJY
lux0xvD3xsAnLV+F1IMMXmUlKDiI1iyT7Lqvu5BM8LtxX072yNBv53z6F8CHHpvP
G8XzoZSKmMNfU9+WzkpaRhCKFW7JCnoJCvsecJKwYSEjhZubsSMOoJuZ7/NHg7zY
x8LO5RfAayLbv7CGmUa6mWEBCdIEP4Uds/+j65gzTCAQT5pFV/nVjwQ9dlLSfipI
hEF4gIQnqRIYaRTaBsMMYEXCuSgkxmw8a1hB2fMXE/eRbsT2AGma35dLU5AqYY5I
ra9W5dSjIKYnmjSfNXFiI8rGjFWnWY92+6BwTQEuUKuUvrVMspgBRloCrEHuTRVp
LmBZkqIWrRStxxZ7SrNkBEmd8gqiu00sIROPSxEFZQjHDFIrjgo=
=Kb0Z
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
