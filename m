From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 00/15] i2c-octeon and i2c-thunderx drivers
Date: Mon, 25 Apr 2016 16:33:29 +0200
Message-ID: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35695 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcDYOd5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Apr 2016 10:33:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Hi Wolfram,

v7 implements the changes from your review plus some comments from David.
I've moved the flush writeq patch before the HLC patch, because it is
already needed there and seems quite trivial and I've added a new patch
to disable the SMBUS QUICK support as discussed.

This series for the Octeon i2c driver is an attempt to upstream some
bug fixes and features that accumulated for some time.

On top of the Octeon changes a i2c driver for the ThunderX SOC is
added which uses the same functional block as the Octeon driver.

Patches are on top of next-20160422 and were tested on OCTEON, OCTEON-78
and ThunderX.

Changes to v6:
- Fixed read_int kerneldoc
- Removed udelay after write-int in recovery
- Killed retries in recovery, use EAGAIN
- Disable SMBUS QUICK and remove unneeded length check
- Spell out enable/disable
- Switch to wait_event_timeout
- Removed superfluous status check in HLC write
- Optimize wait-queue also for HLC
- Use readq/writeq instead of __raw_* in some places
- Add STAT_IDLE to status check (valid after a write)

Changes to v5:
- Switch to i2c recovery framework
- Clean-up register access, introduce new helper functions
- Fixed ready bit check in combined write
- Fixed IFLG clear in hlc_enable
- Removed complicated last phase logic, not needed when we send
  START for every message part

Changes to v4:
- Splitted the High-Level Controller patch into several patches
- Reworded some commit messages

Changes to v3:
- Added more functionality flags for SMBUS
- Removed both module parameters
- Make xfer return also other errors than EGAIN
- Return EPROTO on invalid SMBUS block length
- Use devm_ioremap_resource
- Added rename-only patch
- Removed kerneldoc patch from series
- Improved defines

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



David Daney (3):
  i2c: octeon: Enable High-Level Controller
  i2c: octeon: Add support for cn78xx chips
  i2c: octeon: Add workaround for broken irqs on CN3860

Jan Glauber (10):
  i2c: octeon: Improve error status checking
  i2c: octeon: Use i2c recovery framework
  i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
  dt-bindings: i2c: Add Octeon cn78xx TWSI
  i2c: octeon: Move read function before write
  i2c: octeon: Rename driver to prepare for split
  i2c: octeon: Split the driver into two parts
  i2c: thunderx: Add i2c driver for ThunderX SOC
  i2c: octeon,thunderx: Move register offsets to struct
  i2c: thunderx: Add smbus alert support

Peter Swain (2):
  i2c: octeon: Add flush writeq helper function
  i2c: octeon: Improve performance if interrupt is early

 .../devicetree/bindings/i2c/i2c-octeon.txt         |   6 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-cavium.c                    | 799 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cavium.h                    | 214 ++++++
 drivers/i2c/busses/i2c-octeon-core.c               | 288 ++++++++
 drivers/i2c/busses/i2c-octeon.c                    | 606 ----------------
 drivers/i2c/busses/i2c-thunderx-core.c             | 306 ++++++++
 8 files changed, 1626 insertions(+), 606 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cavium.c
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 delete mode 100644 drivers/i2c/busses/i2c-octeon.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
