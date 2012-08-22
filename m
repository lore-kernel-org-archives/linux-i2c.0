From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PULL REQUEST] i2c-embedded for 3.6-rc
Date: Wed, 22 Aug 2012 10:45:56 +0200
Message-ID: <20120822084556.GA20976@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

please pull some bugfixes for the "embedded" part of the I2C subsystem.
The fixes affect mostly drivers which have been largely reworked lately
and where regressions appeared.

Thanks,

   Wolfram

The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-current

for you to fetch changes up to 371e67c9e1a82b5fd8110b9a25e36bbc3a99e8c7:

  i2c: tegra: protect suspend/resume callbacks with CONFIG_PM_SLEEP (2012-0=
8-18 20:45:09 +0200)

----------------------------------------------------------------
Guenter Roeck (1):
      i2c: diolan-u2c: Fix master_xfer return code

Kevin Hilman (1):
      I2C: OMAP: xfer: fix runtime PM get/put balance on error

Laxman Dewangan (1):
      i2c: tegra: protect suspend/resume callbacks with CONFIG_PM_SLEEP

Lee Jones (1):
      i2c: nomadik: Add default configuration into the Nomadik I2C driver

 drivers/i2c/busses/i2c-diolan-u2c.c |    1 +
 drivers/i2c/busses/i2c-nomadik.c    |   28 ++++++++++++++++++----------
 drivers/i2c/busses/i2c-omap.c       |    2 +-
 drivers/i2c/busses/i2c-tegra.c      |    2 +-
 4 files changed, 21 insertions(+), 12 deletions(-)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlA0nEQACgkQD27XaX1/VRvlJQCgi9kdIA4O9kTBYnLOv0wzKSc2
1qYAnR1GH6pYfmN+SmlffgvD4hvgbvsp
=i0E8
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
