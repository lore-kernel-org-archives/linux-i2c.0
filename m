From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.7
Date: Thu, 19 May 2016 23:23:43 +0200
Message-ID: <20160519212340.GA2111@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

I2C updates for 4.7:

* Peter Rosin did some major rework on the locking of i2c muxes by
  seperating parent-locked muxes and mux-locked muxes. This avoids
  deadlocks/workarounds when the mux itself needs i2c commands for
  muxing. And as a side-effect, other workarounds in the media layer
  could be eliminated. Also, Peter stepped up as the i2c mux
  maintainer and will keep an eye on these changes.
* major updates to the octeon driver
* Add a helper to the core to generate the address+rw_bit octal and
  make drivers use it
* quite a bunch of driver updates

Please pull.

Thanks,

   Wolfram


The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.7

for you to fetch changes up to 73e8b0528346e88a0624f2d9821f382cd6256677:

  i2c: rcar: add DMA support (2016-05-15 08:52:49 +0200)

----------------------------------------------------------------
Antti Palosaari (1):
      [media] si2168: change the i2c gate to be mux-locked

Axel Lin (2):
      i2c: exynos5: Use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS instead of open-coded
      i2c: s3c2410: Use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS instead of open-coded

Bartosz Golaszewski (2):
      eeprom: at24: remove a reduntant if
      eeprom: at24: replace msleep() with usleep_range()

David Daney (2):
      i2c: octeon: Enable High-Level Controller
      i2c: octeon: Add workaround for broken irqs on CN3860

David Wu (1):
      i2c: rk3x: switch to i2c generic dt parsing

Irina Tirdea (1):
      i2c: dln2: Pass forward ACPI companion

Jan Glauber (9):
      i2c: octeon: Increase retry default and use fixed timeout value
      i2c: octeon: Move set-clock and init-lowlevel upward
      i2c: octeon: Rename [read|write]_sw to reg_[read|write]
      i2c: octeon: Introduce helper functions for register access
      i2c: octeon: Remove superfluous check in octeon_i2c_test_iflg
      i2c: octeon: Improve error status checking
      i2c: octeon: Use i2c recovery framework
      i2c: octeon: Add support for cn78xx chips
      i2c: octeon: Remove zero-length message support

Jarkko Nikula (2):
      i2c: i801: Convert to struct dev_pm_ops for suspend/resume
      i2c: i801: Add runtime PM support with autosuspend

Javier Martinez Canillas (3):
      i2c: s3c2410: Print errno code in error logs
      i2c: s3c2410: Check clk_prepare_enable() return value
      i2c: nforce2: Use IS_ENABLED() instead of checking for built-in or mo=
dule

Krzysztof Kozlowski (3):
      i2c: s3c2410: Add missing clock unprepare on probe() error path
      i2c: s3c2410: Minor function-level comment cleanup
      i2c: s3c2410: Cleanup indentation and comment style

Linus Walleij (1):
      i2c: let I2C masters ignore their children for PM

Masahiro Yamada (1):
      i2c: uniphier: add "\n" at the end of error log

Michele Curti (1):
      i2c: algo-bit: declare i2c_bit_quirk_no_clk_stretch as static

Niklas S=C3=B6derlund (1):
      i2c: rcar: add DMA support

Oleksij Rempel (1):
      i2c: imx: reduce load by using usleep_range instead of udelay

Peter Griffin (1):
      i2c: st: Implement bus clear

Peter Rosin (23):
      i2c: mux: add common data for every i2c-mux instance
      i2c: i2c-mux-gpio: convert to use an explicit i2c mux core
      i2c: i2c-mux-pinctrl: convert to use an explicit i2c mux core
      i2c: i2c-arb-gpio-challenge: convert to use an explicit i2c mux core
      i2c: i2c-mux-pca9541: convert to use an explicit i2c mux core
      i2c: i2c-mux-pca954x: convert to use an explicit i2c mux core
      i2c: i2c-mux-reg: convert to use an explicit i2c mux core
      iio: imu: inv_mpu6050: convert to use an explicit i2c mux core
      [media] m88ds3103: convert to use an explicit i2c mux core
      [media] rtl2830: convert to use an explicit i2c mux core
      [media] rtl2832: convert to use an explicit i2c mux core
      [media] si2168: convert to use an explicit i2c mux core
      [media] cx231xx: convert to use an explicit i2c mux core
      of/unittest: convert to use an explicit i2c mux core
      i2c: mux: drop old unused i2c-mux api
      i2c: allow adapter drivers to override the adapter locking
      i2c: muxes always lock the parent adapter
      i2c: mux: relax locking of the top i2c adapter during mux-locked muxi=
