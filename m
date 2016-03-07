From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v3 00/14] i2c-octeon and i2c-thunderx drivers
Date: Mon,  7 Mar 2016 16:10:43 +0100
Message-ID: <cover.1457362545.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35026 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbcCGPLP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 10:11:15 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

This series for the Octeon i2c driver is an attempt to upstream some
bug fixes and features that accumulated for some time.

On top of the Octeon changes a i2c driver for the ThunderX SOC is
added which uses the same functional block as the Octeon driver.

Patches #1-3 are cleanups.
Patches #4-11 are forward-ports of Octeon features and bugfixes.
Patch #12 prepares for the driver split
Patches #13-14 add the ThunderX driver.

Patches are on top of 4.5-rc7 and were tested on OCTEON, OCTEON-78
and ThunderX.

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

David Daney (5):
  i2c-octeon: Cleanup resource allocation code
  i2c-octeon: Support I2C_M_RECV_LEN
  i2c-octeon: Enable high-level controller and improve on bus contention
  i2c-octeon: Add support for cn78XX chips
  i2c-octeon: Add workaround for broken irqs on CN3860

Jan Glauber (6):
  i2c-octeon: Cleanup kerneldoc comments
  i2c-octeon: Cleanup i2c-octeon driver
  dt-bindings: i2c: Add Octeon cn78xx TWSI
  i2c-octeon: Split the driver into two parts
  i2c-thunderx: Add i2c driver for ThunderX SOC
  i2c-thunderx: Add smbus support

Peter Swain (3):
  i2c-octeon: Make adapter timeout tunable
  i2c-octeon: Flush TWSI writes with readback
  i2c-octeon: Faster operation when IFLG signals late

 .../devicetree/bindings/i2c/i2c-octeon.txt         |   6 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-cavium.c                    | 828 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cavium.h                    | 203 +++++
 drivers/i2c/busses/i2c-octeon-core.c               | 304 ++++++++
 drivers/i2c/busses/i2c-octeon.c                    | 633 ----------------
 drivers/i2c/busses/i2c-thunderx-core.c             | 301 ++++++++
 8 files changed, 1655 insertions(+), 633 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cavium.c
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 delete mode 100644 drivers/i2c/busses/i2c-octeon.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
