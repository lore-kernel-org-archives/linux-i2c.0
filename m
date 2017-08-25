From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.13
Date: Fri, 25 Aug 2017 16:30:58 +0200
Message-ID: <20170825143054.vguk564qjnrhv7hf@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u4ozmoomd5apj542"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org


--u4ozmoomd5apj542
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has some bugfixes for you: mainly Jarkko fixed up a few things in
the designware driver regarding the new slave mode. But Ulf also fixed a
long-standing and now agreed suspend problem. Plus, some simple stuff
which nonetheless needs fixing.

Please pull.

Thanks,

   Wolfram


The following changes since commit ef954844c7ace62f773f4f23e28d2d915adc419f:

  Linux 4.13-rc5 (2017-08-13 16:01:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 2a86cdd2e7d3c75580f41f89f9b9211e225573cc:

  i2c: designware: Fix runtime PM for I2C slave mode (2017-08-17 17:55:29 +0200)

----------------------------------------------------------------
Anton Vasilyev (1):
      i2c: simtec: use release_mem_region instead of release_resource

Brendan Higgins (1):
      i2c: aspeed: fixed potential null pointer dereference

Jarkko Nikula (4):
      i2c: designware: Fix oops from i2c_dw_irq_handler_slave
      i2c: designware: Fix standard mode speed when configuring the slave mode
      i2c: designware: Remove needless pm_runtime_put_noidle() call
      i2c: designware: Fix runtime PM for I2C slave mode

Javier Martinez Canillas (1):
      i2c: core: Make comment about I2C table requirement to reflect the code

Ulf Hansson (1):
      i2c: designware: Fix system suspend


with much appreciated quality assurance from
----------------------------------------------------------------
Jarkko Nikula (1):
      (Test) i2c: designware: Fix system suspend

John Stultz (1):
      (Test) i2c: designware: Fix system suspend

Mika Westerberg (1):
      (Rev.) i2c: designware: Fix system suspend

 drivers/i2c/busses/i2c-aspeed.c             |  5 +++--
 drivers/i2c/busses/i2c-designware-platdrv.c | 17 +++++++++++++----
 drivers/i2c/busses/i2c-designware-slave.c   |  6 ++++--
 drivers/i2c/busses/i2c-simtec.c             |  6 ++----
 drivers/i2c/i2c-core-base.c                 |  4 ++--
 5 files changed, 24 insertions(+), 14 deletions(-)

--u4ozmoomd5apj542
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmgNJkACgkQFA3kzBSg
KbbuzBAAsTYJHdCu5LIHZEC55N9QOTUI8Pm26GbFz1/h8LCaUAglSISKKJmu57Eg
uMHO1G9CIbdg+tm7zQogaA310WWp8dODd+rWNgy4uzCFIqJhzt5jkuDeB2e1f3Vx
NKOMmuWjSsxENfoWTxcJf1+LYN0jijTv34Jsz1YOvO4AHTGKUMLaP1FGwrYeSVEq
fKWrvNjceurwcREHEXU5DYSnWLvj8QvZbsdeYhpU5l2eGmqVOgBgTdalwz1xvn6y
Lce6Ma5ghQlPCLvucIxSPmOhWh+lhadOdxsnhiE1x2xR9ie0hGXKGBxiz6MZ/6HT
n8eYLSc3tyEwtAF4kei2dG9VPiTez5BFbzkcfE4A/ppt1eXQcnQYNq1TGCqBZnHg
ctzSaW81/JpBG5ez5/5fTqZpmh1EyeoSvBDXweulROPoZICro4dcEMGtRfACaGmD
M8UMMsQ4bWhGN8vdaKmnXTLj3B+radM8ErEqhvwF38hE/N+zsCNX07gJWLgUYmWu
F3Ic0DxiNEfe+nRCQ8PnYZeKgXy9HKavyp3/0aPgx4MrA1bHN3TL5OQxMLTFHTAa
TXSCmP4PUGssfyyD2oAxNeWNuhFDG9ixWyZlnfxjluu3qJKwIO2izPmAuNtdMEvM
0uaeTEPN7HvIdqLBcw82oYeu80sbhKotvrE9Pq7Ph1FmVNEJwKA=
=a1kc
-----END PGP SIGNATURE-----

--u4ozmoomd5apj542--
