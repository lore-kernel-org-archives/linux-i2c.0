From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.11
Date: Fri, 24 Feb 2017 22:50:14 +0100
Message-ID: <20170224215008.dy36nin5voejf7bt@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbv5mm6tnnlwspa3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48158 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbdBXVuU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Feb 2017 16:50:20 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--hbv5mm6tnnlwspa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for you two new drivers (Tegra BPMP and STM32F4), interrupt
support for pca954x muxes, and a bunch of driver bugfixes and
improvements. Nothing really special this cycle.

A few commits have been added to my tree just recently. Those are the
Tegra BPMP driver and a few straightforward bugfixes or cleanups which I
prefer to have upstream rather soonish. The rest had proper linux-next
exposure.

Please pull.

Thanks,

   Wolfram


The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d36:

  Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.11

for you to fetch changes up to 4c21541d8da17fbe94ecadbfc913d6dff3be7ca2:

  i2c: thunderx: Replace pci_enable_msix() (2017-02-23 13:03:56 +0100)

----------------------------------------------------------------
Alexandre Belloni (1):
      i2c: at91: ensure state is restored after suspending

Andrzej Hajda (2):
      i2c: exynos5: disable fifo-almost-empty irq signal when necessary
      i2c: exynos5: fix arbitration lost handling

Ben Gardner (1):
      misc: eeprom: at24: use device_property_*() functions instead of of_get_property()

Bhumika Goyal (2):
      i2c: omap: constify dev_pm_ops structures
      i2c: busses: constify i2c_algorithm structures

Chris Brandt (1):
      i2c: riic: correctly finish transfers

Grzegorz Jaszczyk (1):
      i2c: mv64xxx: add suspend/resume support

Guenter Roeck (1):
      i2c: i2c-cros-ec-tunnel: Reduce logging noise

Jan Glauber (1):
      i2c: thunderx: Replace pci_enable_msix()

Javier Martinez Canillas (2):
      i2c: mux: pca954x: Export OF device ID table as module aliases
      i2c: mux: pca9541: Export OF device ID table as module aliases

Luis Oliveira (1):
      i2c: core: helper function to detect slave mode

M'boumba Cedric Madianga (2):
      dt-bindings: Document the STM32 I2C bindings
      i2c: stm32f4: add driver

Mika Westerberg (1):
      i2c: i801: Add support for Intel Gemini Lake

Peter Rosin (1):
      i2c: i2c-mux-gpio: rename i2c-gpio-mux to i2c-mux-gpio

Phil Reid (3):
      i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
      dt: bindings: i2c-mux-pca954x: Add documentation for interrupt controller
      i2c: mux: pca954x: Add interrupt controller support

Shardar Shariff Md (1):
      i2c: Add Tegra BPMP I2C proxy driver

Simon Horman (1):
      i2c: sh_mobile: document support for r8a7796 (R-Car M3-W)

Stefan Wahren (1):
      i2c: bcm2835: Avoid possible NULL ptr dereference

Stephen Warren (1):
      dt-bindings: Add Tegra186 BPMP I2C binding

Wei Yongjun (1):
      i2c: mux: mlxcpld: remove unused including <linux/version.h>

Wolfram Sang (1):
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.11


with much appreciated quality assurance from
----------------------------------------------------------------
Andi Shyti (4):
      (Test) i2c: exynos5: fix arbitration lost handling
      (Rev.) i2c: exynos5: fix arbitration lost handling
      (Test) i2c: exynos5: disable fifo-almost-empty irq signal when necessary
      (Rev.) i2c: exynos5: disable fifo-almost-empty irq signal when necessary

Andy Shevchenko (2):
      (Rev.) misc: eeprom: at24: use device_property_*() functions instead of of_get_property()
      (Rev.) i2c: core: helper function to detect slave mode

Douglas Anderson (1):
      (Rev.) i2c: i2c-cros-ec-tunnel: Reduce logging noise

Jean Delvare (1):
      (Rev.) i2c: busses: constify i2c_algorithm structures

Lior Amsalem (2):
      (Rev.) i2c: mv64xxx: add suspend/resume support
      (Test) i2c: mv64xxx: add suspend/resume support

Marek Szyprowski (1):
      (Test) i2c: exynos5: disable fifo-almost-empty irq signal when necessary

