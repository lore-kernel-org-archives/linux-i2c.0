From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.8
Date: Wed, 27 Jul 2016 23:05:17 +0200
Message-ID: <20160727210514.GA1981@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45022 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758565AbcG0VF0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jul 2016 17:05:26 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the I2C pull request for 4.8:

* the core and i801 driver gained support for SMBus Host Notify
* core support for more than one address in DT
* i2c_add_adapter() has now better error messages. We can remove all
  error messages from drivers calling it as a next step.
* bigger updates to rk3x driver to support rk3399 SoC
* the at24 eeprom driver got refactored and can now read special variants with
  unique serials or fixed MAC addresses.

The rest is regular driver updates and bugfixes. Please pull.

Thanks,

   Wolfram


The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.8

for you to fetch changes up to 175c7080f2747b96e4b5352e4c38ddf9a0eacfdb:

  i2c: i801: use IS_ENABLED() instead of checking for built-in or module (2016-07-26 08:44:56 +0200)

----------------------------------------------------------------
Abhishek Sahu (2):
      i2c: qup: Cleared the error bits in ISR
      i2c: qup: Fixed the DMA segments length

Alexey Khoroshilov (1):
      i2c: efm32: fix a failure path in efm32_i2c_probe()

Andy Shevchenko (4):
      i2c: designware-pci: Make bus number allocation robust
      i2c: designware-pci: Introduce Merrifield support
      i2c: designware-pci: Sort header block alphabetically
      i2c: designware-pci: clarify a comment for Merrifield

Axel Lin (3):
      i2c: robotfuzz-osif: Constify osif_table
      i2c: versatile: Allow compile test build
      i2c: versatile: Convert to use resource managed devm_* APIs

Bartosz Golaszewski (11):
      eeprom: at24: improve the device_id table readability
      eeprom: at24: move at24_read() below at24_eeprom_write()
      eeprom: at24: coding style fixes
      eeprom: at24: call read/write functions via function pointers
      eeprom: at24: hide the read/write loop behind a macro
      eeprom: at24: split at24_eeprom_read() into specialized functions
      eeprom: at24: split at24_eeprom_write() into specialized functions
      eeprom: at24: platform_data: use BIT() macro
      eeprom: at24: support reading the serial number for 24csxx
      eeprom: at24: add support for at24mac series
      eeprom: at24: tweak the loop_until_timeout() macro

Ben Dooks (1):
      i2c: meson: allow build with COMPILE_TEST

Benjamin Tissoires (3):
      i2c: add a protocol parameter to the alert callback
      i2c: smbus: add SMBus Host Notify support
      i2c: i801: add support of Host Notify

David Wu (8):
      i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
      i2c: rk3x: use struct "rk3x_i2c_calced_timings"
      i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
      i2c: rk3x: Change SoC data to not use array
      i2c: rk3x: Move spec timing data to "static const" structs
      dt-bindings: i2c: rk3x: add support for rk3399
      i2c: rk3x: add i2c support for rk3399 soc
      i2c: rk3x: support fast-mode plus for rk3399

Ellen Wang (1):
      i2c: i801: recover from hardware PEC errors

Eric Anholt (1):
      i2c: bcm2835: Don't complain on -EPROBE_DEFER from getting our clock

Jaedon Shin (2):
      i2c: brcmstb: Make the driver buildable on BMIPS_GENERIC
      i2c: brcmstb: Remove superfluous size check

Jarkko Nikula (3):
      i2c: designware: Allow build Baytrail semaphore support when IOSF_MBI=m
      i2c: core: Cleanup I2C ACPI namespace
      i2c: core: Add function for finding the bus speed from ACPI

Javier Martinez Canillas (1):
      i2c: i801: use IS_ENABLED() instead of checking for built-in or module

Jean Delvare (4):
      i2c: i801: Drop needless bit-wise OR
      i2c: i2c-smbus: fix i2c_handle_smbus_host_notify documentation
      i2c: Update the description of I2C_SMBUS
      i2c: i2c-smbus: drop useless stubs

Jean-Michel Hautbois (1):
      i2c: Add generic support passing secondary devices addresses

Naveen Kaje (1):
      i2c: qup: use address helper function in read transfer

Sricharan R (2):
      i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled
      i2c: qup: Fix error handling

Tanmay Jagdale (1):
      i2c: xlp9xx: add ACPI support for Broadcom Vulcan

Weifeng Voon (1):
      i2c: designware: Use transfer timeout from ioctl I2C_TIMEOUT

William Breathitt Gray (2):
      i2c: elektor: Utilize the module_isa_driver macro
      i2c: pca-isa: Utilize the module_isa_driver macro

