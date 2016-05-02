From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v8 0/8] i2c-octeon and i2c-thunderx driver
Date: Mon,  2 May 2016 19:35:40 +0200
Message-ID: <1462210548-4648-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32782 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbcEBRgP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 May 2016 13:36:15 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Hi Wolfram,

this are the remaining patches that implement the ThunderX driver.
I like to send them now even if they might not make 4.7.
After the Octeon parts are merged the ThunderX driver code is
quite straight-forward, as should be the driver split.

Patch #5 - #7 are (final) cleanup patches.

Patches are on-top of next-20160502.

Thanks,
Jan

-------------------------------------------------

Changes to v7:
- Sort include files also in octeon-core.c
- Add cleanup bool patch (left-over from v7)
- Dropped read-write function shuffle patch

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

Jan Glauber (8):
  i2c: octeon: Rename driver to prepare for split
  i2c: octeon: Split the driver into two parts
  i2c: thunderx: Add i2c driver for ThunderX SOC
  i2c: thunderx: Add smbus alert support
  i2c: octeon,thunderx: Move register offsets to struct
  i2c: octeon: Sort include files alphabetically
  i2c: cavium: Use booleon values for booleon variables
  i2c: octeon: thunderx: Add MAINTAINERS entry

 MAINTAINERS                                       |   25 +-
 drivers/i2c/busses/Kconfig                        |   10 +
 drivers/i2c/busses/Makefile                       |    3 +
 drivers/i2c/busses/{i2c-octeon.c => i2c-cavium.c} | 1033 ++++++---------------
 drivers/i2c/busses/i2c-cavium.h                   |  214 +++++
 drivers/i2c/busses/i2c-octeon-core.c              |  288 ++++++
 drivers/i2c/busses/i2c-thunderx-core.c            |  306 ++++++
 7 files changed, 1132 insertions(+), 747 deletions(-)
 rename drivers/i2c/busses/{i2c-octeon.c => i2c-cavium.c} (57%)
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
