From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.2
Date: Thu, 25 Jun 2015 20:51:19 +0200
Message-ID: <20150625185114.GA1811@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the I2C pull request. Highlights:

* new drivers for Mediatek I2C, APM X-Gene, Broadcom Settop
* major updates to at91, davinci
* bugfixes to the mux infrastructure when dealing with the new quirk
  mechanism
* more users for the bus recovery feature
* further improvements to the slave framework

Plus, the usual bunch of smaller driver and core improvements and fixes.

There is one patch removing old code from an ARM platform. This has been
acked by the sh_mobile maintainer Simon Horman.

Please pull.

Thanks,

   Wolfram


The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.2

for you to fetch changes up to a294aba164389a3d2c40dfcf5f3989a3bbfe38a2:

  i2c: busses: i2c-bcm2835: limits cdiv to allowed values (2015-06-23 19:55:19 +0200)

----------------------------------------------------------------
Alexander Sverdlin (7):
      i2c: axxia: Add bus recovery functionality
      i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
      i2c: davinci: Avoid sending to own address
      i2c: use parent adapter quirks in mux
      i2c: mux: Use __i2c_transfer() instead of calling parent's master_xfer()
      i2c: mux: pca954x: Use __i2c_transfer because of quirks
      i2c: davinci: Optimize SCL generation

Cyrille Pitchen (7):
      i2c: at91: fix a race condition when using the DMA controller
      i2c: at91: use BIT() macro to define register bits
      i2c: at91: update documentation for DT bindings
      i2c: at91: add support for new alternative command mode
      i2c: at91: print hardware version
      i2c: at91: add support to FIFOs
      i2c: at91: fix code checker warnings

Doug Anderson (1):
      i2c: rk3x: Increase wait timeout to 1 second

Eddie Huang (1):
      I2C: mediatek: Add driver for MediaTek MT8173 I2C controller

Felipe Balbi (1):
      i2c: omap: implement bus recovery

Feng Kan (2):
      i2c: add SLIMpro I2C device driver on APM X-Gene platform
      i2c: busses: xgene-slimpro: fix incorrect __init declation for probe

Geert Uytterhoeven (1):
      i2c: Allow compile test of GPIO consumers if !GPIOLIB

Jarkko Nikula (1):
      i2c: core: Reduce stack size of acpi_i2c_space_handler()

Jisheng Zhang (1):
      i2c: designware: Avoid unnecessary resuming during system suspend

Kamal Dasu (1):
      i2c: brcmstb: Add Broadcom settop SoC i2c controller driver

Krzysztof Kozlowski (1):
      i2c: constify platform_device_id

Mika Westerberg (1):
      i2c: designware: Make sure the device is suspended before disabling runtime PM

Nicholas Mc Guire (1):
      i2c: octeon: remove unused signal handling

Pascal Huerst (1):
      i2c: omap: Add calls for pinctrl state select

Ray Jui (1):
      i2c: iproc: Add suspend/resume support

Shailendra Verma (3):
      i2c: core: fix typo in comment
      i2c: algo-pca: fix typo in comment
      i2c: smbus: fix typo in commet

Shubhrajyoti Datta (1):
      i2c: xiic: Fix kerneldoc warnings

Silvan Wicki (2):
      i2c: bcm2835: clear reserved bits in S-Register
      i2c: busses: i2c-bcm2835: limits cdiv to allowed values

Wolfram Sang (13):
      i2c: add FUNC flag for slave capabilities
      i2c: rcar: report slave capabilities to users
      i2c: slave: docs: be more precise about the prerequsites
      i2c: slave: add error messages to slave core
      i2c: check for proper length of the reg property
      i2c: sh_mobile: add errata workaround
      ARM: shmobile: r8a7740: remove I2C errata handling
      i2c: tegra: don't advertise SMBUS_QUICK
      i2c: tegra: apply size limit quirk
      i2c: rcar: use adapter default for timeout
      i2c: rcar: use proper type for timeout
      i2c: sh_mobile: use adapter default for timeout
      i2c: sh_mobile: use proper type for timeout

