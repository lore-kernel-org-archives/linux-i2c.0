From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.12
Date: Wed, 3 May 2017 16:41:13 +0200
Message-ID: <20170503144109.3brr7ujmuwlbvhi4@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o754kylr2nqeolkz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60176 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753783AbdECOlS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 3 May 2017 10:41:18 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>


--o754kylr2nqeolkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has the following updates for you:

* an immutable cross-subsystem branch fixing PMIC access on Intel Baytrail
* bigger driver updates to the designware, meson, exynos5 drivers
* new i2c_acpi_new_device() function to create devices from ACPI
* struct i2c_driver has now a flag 'disable_i2c_core_irq_mapping' to
  allow custom IRQ mapping in case the default does not fit
* mux subsystem centralized error messages in its core
* new driver for ltc4306 i2c mux
* usual set of small updates

Please pull.

Thanks,

   Wolfram


The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.12

for you to fetch changes up to 889ef45cd4b64cc4fd6dbebecddb8ea4df8cc1e7:

  i2c: thunderx: Enable HWMON class probing (2017-04-21 18:05:22 +0200)

----------------------------------------------------------------
Andrzej Hajda (4):
      i2c: exynos5: simplify timings calculation
      i2c: exynos5: simplify clock frequency handling
      i2c: exynos5: de-duplicate error logs on clock setup
      i2c: exynos5: use core helper to get driver data

Colin Ian King (2):
      i2c: designware-baytrail: fix potential null pointer dereference on dev
      i2c: tegra: fix spelling mistake: "contoller" -> "controller"

Edgar Cherkasov (1):
      i2c: i2c-scmi: add a MS HID

Geliang Tang (1):
      i2c: img-scb: use setup_timer

Hans de Goede (17):
      x86/platform/intel/iosf_mbi: Add a mutex for P-Unit access
      x86/platform/intel/iosf_mbi: Add a PMIC bus access notifier
      i2c: designware: Rename accessor_flags to flags
      i2c: designware-baytrail: Pass dw_i2c_dev into helper functions
      i2c: designware-baytrail: Only check iosf_mbi_available() for shared hosts
      i2c: designware-baytrail: Disallow the CPU to enter C6 or C7 while holding the punit semaphore
      i2c: designware-baytrail: Fix race when resetting the semaphore
      i2c: designware-baytrail: Add support for cherrytrail
      i2c: designware-baytrail: Acquire P-Unit access on bus acquire
      i2c: designware-baytrail: Call pmic_bus_access_notifier_chain
      drm/i915: Add intel_uncore_suspend / resume functions
      drm/i915: Listen for PMIC bus access notifications
      i2c: designware: Never suspend i2c-busses used for accessing the system PMIC
      i2c: designware: Disable pm for PMIC i2c-bus even if there is no _SEM method
      i2c: core: Allow getting ACPI info by index
      i2c: core: Add new i2c_acpi_new_device helper function
      i2c: core: Allow drivers to disable i2c-core irq mapping

Heiner Kallweit (10):
      i2c: meson: use min instead of min_t where min_t isn't needed
      i2c: meson: remove member irq from struct meson_i2c
      i2c: meson: set clock divider in probe instead of setting it for each transfer
      i2c: meson: use i2c core for DT clock-frequency parsing
      i2c: meson: use full 12 bits for clock divider
      i2c: meson: remove variable count from meson_i2c_xfer
      i2c: meson: improve interrupt handler and detect spurious interrupts
      i2c: meson: don't create separate token chain just for the stop command
      i2c: meson: remove meson_i2c_write_tokens
      i2c: meson: improve and simplify interrupt handler

Jan Glauber (2):
      i2c: thunderx: ACPI support for clock settings
      i2c: thunderx: Enable HWMON class probing

Jayachandran C (1):
      i2c: xlp9xx: update for ARCH_THUNDER2

Jon Hunter (1):
      i2c: tegra-bpmp: Enable Tegra BPMP I2C adapter

Julia Cartwright (1):
      i2c: mux: pca954x: make use of raw_spinlock variants

Liang Chen (1):
      dt-bindings: i2c: rk3x: add support for rk3328

Michael Hennerich (2):
      dt-bindings: i2c: mux: ltc4306: Add dt-bindings for I2C multiplexer/switch
      i2c: mux: ltc4306: LTC4306 and LTC4305 I2C multiplexer/switch

Oliver Neukum (1):
      i2c-designware: increase timeout of semaphore transfer

Peter Rosin (8):
      i2c: mux: provide more info on failure in i2c_mux_add_adapter
      i2c: arb: gpio-challenge: stop double error reporting
      i2c: mux: gpio: stop double error reporting
      i2c: mux: pca9541: stop double error reporting
      i2c: mux: pca954x: stop double error reporting
      i2c: mux: pinctrl: stop double error reporting
      i2c: mux: reg: stop double error reporting
      [media] cx231xx: stop double error reporting

