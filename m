From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.13
Date: Wed, 12 Jul 2017 17:49:04 +0200
Message-ID: <20170712154901.yrrhtwfpnokkmswe@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r34zbd7a3ai5vuks"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46163 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752829AbdGLPtI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 12 Jul 2017 11:49:08 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--r34zbd7a3ai5vuks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is my first pull request this merge window for the I2C subsystem. A
little later than usual but we needed to sort out one real build problem
and then a few false positives from buildbot. But now everything seems
in order. This pull request contains:

* i2c core reorganization. One source file became too monolithic. It is
  now split up, yet we still have the same named object as the final
  output. This should ease maintenance.
* new drivers: ZTE ZX2967 family, ASPEED 24XX/25XX,
* designware driver gained slave mode support
* xgene-slimpro driver gained ACPI support
* bigger overhaul for pca-platform driver
* the algo-bit module now supports messages with enforced STOP
* slightly bigger than usual set of driver updates and improvements

Please pull.

Thanks,

   Wolfram


The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.13

for you to fetch changes up to 8f1a357d41a22009150cf404b5aa5876efdb59b1:

  i2c: Provide a stub for i2c_detect_slave_mode() (2017-07-08 21:51:43 +0200)

----------------------------------------------------------------
Andy Shevchenko (1):
      i2c: Provide a stub for i2c_detect_slave_mode()

Arnd Bergmann (1):
      i2c: xgene-slimpro: include linux/io.h for memremap

Arvind Yadav (3):
      i2c: at91: Handle return value of clk_prepare_enable
      i2c: at91: Fix compilation warning.
      i2c: emev2: Handle return value of clk_prepare_enable

Baoyou Xie (2):
      dt: bindings: add documentation for zx2967 family i2c controller
      i2c: zx2967: add i2c controller driver for ZTE's zx2967 family

Brendan Higgins (4):
      i2c: aspeed: added documentation for Aspeed I2C driver
      i2c: aspeed: added driver for Aspeed I2C
      i2c: aspeed: added slave support for Aspeed I2C driver
      MAINTAINERS: add entry for Aspeed I2C driver

Chris Packham (7):
      dt-bindings: add bindings for i2c-pca-platform
      i2c: pca-platform: switch to struct gpio_desc
      i2c: pca-platform: add devicetree awareness
      i2c: pca-platform: use device managed allocations
      i2c: pca-platform: use dev_warn/dev_info instead of printk
      i2c: pca-platform: correctly set algo_data.reset_chip
      i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus

Colin Ian King (1):
      i2c: designware: fix spelling mistakes

George Cherian (1):
      i2c: xlp9xx: Enable HWMON class probing for xlp9xx

Hans de Goede (1):
      i2c: acpi: Do not create i2c-clients for LNXVIDEO ACPI devices

Hoan Tran (2):
      i2c: xgene-slimpro: Use a single function to send command message
      i2c: xgene-slimpro: Add ACPI support by using PCC mailbox

Jarkko Nikula (2):
      i2c: designware: Make HW init functions static
      i2c: designware: Let slave adapter support be optional

Jean Delvare (1):
      i2c: algo-bit: add support for I2C_M_STOP

Luis Oliveira (6):
      i2c: designware: Cleaning and comment style fixes.
      i2c: designware: refactoring of the i2c-designware
      i2c: designware: MASTER mode as separated driver
      i2c: designware: introducing I2C_SLAVE definitions
      i2c: designware: add SLAVE mode functions
      i2c: designware: enable SLAVE in platform module

Matt Weber (1):
      i2c: cadance: fix ctrl/addr reg write order

Michael Thalmeier (1):
      i2c: mxs: change error printing to debug for mxs_i2c_pio_wait_xfer_end

Shawn Guo (1):
      i2c: zx2967: drop COMPILE_TEST dependency

Srinivas Pandruvada (1):
      i2c: i801: Add support for Intel Cannon Lake