Xudong Chen (1):
      I2C: mediatek: Add driver for MediaTek I2C controller

 Documentation/devicetree/bindings/i2c/i2c-at91.txt |  30 +-
 .../devicetree/bindings/i2c/i2c-brcmstb.txt        |  28 +
 .../devicetree/bindings/i2c/i2c-mt6577.txt         |  41 ++
 .../devicetree/bindings/i2c/i2c-xgene-slimpro.txt  |  15 +
 Documentation/i2c/slave-interface                  |  25 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  55 --
 drivers/i2c/algos/i2c-algo-pca.c                   |   2 +-
 drivers/i2c/busses/Kconfig                         |  32 +-
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-at91.c                      | 362 ++++++++--
 drivers/i2c/busses/i2c-axxia.c                     |  41 ++
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  57 ++
 drivers/i2c/busses/i2c-bcm2835.c                   |  11 +
 drivers/i2c/busses/i2c-brcmstb.c                   | 694 +++++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c                   |  80 ++-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  35 +-
 drivers/i2c/busses/i2c-imx.c                       |   2 +-
 drivers/i2c/busses/i2c-mt65xx.c                    | 731 +++++++++++++++++++++
 drivers/i2c/busses/i2c-mxs.c                       |   2 +-
 drivers/i2c/busses/i2c-octeon.c                    |   7 +-
 drivers/i2c/busses/i2c-omap.c                      |  74 ++-
 drivers/i2c/busses/i2c-rcar.c                      |  10 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   2 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |   2 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |  49 +-
 drivers/i2c/busses/i2c-tegra.c                     |  11 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             | 469 +++++++++++++
 drivers/i2c/busses/i2c-xiic.c                      |   1 +
 drivers/i2c/i2c-core.c                             |  63 +-
 drivers/i2c/i2c-mux.c                              |   3 +-
 drivers/i2c/i2c-smbus.c                            |   2 +-
 drivers/i2c/muxes/Kconfig                          |   5 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   2 +-
 include/uapi/linux/i2c.h                           |   1 +
 35 files changed, 2730 insertions(+), 221 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
 create mode 100644 drivers/i2c/busses/i2c-brcmstb.c
 create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
 create mode 100644 drivers/i2c/busses/i2c-xgene-slimpro.c

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVjE2iAAoJEBQN5MwUoCm2njQP/34UZtoErV91jCUgaf/eNdoX
ga7RLRT52kmUGXgAumwfkFbqeCdXVufBU97frTqMnWLMQYRTO9mi+rZzyjXHKa8J
f7bLH2eLaOsFo9YpfXI07dtAcK8pMm/kgY2D5/5Vx5V5inT4EqA6Y73ur9X9+7D3
LCh5ghu2FT+YHNgi4oyr3cfzaHeSBVwQPSsB7v3RAeSEtKgl7Mu2LDHvbHjmCrzc
dwdcJHWR+3rzRhQIbd7w0UkEDyo1Y8vi7ZpcHbGLpYfqIHaojWrEV0b2VGe0+rON
8qTfED61DfZamjdpUB8wmDCRC2+32HGQdmK/aVzU0pYv80kMpAlZ6GlbQ6k8l7dy
oZwJKl0F5MNiUew/LNPLIkVJhM0ceCokz+bbglkYY0GTjNi43i6qcOeD7VOApEBh
z24VWjLzbzwsdV51ErUrF9Qnk3+TL9T0+2bLzIozp3kBlfgVUW+S8gxPBpZZjVZf
+TF9YNnmdgIXQWbajdlpPQIXgCxWTL8tyN9EwQr2+ju5c8pWCFTh754RNwGFV7mc
6f6y1DWTWbBdN7yW9Uqjv0Is2wv1Cv8zfbeAfE+TXklgwnBLnCe0EfDvVKwYL+Oc
CmNLtVtUE5QNx3dyCIiYz/+Xm8UR0danGy/RMT0rYl+HALpFjZLRkGs7COMobza2
uKxQHgF+rFJ0dfvuhjdZ
=13Vf
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
