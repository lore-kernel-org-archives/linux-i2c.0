From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.5
Date: Thu, 14 Jan 2016 20:18:33 +0100
Message-ID: <20160114191829.GA1990@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45530 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbcANTSl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jan 2016 14:18:41 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here is the pull request for the 4.5 merge window. Quite some driver
updates:

* piix4 can now handle multiplexed adapters
* brcmstb, xlr, eg20t, designware drivers support more SoCs
* emev2 gained i2c slave support
* img-scb and rcar got bigger refactoring to remove issues
* lots of common driver updates

i2c core changes:

* new quirk flag when an adapter does not support clock stretching, so
  clients can be configured to avoid that if possible
* added a helper function to retrieve timing parameters from firmware
  (with rcar being the first user)
* "multi-master" DT binding added so drivers can adapt to this setting
  (like disabling PM to keep arbitration working)
* RuntimePM for the logical adapter device is now always enabled by the
  core to ensure propagation from childs to the parent (the HW device)
* new macro builtin_i2c_driver to reduce boilerplate

Please pull.

Thanks,

   Wolfram


The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.5

for you to fetch changes up to c698d639f72b55686ec3518d2bc8dc5f2eca9354:

  i2c: create builtin_i2c_driver to avoid registration boilerplate (2016-01=
-13 11:06:03 +0100)

----------------------------------------------------------------
Akshay Bhat (1):
      DT: i2c: trivial-devices: Add Epson RX8010 and MPL3115

Baruch Siach (1):
      i2c: designware: retry transfer on transient failure

Christian Fetzer (3):
      i2c: piix4: Convert piix4_main_adapter to array
      i2c: piix4: Add support for multiplexed main adapter in SB800
      i2c: piix4: Add adapter port name support for SB800 chipset

Fabio Estevam (2):
      i2c: imx: Improve message log when DMA is not used
      i2c: imx: Remove unneeded comments

Gao Pan (4):
      i2c: imx: init bus recovery info before adding i2c adapter
      i2c: imx: add runtime pm support to improve the performance
      i2c: imx: improve code readability
      i2c: imx: fix i2c resource leak with dma transfer

Geliang Tang (2):
      i2c: designware: use to_pci_dev()
      i2c: st: use to_platform_device()

Kamal Dasu (1):
      i2c: brcmstb: Adding support for CM and DSL SoCs

LABBE Corentin (1):
      i2c: taos-evm: replace simple_strtoul by kstrtou8

Lars-Peter Clausen (1):
      i2c: xiic: Replace spinlock with mutex

Liguo Zhang (2):
      i2c: mediatek: add i2c first write then read optimization
      i2c: mediatek: fix i2c multi transfer issue in high speed mode

Ludovic Desroches (1):
      i2c: at91: add support for the HOLD field

Masahiro Yamada (4):
      i2c: uniphier: error out if clock rate is zero
      i2c: uniphier: error out if bus speed is zero
      i2c: uniphier_f: error out if clock rate is zero
      i2c: uniphier_f: error out if bus speed is zero

M=C3=A5ns Rullg=C3=A5rd (3):
      i2c: xlr: add support for Sigma Designs controller variant
      i2c: xlr: fix extra read/write at end of rx transfer
      i2c: xlr: add interrupt support for Sigma Designs chips

Nicola Corna (4):
      i2c: add i2c quirk flag for unsupported clock stretching
      i2c: algo-bit: add I2C_AQ_NO_CLK_STRETCH
      i2c: bcm2835: add I2C_AQ_NO_CLK_STRETCH
      i2c: add i2c_check_quirks helper function

Niklas S=C3=B6derlund (1):
      i2c: emev2: add slave support

Paul Burton (2):
      i2c: eg20t: set i2c_adapter->dev.of_node
      i2c: eg20t: allow build on MIPS platforms

Paul Gortmaker (1):
      i2c: create builtin_i2c_driver to avoid registration boilerplate

Shubhrajyoti Datta (2):
      i2c: cadence: Move to sensible power management
      i2c: cadence: Remove the suspended flag

Sifan Naeem (5):
      i2c: img-scb: support I2C_M_IGNORE_NAK
      i2c: img-scb: remove fifo EMPTYING interrupts handle
      i2c: img-scb: add handle for stop detected interrupt
      i2c: img-scb: add handle for Master halt interrupt
      i2c: img-scb: support repeated starts on IP v3.3

Stephen Rothwell (1):
      i2c: ibm_iic: rename i2c_timings struct due to clash with generic ver=
sion

Suravee Suthikulpanit (2):
      i2c: designware: Add support for AMD Seattle I2C
      i2c: designware: Do not require clock when SSCN and FFCN are provided

