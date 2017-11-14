From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.15
Date: Tue, 14 Nov 2017 16:37:42 +0100
Message-ID: <20171114153738.tc3rzgqliwjmddxf@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qljzuo7fvzdvgpo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60050 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbdKNPho (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 14 Nov 2017 10:37:44 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>


--7qljzuo7fvzdvgpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

the pull request for I2C contains two bigger than usual tree-wide
changes this time. They all have proper acks, caused no merge conflicts
in linux-next where they have been for a while. They are namely:

* to-gpiod conversion of the i2c-gpio driver and its users
  (touching arch/* and drivers/mfd/*)

* adding a sbs-manager based on I2C core updates to SMBus alerts
  (touching drivers/power/*)

Other notable changes:

* i2c_boardinfo can now carry a dev_name to be used when the device is
  created. This is because some devices in ACPI world need fixed names
  to find the regulators.

* the designware driver got a long discussed overhaul of its PM
  handling. img-scb and davinci got PM support, too.

* at24 driver has way better OF support. And it has a new maintainer.
  Thanks Bartosz for stepping up!

The rest is regular driver updates and fixes.

Please pull.

Thanks,

   Wolfram


The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:

  Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.15

for you to fetch changes up to d82e99a6f9b38cb1a044b4cd979bd49fd3f67cd2:

  ARM: sa1100: simpad: Correct I2C GPIO offsets (2017-11-10 15:48:07 +0100)

----------------------------------------------------------------
Andy Shevchenko (3):
      i2c: Make i2c_unregister_device() NULL-aware
      i2c: taos-evm: Remove duplicate NULL check
      i2c: thunderx: Remove duplicate NULL check

Chris Brandt (1):
      i2c: riic: remove clock and frequency restrictions

Claudio Foellmi (2):
      i2c: generic recovery: check SCL before SDA
      i2c: omap: Trigger bus recovery in lockup case

Colin Ian King (1):
      i2c: designware: make const array supported_speeds static to shink object code size

Divagar Mohandass (3):
      dt-bindings: add eeprom "size" property
      eeprom: at24: add support to fetch eeprom device property "size"
      eeprom: at24: enable runtime pm support

Ed Blake (1):
      i2c: img-scb: Add runtime PM

Franklin S Cooper Jr (2):
      i2c: davinci: Add PM Runtime Support
      dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm property

Geert Uytterhoeven (3):
      i2c: sh_mobile: Use of_device_get_match_data() helper
      dt-bindings: i2c: i2c-mux: spelling s/required is/required if/
      dt-bindings: i2c: i2c-gpio: Add support for named gpios

Hans de Goede (2):
      i2c: Allow overriding dev_name through board_info
      i2c-cht-wc: Add device-properties for fusb302 integration

Hoan Tran (1):
      i2c: xgene-slimpro: Support v2

Javier Martinez Canillas (1):
      eeprom: at24: Add OF device ID table

Jayachandran C (2):
      ACPI / APD: Add clock frequency for ThunderX2 I2C controller
      i2c: xlp9xx: Get clock frequency with clk API

Joel Stanley (1):
      i2c: aspeed: Deassert reset in probe

Julia Lawall (1):
      i2c: mpc: use of_property_read_bool

Kamlakant Patel (1):
      i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags

Karl-Heinz Schneider (2):
      Documentation: Add sbs-manager device tree node documentation
      power: Adds support for Smart Battery System Manager

Kees Cook (1):
      i2c/busses: Convert timers to use timer_setup()

Linus Walleij (7):
      i2c: gpio: Convert to use descriptors
      gpio: Make it possible for consumers to enforce open drain
      i2c: gpio: Enforce open drain through gpiolib
      i2c: gpio: Augment all boardfiles to use open drain
      i2c: gpio: Local vars in probe
      i2c: gpio: Add support for named gpios in DT
      ARM: sa1100: simpad: Correct I2C GPIO offsets

Phil Reid (8):
      i2c: i2c-smbus: Use threaded irq for smbalert
      i2c: i2c-smbus: Move i2c_setup_smbus_alert from i2c-smbus to i2c-core-smbus
      i2c: i2c-smbus: add of_i2c_setup_smbus_alert
      i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
      i2c: mux: pca954x: call request irq after adding mux segments
      i2c: mux: pca954x: Return error if irq_create_mapping fails
      power: supply: sbs-manager: Add alert callback and battery change notification
      power: supply: sbs-battery: move gpio present detect to sbs_get_property

Rafael J. Wysocki (3):
      PM: i2c-designware-platdrv: Clean up PM handling in probe
      PM / mfd: intel-lpss: Push system sleep callbacks to late/early stages
      PM: i2c-designware-platdrv: Suspend/resume at the late/early stages

Sergei Shtylyov (2):
      i2c: rcar: document R8A77970 bindings
      i2c: mux: reg: use of_property_read_bool()

Wolfram Sang (12):
      i2c: davinci: use correct format identifier for size_t
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.15
      Merge branch 'i2c/cht-wc-fusb302-immutable' into i2c/for-4.15
      Merge tag 'i2c-mux/for-4.15-2' of https://github.com/peda-r/i2c-mux into i2c/for-4.15
      power: supply: sbs-battery: remove superfluous variable init
      power: supply: sbs-battery: remove unchecked return var
      power: supply: sbs-message: fix some code style issues
      Merge branch 'for-wolfram' of git://git.kernel.org/.../linusw/linux-gpio into i2c/for-4.15
      Merge branch 'i2c/sbs-manager' into i2c/for-4.15
      i2c: mpc: remove useless variable initialization
      i2c: nuc900: remove platform_data, too
      MAINTAINERS: new maintainer for AT24 driver


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (2):
      (Rev.) i2c: xgene-slimpro: Support v2
      (Rev.) eeprom: at24: add support to fetch eeprom device property "size"

Benjamin Tissoires (1):
      (Rev.) i2c: i2c-smbus: Use threaded irq for smbalert

Geert Uytterhoeven (8):
      (Test) i2c: gpio: Add support for named gpios in DT
      (Test) dt-bindings: i2c: i2c-gpio: Add support for named gpios
      (Test) i2c: gpio: Local vars in probe
      (Test) i2c: gpio: Augment all boardfiles to use open drain
      (Test) i2c: gpio: Enforce open drain through gpiolib
      (Test) gpio: Make it possible for consumers to enforce open drain
      (Test) i2c: gpio: Convert to use descriptors
      (Rev.) i2c: rcar: document R8A77970 bindings

Grygorii Strashko (1):
      (Rev.) i2c: omap: Trigger bus recovery in lockup case

Jarkko Nikula (2):
      (Test) PM: i2c-designware-platdrv: Suspend/resume at the late/early stages
      (Test) PM / mfd: intel-lpss: Push system sleep callbacks to late/early stages

Jean Delvare (1):
      (Rev.) i2c: taos-evm: Remove duplicate NULL check

Johannes Stezenbach (2):
      (Test) PM: i2c-designware-platdrv: Suspend/resume at the late/early stages
      (Test) PM / mfd: intel-lpss: Push system sleep callbacks to late/early stages

Mika Westerberg (4):
      (Rev.) i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags
      (Rev.) i2c: xlp9xx: Get clock frequency with clk API
      (Test) PM: i2c-designware-platdrv: Suspend/resume at the late/early stages
      (Test) PM / mfd: intel-lpss: Push system sleep callbacks to late/early stages

Rajat Jain (2):
      (Test) PM: i2c-designware-platdrv: Suspend/resume at the late/early stages
      (Test) PM / mfd: intel-lpss: Push system sleep callbacks to late/early stages

Sakari Ailus (3):
      (Rev.) eeprom: at24: enable runtime pm support
      (Rev.) eeprom: at24: add support to fetch eeprom device property "size"
      (Rev.) dt-bindings: add eeprom "size" property

Sebastian Reichel (6):
      (Rev.) power: supply: sbs-message: fix some code style issues
      (Rev.) power: supply: sbs-battery: remove unchecked return var
      (Rev.) power: supply: sbs-battery: remove superfluous variable init
      (Rev.) power: supply: sbs-battery: move gpio present detect to sbs_get_property
      (Rev.) power: Adds support for Smart Battery System Manager
      (Rev.) Documentation: Add sbs-manager device tree node documentation

Simon Horman (2):
      (Rev.) i2c: rcar: document R8A77970 bindings
      (Rev.) i2c: sh_mobile: Use of_device_get_match_data() helper

Vignesh R (1):
      (Test) i2c: omap: Trigger bus recovery in lockup case

 .../devicetree/bindings/eeprom/eeprom.txt          |   2 +
 .../devicetree/bindings/i2c/i2c-aspeed.txt         |   7 +-
 .../devicetree/bindings/i2c/i2c-davinci.txt        |  12 +
 Documentation/devicetree/bindings/i2c/i2c-gpio.txt |  32 +-
 Documentation/devicetree/bindings/i2c/i2c-mux.txt  |   4 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   1 +
 Documentation/devicetree/bindings/i2c/i2c.txt      |   4 +-
 .../bindings/power/supply/sbs,sbs-manager.txt      |  66 +++
 MAINTAINERS                                        |   2 +-
 arch/arm/mach-ep93xx/core.c                        |  41 +-
 arch/arm/mach-ep93xx/edb93xx.c                     |  15 +-
 arch/arm/mach-ep93xx/include/mach/platform.h       |   4 +-
 arch/arm/mach-ep93xx/simone.c                      |  12 +-
 arch/arm/mach-ep93xx/snappercl15.c                 |  12 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |   7 +-
 arch/arm/mach-ixp4xx/avila-setup.c                 |  17 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/fsg-setup.c                   |  16 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c                  |  24 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c                 |  16 +-
 arch/arm/mach-ks8695/board-acs5k.c                 |  15 +-
 arch/arm/mach-pxa/palmz72.c                        |  14 +-
 arch/arm/mach-pxa/viper.c                          |  27 +-
 arch/arm/mach-sa1100/simpad.c                      |  14 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c       |  19 +-
 arch/blackfin/mach-bf533/boards/ezkit.c            |  18 +-
 arch/blackfin/mach-bf533/boards/stamp.c            |  18 +-
 arch/blackfin/mach-bf561/boards/ezkit.c            |  18 +-
 arch/mips/alchemy/board-gpr.c                      |  23 +-
 arch/mips/ath79/mach-pb44.c                        |  16 +-
 drivers/acpi/acpi_apd.c                            |   5 +
 drivers/gpio/gpiolib.c                             |  13 +
 drivers/i2c/busses/Kconfig                         |   5 +
 drivers/i2c/busses/i2c-aspeed.c                    |  12 +
 drivers/i2c/busses/i2c-cht-wc.c                    |  51 ++-
 drivers/i2c/busses/i2c-davinci.c                   |  69 +++-
 drivers/i2c/busses/i2c-designware-core.h           |   2 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |  71 ++--
 drivers/i2c/busses/i2c-gpio.c                      | 212 +++++-----
 drivers/i2c/busses/i2c-img-scb.c                   | 104 +++--
 drivers/i2c/busses/i2c-mpc.c                       |   4 +-
 drivers/i2c/busses/i2c-omap.c                      |  25 +-
 drivers/i2c/busses/i2c-parport-light.c             |   1 -
 drivers/i2c/busses/i2c-parport.c                   |   1 -
 drivers/i2c/busses/i2c-pnx.c                       |   8 +-
 drivers/i2c/busses/i2c-riic.c                      | 115 ++++--
 drivers/i2c/busses/i2c-sh_mobile.c                 |   8 +-
 drivers/i2c/busses/i2c-taos-evm.c                  |   3 +-
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |   9 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             |  30 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |  44 +-
 drivers/i2c/i2c-core-base.c                        |  34 +-
 drivers/i2c/i2c-core-smbus.c                       |  55 +++
 drivers/i2c/i2c-smbus.c                            |  81 ++--
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  95 ++---
 drivers/i2c/muxes/i2c-mux-reg.c                    |   9 +-
 drivers/mfd/intel-lpss.h                           |   7 +-
 drivers/mfd/sm501.c                                |  49 ++-
 drivers/misc/eeprom/at24.c                         | 112 +++++-
 drivers/power/supply/Kconfig                       |  14 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-battery.c                 |  35 +-
 drivers/power/supply/sbs-manager.c                 | 445 +++++++++++++++++++++
 include/linux/gpio/consumer.h                      |   6 +
 include/linux/i2c-gpio.h                           |   4 -
 include/linux/i2c-smbus.h                          |  10 +-
 include/linux/i2c.h                                |   2 +
 include/linux/platform_data/i2c-nuc900.h           |   9 -
 70 files changed, 1685 insertions(+), 599 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 drivers/power/supply/sbs-manager.c
 delete mode 100644 include/linux/platform_data/i2c-nuc900.h

--7qljzuo7fvzdvgpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloLDb0ACgkQFA3kzBSg
Kbb7vxAAsFK+sEQ8dw5r+etTG4X8eFq6dDBms44E/DMRTiIDkEVZ9AbWonLRWadu
wXgrzIHFcek1qJGgMwCZo6wg3oC8t6komOZXALKA864lqPk8X1NIDimEf8SVNCHv
lj5+Ak2gXTHgtDyZpTJ6doHyDoCjJIzHjh65u53fmZ1wRegk5aZc03k6y/NoI8jO
VtED/I76GBW1dcjtkeJdx+LSlJjZOUhzcjOEPRUDaMSPeBlZ3MER2Vo+4dlJS4JN
xJCmh5kBg4THDQiaXBOvDRtBnNhH/CMRA0GqYTccEGq8W3Iq3FO9B7G5cSc7NLH+
yPOSlzm18saYXGrtO8D1CcR81PG/BmJNZuMJJ+y6ybcXDyymQaRxP2kneRQlFS+l
JpjOPBBkzh60YmE4Nqde29bnCjPB21BYHdvd6pVDEDVG2TcsaxcCVwtvCZQ/mUxr
t7QCj9i9yo0PCU11pHKQXZyaxVH61Ok+aL5hJQM/UzdfrMuFJgfwezYlhChcAEtu
NY3c26wyIbVJIO3e/H8dyeDXguhGcnbxUfhiCGdU4l0n6o/lVSnhoGRyEVvMUX9r
UTWq7iDgPbXpFy6EMZ6Bmg3UWnJnfQEQmY+h/KMoLv9mj3TQycV0B/JMEUa3GvFG
PcigFRgRZEk4FMFq6CaZP/B1RsQJCq1t+V4POeWG4awuYfTeCxY=
=BdBJ
-----END PGP SIGNATURE-----

--7qljzuo7fvzdvgpo--