Philipp Zabel (1):
      i2c: mv64xxx: simplify optional reset handling

Wolfram Sang (6):
      Merge tag 'topic/designware-baytrail-2017-03-02' of git://anongit.freedesktop.org/git/drm-intel into i2c/for-next
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.12
      Merge branch 'i2c/for-INT33FE' into i2c/for-4.12
      Merge tag 'i2c-mux/for-4.12-2' of https://github.com/peda-r/i2c-mux into i2c/for-4.12
      i2c: rcar: fix resume by always initializing registers before transfer
      i2c: rcar: clarify PM handling with more comments

chin.yew.tan@intel.com (1):
      i2c: designware: Get selected speed mode sda-hold-time via ACPI


with much appreciated quality assurance from
----------------------------------------------------------------
Andi Shyti (1):
      (Rev.) i2c: exynos5: simplify timings calculation

Andy Shevchenko (13):
      (Rev.) i2c: designware: Get selected speed mode sda-hold-time via ACPI
      (Rev.) i2c: core: Allow drivers to disable i2c-core irq mapping
      (Rev.) i2c: core: Add new i2c_acpi_new_device helper function
      (Rev.) i2c: core: Allow getting ACPI info by index
      (Rev.) i2c: designware-baytrail: Call pmic_bus_access_notifier_chain
      (Rev.) i2c: designware-baytrail: Add support for cherrytrail
      (Rev.) i2c: designware-baytrail: Fix race when resetting the semaphore
      (Rev.) i2c: designware-baytrail: Disallow the CPU to enter C6 or C7 while holding the punit semaphore
      (Rev.) i2c: designware-baytrail: Only check iosf_mbi_available() for shared hosts
      (Rev.) i2c: designware-baytrail: Pass dw_i2c_dev into helper functions
      (Rev.) i2c: designware: Rename accessor_flags to flags
      (Rev.) x86/platform/intel/iosf_mbi: Add a PMIC bus access notifier
      (Rev.) x86/platform/intel/iosf_mbi: Add a mutex for P-Unit access

Hans de Goede (1):
      (Rev.) i2c-designware: increase timeout of semaphore transfer

Heiko Stuebner (1):
      (Rev.) dt-bindings: i2c: rk3x: add support for rk3328

Javier Martinez Canillas (7):
      (Rev.) i2c: exynos5: use core helper to get driver data
      (Test) i2c: exynos5: use core helper to get driver data
      (Rev.) i2c: exynos5: de-duplicate error logs on clock setup
      (Test) i2c: exynos5: de-duplicate error logs on clock setup
      (Rev.) i2c: exynos5: simplify clock frequency handling
      (Test) i2c: exynos5: simplify clock frequency handling
      (Test) i2c: exynos5: simplify timings calculation

Jean Delvare (1):
      (Rev.) i2c: i2c-scmi: add a MS HID

Jerome Brunet (2):
      (Rev.) i2c: meson: use i2c core for DT clock-frequency parsing
      (Rev.) i2c: meson: remove member irq from struct meson_i2c

Linus Walleij (1):
      (Rev.) i2c: mux: ltc4306: LTC4306 and LTC4305 I2C multiplexer/switch

Mauro Carvalho Chehab (1):
      (Rev.) [media] cx231xx: stop double error reporting

Mika Westerberg (1):
      (Rev.) i2c: i2c-scmi: add a MS HID

Takashi Iwai (7):
      (Rev.) i2c: designware-baytrail: Add support for cherrytrail
      (Test) i2c: designware-baytrail: Add support for cherrytrail
      (Test) i2c: designware-baytrail: Disallow the CPU to enter C6 or C7 while holding the punit semaphore
      (Test) i2c: designware-baytrail: Only check iosf_mbi_available() for shared hosts
      (Rev.) i2c: designware-baytrail: Pass dw_i2c_dev into helper functions
      (Test) i2c: designware-baytrail: Pass dw_i2c_dev into helper functions
      (Test) i2c: designware: Rename accessor_flags to flags

Ville Syrj??l?? (2):
      (Rev.) drm/i915: Listen for PMIC bus access notifications
      (Rev.) drm/i915: Add intel_uncore_suspend / resume functions

Wolfram Sang (8):
      (Rev.) [media] cx231xx: stop double error reporting
      (Rev.) i2c: mux: reg: stop double error reporting
      (Rev.) i2c: mux: pinctrl: stop double error reporting
      (Rev.) i2c: mux: pca954x: stop double error reporting
      (Rev.) i2c: mux: pca9541: stop double error reporting
      (Rev.) i2c: mux: gpio: stop double error reporting
      (Rev.) i2c: arb: gpio-challenge: stop double error reporting
      (Rev.) i2c: mux: provide more info on failure in i2c_mux_add_adapter