Wolfram Sang (12):
      i2c: jz4780: drop superfluous init
      i2c: free idr when sanity checks in i2c_register_adapter() fail
      i2c: cleanup i2c_register_adapter() by refactoring recovery init
      i2c: improve error messages in i2c_register_adapter()
      i2c: add error message when obtaining idr fails
      i2c: print more info when of_i2c_notify fails
      i2c: print more info when acpi_i2c_space_handler() fails
      i2c: use pr_fmt in the core
      Revert "i2c: core: Add function for finding the bus speed from ACPI"
      Revert "i2c: core: Cleanup I2C ACPI namespace"
      Documentation: i2c: slave: describe buffer problems a bit better
      Documentation: i2c: slave: give proper example for pm usage

viresh kumar (1):
      i2c-dev: don't get i2c adapter via i2c_dev

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-
 Documentation/devicetree/bindings/i2c/i2c.txt      |   7 +
 Documentation/i2c/slave-interface                  |  19 +-
 Documentation/i2c/smbus-protocol                   |   6 +
 drivers/char/ipmi/ipmi_ssif.c                      |   6 +-
 drivers/hwmon/lm90.c                               |   6 +-
 drivers/i2c/Kconfig                                |   4 +-
 drivers/i2c/busses/Kconfig                         |  11 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |   3 +-
 drivers/i2c/busses/i2c-brcmstb.c                   |   3 +-
 drivers/i2c/busses/i2c-designware-core.c           |   2 +-
 drivers/i2c/busses/i2c-designware-core.h           |   1 +
 drivers/i2c/busses/i2c-designware-pcidrv.c         | 143 +++---
 drivers/i2c/busses/i2c-efm32.c                     |   2 +-
 drivers/i2c/busses/i2c-elektor.c                   |  14 +-
 drivers/i2c/busses/i2c-i801.c                      | 152 ++++++-
 drivers/i2c/busses/i2c-jz4780.c                    |   4 -
 drivers/i2c/busses/i2c-pca-isa.c                   |  15 +-
 drivers/i2c/busses/i2c-qup.c                       | 155 +++----
 drivers/i2c/busses/i2c-rk3x.c                      | 498 +++++++++++++++++----
 drivers/i2c/busses/i2c-robotfuzz-osif.c            |   2 +-
 drivers/i2c/busses/i2c-versatile.c                 |  46 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |  13 +-
 drivers/i2c/i2c-core.c                             | 165 ++++---
 drivers/i2c/i2c-dev.c                              |   7 +-
 drivers/i2c/i2c-smbus.c                            | 112 ++++-
 drivers/misc/eeprom/at24.c                         | 498 ++++++++++++++-------
 include/linux/i2c-smbus.h                          |  29 ++
 include/linux/i2c.h                                |  15 +-
 include/linux/platform_data/at24.h                 |  11 +-
 include/uapi/linux/i2c.h                           |   1 +
 31 files changed, 1416 insertions(+), 550 deletions(-)

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXmSIKAAoJEBQN5MwUoCm29ScP/3KfcJP9T/RL1xoTnBx7foso
P/OIXXN196wScIOyidHKor1gK+0FeeBn4mCHeOMpAPJ4u9sFoXSajSDsWvR6cYvS
cgAQM4v2vkYoj+a/TyTTH6CZlbhbCIaVl2Ng/ah6I3Jlrh6QXEf235RqgHp9Hfkw
SOTPtVUaKdojinbkgy5H2EYkeMw6c0TYk1TXMKpp+TpKns4JihFtVyaGNXhTSn1b
eHD7XfNvW6MOqEEs6yPNQfn1Afl/2l+fyjFhv+YRWpN0Z07b7HDIYvdhe4nO2iVo
M8p4CDsuStc5dmDnKf4zjXAG0uMcLYd2SVJHgOw9DG3nQMWK1vtxgHux16HK1gVM
Xh1Mx5srLfiw6QcdLxXDG4wftKpPFzOuLeBIUpR4TZ2CU9uauuQgu3yhnkEJv1zD
8W5NONZaE0SBX7899xQaMPiEV1Nd9cCUI55iZfGGPTTV5vHBq5wKJkkATJeGIjO7
5U93KlbqoobiPsQ639X1m/+3Zzp5BdEndaSFq33lNI9r8VXYmn+99lHG1rKCjbhH
FAS7nZJtMnS0+n6BgdQ2uv8RXZmLzrRuKgZ4d2Up9bm9aHY+0XJ0IzmRzfZfjHbn
r36kfjIk1VMS3Vgry3jYju7+5JGXOTGGJ35+1IQkQjjV2BOiB6UyAnxTEfZf7yjL
fpB3f3eRVMPZWwvFTwYh
=zyow
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