Wolfram Sang (15):
      i2c: rename core source file to allow refactorization
      i2c: break out slave support into separate file
      i2c: break out smbus support into separate file
      i2c: break out OF support into separate file
      i2c: break out ACPI support into separate file
      docs: i2c: dev-interface: adapt to new filenames of the i2c core
      i2c: remove unneeded includes from core
      i2c: reformat core-base file header
      i2c: stub: use pr_fmt
      i2c: sh_mobile: remove platform_data
      i2c: sh_mobile: drop needless check for of_node
      i2c: stub: fix build warning regression
      i2c: use proper name for the R-Car SoC
      i2c: rcar: document HW incapabilities
      i2c: zx2967: always use the same device when printing errors


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (17):
      (Rev.) i2c: designware: Let slave adapter support be optional
      (Rev.) i2c: designware: Make HW init functions static
      (Rev.) i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
      (Rev.) i2c: pca-platform: correctly set algo_data.reset_chip
      (Rev.) i2c: acpi: Do not create i2c-clients for LNXVIDEO ACPI devices
      (Rev.) i2c: designware: enable SLAVE in platform module
      (Rev.) i2c: designware: add SLAVE mode functions
      (Rev.) i2c: zx2967: add i2c controller driver for ZTE's zx2967 family
      (Rev.) i2c: designware: introducing I2C_SLAVE definitions
      (Rev.) i2c: designware: Cleaning and comment style fixes.
      (Rev.) i2c: remove unneeded includes from core
      (Rev.) docs: i2c: dev-interface: adapt to new filenames of the i2c core
      (Rev.) i2c: break out ACPI support into separate file
      (Rev.) i2c: break out OF support into separate file
      (Rev.) i2c: break out smbus support into separate file
      (Rev.) i2c: break out slave support into separate file
      (Rev.) i2c: rename core source file to allow refactorization

Geert Uytterhoeven (2):
      (Rev.) i2c: sh_mobile: drop needless check for of_node
      (Rev.) i2c: sh_mobile: remove platform_data

Hoan Tran (1):
      (Rev.) i2c: xgene-slimpro: include linux/io.h for memremap

Jean Delvare (1):
      (Rev.) i2c: stub: use pr_fmt

Jun Nie (1):
      (Rev.) i2c: zx2967: add i2c controller driver for ZTE's zx2967 family

Luis Oliveira (2):
      (Test) i2c: designware: Let slave adapter support be optional
      (Test) i2c: designware: Make HW init functions static

Mika Westerberg (2):
      (Rev.) i2c: break out ACPI support into separate file
      (Rev.) i2c: rename core source file to allow refactorization