tagorereddy (6):
      (Test) drm/i915: Listen for PMIC bus access notifications
      (Test) drm/i915: Add intel_uncore_suspend / resume functions
      (Test) i2c: designware-baytrail: Call pmic_bus_access_notifier_chain
      (Test) i2c: designware-baytrail: Acquire P-Unit access on bus acquire
      (Test) x86/platform/intel/iosf_mbi: Add a PMIC bus access notifier
      (Test) x86/platform/intel/iosf_mbi: Add a mutex for P-Unit access

 .../devicetree/bindings/i2c/i2c-meson.txt          |   2 +
 .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    |  61 ++++
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |   1 +
 MAINTAINERS                                        |   8 +
 arch/x86/include/asm/iosf_mbi.h                    |  87 ++++++
 arch/x86/platform/intel/iosf_mbi.c                 |  49 ++++
 drivers/gpu/drm/i915/Kconfig                       |   1 +
 drivers/gpu/drm/i915/i915_drv.c                    |   6 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   7 +-
 drivers/gpu/drm/i915/intel_uncore.c                |  53 +++-
 drivers/i2c/busses/Kconfig                         |   3 +-
 drivers/i2c/busses/i2c-designware-baytrail.c       |  87 ++++--
 drivers/i2c/busses/i2c-designware-core.c           |  25 +-
 drivers/i2c/busses/i2c-designware-core.h           |  17 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  26 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  64 ++--
 drivers/i2c/busses/i2c-exynos5.c                   | 116 ++------
 drivers/i2c/busses/i2c-img-scb.c                   |   5 +-
 drivers/i2c/busses/i2c-meson.c                     | 134 ++++-----
 drivers/i2c/busses/i2c-mv64xxx.c                   |  15 +-
 drivers/i2c/busses/i2c-rcar.c                      |   8 +-
 drivers/i2c/busses/i2c-scmi.c                      |   4 +
 drivers/i2c/busses/i2c-tegra-bpmp.c                |   2 +-
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |  25 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |   1 +
 drivers/i2c/i2c-core.c                             |  62 +++-
 drivers/i2c/i2c-mux.c                              |   9 +-
 drivers/i2c/muxes/Kconfig                          |  11 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |   4 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |   4 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                | 322 +++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  19 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |   4 +-
 drivers/i2c/muxes/i2c-mux-reg.c                    |   4 +-
 drivers/media/usb/cx231xx/cx231xx-i2c.c            |  15 +-
 include/linux/i2c.h                                |  10 +
 38 files changed, 962 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 create mode 100644 drivers/i2c/muxes/i2c-mux-ltc4306.c

--o754kylr2nqeolkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkJ6/8ACgkQFA3kzBSg
KbZh8RAAjOJDt3etG8Ae32n5qcDAobaOk8gEViOLCdozOal/CNsczUImQL9/lOd1
Ax36d0oyLAABf3XGMvgosnMsPvdg9ckWxSXx6U0PEn0JgR/qqwnm4zbbSnqG4gOA
n6kq7OJqKXuKnFGd3dCZjxDMsgp/EUGDEZNOuIOV+nVMFclYlqSUiD2phzd2Pzcd
3aM9c1xL8lPJuDK67dgao9o+F4JRnZTIm+VXgIN8ChnjE18tlh+OmiTYADK1vq2+
MKRNh86Ihrm5LI3pN1QOHXuMqtiweHUiMGtfz+XhKBergFfXbETshVQs5pPBhAM/
4P9kTFyZFBC5Q99AS+sRU7vB5QnOPGKfl4dm1CA4Go1vnnq5qJZwq6AHuAFRS89P
VvKYfpKT5xtO2vpacRyoSnDR5pYURYsjvXOiKiFsMEdXLbCgCSRuvtGSLnJfXtA3
0SCr8tTpxUMLrOGi/ZvTpBHuaNPWoVBfg/SiKlVtyU2wOgJbdpxxt0AN9jkgiL+y
dTUrpVmgI6KLKHuSHC2PF2Wkw9TLRzsHly/q9uyTXC1ftx/zmL2Qgb3gSDcdBR4l
24qfTgQcWeaQGyEzgu7yThUbzAuvZZHnnhiH70WC2sFwSzZ/dsOF4m6524g55sjF
MBbItN1baII7J0x+KbMc49WwdB2iSUSWVTaK7nH92g6Km0CKJEo=
=eieN
-----END PGP SIGNATURE-----

--o754kylr2nqeolkz--
