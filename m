From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 3.17
Date: Wed, 20 Aug 2014 22:25:02 -0500
Message-ID: <20140821032456.GA3920@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the fixup for the 'lowlight' of my last pull request. I2C is not
selected anymore by I2C_ACPI. Instead, the code in question now depends
on I2C=y. Also, Mika has agreed to support me and be the maintainer for
I2C-ACPI related patches. Finally, a new-ID-patch came along last week.

Please pull,

   Wolfram


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to 4560d67722816cca4b2f3dfb1d7c5b902fd2075b:

  MAINTAINERS: add maintainer for ACPI parts of I2C (2014-08-19 10:34:08 -0500)

----------------------------------------------------------------
Alan Cox (1):
      i2c: i801: Add PCI ID for Intel Braswell

Lan Tianyu (1):
      i2c: rework kernel config I2C_ACPI

Wolfram Sang (1):
      MAINTAINERS: add maintainer for ACPI parts of I2C

 MAINTAINERS                   |  7 +++++++
 drivers/i2c/Kconfig           | 15 ++++++---------
 drivers/i2c/Makefile          |  2 +-
 drivers/i2c/busses/i2c-i801.c |  2 ++
 drivers/i2c/i2c-acpi.c        |  2 ++
 include/linux/i2c.h           | 12 ++++++++----
 6 files changed, 26 insertions(+), 14 deletions(-)

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT9WaIAAoJEBQN5MwUoCm28eoP/1BNoR2ihREEaZlJPmWS6jIa
rA5oXmSW28Lzof132LIR5+th8saarmOiCKG6L950GCOUu7nrIzqT9uMpoHQzxP7B
EgTFoTad4gKrS0/MqXY/qKydEZk3eed0RxKOpRUcRKWMLmpBPqpV8JJoDXTVZMCh
CTfh7v3RS4/998ru9cz4msAVJt7ACOMuNSlas7lz4zlnexk8imj65akjLnA+bsHy
pqS799IwjBsRIWdtkBCePCVQl1/QC1cT9DEY22hDYoDa1KrKEk8lpPezTivOh5xW
7vo4wcCbpzaKx3Mo8hFCGzA3ZJwM63J1gVBAEemc25Qg/jAzq9j8QK81dKX5dwZ8
8RqyCrT0AX5zW0TN5biK0kqadepkN68h4i7VLzJR63uO5ypHRIodT0dsM9kpFAAj
G0g8FQRlCfbAK8W691BD3kJZ+GZQHKH9ZYqFcRyecG+W0ENDWpH8+7awfAmP+SnB
JZKODqkktHuD/nNj29Wo5CLLmvwnzNeeJTeM2Ux0ZY/nbodt/TuqTkJHRC1ZQUSd
5vVubQl6CVrHzoRAmIj9UnPPZNHP/TTsIIbmufEJr00WE11AVKbEWUsUZitDb2fI
KjfxHj7rG76ewFIGFEpx3066WzmZfl8K3AE07oAY+uKTQdY0bUGLYT0zD54lya2Y
UJGZ8G1CgKjg8csXUVMB
=rAlM
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
