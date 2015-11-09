From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.4
Date: Mon, 9 Nov 2015 22:09:14 +0100
Message-ID: <20151109210910.GA3138@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60511 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbbKIVJV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 9 Nov 2015 16:09:21 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the pull request from I2C for the 4.4 merge window:

* new drivers: UniPhier (with and without FIFO)
* some drivers got some bigger rework: ismt, designware, img-scb
  (rcar had to be reverted because issues were showing up just lately)
* ACPI: reworked the device scanning and added support for muxes

And quite a lot of driver bugfixes and cleanups this time. All files
touched outside of the i2c realm have proper acks. Note there will be a
merge conflict in the designware driver due to a bugfix applied late to
4.3. Not that you'd really need it, but my proposed resolution is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/conflict-4.4

Resolving the conflict, I noticed asymmetry in the runtime_pm error
handling of the designware driver. I'll ask the developers about this.
However, I hope you'll pull this, so we can go from there and fix it
incrementally.

Thanks,

   Wolfram


The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.4

for you to fetch changes up to 75ecc64ef5a1f310fc80f732ad8cfb7e1bdc59d5:

  i2c: rcar: Revert the latest refactoring series (2015-10-30 12:40:46 +0100)

----------------------------------------------------------------
Alexander Sverdlin (1):
      i2c: davinci: Optimize clock generation on Keystone SoC

Andy Shevchenko (10):
      i2c: ismt: mark register space with __iomem
      i2c: ismt: improve usage of devres API
      i2c: ismt: PCI core handles power state for us
      i2c: ismt: do not duplicate msi_enabled flag
      i2c: ismt: propagate actual error code
      i2c: ismt: issue a warning when fail to request MSI
      mfd: core: redo ACPI matching of the children devices
      mfd: intel_quark_i2c_gpio: load gpio driver first
      mfd: intel_quark_i2c_gpio: support devices behind i2c bus
      at24: enable ACPI device found on Galileo Gen2

Axel Lin (1):
      i2c: au1550: Convert to devm_kzalloc and devm_ioremap_resource

Barry Song (1):
      i2c: tegra: drop duplicated code for assigning algo

Cyrille Pitchen (1):
      i2c: at91: fix write transfers by clearing pending interrupt first

Dustin Byford (2):
      acpi: add acpi_preset_companion() stub
      i2c: add ACPI support for I2C mux ports

Fabio Estevam (1):
      i2c: imx: Use -ENXIO as error in the NACK case

Gao Pan (1):
      i2c: imx: implement bus recovery

Geert Uytterhoeven (1):
      i2c: rcar: Remove obsolete platform data support

Guoying Zhang (1):
      i2c: sirf: tune the divider to make i2c bus freq more accurate

Jarkko Nikula (9):
      i2c: designware: Remove interrupt clearing from i2c_dw_pci_probe()
      i2c: designware: Disable interrupts before requesting PCI device interrupt
      i2c: designware: Remove unused functions
      i2c: designware: Make dw_readl() and dw_writel() static
      i2c: designware: Rename platform driver probe and PM functions
      i2c: designware: Move common probe code into i2c_dw_probe()
      i2c: designware: Fix build error when !CONFIG_PM_SLEEP
      i2c: i801: Add support for Intel Broxton
      i2c: i801: Document Intel DNV and Broxton

Jean Delvare (2):
      i2c-dev: Fix typo in ioctl name reference
      i2c-dev: Fix I2C_SLAVE ioctl comment

Ken Xue (1):
      i2c: designware: reverts "i2c: designware: Add support for AMD I2C controller"

Liguo Zhang (1):
      i2c: mediatek: add i2c resume support

Ludovic Desroches (1):
      i2c: at91: manage unexpected RXRDY flag when starting a transfer

Luis de Bethencourt (4):
      i2c: ibm-iic: Fix module autoload for OF platform driver
      i2c: meson: Fix module autoload for OF platform driver
      i2c: rk3x: Fix module autoload for OF platform driver
      i2c: stu300: Fix module autoload for OF platform driver

Manuel Lauss (1):
      i2c: au1550: relax bus timings a bit

Masahiro Yamada (2):
      i2c: uniphier: add UniPhier FIFO-less I2C driver
      i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver

Max Filippov (1):
      i2c: ocores: support big-endian register layout

Michal Simek (1):
      i2c: cadence: enable driver for ARM64

Mika Westerberg (2):
      i2c / ACPI: Rework I2C device scanning
      i2c: i801: Add support for Intel DNV

Muhammad Falak R Wani (1):
      i2c: pnx: Use setup_timer instead of open coding it

Shaohui Xie (1):
      i2c: imx: add support for Freescale Layerscape platforms

Sifan Naeem (7):
      i2c: img-scb: enable fencing for all versions of the ip
      i2c: img-scb: do dummy writes before fifo access
      i2c: img-scb: use DIV_ROUND_UP to round divisor values
      i2c: img-scb: fix LOW and HIGH period values for the SCL clock
      i2c: img-scb: use line_status instead of i2c->line_status
      i2c: img-scb: Clear line and interrupt status before starting a transfer
      i2c: img-scb: verify support for requested bit rate

Vaibhav Hiremath (1):
      i2c: pxa: Add support for pxa910/988 & new configuration features

