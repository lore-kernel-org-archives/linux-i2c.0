From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.14
Date: Fri, 8 Sep 2017 21:24:21 +0200
Message-ID: <20170908192417.aczqvttxgbdqvtqn@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="umgddew37g2lxmbk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54045 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754777AbdIHTYX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 8 Sep 2017 15:24:23 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>


--umgddew37g2lxmbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

For v4.14, I2C has the following changes:

* new drivers for Spreadtrum I2C, Intel Cherry Trail Whiskey Cove SMBUS
* quite some driver updates
* cleanups for the i2c-mux subsystem
* some subsystem-wide constification
* further cleanup of include/linux/i2c

For the latter topic, I applied a patch touching files for blackfin arch. I
didn't get acks for those because the mailing list seems to be dead and the
email for Sonic Zhang bounces meanwhile. Since the patch is trivial and I'd
like to finalize the cleanup now, I hope you agree to me picking it via
I2C. All other patches have proper acks from the responsible maintainers.

Please pull.

Thanks,

   Wolfram


The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.14

for you to fetch changes up to 8ce906c13c32cfd3de71063ca4b8c3b774e4ca08:

  i2c: sprd: Fix undefined reference errors (2017-08-31 20:32:33 +0200)

----------------------------------------------------------------
Andrew Jeffery (1):
      i2c: aspeed: Retain delay/setup/hold values when configuring bus frequency

Andy Yan (2):
      dt-bindings: i2c: rk3x: add support for rv1108
      i2c: rk3x: add support for rv1108

Arvind Yadav (2):
      i2c: taos-evm: constify serio_device_id
      i2c: nomadik: constify amba_id

Baolin Wang (3):
      dt-bindings: i2c: Add Spreadtrum I2C controller documentation
      i2c: Add Spreadtrum I2C controller driver
      i2c: sprd: Fix undefined reference errors

Bhumika Goyal (4):
      i2c: busses: make i2c_algorithm const
      i2c: busses: make i2c_adapter const
      i2c: busses: make i2c_adapter_quirks const
      i2c: versatile: Make i2c_algo_bit_data const

Biju Das (2):
      dt-bindings: i2c: Document r8a7743/5 support
      dt-bindings: i2c: sh_mobile: Document r8a7743/5 support

Brendan Higgins (1):
      i2c: aspeed: add proper support fo 24xx clock params

Colin Ian King (1):
      i2c-cht-wc: make cht_wc_i2c_adap_driver static

Dan Carpenter (1):
      i2c: mux: pinctrl: potential NULL dereference on error

Eugeniu Rosca (2):
      i2c: rcar: avoid unused ret variable
      i2c: sh_mobile: avoid unused ret variable

Franklin S Cooper Jr (1):
      i2c: davinci: Preserve return value of devm_clk_get

Gustavo A. R. Silva (1):
      i2c: constify internal structures

Hans de Goede (5):
      i2c-cht-wc: Add Intel Cherry Trail Whiskey Cove SMBUS controller driver
      i2c-cht-wc: Add locking to interrupt / smbus_xfer functions
      i2c-cht-wc: Ack read irqs after reading the data register
      i2c-cht-wc: Workaround CHT GPIO controller IRQ issues
      MAINTAINERS: Add entry for drivers/i2c/busses/i2c-cht-wc.c

Javier Martinez Canillas (1):
      dt-bindings: i2c: eeprom: Document vendor to be used and deprecated ones

Jun Gao (4):
      i2c: mediatek: send i2c master code at 400k
      dt-bindings: i2c: modify information formats
      dt-bindings: i2c: Add MediaTek MT7622 i2c binding
      i2c: mediatek: Add i2c compatible for MediaTek MT7622

Masahiro Yamada (3):
      i2c: use dev_get_drvdata() to get private data in suspend/resume hooks
      i2c: uniphier: add suspend / resume support
      i2c: uniphier-f: add suspend / resume support

Peter Rosin (4):
      i2c: mux: pinctrl: remove platform_data
      i2c: mux: pinctrl: drop the idle_state member
      i2c: Documentation: i2c-topology: mention recent driver additions
      i2c: mux: i2c-arb-gpio-challenge: allow compiling w/o OF support

