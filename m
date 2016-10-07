From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.9
Date: Fri, 7 Oct 2016 11:32:29 +0200
Message-ID: <20161007093226.GA2058@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55157 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbcJGJci (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 7 Oct 2016 05:32:38 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here is the 4.9 pull request from I2C including:

* centralized error messages when registering to the core
* improved lockdep annotations to prevent false positives
* DT support for muxes, gates, and arbitrators
* bus speeds can now be obtained from ACPI
* i2c-octeon got refactored and now supports ThunderX SoCs, too
* i2c-tegra and i2c-designware got a bigger bunch of updates
* a couple of standard driver fixes and improvements

Please pull.

Thanks,

   Wolfram


The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.9

for you to fetch changes up to 662786a5429c3a992c6f884a647ee32424822358:

  i2c: axxia: disable clks in case of failure in probe (2016-09-24 11:26:55=
 +0200)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      i2c: axxia: disable clks in case of failure in probe

Andy Shevchenko (2):
      i2c: core: put literals on one line in dev_*() calls
      i2c: i801: Add support for Kaby Lake PCH-H

Bartosz Golaszewski (5):
      eeprom: at24: check if the chip is functional in probe()
      i2c: export i2c_adapter_depth()
      lockdep: make MAX_LOCKDEP_SUBCLASSES unconditionally visible
      i2c: add a warning to i2c_adapter_depth()
      gpio: pca953x: fix an incorrect lockdep warning

David Wu (2):
      i2c: rk3x: Fix sparse warning
      i2c: rk3x: Fix variable 'min_total_ns' unused warning

Dmitry Bazhenov (2):
      i2c: octeon: Fix set SCL recovery function
      i2c: octeon: Avoid sending STOP during recovery

Geert Uytterhoeven (1):
      i2c: shmobile: Use ARCH_SHMOBILE instead of SUPERH

Jan Glauber (10):
      i2c: octeon: Rename driver to prepare for split
      i2c: octeon: Split the driver into two parts
      i2c: thunderx: Add i2c driver for ThunderX SOC
      i2c: thunderx: Add SMBUS alert support
      i2c: octeon,thunderx: Move register offsets to struct
      i2c: octeon: Sort include files alphabetically
      i2c: octeon: Use booleon values for booleon variables
      i2c: octeon: thunderx: Add MAINTAINERS entry
      i2c: octeon: Fix high-level controller status check
      i2c: octeon: thunderx: Limit register access retries

Jarkko Nikula (3):
      i2c: core: Cleanup I2C ACPI namespace, take 2
      i2c: core: Add function for finding the bus speed from ACPI, take 2
      i2c: designware: Find bus speed from ACPI

Jon Hunter (10):
      i2c: tegra: Fix lines over 80 characters
      i2c: tegra: Use BIT macro
      i2c: tegra: Fix missing blank lines after declarations
      i2c: tegra: Add missing new line characters
      i2c: tegra: Remove non device-tree support
      i2c: tegra: Use device name for adapter name
      i2c: tegra: Simplify I2C resume
      i2c: tegra: Add runtime power-management support
      i2c: tegra: Add pinctrl support
      i2c: tegra: Fix assignment of boolean variables

Jos=C3=A9 Roberto de Souza (1):
      i2c: designware: wait for disable/enable only if necessary

Lucas De Marchi (3):
      i2c: designware: add common functions for locking
      i2c: designware: detect when dynamic tar update is possible
      i2c: designware: do not disable adapter after transfer

Masahiro Yamada (4):
      i2c: uniphier: avoid WARN_ON() of clk_disable() in failure path
      i2c: uniphier-f: avoid WARN_ON() of clk_disable() in failure path
      i2c: uniphier-f: set the adapter to master mode when probing
      i2c: uniphier-f: fix misdetection of incomplete STOP condition

Mika Westerberg (1):
      i2c / ACPI: Do not touch an I2C device if it belongs to another adapt=
er

Neil Armstrong (1):
      i2c: meson: add gxbb compatible string

Peter Rosin (10):
      i2c: add i2c_trylock_bus wrapper, use it
      dt-bindings: i2c: add support for 'i2c-mux' subnode
      dt-bindings: i2c: add support for 'i2c-arb' subnode
      dt-bindings: i2c: add support for 'i2c-gate' subnode
      dt-bindings: i2c: add bindings for nxp,pca9541
      i2c: mux: add support for 'i2c-mux', 'i2c-arb' and 'i2c-gate' DT subn=
odes
      i2c: mux: inform the i2c mux core about how it is used
      i2c: pca9541: add device tree binding
      i2c: pca954x: add device tree binding
      i2c: move locking operations to their own struct

Shardar Shariff Md (5):
      i2c: tegra: use readl_poll_timeout after config_load reg programmed
      i2c: tegra: If fifo flush fails return error
      i2c: tegra: add separate function for config_load programing
      i2c: tegra: use atomic poll function during configuration
      i2c: tegra: proper handling of error cases

Ulrich Hecht (1):
      i2c: rcar: add support for r8a7796 (R-Car M3-W)

Weifeng Voon (5):
      i2c: designware: Move clk_freq into struct dw_i2c_dev
      i2c: designware: get fast plus and high speed *CNT configuration
      i2c: designware: Enable fast mode plus
      i2c: designware: set the common config before the if else
      i2c: designware: Enable high speed mode

Wolfram Sang (4):
      i2c: don't print error when adding adapter fails
      i2c: uniphier{-f}: don't print error when adding adapter fails
      Merge branch 'i2c-mux-dt-3' of https://github.com/peda-r/i2c-mux into=
 i2c/for-4.9
      gpio: pca953x: variable 'id' was used twice

Yang Li (1):
      i2c: imx: make bus recovery through pinctrl optional

 .../bindings/i2c/i2c-arb-gpio-challenge.txt        |    8 +-
 Documentation/devicetree/bindings/i2c/i2c-arb.txt  |   35 +
 Documentation/devicetree/bindings/i2c/i2c-gate.txt |   41 +
 .../devicetree/bindings/i2c/i2c-meson.txt          |    2 +-
 Documentation/devicetree/bindings/i2c/i2c-mux.txt  |   23 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |    1 +
 .../devicetree/bindings/i2c/nxp,pca9541.txt        |   29 +
 MAINTAINERS                                        |   10 +
 drivers/gpio/gpio-pca953x.c                        |   16 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   10 +-
 drivers/i2c/busses/Kconfig                         |   13 +-
 drivers/i2c/busses/Makefile                        |    3 +
 drivers/i2c/busses/i2c-amd756.c                    |    5 +-
 drivers/i2c/busses/i2c-at91.c                      |    2 -
 drivers/i2c/busses/i2c-axxia.c                     |    8 +-
 drivers/i2c/busses/i2c-bcm-iproc.c                 |    8 +-
 drivers/i2c/busses/i2c-bcm-kona.c                  |    4 +-
 drivers/i2c/busses/i2c-bfin-twi.c                  |    4 +-
 drivers/i2c/busses/i2c-brcmstb.c                   |    4 +-
 drivers/i2c/busses/i2c-cadence.c                   |    4 +-
 drivers/i2c/busses/i2c-cpm.c                       |    4 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c            |    4 +-
 drivers/i2c/busses/i2c-davinci.c                   |    4 +-
 drivers/i2c/busses/i2c-designware-core.c           |  196 +++-
 drivers/i2c/busses/i2c-designware-core.h           |   12 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |   43 +-
 drivers/i2c/busses/i2c-diolan-u2c.c                |    4 +-
 drivers/i2c/busses/i2c-dln2.c                      |    4 +-
 drivers/i2c/busses/i2c-efm32.c                     |    1 -
 drivers/i2c/busses/i2c-exynos5.c                   |    4 +-
 drivers/i2c/busses/i2c-hix5hd2.c                   |    4 +-
 drivers/i2c/busses/i2c-i801.c                      |    5 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |    4 +-
 drivers/i2c/busses/i2c-img-scb.c                   |    4 +-
 drivers/i2c/busses/i2c-imx.c                       |   35 +-
 drivers/i2c/busses/i2c-isch.c                      |    4 +-
 drivers/i2c/busses/i2c-ismt.c                      |    4 +-
 drivers/i2c/busses/i2c-jz4780.c                    |    4 +-
 drivers/i2c/busses/i2c-lpc2k.c                     |    4 +-
 drivers/i2c/busses/i2c-meson.c                     |    2 +-
 drivers/i2c/busses/i2c-mpc.c                       |    4 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |    4 +-
 drivers/i2c/busses/i2c-mxs.c                       |    1 -
 drivers/i2c/busses/i2c-nforce2.c                   |    1 -
 drivers/i2c/busses/i2c-nomadik.c                   |    4 +-
 drivers/i2c/busses/i2c-ocores.c                    |    4 +-
 .../i2c/busses/{i2c-octeon.c =3D> i2c-octeon-core.c} | 1084 ++++++--------=
------
 drivers/i2c/busses/i2c-octeon-core.h               |  216 ++++
 drivers/i2c/busses/i2c-octeon-platdrv.c            |  286 ++++++
 drivers/i2c/busses/i2c-omap.c                      |    4 +-
 drivers/i2c/busses/i2c-piix4.c                     |    1 -
 drivers/i2c/busses/i2c-pmcmsp.c                    |    4 +-
 drivers/i2c/busses/i2c-pnx.c                       |    4 +-
 drivers/i2c/busses/i2c-puv3.c                      |    5 +-
 drivers/i2c/busses/i2c-pxa.c                       |    4 +-
 drivers/i2c/busses/i2c-rcar.c                      |    5 +-
 drivers/i2c/busses/i2c-riic.c                      |    4 +-
 drivers/i2c/busses/i2c-rk3x.c                      |    9 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |    1 -
 drivers/i2c/busses/i2c-sh7760.c                    |    4 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |    1 -
 drivers/i2c/busses/i2c-sirf.c                      |    4 +-
 drivers/i2c/busses/i2c-st.c                        |    4 +-
 drivers/i2c/busses/i2c-stu300.c                    |    5 +-
 drivers/i2c/busses/i2c-tegra.c                     |  279 +++--
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |  259 +++++
 drivers/i2c/busses/i2c-uniphier-f.c                |  106 +-
 drivers/i2c/busses/i2c-uniphier.c                  |   78 +-
 drivers/i2c/busses/i2c-wmt.c                       |    4 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             |    1 -
 drivers/i2c/busses/i2c-xiic.c                      |    1 -
 drivers/i2c/busses/i2c-xlp9xx.c                    |    4 +-
 drivers/i2c/busses/i2c-xlr.c                       |    4 +-
 drivers/i2c/i2c-core.c                             |  272 +++--
 drivers/i2c/i2c-mux.c                              |   73 +-
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |    2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   11 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   46 +-
 drivers/misc/eeprom/at24.c                         |   15 +-
 include/linux/i2c-mux.h                            |    8 +-
 include/linux/i2c.h                                |   47 +-
 include/linux/lockdep.h                            |    4 +-
 82 files changed, 2121 insertions(+), 1332 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
 rename drivers/i2c/busses/{i2c-octeon.c =3D> i2c-octeon-core.c} (56%)
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-platdrv.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-pcidrv.c

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX92uqAAoJEBQN5MwUoCm2QKwP/jn23w5+xMJWhJnVd3hmGH03
gvPQ/3y+sCRD+uQPiH331I5OIgej1f5s+32dsgjpKNzJRGirV3Ol5PKTTJ/o543X
wjMlPNnf6bUgtQB6fW44XwtbBz8IQcFOBmqQC1lOzlKhOOQws+AIlDY3gs9FNp7w
JpUOMuN6/Yy/uinvRJO4Jf8ncxlyJVKnEkXlbvNRH5oHCfqlZSXS9aRqnCwE/ytB
+6V229rwXINeMrcIwPJh9hyzDupnAGRhRsipjOZl2rcz9dDAxohIL6bP4Q12526y
T/p2pmc165ul0qc9SAGQGtYhepVH8ubiqYTcJqNxbDz4zrWSiUlKADE5BOkHNqR5
rT82nL2mz3DjSfBui2NT3CXlJYVM3HJbRcmmFl57YGJlunGqj0NOf3Kdvi+/Huwt
DMBKsSbUs6kUQAycac67xA7V/BGhdpsRngngWG3NiRbpFR2spPulN/Fv2jvgnfjr
hD/XOHkT0Sna7tBeu2y8TgBvbNNo47wnz+HrelzUkZaGJZBEDvYrt7BKV0/NFVfc
owWxtcf3oNPa0JvSIw79GQM9U+POzPTCTqvEUgZzao6pdyfdr8P3QVm9D01y1CSB
PcYnECNxpijYAe4L7kWe4enADoUKEeNwEtbtgxj4RFTMfmGOz2GTmUiL2AP/i1Uh
he5fgrosgpdljT1TAzjB
=LosV
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