ng
      i2c: mux: document i2c muxes and elaborate on parent-/mux-locked muxes
      iio: imu: inv_mpu6050: change the i2c gate to be mux-locked
      [media] rtl2832: change the i2c gate to be mux-locked
      [media] rtl2832_sdr: get rid of empty regmap wrappers
      [media] rtl2832: regmap is aware of lockdep, drop local locking hack

Peter Swain (2):
      i2c: octeon: Add flush writeq helper function
      i2c: octeon: Improve performance if interrupt is early

Sebastian Andrzej Siewior (1):
      i2c: omap: drop the lock hard irq context

Shardar Shariff Md (2):
      i2c: tegra: enable multi master mode for tegra210
      i2c: tegra: disable clock before returning error

Thomas Petazzoni (4):
      i2c: mv64xxx: enable the driver on ARCH_MVEBU
      i2c: mv64xxx: handle probe deferral for the clock
      i2c: mv64xxx: use clk_{prepare_enable,disable_unprepare}
      i2c: mv64xxx: remove CONFIG_HAVE_CLK conditionals

Wolfram Sang (20):
      i2c: guarantee that I2C_M_RD will be 0x0001 forever
      i2c: introduce helper function to get 8 bit address from a message
      i2c: core: use new 8 bit address helper function
      i2c: bcm-iproc: use new 8 bit address helper function
      i2c: bcm-kona: use new 8 bit address helper function
      i2c: brcmstb: use new 8 bit address helper function
      i2c: cpm: use new 8 bit address helper function
      i2c: ibm_iic: use new 8 bit address helper function
      i2c: img-scb: use new 8 bit address helper function
      i2c: iop3xx: use new 8 bit address helper function
      i2c: lpc2k: use new 8 bit address helper function
      i2c: mt65xx: use new 8 bit address helper function
      i2c: ocores: use new 8 bit address helper function
      i2c: powermac: use new 8 bit address helper function
      i2c: qup: use new 8 bit address helper function
      i2c: sh_mobile: use new 8 bit address helper function
      i2c: sirf: use new 8 bit address helper function
      i2c: st: use new 8 bit address helper function
      i2c: mux: pinctrl: fix indentation for better readability
      i2c: only check scl functions when using generic recovery

 .../devicetree/bindings/i2c/i2c-octeon.txt         |   6 +
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   3 +
 Documentation/i2c/i2c-topology                     | 370 ++++++++
 MAINTAINERS                                        |   1 +
 drivers/i2c/algos/i2c-algo-bit.c                   |   2 +-
 drivers/i2c/busses/Kconfig                         |   2 +-
 drivers/i2c/busses/i2c-bcm-iproc.c                 |   2 +-
 drivers/i2c/busses/i2c-bcm-kona.c                  |   5 +-
 drivers/i2c/busses/i2c-brcmstb.c                   |   4 +-
 drivers/i2c/busses/i2c-cpm.c                       |   4 +-
 drivers/i2c/busses/i2c-dln2.c                      |   2 +
 drivers/i2c/busses/i2c-exynos5.c                   |  10 +-
 drivers/i2c/busses/i2c-i801.c                      |  52 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   2 +-
 drivers/i2c/busses/i2c-img-scb.c                   |   4 +-
 drivers/i2c/busses/i2c-imx.c                       |   2 +-
 drivers/i2c/busses/i2c-iop3xx.c                    |   5 +-
 drivers/i2c/busses/i2c-lpc2k.c                     |   4 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |   5 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |  45 +-
 drivers/i2c/busses/i2c-nforce2.c                   |   2 +-
 drivers/i2c/busses/i2c-ocores.c                    |   5 +-
 drivers/i2c/busses/i2c-octeon.c                    | 998 +++++++++++++++++=
