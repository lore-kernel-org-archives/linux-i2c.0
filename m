From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.10
Date: Thu, 15 Dec 2016 21:35:06 +0100
Message-ID: <20161215203503.GA2636@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here is the first pull request from I2C for 4.10, including:

* the first series of making i2c_device_id optional instead of mandatory
  (in favor of alternatives like of_device_id). This involves adding a
  new probe callback (probe_new) which removes some peculiarities I2C had
  for a long time now. The new probe is matching the other subsystems
  now and the old one will be removed once all users are converted. It
  is expected to take a while but there is ongoing interest in that.
* SMBus Host Notify introduced 4.9 got refactored. They are now using
  interrupts instead of the alert callback which solves multiple issues.
* new drivers for iMX LowPower I2C, Mellanox CPLD and its I2C mux
* significant refactoring for bcm2835 driver
* usual set of driver updates and improvements

Thanks,

   Wolfram


The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.10

for you to fetch changes up to 6eb89ef029fe22aee518a9dc75b9ee5d6ef9b3fe:

  i2c: fsl-lpi2c: read lpi2c fifo size in probe() (2016-12-11 23:06:39 +010=
0)

----------------------------------------------------------------
Alexander Stein (2):
      i2c: designware: Consolidate default functionality bits
      i2c: designware-pcidrv: Add 10bit address feature to medfield/merrifi=
eld

Benjamin Tissoires (6):
      i2c: i801: store and restore the SLVCMD register at load and unload
      i2c: i801: minor formatting issues
      i2c: i801: use BIT() macro for bits definition
      i2c: i801: use the BIT() macro for FEATURES_* also
      i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0
      i2c: use an IRQ to report Host Notify events, not alert

Gao Pan (3):
      dt-bindings: i2c: imx-lpi2c: add devicetree bindings
      i2c: imx-lpi2c: add low power i2c bus driver
      i2c: fsl-lpi2c: read lpi2c fifo size in probe()

Jan Glauber (2):
      i2c: octeon: thunderx: TWSI software reset in recovery
      i2c: octeon: thunderx: Remove double-check after interrupt

Jan Kotas (1):
      i2c: cadence: Allow Cadence I2C to be selected for Cadence Xtensa CPUs

Jarkko Nikula (1):
      i2c: designware: Allow reduce bus speed by "clock-frequency" property

Julia Lawall (1):
      i2c: constify i2c_adapter_quirks structures

Lee Jones (7):
      i2c: Add pointer dereference protection to i2c_match_id()
      i2c: Add the ability to match device to compatible string without an =
of_node
      i2c: Match using traditional OF methods, then by vendor-less compatib=
le strings
      i2c: Make I2C ID tables non-mandatory for DT'ed devices
      i2c: Export i2c_match_id() for direct use by device drivers
      i2c: Provide a temporary .probe_new() call-back type
      mfd: 88pm860x: Move over to new I2C device .probe() call

Masahiro Yamada (2):
      i2c: uniphier: rename jump label to follow coding style guideline
      i2c: uniphier-f: rename jump label to follow coding style guideline

Naveen Kaje (2):
      i2c: qup: add ACPI support
      i2c: qup: support SMBus block read

Noralf Tr=C3=B8nnes (7):
      i2c: bcm2835: Fix hang for writing messages larger than 16 bytes
      i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
      i2c: bcm2835: Use dev_dbg logging on transfer errors
      i2c: bcm2835: Can't support I2C_M_IGNORE_NAK
      i2c: bcm2835: Add support for Repeated Start Condition
      i2c: bcm2835: Support i2c-dev ioctl I2C_TIMEOUT
      i2c: bcm2835: Add support for dynamic clock

Paul Gortmaker (1):
      i2c: i2c-pxa-pci; make explicitly non-modular

Peter Rosin (1):
      i2c: i2c-mux-gpio: update mux with gpiod_set_array_value_cansleep

Romain Perier (3):
      dt-bindings: i2c: pxa: Update the documentation for the Armada 3700
      i2c: pxa: Add definition of fast and high speed modes via the regs la=
yout
      i2c: pxa: Add support for the I2C units found in Armada 3700

Simon Horman (2):
      i2c: rcar: Add per-Generation fallback bindings
      i2c: sh_mobile: Add per-Generation fallback bindings

Tanmay Jagdale (1):
      i2c: xlp9xx: ACPI support for I2C clients

Tin Huynh (1):
      i2c: designware: Implement support for SMBus block read and write

Vadim Pasternak (2):
      i2c: mux: mellanox: add driver
      i2c: mlxcpld: add master driver for mellanox systems

