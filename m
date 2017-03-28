From: Tan Chin Yew <chin.yew.tan@intel.com>
Subject: [PATCH V3] Set sda-hold-time based on ACPI *CNT value
Date: Tue, 28 Mar 2017 16:48:01 +0800
Message-ID: <1490690882-11623-1-git-send-email-chin.yew.tan@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54583 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754563AbdC1Isk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Mar 2017 04:48:40 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

For I2c to operate correctly under all speed mode, sda-hold-time need to
be perfectly tuned. However, sda-hold-time is precalculated according to
circuit parameter which make it platform-specific.

In order to get accurate sda-hold-time for all platforms, pretuned
sda-hold-time for particular platform is stored in ACPI table and driver
to load the sda holding time from ACPI table.

This patch read the I2c sda-hold-time from ACPI table and assigned the
suitable hold time based on the i2c clock frequency.

Tested on Intel Apollo Lake.

Changes in V3:
	- Remove null handling in function dw_i2c_acpi_params.
	- Add descriptions to commit message.

Changes in V2:
	- The code is realigned according to suggestion.
	- "case 400000:" is added on top of "default:" for readability.

Tan Chin Yew (1):
  i2c: designware: Get selected speed mode sda-hold-time via ACPI

 drivers/i2c/busses/i2c-designware-platdrv.c | 31 ++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
1.9.1
