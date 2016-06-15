From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v10 0/8] i2c-octeon and i2c-thunderx driver
Date: Wed, 15 Jun 2016 15:51:26 +0200
Message-ID: <cover.1465997603.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36289 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbcFONv5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Jun 2016 09:51:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>

Hi Wolfram,

I'm reposting the rebased ThunderX i2c driver series.
Patches are on-top of 4.7-rc3.

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
  i2c: cavium: Use booleon values for booleon variables
  i2c: octeon: thunderx: Add MAINTAINERS entry

 MAINTAINERS                                       |   25 +-
 drivers/i2c/busses/Kconfig                        |   10 +
 drivers/i2c/busses/Makefile                       |    3 +
 drivers/i2c/busses/{i2c-octeon.c => i2c-cavium.c} | 1039 ++++++---------------
 drivers/i2c/busses/i2c-cavium.h                   |  214 +++++
 drivers/i2c/busses/i2c-octeon-core.c              |  288 ++++++
 drivers/i2c/busses/i2c-thunderx-core.c            |  305 ++++++
 7 files changed, 1134 insertions(+), 750 deletions(-)
 rename drivers/i2c/busses/{i2c-octeon.c => i2c-cavium.c} (57%)
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
