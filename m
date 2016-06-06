From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/3] i2c: core/designware: Find bus speed from ACPI
Date: Mon,  6 Jun 2016 14:26:20 +0300
Message-ID: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45884 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbcFFL0d (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 6 Jun 2016 07:26:33 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

These patches add support to i2c-core for finding the bus speed from
ACPI by looking at slowest connection from ACPI I2cSerialBus resources
that are associated to I2C controller and use it in i2c-designware.

i2c-core patches apply on top of v4.7-rc1 and i2c-designware change is
on top of Weifeng's fast mode + and high speed set:

http://www.spinics.net/lists/linux-i2c/msg24699.html

Jarkko Nikula (3):
  i2c: core: Cleanup I2C ACPI namespace
  i2c: core: Add function for finding the bus speed from ACPI
  i2c: designware: Find bus speed from ACPI

 drivers/i2c/busses/i2c-designware-platdrv.c |   6 +-
 drivers/i2c/i2c-core.c                      | 116 +++++++++++++++++++---------
 include/linux/i2c.h                         |   9 +++
 3 files changed, 94 insertions(+), 37 deletions(-)

-- 
2.8.1
