From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.20
Date: Thu, 1 Nov 2018 10:50:35 +0000
Message-ID: <20181101105031.GA2096@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a core bugfix & cleanup as well as an ID addition and
MAINTAINERS update for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit 9bb9d4fdce9e6b351b7b905f150745a0fccccc06:

  Merge branch 'for-linus-4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml (2018-10-31 15:46:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to 012ebc3b7801fcf424d0ebb4689c98f90a8593e0:

  MAINTAINERS: add maintainer for IMX LPI2C driver (2018-10-31 23:37:34 +0000)

----------------------------------------------------------------
A.s. Dong (2):
      dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp compatible string
      MAINTAINERS: add maintainer for IMX LPI2C driver

Charles Keepax (2):
      i2c: Remove unnecessary call to irq_find_mapping
      i2c: Clear client->irq in i2c_device_remove


with much appreciated quality assurance from
----------------------------------------------------------------
Benjamin Tissoires (2):
      (Rev.) i2c: Clear client->irq in i2c_device_remove
      (Rev.) i2c: Remove unnecessary call to irq_find_mapping

Rob Herring (1):
      (Rev.) dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp compatible string

 Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt | 1 +
 MAINTAINERS                                             | 8 ++++++++
 drivers/i2c/i2c-core-base.c                             | 7 +++----
 3 files changed, 12 insertions(+), 4 deletions(-)

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlva2nMACgkQFA3kzBSg
KbbfNQ//RILjBiO83eUiTXB832m8vNiru5x6FiiS9ckQGX7cOgVckmJ/NxYF1b3n
mjUi4e8K/uzSqpe0sTc667saxxNMK6xvbr27ttNLOQ5umAXIyy93thesXVHcchAF
MytE4yNVP+ir97LVbSJDFg1pglXi7YVrCaqsPr2eGStxGP98fk8x2e0qByBg3HhQ
pDG0kZWjPadx6237n0T87ZzOaN0qOT4vxL5VTVgMlmCl/5TBeFAIL4CQ4KGCR656
cTuaMqxLnyf6ipWejjCWF9M6ChHUlvKdsg5XCkRmy8axNQtesB5fqZW8JTK2TC92
WsNEadK9mNVhHRPpEz8A4KWOG3FnhkGJkv91Fm+1C2ttajCm6p8x5jItTj/aVZDU
yGCspqLa369q4pK/tSl+3lbUksg5BSREKNEeuAMb0+7H155u3oNTM2/54CcdHW5q
xLkW99rcWmEr93lpE6TYSV3olMpFA5Efz/KLzv2SY1o29a+EkMi4mdQ3cCIlRZDq
AmGMPurYPvttonmRnCgoXf4LWdXy2zNUtCb5GsXjk2q9FZ1PdSobMEQxCGwe85Av
ATzFk9hwxFfV1b4cEXOeOKVmGhg1jIaxVX0QzrVrdlhuqgIV5lteyoQYGiywefm6
u1+FjNPhM2tn/khH9fC48MITEjYgwF65wCNK6YvFwsFJ067C/rw=
=EycZ
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