Philipp Zabel (4):
      i2c: mv64xxx: explicitly request exclusive reset control
      i2c: stm32f4: explicitly request exclusive reset control
      i2c: sun6i-pw2i: explicitly request exclusive reset control
      i2c: tegra: explicitly request exclusive reset control

Qiuxu Zhuo (1):
      i2c: i801: Restore the presence state of P2SB PCI device after reading BAR

Rob Herring (1):
      i2c: Convert to using %pOF instead of full_name

Wolfram Sang (7):
      gpu: drm: tc35876x: move header file out of I2C realm
      i2c: mux: pca9541: sort include files
      i2c: mux: pca954x: move header file out of I2C realm
      i2c: mux: mlxcpld: move header file out of I2C realm
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.14
      blackfin: merge the two TWI header files
      MAINTAINERS: drop entry for Blackfin I2C and Sonic's email


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (3):
      (Rev.) i2c: Add Spreadtrum I2C controller driver
      (Rev.) i2c-cht-wc: Add Intel Cherry Trail Whiskey Cove SMBUS controller driver
      (Rev.) i2c: use dev_get_drvdata() to get private data in suspend/resume hooks

Brendan Higgins (2):
      (Rev.) i2c: aspeed: Retain delay/setup/hold values when configuring bus frequency
      (Test) i2c: aspeed: Retain delay/setup/hold values when configuring bus frequency

Grygorii Strashko (1):
      (Rev.) i2c: davinci: Preserve return value of devm_clk_get

Heiko Stuebner (1):
      (Rev.) i2c: rk3x: add support for rv1108

Mika Westerberg (1):
      (Rev.) i2c: i801: Restore the presence state of P2SB PCI device after reading BAR

Stephen Warren (2):
      (Rev.) i2c: mux: pinctrl: drop the idle_state member
      (Rev.) i2c: mux: pinctrl: remove platform_data

Yingjoe Chen (1):
      (Rev.) i2c: mediatek: Add i2c compatible for MediaTek MT7622