tnhuynh@apm.com (1):
      i2c: mux: pca954x: Add ACPI support for pca954x

 .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt      |  20 +
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt  |   1 +
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |  32 +-
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  17 +-
 Documentation/i2c/busses/i2c-mlxcpld               |  47 ++
 Documentation/i2c/smbus-protocol                   |  12 +-
 MAINTAINERS                                        |   9 +
 drivers/i2c/Kconfig                                |   1 +
 drivers/i2c/busses/Kconfig                         |  25 +-
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-axxia.c                     |   2 +-
 drivers/i2c/busses/i2c-bcm-iproc.c                 |   2 +-
 drivers/i2c/busses/i2c-bcm2835.c                   | 218 ++++---
 drivers/i2c/busses/i2c-designware-core.c           |  46 +-
 drivers/i2c/busses/i2c-designware-core.h           |   8 +
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  10 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  23 +-
 drivers/i2c/busses/i2c-dln2.c                      |   2 +-
 drivers/i2c/busses/i2c-i801.c                      | 123 ++--
 drivers/i2c/busses/i2c-imx-lpi2c.c                 | 652 +++++++++++++++++=
++++
 drivers/i2c/busses/i2c-mlxcpld.c                   | 504 ++++++++++++++++
 drivers/i2c/busses/i2c-octeon-core.c               |  46 +-
 drivers/i2c/busses/i2c-pxa-pci.c                   |  32 +-
 drivers/i2c/busses/i2c-pxa.c                       |  26 +-
 drivers/i2c/busses/i2c-qup.c                       | 122 +++-
 drivers/i2c/busses/i2c-rcar.c                      |   5 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   4 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |   6 +-
 drivers/i2c/busses/i2c-uniphier.c                  |   6 +-
 drivers/i2c/busses/i2c-viperboard.c                |   2 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |   1 +
 drivers/i2c/i2c-core.c                             | 197 ++++++-
 drivers/i2c/i2c-smbus.c                            | 102 ----
 drivers/i2c/muxes/Kconfig                          |  11 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  18 +-
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                | 220 +++++++
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  28 +-
 drivers/mfd/88pm860x-core.c                        |   5 +-
 include/linux/i2c-smbus.h                          |  27 -
 include/linux/i2c.h                                |  26 +-
 include/linux/i2c/mlxcpld.h                        |  52 ++
 42 files changed, 2264 insertions(+), 429 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
 create mode 100644 Documentation/i2c/busses/i2c-mlxcpld
 create mode 100644 drivers/i2c/busses/i2c-imx-lpi2c.c
 create mode 100644 drivers/i2c/busses/i2c-mlxcpld.c
 create mode 100644 drivers/i2c/muxes/i2c-mux-mlxcpld.c
 create mode 100644 include/linux/i2c/mlxcpld.h

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUv53AAoJEBQN5MwUoCm2pgcP/12niDM4wKfuZKxA3TWw4J+/
Yjrc1+g1xFB3Fo1eCYGTrsseVZ3aGTC7RcIY8wTTLpPdLS91e3KJM/WQWK8610T+
+1JhcK1RameR0AtoSinxsJmlj/2f1ikjg6H4aa0RE4S/MJX5nxCceiEVzUcZnD2P
JAcYgV+mLNGzfQSN8x5OVQiRG0agWM7d0U2DQZoK8gk8zFJ7VxOT4fE/p9CmpFre
aJfJESlUK0/equAu1NzTClMw3HUqUoii9JzasxhAbOHSuKzAGad2NwKwjCb0bMx3
QGHAbLe8Ip/UWrXdqZ+PEYR0bxL66ezUkFIXF1izs3/VJteP1ngQ/vLJXo1sTmjH
yc1ZmWy1t0QzP5GG6RWERbG6KayoFi6cGgDpSgOsC4IA7snZt88khSaxngyFpEas
LZO7RBjYUrz5zyUdWhEzBQoyUuLb20RaTcd+HjVcn8B0/whm7A5YblIX1GrLXQhP
qD9PJX5LJ6kfMj44DAXNJI0aukVTXQRdkSWhmpiOrx31gvQR/81mpiiEw6m/P9ww
b07FS7wJOOS69XpuwMMCI13pSwweaEQwj+JmOILWJs0GPANiswuF0Eh4xFlGVs8k
8raj37moHG7g6m8qLhXC71wVYf2Rvrv8A0/kWbEh/uji4ihkWJa3CnUrfv7eBlo/
IZWb2gF5BZseBRUaWVe2
=yjhl
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
