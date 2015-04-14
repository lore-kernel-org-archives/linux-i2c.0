From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.1
Date: Tue, 14 Apr 2015 23:22:59 +0200
Message-ID: <20150414212255.GA1374@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here is the i2c pull request for 4.1. Most notable:

* introducing the i2c_quirk infrastructure. Now, flaws of I2C
  controllers can be described and the core will check if the
  flaws collide with the messages to be sent

* wait_for_completion return type cleanup series

* new drivers for Digicolor, Netlogic XLP, Ingenic JZ4780

* updates to the I2C slave framework which include API changes. Its
  only user was updated, too. Documentation was finally added

* changed dynamic bus numbering for the DT case. This could change bus
  numbers for users. However, it fixes a collision where dynamic and
  static busses request the same id.

* driver bugfixes, cleanups

Please pull.

Thanks,

   Wolfram


The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:

  Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to 2bbd681ba2bfa0f3805fb541b0840b96893c5727:

  i2c: xlp9xx: Driver for Netlogic XLP9XX/5XX I2C controller (2015-04-10 18=
:59:49 +0200)

----------------------------------------------------------------
Alexey Brodkin (1):
      i2c: designware: Suppress error message if platform_get_irq() < 0

Amit Tomar (1):
      i2c: mpc: Fix ISR return value

Baruch Siach (1):
      i2c: add support for the Digicolor I2C controller

Grygorii Strashko (3):
      i2c: change input parameter to i2c_adapter for prepare/unprepare_reco=
very
      i2c: davinci: use bus recovery infrastructure
      i2c: davinci: use ICPFUNC to toggle I2C as gpio for bus recovery

Ioan Nicu (1):
      i2c: i2c-mux-gpio: remove error messages for probe deferrals

Jarkko Nikula (5):
      i2c: i801: Don't break user-visible strings
      i2c: i801: Remove i801_driver forward declaration
      i2c: i801: Use managed devm_* memory and irq allocation
      i2c: i801: Remove pci_enable_device() call from i801_resume()
      i2c: i801: Use managed pcim_* PCI device initialization and reservati=
on

Neelesh Gupta (1):
      i2c: opal: Update quirk flags to do write-then-anything

Nicholas Mc Guire (15):
      i2c: mxs: match wait_for_completion_timeout return type
      i2c: tegra: match return type of wait_for_completion_timeout
      i2c: wmt: use msecs_to_jiffies for time conversions
      i2c: cadence: fixup wait_for_completion_timeout return handling
      i2c: designware: fixup return handling of wait_for_completion_timeout
      i2c: i2c-bcm2835: match return type of wait_for_completion_timeout
      i2c: wmt: match return type of wait_for_completion_timeout
      i2c: ismt: fix type of return var of wait_for_completion_timeout
      i2c: imx: match return type of wait_for_completion_timeout
      i2c: nomadik: match return type of wait_for_completion_timeout
      i2c: nomadik: match status to return type of read_i2c
      i2c: axxia: fixup return type of wait_for_completion_timeout
      i2c: at91: fixup return type of wait_for_completion_timeout
      i2c: img-scb: fixup of wait_for_completion_timeout return handling
      i2c: davinci: fixup wait_for_completion_timeout handling

Octavian Purdila (1):
      i2c: dln2: set the device tree node of the adapter

Subhendu Sekhar Behera (2):
      of: Add vendor prefix 'netlogic'
      i2c: xlp9xx: Driver for Netlogic XLP9XX/5XX I2C controller

Uwe Kleine-K=C3=B6nig (1):
      i2c: pca954x: improve usage of gpiod API

Valentin Longchamp (1):
      i2c: mpc: assign the correct prescaler from SVR

Wolfram Sang (19):
      i2c: add quirk structure to describe adapter flaws
      i2c: add quirk checks to core
      i2c: at91: make use of the new infrastructure for quirks
      i2c: opal: make use of the new infrastructure for quirks
      i2c: qup: make use of the new infrastructure for quirks
      i2c: cpm: make use of the new infrastructure for quirks
      i2c: axxia: make use of the new infrastructure for quirks
      i2c: dln2: make use of the new infrastructure for quirks
      i2c: powermac: make use of the new infrastructure for quirks
      i2c: viperboard: make use of the new infrastructure for quirks
      i2c: pmcmsp: make use of the new infrastructure for quirks
      i2c: bcm-iproc: make use of the new infrastructure for quirks
      Merge branch 'i2c/quirks' into i2c/for-4.1
      of: base: add function to get highest id of an alias stem
      i2c: busses with dynamic ids should start after fixed ids for DT
      i2c: slave: rework the slave API
      Documentation: i2c: describe the new slave mode
      i2c: slave: add documentation for i2c-slave-eeprom
      i2c: slave-eeprom: add more info when to increase the pointer

