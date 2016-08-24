From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 0/8] i2c-octeon and i2c-thunderx driver
Date: Wed, 24 Aug 2016 23:25:41 +0200
Message-ID: <20160824212549.16140-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34320 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755637AbcHXV0I (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 24 Aug 2016 17:26:08 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Hi Wolfram,

this update should address all comments. The probe funtion
is much easier to read now after using the managed device functions.

We also had an issue with the 5ms timeout and some ipmi/ssif commands so
I dropped the timeout setting to get the 1s default.

Changes to v10:
- Proper use of managed device functions
- Renamed files
- Removed i2c class setting
- Droped timeout setting
- Improved Kconfig dependency
- Removed most probing kernel messages
- select SMBUS instead of if-defing
- Removed bogus i2c pointer check 
- Explicitely mention GPL version
- Drop whitespace fixes from MAINTAINERS patch

Changes to v9:
- rebased on top of upstreamed octeon i2c fixes
- reduced default sclk to 700Mhz

Changes to v8:
- Use device property for clock-frequency setting in thunderx,
  get rid of of_find_node_by_name
- Simplify adap.name by using device name
- SMBUS ACPI handling
- Re-phrase SMBUS error/not-specified message

Thanks,
Jan

-------------------------------------------------

Jan Glauber (8):
  i2c: octeon: Rename driver to prepare for split
  i2c: octeon: Split the driver into two parts
  i2c: thunderx: Add i2c driver for ThunderX SOC
  i2c: thunderx: Add SMBUS alert support
  i2c: octeon,thunderx: Move register offsets to struct
  i2c: octeon: Sort include files alphabetically
  i2c: octeon: Use booleon values for booleon variables
  i2c: octeon: thunderx: Add MAINTAINERS entry

 MAINTAINERS                                        |    8 +
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    3 +
 .../i2c/busses/{i2c-octeon.c => i2c-octeon-core.c} | 1039 ++++++--------------
 drivers/i2c/busses/i2c-octeon-core.h               |  211 ++++
 drivers/i2c/busses/i2c-octeon-platdrv.c            |  288 ++++++
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |  259 +++++
 7 files changed, 1077 insertions(+), 742 deletions(-)
 rename drivers/i2c/busses/{i2c-octeon.c => i2c-octeon-core.c} (57%)
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-platdrv.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-pcidrv.c

-- 
2.9.0.rc0.21.g7777322
