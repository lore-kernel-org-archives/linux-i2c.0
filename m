From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 3.20
Date: Sat, 21 Feb 2015 08:13:48 +0100
Message-ID: <20150221071343.GA1355@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

a little late due to a HD crash, here is the pull request for i2c.
Summary:

* legacy PM code removed from the core, there were no users anymore
  (thanks to Lars-Peter Clausen)
* new driver for Broadcom iProc
* bigger driver updates for designware, rk3x, cadence, ocores
* a bunch of smaller updates and bugfixes

Please pull!

   Wolfram


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-3.20

for you to fetch changes up to 0d8fb59924cf20e7bef2c41f8d4e87127f573546:

  i2c: ocores: rework clk code to handle NULL cookie (2015-02-20 18:01:23 +0100)

----------------------------------------------------------------
Alexander Sverdlin (1):
      of: i2c: Add i2c-mux-idle-disconnect DT property to PCA954x mux driver

Andy Shevchenko (3):
      i2c: designware-pci: remove Moorestown support
      i2c: designware-pci: no need to provide clk_khz
      i2c: designware-pci: update Intel copyright line

Arnaud Ebalard (1):
      dt-bindings: use isil prefix for Intersil in I2C trivial-devices.txt

Baruch Siach (1):
      i2c: fix reference to functionality constants definition

David Box (2):
      i2c: designware: Add i2c bus locking support
      i2c: designware: Add Intel Baytrail PMIC I2C bus support

Dmitry Osipenko (1):
      i2c: tegra: Maintain CPU endianness

Dmitry Torokhov (1):
      i2c: do not try to load modules for of-registered devices

Doug Anderson (1):
      i2c: rk3x: Account for repeated start time requirement

Harini Katakam (2):
      i2c: cadence: Handle > 252 byte transfers
      i2c: cadence: Check for errata condition involving master receive

Jarkko Nikula (1):
      i2c: designware: Do not calculate SCL timing parameters needlessly

Jisheng Zhang (1):
      i2c: designware: use {readl|writel}_relaxed instead of readl/writel

Lars-Peter Clausen (1):
      i2c: Remove support for legacy PM

Max Filippov (2):
      i2c: ocores: fix clock-frequency binding usage
      i2c: ocores: add common clock support

Mika Westerberg (1):
      i2c: ACPI: Pick the first address if device has multiple

Nicholas Mc Guire (1):
      i2c: imx: fix handling of wait_for_completion_timeout result

Philipp Zabel (2):
      i2c: imx: remove unused return value assignments
      i2c: imx: whitespace and checkpatch cleanup

Ray Jui (1):
      i2c: iproc: Add Broadcom iProc I2C Driver

Wolfram Sang (6):
      i2c: pmcmsp: remove dead code
      i2c: simplify boilerplate code for attribute groups
      i2c: designware-baytrail: use proper Kconfig dependencies
      i2c: clarify comments about the dev_released completion
      i2c: designware-baytrail: another fixup for proper Kconfig dependencies
      i2c: ocores: rework clk code to handle NULL cookie

Zhangfei Gao (1):
      i2c: hix5hd2: add COMPILE_TEST

addy ke (1):
      i2c: rk3x: fix bug that cause measured high_ns doesn't meet I2C specification

 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  37 ++
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |   3 +
 .../devicetree/bindings/i2c/i2c-ocores.txt         |  42 +-
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  14 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |   5 +-
 Documentation/i2c/functionality                    |   2 +-
 drivers/i2c/busses/Kconfig                         |  22 +-
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-bcm-iproc.c                 | 461 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cadence.c                   | 189 +++++----
 drivers/i2c/busses/i2c-designware-baytrail.c       | 160 +++++++
 drivers/i2c/busses/i2c-designware-core.c           |  83 ++--
 drivers/i2c/busses/i2c-designware-core.h           |  12 +
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  41 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  20 +-
 drivers/i2c/busses/i2c-imx.c                       |  33 +-
 drivers/i2c/busses/i2c-ocores.c                    |  91 +++-
 drivers/i2c/busses/i2c-pmcmsp.c                    |   7 -
 drivers/i2c/busses/i2c-rk3x.c                      |  99 +++--
 drivers/i2c/busses/i2c-tegra.c                     |   2 +
 drivers/i2c/i2c-core.c                             | 162 +-------
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  11 +-
 include/linux/i2c.h                                |   4 -
 23 files changed, 1139 insertions(+), 363 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-iproc.c
 create mode 100644 drivers/i2c/busses/i2c-designware-baytrail.c

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU6DAnAAoJEBQN5MwUoCm2bmQQAI+q2ipynUA3CJk+WMkMwegC
/SVZXkKjuc4suqECmV6awhsOcl65n2XnWUZR0F8IpjnTaKOOZaqAIMZzRkl//icu
DxvWGZsuBsmt1gjO5X60dyDSM7jr2HCky94tBnXIld36jOHPPI6Agd/dGLtfBjUG
lcCO1p0OoSCI8pnN33R0NclUWRd0LPBFQFhAZPqX2jOvwDiqIMDmLiq0/sDXXB+7
YVyhFvSDE4SX/t4XuqmT9Wvy1dxTQvUMy0G4YxJqyZ0iln3gW/qtaquv6ch3DNDt
+X8tLSaHOk5fWB0yfbfK6aoIILg4vAn7QZRKjao85fL/nx79ghlcjuc5ZhSFNkq0
7f54X4p7p6r5g0vk6iuxiPI0noaGSCE7FAEZxf82poeq40OeZxq7xRetHfmziRcS
NHA4EO4Bf874NvQLhUO0FGGVISpOWYvpCaWyRTT7eFeqM/PNR/fcFhJTeQqKcyT7
BNFaA9nXyCA34gps3/E0hgIfsKCqvH1pos9irpfzw7waEfSg3RmkoGCj1k98sXKT
bSzYGuFS9ZFSzPAwkpF7oDpEAFiDwZAfYlZKb/UZMrayWXvw5pGQnz6csFs4pJIz
CdGqyO+adQFd01K6btjGzw+Mb0EN0cOKV0B/vqjGQE/kMe8/YZnz1urSTBro9Ck0
mVbrj7PPViSTxDZ/PCER
=Hhhc
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