Nadav Haklai (1):
      (Rev.) i2c: mv64xxx: add suspend/resume support

Simon Glass (1):
      (Rev.) dt-bindings: Add Tegra186 BPMP I2C binding

Wolfram Sang (1):
      (Rev.) i2c: riic: correctly finish transfers

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  14 +-
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   1 +
 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 .../bindings/i2c/nvidia,tegra186-bpmp-i2c.txt      |  42 +
 Documentation/i2c/busses/i2c-i801                  |   1 +
 Documentation/i2c/muxes/i2c-mux-gpio               |  20 +-
 drivers/i2c/busses/Kconfig                         |  22 +
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-at91.c                      |   5 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |   4 +-
 drivers/i2c/busses/i2c-bfin-twi.c                  |   2 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c            |   8 +-
 drivers/i2c/busses/i2c-designware-core.c           |   2 +-
 drivers/i2c/busses/i2c-eg20t.c                     |   2 +-
 drivers/i2c/busses/i2c-emev2.c                     |   2 +-
 drivers/i2c/busses/i2c-exynos5.c                   |  34 +-
 drivers/i2c/busses/i2c-i801.c                      |   3 +
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |   2 +-
 drivers/i2c/busses/i2c-imx.c                       |   2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |  21 +
 drivers/i2c/busses/i2c-nforce2.c                   |   2 +-
 drivers/i2c/busses/i2c-octeon-core.h               |   4 -
 drivers/i2c/busses/i2c-omap.c                      |   2 +-
 drivers/i2c/busses/i2c-riic.c                      |  30 +-
 drivers/i2c/busses/i2c-robotfuzz-osif.c            |   2 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   2 +-
 drivers/i2c/busses/i2c-st.c                        |   2 +-
 drivers/i2c/busses/i2c-stm32f4.c                   | 897 +++++++++++++++++++++
 drivers/i2c/busses/i2c-tegra-bpmp.c                | 346 ++++++++
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |   6 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             |   2 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |   2 +-
 drivers/i2c/busses/i2c-xlr.c                       |   2 +-
 drivers/i2c/i2c-core.c                             |  33 +
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                |   1 -
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   1 +
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 151 +++-
 drivers/misc/eeprom/at24.c                         |  45 +-
 include/linux/i2c.h                                |   1 +
 39 files changed, 1675 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c
 create mode 100644 drivers/i2c/busses/i2c-tegra-bpmp.c

--hbv5mm6tnnlwspa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliwqoEACgkQFA3kzBSg
Kbb8tg/8DyFdec5dma5xjeM9DGaL3eOcK5OqcwR374vt+uqhfBMgxBouyEEIqAIM
M8ZO1McPsSTnkrvFRXrUMs8aw7iz4z82/SzUES2bhEBsr7+Ke9um7866QUDFGht0
ih9ghyelheDG5G5tK/Pg7K4TI78r7l9oPnoMQOqIA3wfNUXjvtzibq/R3J9HmDOm
EyQM69ubrPAbO+3LhuxZEOAaDLhhpYKfpBQeFMtX1lLZyqRQve5Sy4hAUxEEEB7y
WLW8KTFG1U+w67vVgSjiER4nVekoYvcdmqUK5ERVWXyo3TTLIurK/iWpmUKLo4CX
N8vcBhB3srWJCDn6MzkeXTFO1u6biqx5kVW+qVnDYUq/uER5RAkC25Dc09LNFFa1
f2yROJxxz3ddidq8o33QHux9PL5OvKOB2gOgDaonGzpH/hZxnaHy+gU1zfSGJ9WR
Hb2b4KCJ88xu3utDtK1vgO3RNNuSUlwP4EkhcUnIDORH+brMbnj3WAZvmVu4YUiO
t7KIkLhBB4GmzNHzmCMuie2gjzc+0jMH5nLHu2YSJBMDsnOyg+XFXN3wWlJ4YJCO
vtdXbtpgEgtiRi665mulEZJ1UypSECiSfLWWcv9UpxLIq68MIPZ7ftok6PDZS6Ti
qagHsaPRFTQbZt60CeZJKh5QmjMJSGxddxX6dRw/WnvptglAIwM=
=X30X
-----END PGP SIGNATURE-----

--hbv5mm6tnnlwspa3--