Zubair Lutfullah Kakakhel (1):
      i2c: jz4780: Add i2c bus controller driver for Ingenic JZ4780

 .../devicetree/bindings/i2c/i2c-davinci.txt        |   3 +
 .../devicetree/bindings/i2c/i2c-digicolor.txt      |  25 +
 .../devicetree/bindings/i2c/i2c-jz4780.txt         |  35 +
 .../devicetree/bindings/i2c/i2c-xlp9xx.txt         |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/i2c/slave-eeprom-backend             |  14 +
 Documentation/i2c/slave-interface                  | 179 +++++
 Documentation/i2c/summary                          |   4 -
 drivers/i2c/busses/Kconfig                         |  28 +
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-at91.c                      |  39 +-
 drivers/i2c/busses/i2c-axxia.c                     |  27 +-
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  15 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |   2 +-
 drivers/i2c/busses/i2c-cadence.c                   |   6 +-
 drivers/i2c/busses/i2c-cpm.c                       |  20 +-
 drivers/i2c/busses/i2c-davinci.c                   | 194 +++--
 drivers/i2c/busses/i2c-designware-core.c           |   3 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |   6 +-
 drivers/i2c/busses/i2c-digicolor.c                 | 385 ++++++++++
 drivers/i2c/busses/i2c-dln2.c                      |  13 +-
 drivers/i2c/busses/i2c-i801.c                      |  51 +-
 drivers/i2c/busses/i2c-img-scb.c                   |  14 +-
 drivers/i2c/busses/i2c-imx.c                       |  10 +-
 drivers/i2c/busses/i2c-ismt.c                      |   5 +-
 drivers/i2c/busses/i2c-jz4780.c                    | 832 +++++++++++++++++=
++++
 drivers/i2c/busses/i2c-mpc.c                       |  33 +-
 drivers/i2c/busses/i2c-mxs.c                       |   5 +-
 drivers/i2c/busses/i2c-nomadik.c                   |   6 +-
 drivers/i2c/busses/i2c-opal.c                      |  24 +-
 drivers/i2c/busses/i2c-pmcmsp.c                    |  42 +-
 drivers/i2c/busses/i2c-powermac.c                  |  10 +-
 drivers/i2c/busses/i2c-qup.c                       |  21 +-
 drivers/i2c/busses/i2c-rcar.c                      |  10 +-
 drivers/i2c/busses/i2c-tegra.c                     |  12 +-
 drivers/i2c/busses/i2c-viperboard.c                |  10 +-
 drivers/i2c/busses/i2c-wmt.c                       |  10 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    | 445 +++++++++++
 drivers/i2c/i2c-core.c                             |  73 +-
 drivers/i2c/i2c-slave-eeprom.c                     |  18 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  10 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   6 +-
 drivers/of/base.c                                  |  26 +
 include/linux/i2c.h                                |  55 +-
 include/linux/of.h                                 |   6 +
 include/linux/platform_data/i2c-davinci.h          |   1 +
 46 files changed, 2483 insertions(+), 276 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
 create mode 100644 Documentation/i2c/slave-eeprom-backend
 create mode 100644 Documentation/i2c/slave-interface
 create mode 100644 drivers/i2c/busses/i2c-digicolor.c
 create mode 100644 drivers/i2c/busses/i2c-jz4780.c
 create mode 100644 drivers/i2c/busses/i2c-xlp9xx.c

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLYUvAAoJEBQN5MwUoCm2ttwP/Rd99T5T5QnwNCLxODodzb/9
6jJAoHcga1YxA2jHRXW0f0+ujuOI40fg9vgaBTylHhQXm13EcQ2nfx24k2X/11NI
U3z/cJaKiagwpg0SGyxs2S2I0zYhRtRD7psiBAWbB09Q9XS+CwzbgKCTCSRTv7Qe
w85aSL1f6MvGrjHvdOG7gyMLb+X1ezihd8a/yDC0ZSzE6DFoTrEfzb5MntAsbNZA
l/woiZnQNmhhB7uHmNpDBKLzugf7yHpLlDwCruKnukktiScQRguU7JJqCKc92a58
mjHfikJAlTh2KR+RcZ5dJmpOAk4VeFj9PVhMZy3gh7goLP0jB9bz9JOHpuab1Sz3
W0YI6z5JUgccoaYnnmZ2QqWL+4sN9LWdi/ErL5Xa7CFdmDreuTo9P2U3uw59p0oF
5UCKmqdO/YQyMsDNV90h2He8P6+L32U57IeNSKj4ZtSKbFCnMmEBOcKCkm0wVMsh
COBuEEUmhfLPcPGEKXdMsIvPHLtDnkJmw5TBZSch3HkzIZxM99rPoAIRJrFDesdO
55bBWru87eRRxAX+5ZZ8L0dYII/OkZ+iwzL7Zw+BhnR3898nQz7b+iYaIK2e1nsg
8oc65Z8BULq8OVh/lfuqAQ9XnE/kBhlLTyR0gR/uRAxq6mmyZP0owtyoq3KndRz/
yIPSrrsnNr65Z/57q895
=yCh2
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
