From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v4 00/14] i2c-octeon and i2c-thunderx drivers
Date: Fri, 18 Mar 2016 09:46:25 +0100
Message-ID: <cover.1458289385.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35672 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbcCRIqv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Mar 2016 04:46:51 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

This series for the Octeon i2c driver is an attempt to upstream some
bug fixes and features that accumulated for some time.

On top of the Octeon changes a i2c driver for the ThunderX SOC is
added which uses the same functional block as the Octeon driver.

Patches #1-2 are cleanups.
Patches #3-10 are forward-ports of Octeon features and bugfixes.
Patch #11-12 prepare for the driver split
Patches #13-14 add the ThunderX driver.

Patches are on top of 4.5 + i2c-octeon-kerneldoc-patch and were
tested on OCTEON, OCTEON-78 and ThunderX.

Changes to v3:
- added more functionality flags for SMBUS
- removed both module parameters
- make xfer return also other errors than EGAIN
- return EPROTO on invalid SMBUS block length
- use devm_ioremap_resource
- added rename-only patch
- removed kerneldoc patch from series
- improved defines

Changes to v2:
- Split clenaup patch into several patches
- Strictly moved functional changes to later patches
- Fixed do-while checkpatch errors
- Moved defines to the patches that use them
- Use BIT_ULL macro
- Split ThunderX patch into 2 patches

Changes to v1:
- Fixed compile error on x86_64
- Disabled thunderx driver on MIPS
- Re-ordered some thunderx probe functions for readability
- Fix missing of_irq.h and i2c-smbus.h includes
- Use IS_ENABLED for CONFIG options

Jan

-------------------------------------------------


David Daney (4):
  i2c-octeon: Support I2C_M_RECV_LEN
  i2c-octeon: Enable high-level controller and improve on bus contention
  i2c-octeon: Add support for cn78xx chips
  i2c-octeon: Add workaround for broken irqs on CN3860

Jan Glauber (8):
  i2c-octeon: Cleanup i2c-octeon driver
  i2c-octeon: Cleanup resource allocation code
  i2c-octeon: Change adapter timeout and retry default values
  dt-bindings: i2c: Add Octeon cn78xx TWSI
  i2c-octeon: Rename driver to prepare for split
  i2c-octeon: Split the driver into two parts
  i2c-thunderx: Add i2c driver for ThunderX SOC
  i2c-thunderx: Add smbus alert support

Peter Swain (2):
  i2c-octeon: Flush TWSI writes with readback
  i2c-octeon: Faster operation when IFLG signals late

 .../devicetree/bindings/i2c/i2c-octeon.txt         |   6 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-cavium.c                    | 822 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cavium.h                    | 212 ++++++
 drivers/i2c/busses/i2c-octeon-core.c               | 283 +++++++
 drivers/i2c/busses/i2c-octeon.c                    | 622 ----------------
 drivers/i2c/busses/i2c-thunderx-core.c             | 303 ++++++++
 8 files changed, 1639 insertions(+), 622 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cavium.c
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 delete mode 100644 drivers/i2c/busses/i2c-octeon.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
