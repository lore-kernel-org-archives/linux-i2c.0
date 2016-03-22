From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.6
Date: Tue, 22 Mar 2016 19:21:51 +0100
Message-ID: <20160322182040.GA24339@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40060 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbcCVSWR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 22 Mar 2016 14:22:17 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the pull request for I2C. Mostly usual driver updates and
improvements. The changelog should give an idea. Standing out is the
i2c-qup driver with lots of new capabilities and we also have now an
i2c-demuxer.

I'd especially like to welcome Peter Rosin as the i2c-mux maintainer. He
has an interesting series for muxes in the queue and agreed to look
after this part of the subsystem. Thank you, Peter, and welcome again!

The octeon changes were applied pretty recently before the merge window.
I am aware. They are the first (and relatively simple) patches of a
larger overhaul to this driver. In case something goes wrong with them,
they are easy to fix (or revert). The advantage I see is that they are
out of the way, and I can concentrate on the next block of patches. I
really would like to apply the overhaul in smaller batches to avoid
regressions. And waiting a cycle for the introductory patches seemed too
much of a delay for me.

Please pull.

Thanks,

   Wolfram


The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to 886f6f8337dd506e9ae0e45ee13eef3a0ceebd03:

  i2c: octeon: Support I2C_M_RECV_LEN (2016-03-18 15:50:42 +0100)

----------------------------------------------------------------
Andy Shevchenko (2):
      MAINTAINERS: Mika and me are designated reviewers for I2C DESIGNWARE
      i2c: i801: sort IDs alphabetically

Baruch Siach (1):
      i2c: designware: remove redundant lock

David Daney (1):
      i2c: octeon: Support I2C_M_RECV_LEN

Dmitriy Baranov (1):
      i2c: imx: remove extra spaces.

Geert Uytterhoeven (1):
      dt-bindings: i2c: Spelling s/propoerty/property/

Jan Glauber (3):
      i2c: octeon: Cleanup kerneldoc comments
      i2c: octeon: Cleanup i2c-octeon driver
      i2c: octeon: Cleanup resource allocation code

Jarkko Nikula (1):
      i2c: designware: Prevent runtime suspend during adapter registration

Jean Delvare (4):
      i2c: designware-platform: Drop duplicate module information
      i2c: piix4: Support alternative port selection register
      i2c: piix4: Always use the same type for port
      i2c: piix4: Pre-shift the port number

Liguo Zhang (1):
      i2c: mt65xx: add 4GB DMA mode support in i2c driver

Masahiro Yamada (1):
      i2c: uniphier: add COMPILE_TEST option

Peter Rosin (1):
      MAINTAINERS: add Peter Rosin as i2c mux maintainer

Ray Jui (3):
      i2c: iproc: Add recovery mechanism in error case
      i2c: iproc: Fix typo in the driver
      i2c: iproc: Support larger TX transfer

Shubhrajyoti Datta (2):
      i2c: xiic: Implement power management
      i2c: cadence: Fix the kernel-doc warnings

Simon Horman (1):
      i2c: riic, sh_mobile, rcar: Use ARCH_RENESAS

Sricharan R (5):
      i2c: qup: Change qup_wait_writeready function to use for all timeouts
      i2c: qup: Add V2 tags support
      i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
      i2c: qup: Add bam dma capabilities
      i2c: qup: Fix fifo handling after adding V2 support

Sudip Mukherjee (1):
      i2c: do not use internal data from driver core

Wolfram Sang (10):
      i2c: mux: demux-pinctrl: add driver
      i2c: i2c-boardinfo: sort includes
      i2c: i2c-core: sort includes
      i2c: i2c-dev: sort includes
      i2c: i2c-mux: sort includes
      i2c: i2c-smbus: sort includes
      i2c: i2c-stub: sort includes
      i2c: tegra: don't open code of_device_get_match_data()
      i2c: rcar: don't open code of_device_get_match_data()
      i2c: immediately mark ourselves as registered

 .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   |  23 +
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  | 135 +++
 Documentation/devicetree/bindings/i2c/i2c-imx.txt  |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-sirf.txt |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-xiic.txt |   3 +
 MAINTAINERS                                        |  14 +-
 drivers/i2c/busses/Kconfig                         |  10 +-
 drivers/i2c/busses/i2c-bcm-iproc.c                 | 177 ++--
 drivers/i2c/busses/i2c-cadence.c                   |  14 +-
 drivers/i2c/busses/i2c-designware-baytrail.c       |   5 -
 drivers/i2c/busses/i2c-designware-core.c           |  22 +-
 drivers/i2c/busses/i2c-designware-core.h           |   2 -
 drivers/i2c/busses/i2c-i801.c                      |   8 +-
 drivers/i2c/busses/i2c-imx.c                       |  12 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |  42 +
 drivers/i2c/busses/i2c-octeon.c                    | 307 +++----
 drivers/i2c/busses/i2c-piix4.c                     |  48 +-
 drivers/i2c/busses/i2c-qup.c                       | 977 ++++++++++++++++++++-
 drivers/i2c/busses/i2c-rcar.c                      |   2 +-
 drivers/i2c/busses/i2c-tegra.c                     |   4 +-
 drivers/i2c/busses/i2c-xiic.c                      |  88 +-
 drivers/i2c/i2c-boardinfo.c                        |   6 +-
 drivers/i2c/i2c-core.c                             |  39 +-
 drivers/i2c/i2c-dev.c                              |  14 +-
 drivers/i2c/i2c-mux.c                              |   8 +-
 drivers/i2c/i2c-smbus.c                            |   8 +-
 drivers/i2c/i2c-stub.c                             |   8 +-
 drivers/i2c/muxes/Kconfig                          |   9 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 272 ++++++
 31 files changed, 1893 insertions(+), 372 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8Yz3AAoJEBQN5MwUoCm2JsgQAJOu5B0/t/GdyB4Gs+GQ6fT7
QumafGBYLp9Sq03PkzC1h9Wu3wZfENCg0/iF9/z5aZn/q7ASYNDlkKaXnNJ4Z/YJ
Bwjm/FL5P7eZ0OEfxqM22YnuyJESx3HKCOMu46JrEFQks8v5g3Bgapo6azi/Kqls
DdiT79EeM1GqTlZwomPgJ7vNeLXyBDqFRpJjOAWvMuXeSdg3/S7bZdhvm04i6s8w
zOAG53BLOYzo3dyTwpI+PVg3YUa7g32V84KHX6fQ8ekSw6JhMYJjYJOQtYlTlp66
dG/VmpaHwIULddZiyV1RPVH8DBGL8ZUjMzYQR7pN7YkHb8TwWvUllSzotBSqEs8g
XNTAq+cTYZfK7RWF9cXZ52rhzjxTCwE4jzH7waC1ecIfqCbbVtXHeZZb/ziFkcPo
boNX+yjvMmB3u2/mhR1x+YBJC75NbmVagTOnWE2VJQxBwzxUl2Z5Yk76+B7RCAIX
oOJduQYzBEP4sdwnFBCBndB6reGfRZMEf8tFiFwoJ3Qvo1rQLO48mGoifYrR7/ED
uK5m2MCEm/VCm+jcEmg7AZQGoHjN/RoA9fX3HDYYB1599961snTeMgFcYZ0vJVnP
Pwwb7A0AJKbD79g5IYXstbQ8BikduhNpEA5YSFaBEucCoFYy1vt4cPQ3igGybX+h
bvFqb2Pbga8Oak2iS7BF
=69+D
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
