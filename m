From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PULL REQUEST] i2c embedded for 3.4
Date: Fri, 23 Mar 2012 10:17:19 +0100
Message-ID: <20120323091719.GA14540@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

nothing special from i2c-embedded for this merge window. Two new drivers,
minor feature additions, bugfixes, cleanups.

All patches have been in linux-next for some time, too.

Please pull. Thanks,

   Wolfram


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-3.4

for you to fetch changes up to bbceeee82ef55c11db0161f4078edd79290e3bcf:

  i2c-eg20t: Remove write-only variables (2012-03-07 19:26:22 +0100)

----------------------------------------------------------------
Alexander Stein (2):
      i2c-eg20t: Rework pch_i2c_wait_for_bus_idle to reduce wait time
      i2c-eg20t: Remove write-only variables

Alok Chauhan (1):
      i2c: tegra: Remove unnecessary write to INT_STATUS

Ganesan Ramalingam (1):
      i2c: Support for Netlogic XLR/XLS I2C controller.

Jayachandran C (1):
      i2c: Move I2C_EG20T option to the right place.

Mark Brown (2):
      i2c-s3c2410: Convert to devm_kzalloc()
      i2c-s3c2410: Add stub runtime power management

Oskar Schirmer (1):
      i2c: imx: fix imx driver to work though signal is pending

Pawel Moll (1):
      i2c: versatile: Add Device Tree support

Pratyush Anand (1):
      i2c: designware: dw_i2c_init_driver as subsys initcall

Tang Yuantian (1):
      i2c: mpc: Add support for SMBUS_READ_BLOCK_DATA

Wolfram Sang (1):
      misc: at24: describe platform_data with kernel_doc

Zhiwu Song (1):
      i2c: add CSR SiRFprimaII on-chip I2C controllers driver

 Documentation/devicetree/bindings/i2c/sirf-i2c.txt |   19 +
 drivers/i2c/busses/Kconfig                         |   44 ++-
 drivers/i2c/busses/Makefile                        |    4 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |    2 +-
 drivers/i2c/busses/i2c-eg20t.c                     |   44 +-
 drivers/i2c/busses/i2c-imx.c                       |    5 -
 drivers/i2c/busses/i2c-mpc.c                       |   63 ++-
 drivers/i2c/busses/i2c-s3c2410.c                   |   14 +-
 drivers/i2c/busses/i2c-sirf.c                      |  459 ++++++++++++++++=
++++
 drivers/i2c/busses/i2c-tegra.c                     |    1 -
 drivers/i2c/busses/i2c-versatile.c                 |   10 +
 drivers/i2c/busses/i2c-xlr.c                       |  278 ++++++++++++
 include/linux/i2c/at24.h                           |   35 ++-
 13 files changed, 912 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/sirf-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-sirf.c
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9sP58ACgkQD27XaX1/VRsALACfbK1vdvdxBCCNtxwPjKh/Q56w
LQkAn14ZV7EZhYPvnq4FBJQIFeVawbD9
=b/zy
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
