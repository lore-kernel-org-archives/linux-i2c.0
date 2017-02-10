From: chin.yew.tan@intel.com
Subject: [PATCH] Set sda-hold-time based on ACPI *CNT value
Date: Fri, 10 Feb 2017 19:15:35 +0800
Message-ID: <1486725336-19405-1-git-send-email-chin.yew.tan@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41244 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752468AbdBJLQf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Feb 2017 06:16:35 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org

From: Tan Chin Yew <chin.yew.tan@intel.com>

For I2c to operate correctly under all speed mode, sda-hold-time need to
be perfectly tuned. However, sda-hold-time is precalculated according to
circuit parameter which make it platform-specific.

In order to get accurate sda-hold-time for all platforms, pretuned
sda-hold-time for particular platform is stored in ACPI table and driver
to load the sda holding time from ACPI table.

This patch read the I2c sda-hold-time from ACPI table and assigned the
suitable hold time based on the i2c clock frequency.

Tested on Intel Apollo Lake.

Tan Chin Yew (1):
  i2c: designware: Get selected speed mode sda-hold-time via ACPI

 drivers/i2c/busses/i2c-designware-platdrv.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
1.9.1
