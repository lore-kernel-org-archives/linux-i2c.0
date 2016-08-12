From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/8] i2c: designware: Support fast mode plus and high speed
Date: Fri, 12 Aug 2016 17:02:46 +0300
Message-ID: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcHLODF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Aug 2016 10:03:05 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Patches here were posted before for v4.8 but got dropped due merge
conflicts with changes coming from ACPI subsystem.

http://www.spinics.net/lists/linux-i2c/msg24699.html
http://www.spinics.net/lists/linux-i2c/msg24857.html

I promised to resend both sets together since my set doesn't have much use
without Weifeng's set and my patches are done on top of it.

Patches 1-4/8 are same than before. Patch 5/8 had tiny conflict with the
ed1bf03470b8 ("i2c: designware-pci: Make bus number allocation robust")
because both added the DW_IC_CON_SPEED_MASK.

Patches 6-7/8 are a bit larger due conflicts with the
commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure
notifications"). No changes in patch 8/8.

Jarkko Nikula (3):
  i2c: core: Cleanup I2C ACPI namespace, take 2
  i2c: core: Add function for finding the bus speed from ACPI, take 2
  i2c: designware: Find bus speed from ACPI

Weifeng Voon (5):
  i2c: designware: Move clk_freq into struct dw_i2c_dev
  i2c: designware: get fast plus and high speed *CNT configuration
  i2c: designware: Enable fast mode plus
  i2c: designware: set the common config before the if else
  i2c: designware: Enable high speed mode

 drivers/i2c/busses/i2c-designware-core.c    |  33 ++++-
 drivers/i2c/busses/i2c-designware-core.h    |  11 ++
 drivers/i2c/busses/i2c-designware-platdrv.c |  43 +++++--
 drivers/i2c/i2c-core.c                      | 179 ++++++++++++++++++++--------
 include/linux/i2c.h                         |   9 ++
 5 files changed, 208 insertions(+), 67 deletions(-)

-- 
2.8.1