----
 drivers/i2c/busses/i2c-omap.c                      |  12 +-
 drivers/i2c/busses/i2c-powermac.c                  |   4 +-
 drivers/i2c/busses/i2c-qup.c                       |   2 +-
 drivers/i2c/busses/i2c-rcar.c                      | 233 ++++-
 drivers/i2c/busses/i2c-rk3x.c                      |  87 +-
 drivers/i2c/busses/i2c-s3c2410.c                   | 244 +++--
 drivers/i2c/busses/i2c-sh_mobile.c                 |   3 +-
 drivers/i2c/busses/i2c-sirf.c                      |   4 +-
 drivers/i2c/busses/i2c-st.c                        |  48 +-
 drivers/i2c/busses/i2c-tegra.c                     |  81 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |   2 +-
 drivers/i2c/busses/i2c-uniphier.c                  |   2 +-
 drivers/i2c/i2c-core.c                             |  72 +-
 drivers/i2c/i2c-mux.c                              | 300 +++++--
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |  47 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  73 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                |  58 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  61 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                | 135 +--
 drivers/i2c/muxes/i2c-mux-reg.c                    |  69 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  79 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   3 +-
 drivers/media/dvb-frontends/m88ds3103.c            |  19 +-
 drivers/media/dvb-frontends/m88ds3103_priv.h       |   2 +-
 drivers/media/dvb-frontends/rtl2830.c              |  20 +-
 drivers/media/dvb-frontends/rtl2830_priv.h         |   2 +-
 drivers/media/dvb-frontends/rtl2832.c              | 243 +----
 drivers/media/dvb-frontends/rtl2832.h              |   4 +-
 drivers/media/dvb-frontends/rtl2832_priv.h         |   3 +-
 drivers/media/dvb-frontends/rtl2832_sdr.c          | 303 +++----
 drivers/media/dvb-frontends/rtl2832_sdr.h          |   5 +-
 drivers/media/dvb-frontends/si2168.c               | 106 +--
 drivers/media/dvb-frontends/si2168_priv.h          |   3 +-
 drivers/media/usb/cx231xx/cx231xx-core.c           |   6 +-
 drivers/media/usb/cx231xx/cx231xx-i2c.c            |  47 +-
 drivers/media/usb/cx231xx/cx231xx.h                |   4 +-
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |   5 +-
 drivers/misc/eeprom/at24.c                         |   9 +-
 drivers/of/unittest.c                              |  37 +-
 include/linux/i2c-mux.h                            |  55 +-
 include/linux/i2c.h                                |  50 +-
 include/uapi/linux/i2c.h                           |  13 +-
 67 files changed, 2648 insertions(+), 1445 deletions(-)
 create mode 100644 Documentation/i2c/i2c-topology

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXPi7cAAoJEBQN5MwUoCm2CnMP/3kKWxzsqZBd95sWlQYQBYqs
cq+eKEwKHdLIxbpTQw8zDUYnPUUUFFcDVPxCNpcxnKTPYB5M+M/EA43Hfk9IqNuv
ztJzuGcpfJV8ug6ixSASiv1Qncr9N0sjnOoBZKwP3UJMUzAljk38Wm3IT/mfekP6
Zk+X/Pb+SzzTtDYl9BT1dO0iKwyHLtUVI8o5VrzRpl5oz2PKLJS53N0ho2nVtjUx
ptyVLYGa/iHVq8ppdI9veCAophgPkk61pDuhpTnFnJz9g26+5tIlh/5eht6EIFox
X8sCcj68mHZRjU5QM7Ap3f9gUUr4VCkPs29HG30s5YmW8flb6gsp/rPRR4KfWTk+
TnqwA0713Ai6WyxjLNk9Yq+dvrjn0P5x7UtaAv8lpyMEeobhkxiAfkXM/5721czx
p9AkAmkDzYBEVXtsKQBWiTAln/hwvuYjYtkk4aZSUWH4Q2qwUKWb4lJmp0aKU0pQ
RV9AOy5YH5RNDqcKH9jX8Gdpd9RjrW3hzPXnBZ0+QGb5N+YTPLA9DBik0168cE2j
u4lKjh5L8QtmtJR3zOUGMLPAiu2CaaWawa7hR6V9V2Pm1qDPSMVaxtRe8Ysk82Id
ra/sdsB0X6MRTnO1sNWx3VuUByTUDQls2K1bs2JYIlXJ5LshH8fVkGT19rSUMph3
OVnycEFqJfqzggCyCaIt
=bwny
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