Wolfram Sang (26):
      i2c: rcar: make sure clocks are on when doing clock calculation
      i2c: rcar: rework hw init
      i2c: rcar: remove unused IOERROR state
      i2c: rcar: remove spinlock
      i2c: rcar: refactor setup of a msg
      i2c: rcar: init new messages in irq
      i2c: rcar: don't issue stop when HW does it automatically
      i2c: rcar: check master irqs before slave irqs
      i2c: rcar: revoke START request early
      i2c: rcar: clean up after refactoring
      i2c: rcar: handle difference in setting up non-first message
      i2c: piix4: remove unneeded assignments
      i2c: document generic DT bindings for timing parameters
      i2c: add generic routine to parse DT for timing information
      i2c: rcar: refactor probe function a little
      i2c: rcar: switch to i2c generic dt parsing
      i2c: rcar: honor additional i2c timings from DT
      i2c: emev: select I2C slave support
      i2c: make i2c_parse_fw_timings() always visible
      i2c: document binding for multi-master case
      i2c: rcar: remove macros dealing with flags
      i2c: rcar: disable PM in multi-master mode
      i2c: always enable RuntimePM for the adapter device
      i2c: s3c2410: remove superfluous runtime PM calls
      dt-bindings: move I2C eeprom descriptions to the proper file
      dt-bindings: i2c: eeprom: add another EEPROM device

 .../devicetree/bindings/eeprom/eeprom.txt          |  21 +-
 Documentation/devicetree/bindings/i2c/i2c-at91.txt |   5 +-
 .../devicetree/bindings/i2c/i2c-brcmstb.txt        |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   4 +
 Documentation/devicetree/bindings/i2c/i2c.txt      |  36 ++-
 .../devicetree/bindings/i2c/trivial-devices.txt    |  15 +-
 drivers/i2c/algos/i2c-algo-bit.c                   |   6 +
 drivers/i2c/busses/Kconfig                         |   9 +-
 drivers/i2c/busses/i2c-at91.c                      |  53 +++-
 drivers/i2c/busses/i2c-bcm2835.c                   |  10 +
 drivers/i2c/busses/i2c-brcmstb.c                   |  80 ++++--
 drivers/i2c/busses/i2c-cadence.c                   |  73 +++--
 drivers/i2c/busses/i2c-designware-core.c           |  23 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   4 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  32 ++-
 drivers/i2c/busses/i2c-eg20t.c                     |   1 +
 drivers/i2c/busses/i2c-emev2.c                     | 112 +++++++-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   4 +-
 drivers/i2c/busses/i2c-img-scb.c                   |  92 ++++--
 drivers/i2c/busses/i2c-imx.c                       | 113 ++++++--
 drivers/i2c/busses/i2c-mt65xx.c                    |  54 +++-
 drivers/i2c/busses/i2c-piix4.c                     | 202 +++++++++++--
 drivers/i2c/busses/i2c-rcar.c                      | 319 ++++++++++-------=
----
 drivers/i2c/busses/i2c-s3c2410.c                   |   6 -
 drivers/i2c/busses/i2c-st.c                        |   3 +-
 drivers/i2c/busses/i2c-taos-evm.c                  |   8 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |  11 +-
 drivers/i2c/busses/i2c-uniphier.c                  |  11 +-
 drivers/i2c/busses/i2c-xiic.c                      |  12 +-
 drivers/i2c/busses/i2c-xlr.c                       | 250 ++++++++++++++--
 drivers/i2c/i2c-core.c                             |  56 ++++
 include/linux/i2c.h                                |  47 ++-
 32 files changed, 1254 insertions(+), 420 deletions(-)

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWl/SFAAoJEBQN5MwUoCm2ZjMP/izb16b+tnTDNlUnm9/6qX5C
HM/mAzYR6jx+XCnzGPiHBTEO24ThxnQaqmnjDvpKHYp64Pjfj9Eo/QfOYY2JUYFO
Gycr3vhW0A83dy7d+fRrjfdw8ijIAElBCm91alfG5xJiP2EzEwo9uLM07K3t8apQ
iGkRSBJ2J507j5dDRYnxTop0ZTp/kVZFRfqzW6e+o/JgZRf5OrWZS2JeXRtyYzZr
8vIq3UOejLRA8ZE0nMb0IbTJKTw5+fWxH+3L+iF2yF/B+ZMrNm/Imdx+YSOPyfgr
DAX/E5kP3WqDmtZzdoSd+VFdk4IuhrYMbeIQ6ndPgjsQLhmWde0lxO3Mih2Zc4ak
p+1mW6SI3+XtcTn2ekC50I0jdcOdWXObOsED44jTjd712zrQGbaFLegAXnAkSeF+
zHcxrfFYPC+QoG2WYA/kunIaq52FCEQWKq0XxqYzLU9/w+LiSFXGgwcq648dgdRJ
Paku5YSkEbo0oeTTTNf3W6+Ac+c2HXFIYXH9OGtlipzxUiCAA6FsVM4yGUPUYo2b
M1wexugRPy11QapTdVblvPLN4RM819zpBMZR0B4GDsKJAFpU746uLWVBNJin6jMy
WdKj49+c+TbuktqJWb6poOIoPnqqj5VIXtClYGB7258342WorsbyKTu4fOQnRmWi
9p3oxWf5V2yJCOF0pIGe
=48MC
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
