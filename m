From: Jan Glauber <jglauber@cavium.com>
Subject: [Resend PATCH 00/10] i2c-octeon and i2c-thunderx drivers
Date: Mon, 29 Feb 2016 14:46:07 +0100
Message-ID: <cover.1456752497.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ddaney@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

I'm resending both patch series as one since the thunderx driver
depends on the octeon driver patches. Also (subtly) dropping the RFC
in the hope of getting the patches reviewed.

This series for the Octeon i2c driver is an attempt to upstream some
bug fixes and features that accumulated for some time. I tried to
split the cleanup from the other patches and updated the patch
descriptions according to my humble i2c knowledge.

Patches are on top of 4.5-rc6 and were tested on OCTEON, OCTEON-78
and ThunderX.

Jan

----------------------------------------------------------------------

David Daney (4):
  i2c-octeon: Support I2C_M_RECV_LEN
  i2c-octeon: Enable high-level controller and improve on bus contention
  i2c-octeon: Add support for cn78XX chips
  i2c-octeon: Add workaround for chips with broken irqs

Jan Glauber (4):
  i2c-octeon: Cleanup i2c-octeon driver
  dt-bindings: i2c: add Octeon cn78xx TWSI
  i2c: split i2c-octeon driver and add ThunderX support
  i2c: thunderx: add smbus support

Peter Swain (2):
  i2c-octeon: Flush TWSI writes with readback
  i2c-octeon: Faster operation when IFLG signals late

 .../devicetree/bindings/i2c/i2c-octeon.txt         |   6 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-cavium.c                    | 828 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cavium.h                    | 191 +++++
 drivers/i2c/busses/i2c-octeon-core.c               | 302 ++++++++
 drivers/i2c/busses/i2c-octeon.c                    | 633 ----------------
 drivers/i2c/busses/i2c-thunderx-core.c             | 294 ++++++++
 8 files changed, 1634 insertions(+), 633 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cavium.c
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 delete mode 100644 drivers/i2c/busses/i2c-octeon.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