Wolfram Sang (15):
      i2c: rcar: rework hw init
      i2c: rcar: remove unused IOERROR state
      i2c: rcar: remove spinlock
      i2c: rcar: refactor setup of a msg
      i2c: rcar: init new messages in irq
      i2c: rcar: don't issue stop when HW does it automatically
      i2c: rcar: check master irqs before slave irqs
      i2c: rcar: revoke START request early
      i2c: rcar: clean up after refactoring
      i2c: rcar: add support for r8a7795 (R-Car H3)
      i2c: sh_mobile: add support for r8a7795 (R-Car H3)
      MAINTAINERS: i2c: mark also subdirectories as maintained
      MAINTAINERS: i2c: drop i2c-pnx maintainer
      i2c: pnx: remove superfluous assignment
      i2c: rcar: Revert the latest refactoring series

 Documentation/acpi/enumeration.txt                 |  11 +-
 Documentation/acpi/i2c-muxes.txt                   |  58 ++
 .../devicetree/bindings/i2c/i2c-davinci.txt        |   6 +-
 Documentation/devicetree/bindings/i2c/i2c-imx.txt  |   9 +
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   1 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   1 +
 .../devicetree/bindings/i2c/i2c-uniphier-f.txt     |  25 +
 .../devicetree/bindings/i2c/i2c-uniphier.txt       |  25 +
 Documentation/i2c/busses/i2c-i801                  |   2 +
 MAINTAINERS                                        |   8 +-
 drivers/i2c/busses/Kconfig                         |  24 +-
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-at91.c                      |  82 ++-
 drivers/i2c/busses/i2c-au1550.c                    |  60 +--
 drivers/i2c/busses/i2c-davinci.c                   |   8 +
 drivers/i2c/busses/i2c-designware-core.c           |  74 ++-
 drivers/i2c/busses/i2c-designware-core.h           |  10 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  33 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  84 +--
 drivers/i2c/busses/i2c-i801.c                      |  16 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   1 +
 drivers/i2c/busses/i2c-img-scb.c                   |  73 +--
 drivers/i2c/busses/i2c-imx.c                       |  73 ++-
 drivers/i2c/busses/i2c-ismt.c                      |  80 +--
 drivers/i2c/busses/i2c-meson.c                     |   1 +
 drivers/i2c/busses/i2c-mt65xx.c                    |  16 +
 drivers/i2c/busses/i2c-ocores.c                    |  31 +-
 drivers/i2c/busses/i2c-pnx.c                       |   7 +-
 drivers/i2c/busses/i2c-pxa.c                       |  41 +-
 drivers/i2c/busses/i2c-rcar.c                      |  24 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   1 +
 drivers/i2c/busses/i2c-sh_mobile.c                 |   1 +
 drivers/i2c/busses/i2c-sirf.c                      |  26 +-
 drivers/i2c/busses/i2c-stu300.c                    |   1 +
 drivers/i2c/busses/i2c-tegra.c                     |   1 -
 drivers/i2c/busses/i2c-uniphier-f.c                | 584 +++++++++++++++++++++
 drivers/i2c/busses/i2c-uniphier.c                  | 441 ++++++++++++++++
 drivers/i2c/i2c-core.c                             |  82 ++-
 drivers/i2c/i2c-dev.c                              |  23 +-
 drivers/i2c/i2c-mux.c                              |   8 +
 drivers/mfd/intel_quark_i2c_gpio.c                 |  33 +-
 drivers/mfd/mfd-core.c                             |  52 +-
 drivers/misc/eeprom/at24.c                         |  22 +-
 fs/compat_ioctl.c                                  |   2 +-
 include/linux/acpi.h                               |   5 +
 include/linux/i2c-ocores.h                         |   1 +
 include/linux/i2c/i2c-rcar.h                       |  10 -
 include/linux/mfd/core.h                           |  10 +-
 include/uapi/linux/i2c-dev.h                       |   4 +-
 49 files changed, 1778 insertions(+), 415 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
 create mode 100644 drivers/i2c/busses/i2c-uniphier-f.c
 create mode 100644 drivers/i2c/busses/i2c-uniphier.c
 delete mode 100644 include/linux/i2c/i2c-rcar.h

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQQt2AAoJEBQN5MwUoCm2+zsQAI4LUMQNX1buKBo3F9QqFd9X
NmNGhbyOhZsKsgGaKtXWmCPHq5o40ctgAPCaM3x8Yx3o8oNwbqu8GrORGtXS1xx0
7O5gJohPC8zDVY4dbNZBZe60/FXJSNOgU2mAp5eeDoDO7ZhatgDGgSQt3mokuQfz
zjHZMrLwaX0AKolLa/qzzkvbrv3OxdYcr0zU76F6oSs6ZRm/LUXd3b4PXj7k2Dz/
PNMWFaU/QjWPgK3PNB2AinRaVW0bsm5SmufcTtdOgN9ShbxIBFZv6l9kDOumlyAt
CMfexLLn0GJGoAiaQqP4rOkzHFvvIAVBU4IHxk/0s/j/c/iaKfvXbdeii0PvSxhv
THy6zm8T8mz1AISkZsPSK2eoupgpW8+2cQ7Bi7TOiTsitXR7GkUg5vQTpdaYgKcU
jZ1AIkc+NWo3FD9UGVWzKF/NJ99b00ubdKvC4VLfp4lfFck78omcYbITJ85jCdMj
ae9wF+zOSfS7gJKx0etkpmG33k05Ojv0pZNimr1596D9Z07BqyxMgYIx8ponS1/8
u+FD7+y+QXYNIN7Q4X1x4he4E+hwlBRAPaCMg/AEo/egmvGUSCKDmS614yxQJgrv
R/IuxxSDuWQ2StMiRmzzlMzxBqrdxJgMtvnYoSUrGCOslpr2aUM3rWu2IgQeuQeZ
3KZPdLkkGsmuFhXKZIh/
=EpDr
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