Yunying Sun (1):
      (Test) i2c: i801: Restore the presence state of P2SB PCI device after reading BAR

 .../devicetree/bindings/eeprom/eeprom.txt          |   6 +-
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt  |  15 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   5 +-
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |   1 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   5 +-
 Documentation/devicetree/bindings/i2c/i2c-sprd.txt |  31 +
 Documentation/i2c/i2c-topology                     |   6 +
 MAINTAINERS                                        |  15 +-
 arch/blackfin/include/asm/bfin_twi.h               | 134 ++++-
 arch/blackfin/kernel/debug-mmrs.c                  |   1 -
 .../intel-mid/device_libs/platform_tc35876x.c      |   2 +-
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c         |   2 +-
 drivers/i2c/busses/Kconfig                         |  15 +
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-aspeed.c                    |  81 ++-
 drivers/i2c/busses/i2c-at91.c                      |   2 +-
 drivers/i2c/busses/i2c-bcm-iproc.c                 |   6 +-
 drivers/i2c/busses/i2c-bfin-twi.c                  |   1 -
 drivers/i2c/busses/i2c-cadence.c                   |   6 +-
 drivers/i2c/busses/i2c-cht-wc.c                    | 363 ++++++++++++
 drivers/i2c/busses/i2c-cpm.c                       |   2 +-
 drivers/i2c/busses/i2c-davinci.c                   |  10 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |   6 +-
 drivers/i2c/busses/i2c-designware-slave.c          |   2 +-
 drivers/i2c/busses/i2c-exynos5.c                   |   6 +-
 drivers/i2c/busses/i2c-gpio.c                      |   4 +-
 drivers/i2c/busses/i2c-hix5hd2.c                   |   6 +-
 drivers/i2c/busses/i2c-i801.c                      |  12 +-
 drivers/i2c/busses/i2c-kempld.c                    |   2 +-
 drivers/i2c/busses/i2c-lpc2k.c                     |   6 +-
 drivers/i2c/busses/i2c-mlxcpld.c                   |   2 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |  79 ++-
 drivers/i2c/busses/i2c-mv64xxx.c                   |   5 +-
 drivers/i2c/busses/i2c-nomadik.c                   |   2 +-
 drivers/i2c/busses/i2c-ocores.c                    |   2 +-
 drivers/i2c/busses/i2c-octeon-platdrv.c            |   2 +-
 drivers/i2c/busses/i2c-opal.c                      |   2 +-
 drivers/i2c/busses/i2c-pmcmsp.c                    |   4 +-
 drivers/i2c/busses/i2c-pnx.c                       |   2 +-
 drivers/i2c/busses/i2c-powermac.c                  |  12 +-
 drivers/i2c/busses/i2c-puv3.c                      |   2 +-
 drivers/i2c/busses/i2c-pxa.c                       |   6 +-
 drivers/i2c/busses/i2c-qup.c                       |   2 +-
 drivers/i2c/busses/i2c-rcar.c                      |   5 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   9 +
 drivers/i2c/busses/i2c-s3c2410.c                   |   6 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   4 +-
 drivers/i2c/busses/i2c-sirf.c                      |   6 +-
 drivers/i2c/busses/i2c-sprd.c                      | 646 +++++++++++++++++++++
 drivers/i2c/busses/i2c-st.c                        |   3 +-
 drivers/i2c/busses/i2c-stm32f4.c                   |   4 +-
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |   6 +-
 drivers/i2c/busses/i2c-taos-evm.c                  |   2 +-
 drivers/i2c/busses/i2c-tegra.c                     |   4 +-
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |   2 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |  46 +-
 drivers/i2c/busses/i2c-uniphier.c                  |  40 +-
 drivers/i2c/busses/i2c-versatile.c                 |   2 +-
 drivers/i2c/busses/i2c-xiic.c                      |   8 +-
 drivers/i2c/i2c-core-of.c                          |  24 +-
 drivers/i2c/muxes/Kconfig                          |   3 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +-
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                |   2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   9 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                | 225 +++----
 include/linux/i2c-mux-pinctrl.h                    |  41 --
 include/linux/i2c/bfin_twi.h                       | 145 -----
 include/linux/{i2c => platform_data}/pca954x.h     |   0
 include/linux/{i2c => platform_data}/tc35876x.h    |   0
 include/linux/{i2c => platform_data/x86}/mlxcpld.h |   0
 71 files changed, 1594 insertions(+), 531 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sprd.txt
 create mode 100644 drivers/i2c/busses/i2c-cht-wc.c
 create mode 100644 drivers/i2c/busses/i2c-sprd.c
 delete mode 100644 include/linux/i2c-mux-pinctrl.h
 delete mode 100644 include/linux/i2c/bfin_twi.h
 rename include/linux/{i2c => platform_data}/pca954x.h (100%)
 rename include/linux/{i2c => platform_data}/tc35876x.h (100%)
 rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)

--umgddew37g2lxmbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmy7mAACgkQFA3kzBSg
KbZbdBAApauKMjroBHwLHt+5+erMVpFzVx3YnUyV3/hEqxAfFBI8nRjtt7Zh0eAB
JCMlQGJywnRoOmdSbkIj45t7Khm88WKPyc5ItSDKsolxIxUasndC25XtSIzGJWVE
PFmsyvuUgW1DbSonOrmP4iNuLCPzDq2IGs7u0TxYzHUR4PJhBtp8vVVKaojz4lgJ
9Bliwu2GEWRsxZKw4fBd2bvETrW/K6eZNOuNVDubfegyVR3/1yf+aYdwt6bq32un
G+29VP3QzuNTzlj7lnqiloVFMSGotOawlXdVIJCFcNdEduX15DLEcheuLqE+u/+L
BUX1j9cIbcxGwz5QILmSk8WCpaF/ystgd+azz0ZX2NQ2sXkd1YhWRKhAAnF1nVhj
sYreE0wC2jfNVrQjlmPeOUHlw9M24Xs6vXiBXbo33v3MeC4jBurCJ0kC88G8rWw0
9977Z2rkw1XIl4gEj7kPfepPyYnYIWvuLi7K/nKlKGpO900163oObSnWLwqDqztE
BQSzUJh5xkALclTIdFxQ7anrtdKfTJShJD/Gy53cvD6AcAsl0BgZ6KIlQu7iykRa
Rhcl5yeLrgh7jC6OITWnM39sM1QpXRmTUkY7DGt2scNkRRPjd5Uu9mxWGyjcgwtu
vY2zCPnX2daUGI62n5TGc0Wg4G40zryJX2ZOrEXwEEjzAE/64Ss=
=vJ1g
-----END PGP SIGNATURE-----

--umgddew37g2lxmbk--