Wolfram Sang (2):
      (Test) i2c: algo-bit: add support for I2C_M_STOP
      (Test) i2c: at91: Fix compilation warning.

 .../devicetree/bindings/i2c/i2c-aspeed.txt         |   48 +
 .../devicetree/bindings/i2c/i2c-designware.txt     |   16 +-
 .../devicetree/bindings/i2c/i2c-pca-platform.txt   |   29 +
 .../devicetree/bindings/i2c/i2c-zx2967.txt         |   22 +
 Documentation/driver-api/i2c.rst                   |    5 +-
 Documentation/i2c/busses/i2c-i801                  |    2 +
 Documentation/i2c/dev-interface                    |   14 +-
 MAINTAINERS                                        |   13 +
 drivers/i2c/Makefile                               |    7 +-
 drivers/i2c/algos/i2c-algo-bit.c                   |   13 +-
 drivers/i2c/busses/Kconfig                         |   34 +-
 drivers/i2c/busses/Makefile                        |    6 +
 drivers/i2c/busses/i2c-aspeed.c                    |  891 +++++++++++
 drivers/i2c/busses/i2c-at91.c                      |   16 +-
 drivers/i2c/busses/i2c-cadence.c                   |    6 +-
 drivers/i2c/busses/i2c-designware-common.c         |  281 ++++
 drivers/i2c/busses/i2c-designware-core.h           |  182 ++-
 ...c-designware-core.c => i2c-designware-master.c} |  474 +-----
 drivers/i2c/busses/i2c-designware-pcidrv.c         |    9 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  117 +-
 drivers/i2c/busses/i2c-designware-slave.c          |  393 +++++
 drivers/i2c/busses/i2c-emev2.c                     |    4 +-
 drivers/i2c/busses/i2c-i801.c                      |    8 +
 drivers/i2c/busses/i2c-mxs.c                       |    6 +-
 drivers/i2c/busses/i2c-pca-platform.c              |  133 +-
 drivers/i2c/busses/i2c-rcar.c                      |    9 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   27 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             |  242 ++-
 drivers/i2c/busses/i2c-xlp9xx.c                    |    1 +
 drivers/i2c/busses/i2c-zx2967.c                    |  609 +++++++
 drivers/i2c/i2c-core-acpi.c                        |  665 ++++++++
 drivers/i2c/{i2c-core.c => i2c-core-base.c}        | 1684 +-------------------
 drivers/i2c/i2c-core-of.c                          |  276 ++++
 drivers/i2c/i2c-core-slave.c                       |  115 ++
 drivers/i2c/i2c-core-smbus.c                       |  594 +++++++
 drivers/i2c/i2c-core.h                             |   24 +
 drivers/i2c/i2c-stub.c                             |   14 +-
 include/linux/i2c.h                                |    2 +
 include/linux/i2c/i2c-sh_mobile.h                  |   11 -
 include/trace/events/i2c.h                         |  226 +--
 include/trace/events/smbus.h                       |  249 +++
 41 files changed, 4969 insertions(+), 2508 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 create mode 100644 drivers/i2c/busses/i2c-aspeed.c
 create mode 100644 drivers/i2c/busses/i2c-designware-common.c
 rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (59%)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
 create mode 100644 drivers/i2c/busses/i2c-zx2967.c
 create mode 100644 drivers/i2c/i2c-core-acpi.c
 rename drivers/i2c/{i2c-core.c => i2c-core-base.c} (58%)
 create mode 100644 drivers/i2c/i2c-core-of.c
 create mode 100644 drivers/i2c/i2c-core-slave.c
 create mode 100644 drivers/i2c/i2c-core-smbus.c
 delete mode 100644 include/linux/i2c/i2c-sh_mobile.h
 create mode 100644 include/trace/events/smbus.h

--r34zbd7a3ai5vuks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllmROkACgkQFA3kzBSg
KbY6SBAAh1vWqcE5WZAtFXT3Qh3FQbdmoWoJh+867h9XxSoNsCrgh9SBTJMXJik1
O34IyofbTINQ17ZBKPdGgOY8iOz7zwFQerblxXMN6uPVmGMMyPfGcoIcQ/BARTGU
I+1rIvQVaaye8hQehgPnh6EZdMvsDSIgf2woNUpFY4Uz1+5NJ9P0g3GfX3WjaZsm
kwioQOUuQUWpPG+AexrhkyVaVkeviRj6xxRnHtKASSdBL7ydNkpR+lIs48F2ZlNo
G6rF9wsIO6BmSG4NwuN3D0gyEKqS/GJYnTNYGc5s/FYmJByITGQVuOL21AatF9bI
LoQFB3HTeFhLUGr6+bpinARgTYLf1XRCzNhbuVQw4hR0uKhU1RUl0DXjsue5FbjG
D1DVEeYncLey0N/Qlq0Fw/qZjsnriVtwdmtfseAWZxg/5XnHD2FHS+Nm4Pc7VyUR
BV39hfjvHCAd9Krs6jmbmnE3yKKDB+t/FdzVV5XHZUm+NImnHt22IXRtNZmgORFZ
1uCrZW718wkMwOv3wiWrjKA+A03Thzr8+Wqbv3x22C/os1E9FYVYVu/4h096865Z
fcmUOcv3rCCZ0gCLOgMIar4SFHYKJaCSCTRundPcnEd5FAwcFBMFFGomSuJh8B6n
gq/GXiPhzr0Bo8ToBg1kwFpJiMEmTnB8enRtiNPPbrEb/4ryoS0=
=OQeH
-----END PGP SIGNATURE-----

--r34zbd7a3ai5vuks--
