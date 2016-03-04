From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 00/10] i2c-octeon and i2c-thunderx drivers
Date: Fri,  4 Mar 2016 18:57:42 +0100
Message-ID: <cover.1457111728.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33309 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235AbcCDR6D (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Mar 2016 12:58:03 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

This series for the Octeon i2c driver is an attempt to upstream some
bug fixes and features that accumulated for some time. I tried to
split the cleanup from the other patches and updated the patch
descriptions according to my humble i2c knowledge.
  
Patches are on top of 4.5-rc6 and were tested on OCTEON, OCTEON-78
and ThunderX.

Changes to v1:
- Fixed compile error on x86_64
- Disabled thunderx driver on MIPS
- Re-ordered some thunderx probe functions for readability
- Fix missing of_irq.h and i2c-smbus.h includes
- Use IS_ENABLED for CONFIG options

Comments welcome.

Thanks,
Jan

------------------------------------------------------------------

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
 drivers/i2c/busses/i2c-thunderx-core.c             | 301 ++++++++
 8 files changed, 1641 insertions(+), 633 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cavium.c
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 delete mode 100644 drivers/i2c/busses/i2c-octeon.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
